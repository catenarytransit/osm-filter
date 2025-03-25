use std::collections::HashMap;
use std::env;
use std::fs::File;
use std::io;
use std::path::PathBuf;

use osm_io::osm::model::way::Way;
use osm_io::osm::model::element::Element;
use osm_io::osm::model::tag::Tag;
use osm_io::osm::pbf;
use osm_io::osm::pbf::compression_type::CompressionType;
use osm_io::osm::pbf::file_info::FileInfo;

fn main() -> Result<(), io::Error> {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        eprintln!("Usage: {} <input.osm.pbf> <output.osm.pbf>", args[0]);
        return Ok(());
    }

    let input_filename = &args[1];
    let output_filename = &args[2];

    println!("Reading from: {}", input_filename);
    println!("Writing to: {}", output_filename);
    
    let input_path = PathBuf::from(input_filename);
    let output_path = PathBuf::from(output_filename);

    let reader = pbf::reader::Reader::new(&input_path).unwrap();

    let mut file_info = FileInfo::default();
    file_info.with_writingprogram_str("");
    let mut writer = pbf::writer::Writer::from_file_info(
        output_path,
        file_info,
        CompressionType::Zlib,
    ).unwrap();

    writer.write_header().unwrap();

    for element in reader.elements().unwrap() {

        let mut filter_out = false;
        let element = match element {
            Element::Node { node } => {

                Element::Node {
                    node: node.clone(),
                }
            }
            Element::Way { way: way } => {

                let mut way = way;
                let mut tags = way.take_tags();


                    let has_highway = tags.iter().find(|tag| tag.k().as_str() == "highway");

                    if has_highway.is_some() {
                        tags = tags
                            .iter()
                            .filter(|tag| tag.k().as_str() != "name")
                            .filter(|tag| tag.k().as_str() != "name:en")
                            .filter(|tag| tag.k().as_str() != "name:de")
                            .filter(|tag| tag.k().as_str() != "name:etymology")
                            .cloned()
                            .collect::<Vec<Tag>>();
                    }
                

                let way = osm_io::osm::model::way::Way::new(
                    way.id(),
                    way.version(),
                    way.timestamp(),
                    way.changeset(),
                    way.uid(),
                    way.user().to_string(),
                    way.visible(),
                    way.refs().to_vec(),
                    tags
                );

                Element::Way { way: way }
            }
            Element::Relation { relation: relation } => {
                Element::Relation { relation: relation }
            }
            Element::Sentinel => {
                filter_out = true;

                Element::Sentinel
            }
        };
        if !filter_out {
            writer.write_element(element).unwrap();
        }
    }

    writer.close().unwrap();

    println!("Processing complete.");
    Ok(())
}
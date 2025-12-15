wget https://download.geofabrik.de/europe-latest.osm.pbf -O europe-latest.osm.pbf

osmium extract -b 5.6216,45.44223,10.88867,48.3833 europe-latest.osm.pbf -o switzerland-bbox.osm.pbf --overwrite

osmium tags-filter -o switzerland-gtfs-pfaedle.osm.pbf --expressions=pfaedle-filter-all.txt switzerland-bbox.osm.pbf --overwrite

gh release upload latest switzerland-gtfs-pfaedle.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/

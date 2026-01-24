wget https://download.geofabrik.de/north-america/canada-latest.osm.pbf -O canada-latest.osm.pbf

osmium tags-filter -o railstations-canada-latest.osm.pbf --expressions=railway-station-filter.txt canada-latest.osm.pbf --overwrite

gh release upload latest railstations-canada-latest.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/
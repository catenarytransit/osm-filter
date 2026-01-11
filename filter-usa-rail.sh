wget https://download.geofabrik.de/north-america/us-latest.osm.pbf -O us-latest.osm.pbf

 osmium tags-filter -o railonly-us-latest.osm.pbf --expressions=railway-filter.txt us-latest.osm.pbf --overwrite

 gh release upload latest railonly-us-latest.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/

 osmium tags-filter -o railstations-us-latest.osm.pbf --expressions=railway-station-filter.txt us-latest.osm.pbf --overwrite

 gh release upload latest railstations-us-latest.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/
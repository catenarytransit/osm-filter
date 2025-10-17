wget https://raw.githubusercontent.com/catenarytransit/pfaedled-gtfs-actions/refs/heads/main/railway-filter.txt -O railway-filter.txt

wget https://download.geofabrik.de/north-america/us-latest.osm.pbf -O us-latest.osm.pbf

 osmium tags-filter -o railonly-us-latest.osm.pbf --expressions=railway-filter.txt us-latest.osm.pbf

 gh release upload latest railonly-us-latest.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/

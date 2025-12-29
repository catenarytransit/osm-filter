#wget https://raw.githubusercontent.com/catenarytransit/pfaedled-gtfs-actions/refs/heads/main/railway-filter.txt -O railway-filter.txt

#wget https://download.geofabrik.de/europe-latest.osm.pbf -O europe-latest.osm.pbf

 osmium tags-filter -o railonly-europe-latest.osm.pbf --expressions=railway-filter.txt europe-latest.osm.pbf

 gh release upload latest railonly-europe-latest.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/

wget https://raw.githubusercontent.com/catenarytransit/pfaedled-gtfs-actions/refs/heads/main/railway-filter.txt -O railway-filter.txt

wget https://download.geofabrik.de/north-america-latest.osm.pbf -O north-america-latest.osm.pbf

 osmium tags-filter -o railonly-north-america-latest.osm.pbf --expressions=railway-filter.txt north-america-latest.osm.pbf

 gh release upload latest railonly-north-america-latest.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/

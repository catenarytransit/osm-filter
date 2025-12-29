wget https://download.geofabrik.de/north-america-latest.osm.pbf -O north-america-latest.osm.pbf

osmium tags-filter -o amtrak-thruway.osm.pbf --expressions=amtrakthruwayfilter.txt north-america-latest.osm.pbf

gh release upload latest amtrak-thruway.osm.pbf --clobber -R https://github.com/catenarytransit/osm-filter/

DC_VERSION="latest"
DC_DIRECTORY=.
DC_PROJECT="dependency-check scan: $(pwd)"
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"
ODC_REPORTS="$DC_DIRECTORY/odc-reports"
NVD_API_KEY=

    if [ ! -d "$DATA_DIRECTORY" ]; then
        echo "Initially creating persistent directory: $DATA_DIRECTORY"
        mkdir -p "$DATA_DIRECTORY"
    fi
    if [ ! -d "$CACHE_DIRECTORY" ]; then
        echo "Initially creating persistent directory: $CACHE_DIRECTORY"
        mkdir -p "$CACHE_DIRECTORY"
    fi
    if [ ! -d "$ODC_REPORTS" ]; then
        echo "Initially creating persistent directory: $DATA_DIRECTORY"
        mkdir -p "$ODC_REPORTS"
    fi      
    docker pull owasp/dependency-check:$DC_VERSION        
    docker run --rm \
    -e user=$USER \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    --volume $(pwd):/src:z \
    --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z \
    --volume "$ODC_REPORTS":/report:z \
    owasp/dependency-check:$DC_VERSION \
    --scan /src \
    --nvdApiKey "$NVD_API_KEY" \
    --format "ALL" \
    --project "$DC_PROJECT" \
    --out /report
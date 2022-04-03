PACKAGES="$1"

# cat packages.csv | grep -i "^PACKAGES" | grep -i -v "\.patch;" | while read line; do
#     echo "inside"
#     NAME="`echo $line | cut -d\; -f1`"
#     VERSION="`echo $line | cut -d\; -f2`"
#     URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
#     CACHEFILE="$(basename "$URL")"
#     DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"
#     mkdir -pv "$DIRNAME"
#     echo "Extracting $CACHEFILE"
#     tar -xf "$CACHEFILE" -C "$DIRNAME"

    # pushd "$DIRNAME"
    #     if [ "$(ls -1A | wc -l)" == "1" ]; then
    #         mv $(ls -1A)/* ./
    #     fi
    #     echo "Compiling $PACKAGES"
    #     sleep 5
    #     mkdir -pv "../log/$PACKAGES"
    #     if ! source "../$PACKAGES.sh" 2>&1 | tee "../log/$PACKAGES.log" ; then
    #         echo "Compiling $PACKAGES FAILED!"
    #         popd
    #         exit 1
    #     fi
    #     echo "Done Compiling $PACKAGES"
    # popd
# done

cat packages.csv | grep -i "^$PACKAGES;" | grep -i -v "\.patch;" | while read line; do
    NAME="`echo $line | cut -d\; -f1`"
    export VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    MD5SUM="`echo $line | cut -d\; -f4`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"
    mkdir -pv "$DIRNAME"
    echo "Extracting $CACHEFILE"
    tar -xf "$CACHEFILE" -C "$DIRNAME"

    pushd "$DIRNAME"
        if [ "$(ls -1A | wc -l)" == "1" ]; then
            mv $(ls -1A)/* ./
        fi
        echo "Compiling $PACKAGES"
        sleep 5
        mkdir -pv "../log/$PACKAGES"
        if ! source "../$PACKAGES.sh" 2>&1 | tee "../log/$PACKAGES.log" ; then
            echo "Compiling $PACKAGES FAILED!"
            popd
            exit 1
        fi
        echo "Done Compiling $PACKAGES"
    popd
done
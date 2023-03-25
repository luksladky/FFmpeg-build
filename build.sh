echo "----- Build FFmpeg and merge to universal binary ----- "
ARGS="--enable-gpl --disable-ffmpeg --disable-ffplay --disable-ffprobe --disable-avdevice --disable-avfilter --disable-network --disable-postproc --disable-avfilter --disable-encoders --disable-muxers --disable-devices --disable-filters"
python make_compile.py --ffmpeg_dir ./ffmpeg --target_dir ./build --compile_args "$ARGS"
python make_universal.py --dir ./build

UNIVERSAL_DIR="./build/install_universal/lib"
echo "----- Signing the universal binaries -----"
security find-identity -v -p codesigning
CERT_ID=$(security find-identity -v -p codesigning | grep ":" | awk '{print $2}')
for file in $(ls $UNIVERSAL_DIR)
do
    bin_path="$UNIVERSAL_DIR/$file"
    codesign --force --timestamp --sign $CERT_ID $bin_path      
done

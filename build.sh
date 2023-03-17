echo "----- Download ffmpeg git submodule -----"
git config --global core.autocrlf input
git submodule init
git submodule update

echo "----- Download build tools ----- "
xcode-select --install
brew install python@3.11
brew install automake fdk-aac git lame libass libtool libvorbis libvpx opus sdl shtool texi2html theora wget x264 x265 xvid nasm

echo "----- Build FFmpeg and merge to universal binary ----- "
ARGS="--enable-gpl --disable-ffmpeg --disable-ffplay --disable-ffprobe --disable-avdevice --disable-avfilter --disable-network --disable-postproc --disable-avfilter --disable-encoders --disable-muxers --disable-devices --disable-filters"
python make_compile.py --ffmpeg_dir ./ffmpeg --target_dir ./build --compile_args "$ARGS"
python make_universal.py --dir ./build

echo "----- Copy to ./install folder ----- "
python install.py --ffmpeg_path ./build/install_universal --target_dir ./install
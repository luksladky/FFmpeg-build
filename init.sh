echo "----- Download ffmpeg git submodule -----"
git config --global core.autocrlf input
git submodule init
git submodule update

echo "----- Download build tools ----- "
xcode-select --install
brew install python@3.11
brew install automake fdk-aac git lame libass libtool libvorbis libvpx opus sdl shtool texi2html theora wget x264 x265 xvid nasm
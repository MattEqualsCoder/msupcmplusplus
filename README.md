# msupcm++

A native libSox implementation of the msupcm tool

## Usage

```
msupcm tracks.json
```

See included [configs](configs/) for tracks.json examples

### CLI Usage

[TODO]

## Building

### Dependencies

After checking out the main repository, you will need to also check out all of the dependencies, which are linked as submodules.

```
cd <local repo directory>
git submodule update --init --recursive
```

### Windows

After the dependencies have been checked out, simply open the msupcm++.sln file in Visual Studio (2019 or later) and build the solution.

### Linux

First, start by installing all necessary build tools

```
sudo apt install build-essential autoconf libtool
```

and dependency system dev packages

```
sudo apt install libao-dev libasound-dev libmad0-dev libmp3lame-dev libopusfile-dev libpulse-dev libsndfile1-dev libsndio-dev
```

then simply run

```
make
```

from the top-level repo directory.

### AppImage

It is also possible to build a portable **AppImage** of `msupcm++`.  
This bundles the binary together with its dependencies into a single executable file  
that can be run on most modern Linux distributions without installing libraries manually.

From the top-level repo directory, run:

```
chmod +x make-appimage.sh  
./make-appimage.sh
```

After the build finishes, an AppImage will be created in the same directory,  
for example:

```
MSUPCMPLUSPLUS-x86_64.AppImage
```

You can run it directly:

```
./MSUPCMPLUSPLUS-x86_64.AppImage tracks.json
```

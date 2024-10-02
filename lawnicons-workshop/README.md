# Lawnicons-workshop

* Clone/Pull in latest commit from Lawnicons git
* Optimize and convert svg to Android drawable xml format
* Remove resources from Lawnicons which contained in PixelLauncher

## Usage

* First, install required tools

```bash
# https://github.com/svg/svgo
npm install -g svgo
# https://github.com/stasson/vd-tool
npm install -g vd-tool
```

* And then, run script. This will take some time.

```bash
cd vendor/google/overlays/ThemeIcons/lawnicons-workshop
./svg2xml
```

* Done!

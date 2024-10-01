# Lawnicons-workshop

* Optimize and convert svg to Android drawable xml format
* Remove duplicated resources to PixelLauncher

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

* Copy output to PixelLauncherIconsOverlay
  * `out/drawable` goes under `PixelLauncherIconsOverlay/res-custom/drawable/drawable`
  * Copy contents of `out/xml/grayscale_icon_map.xml`<br>
    under the `<!-- Custom icons -->` section of<br>
    `PixelLauncherIconsOverlay/res/xml/grayscale_icon_map.xml`<br>
    except `<?xml version="1.0" encoding="utf-8"?>`, `<icons>` and `</icons>`

* Done!

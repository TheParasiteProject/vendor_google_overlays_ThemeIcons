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

* Copy output to PixelLauncherIconsOverlay
  * Remove `PixelLauncherIconsOverlay/res-custom/drawable`
  * `out/drawable` goes under `PixelLauncherIconsOverlay/res-custom`
  * Copy contents of `out/xml/grayscale_icon_map.xml`<br>
    to `PixelLauncherIconsOverlay/res/xml/grayscale_icon_map.xml`<br>
    under the `<!-- Custom icons -->` section of<br>
    except `<?xml version="1.0" encoding="utf-8"?>`, `<icons>` and `</icons>`

* Done!

## ToDo

* Major:
  * Automatically update resources and xml

* Minor (or not added probably):
  * Create separate dir for Lawnicons (res-lawnicons)<br>
    So that we can add our own icons too
  * Auto remove entries from Lawnicons that<br>
    contained in custom icons (res-custom) we added

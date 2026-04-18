```nu
# replace black with white
magick input.png -fill white -fuzz 15% -opaque black output.png
# floodfill
magick input.png -fuzz 10% -fill white -draw 'color 0,0 floodfill' output.png
# transparent color
magick input.png -fuzz 20% -transparent white output.png
```

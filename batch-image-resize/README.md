# Batch Image Resize

This script creates a resized/ subdirectory in the Working Directory.
Recreates the folder structure of the Working Directory in the resized/ directory.
Resizes all images from Working Directory(Including all sub directories) and puts them in the resized/ directory

Example:-

Before running the script:-
```
foo/
|
|
|
+---bar/
|   |
|   +---A.jpg
|   +---foobar/
|       |
|       +---B.jpg
+---foo2/
|   |
|   +---C.jpg
|
|
|
+---resize.sh
```
(NOTE: Working Directory = Current Directory of the script)

After running the script:-
```
foo/
|
|
|
+---bar/
|   |
|   +---A.jpg
|   +---foobar/
|       |
|       +---B.jpg
+---foo2/
|   |
|   +---C.jpg
|
|
|
|---resized/
|   |
|   +---bar/
|   |   |
|   |   +---A.jpg
|   |   +---foobar/
|   |       |
|   |       +---B.jpg
|   +---foo2/
|       |
|       +---C.jpg
|
|
|
+---resize.sh

```

# Dependencies
imagemagick
On Ubuntu/debian based distros:-
```
sudo apt update && sudo apt install imagemagick
```

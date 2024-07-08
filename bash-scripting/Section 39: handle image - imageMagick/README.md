# Section 38: handle image - imageMagick

## I. Image Magick: identify
```
- It allows us to collect information about an image

- To see all available options:
> identify -help
```

**example**
```
# show image info
> identify [image]

# show detail image information
> identify -verbose [image]

# get image width + heigh
> identify -format '%wx%h' [image]
```

## II: Image Magick: Resizing an image

### 1. introduction:
```
> convert input.jpg -resize 100x100 output.jpg

# notes:
- input.jpg: The image that we want to resize
- -resize 100x100:The maximum target image size. If the image is not square, the maximum width / height is 100px
- output.jpg: the image that we want to create
```

### 2. example:

**resize `jpg` to `jpg`**
```
> convert image-1.jpg -resize 100x80 image-1-thumbnail.jpg

# recheck:
> du *
or

> identify -format '%wx%h' image-1-thumbnail.jpg
```

**resize `jpg` to `png`**
```
> convert image-1.jpg -resize 100x80 image-1-thumbnail.png

# recheck:
> du *
or

> identify -format '%wx%h' image-1-thumbnail.png
```

**change type `jpg` to `png`**
```
> convert image-1.jpg image-1-png.png

# recheck:
> du *
or

> identify -format '%wx%h' image-1-png.png
```

**swirl image:**
```
> convert image-1.jpg -swirl 50 -resize 100x80 image-1-thumbnail.jpg

# recheck:
> du *
or

> identify -format '%wx%h' image-1-thumbnail.jpg
```

## III. working with filename:

### 1.`basename` vs. `dirname`
```
- Let's say we have a long pathname, such as:
- /home/janniss/Desktop/file.txt
```

**get the `folder`**
```
# command:
- dirname /home/janniss/Desktop/file.txt

# result:
- /home/janniss/Desktop
```

**get `filename`?**
```
# command:
- basename /home/janniss/Desktop/file.txt

# result:
- file.txt
```

### 2. get file `extensions`

**introduction**
```
> filename='file.txt'
=> How can we get the extension (txt)?

# command
> echo "${filename##*.}"

# result: txt

# conclusion:
- ##: Removes the longest match (from the beginning of the variable)of the pattern.

- Here, the pattern is *., meaning it should match everything, but it must have a dot at the end.
```

**example for `##`**:
```
# command
> filename='file.txt'
> echo "${filename##*.}

# result:
> txt
```

**example for `#`**:
```
# command:
> filename='file.word.txt'
> echo "${filename#*.}

# result:
> word.txt

# command:
> filename='file.word.text.txt'
> echo "${filename#*.}

# result:
> word.text.txt
```

### 3. get file name without `extensions`:

**introduction**
```
filename='file12345.txt'
```

```
# command:
> echo "${filename%.*}"

# result:
>  file12345

- %: Removes the shortest match of the pattern (from the end of the variable). Here, the pattern is .*, meaning it should match everything, but it must have a dot at the beginning.

- %%:
# command:
> echo "${filename%%.*}"

- This would just remove the longest match of the pattern
- The filename without the extension would not be detected correctly for hello.world.txt
```

**example for `%`**:
```
# command
> filename='file12345.txt'
> echo "${filename%.*}

# result:
> file12345

# command:
> filename='file12345.word.txt'
> echo "${filename%.*}

# result:
> file12345.word
```

**example for `%%`**:
```
# command:
> filename='file12345.word.txt'
> echo "${filename%%.*}

# result:
> file12345.word

# command:
> filename='file12345.word.text.txt'
> echo "${filename#*.}

# result:
> file12345.word.text
```

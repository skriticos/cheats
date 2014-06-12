### Images

resize *.jpg files to 2MP if they are bigger (in place, remove old file)

```bash
for file in {*.jpg,*.JPG}; do
  mv "$file" "old$file"
  convert -resize 3000000@\> "old$file" -quality 80 "$file"
  rm "old$file"
done
```

### Videos

convert video to webm

```bash
# slow version
for file in {*.mp4,*.MP4}; do
  newfile=`echo $file | sed -r 's/\.[[:alnum:]]+$//'`.webm
  avconv -i "$file" -c:v libvpx -qmin 0 -qmax 50 -crf 10 -b:v 2M \
    -c:a libvorbis -q:a 4 "$newfile"
done
```

```bash
# fast version
parallel 'newfile=`echo {} | sed -r 's/\.[[:alnum:]]+$//'`.webm; \
  avconv -i "{}" -c:v libvpx -qmin 0 -qmax 50 -crf 10 -b:v 2M \
  -c:a libvorbis -q:a 4 "$newfile"' ::: {*.mp4,*.MP4}
```

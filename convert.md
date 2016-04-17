### Images

resize *.jpg files to 2MP if they are bigger (in place, remove old file)

video explanation: https://www.youtube.com/watch?v=AG0bItQLBdI

```bash
for file in {*.jpg,*.JPG}; do
  mv "$file" "old$file"
  convert -resize 3000000@\> "old$file" -quality 80 "$file"
  rm "old$file"
done
```

### Videos

convert video to webm

video explanation: https://www.youtube.com/watch?v=bUkHPaOz9vg

```bash
# slow version
for file in {*.mp4,*.MP4}; do
  newfile=`echo _$file`
  ffmpeg -i "$file" -c:v libx264 -preset slow -crf 20 -c:a copy "$newfile"
done

# new version
for file in {*.mp4,*.MP4}; do
  newfile=`echo _$file`
  ffmpeg -i "$file" -c:v libx265 -preset medium -x265-params crf=20 -c:a copy -strict experimental "$newfile"
done
```

```bash
# fast version
parallel 'newfile=`echo {} | sed -r 's/\.[[:alnum:]]+$//'`.webm; \
  avconv -i "{}" -c:v libvpx -qmin 0 -qmax 50 -crf 10 -b:v 2M \
  -c:a libvorbis -q:a 4 "$newfile"' ::: {*.mp4,*.MP4}
```

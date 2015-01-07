  % arecord -l

List the recording devices. When I added a new webcam to the plugged in hardware list, it messed up the hardware address list and showed an error when recording the next video. The solution was to remove the webcam and restore the original hardware setting.

ToDo: Find a way to address devices by name instead of hardware address to avoid these kind of issues.

  **** List of CAPTURE Hardware Devices ****
  card 0: PCH [HDA Intel PCH], device 0: VT1802 Analog [VT1802 Analog]
    Subdevices: 1/1
    Subdevice #0: subdevice #0
  card 1: Mic [Samson Meteor Mic], device 0: USB Audio [USB Audio]
    Subdevices: 1/1
    Subdevice #0: subdevice #0

This is an example output.

  -f alsa -i hw:1,0

If I want to record a video with ffmpeg/avconv from the Samson Meteor Mic, it takes this the card number and then zero for subdevice.

Sources:
http://www.cyberciti.biz/tips/howto-display-soundcards-digital-audio-devices.html

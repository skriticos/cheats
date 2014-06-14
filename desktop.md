### Sample desktop file

```
[Desktop Entry]
Version=1.0
Type=Application
Name=Foo Viewer
Comment=The best viewer for Foo objects available!
TryExec=fooview
Exec=fooview %F
Icon=fooview
MimeType=image/x-foo;
Actions=Gallery;Create;

[Desktop Action Gallery]
Exec=fooview --gallery
Name=Browse Gallery

[Desktop Action Create]
Exec=fooview --create-new
Name=Create a new Foo!
Icon=fooview-new
```

### Exec variables

| code | description |
| ---- | ----------- |
| %f | A single file name, even if multiple files are selected. The system reading the desktop entry should recognize that the program in question cannot handle multiple file arguments, and it should should probably spawn and execute multiple copies of a program for each selected file if the program is not able to handle additional file arguments. If files are not on the local file system (i.e. are on HTTP or FTP locations), the files will be copied to the local file system and %f will be expanded to point at the temporary file. Used for programs that do not understand the URL syntax. |
| %F | A list of files. Use for apps that can open several local files at once. Each file is passed as a separate argument to the executable program. |
| %u | A single URL. Local files may either be passed as file: URLs or as file path. |
| %U | A list of URLs. Each URL is passed as a separate argument to the executable program. Local files may either be passed as file: URLs or as file path. |
| %i | The Icon key of the desktop entry expanded as two arguments, first --icon and then the value of the Icon key. Should not expand to any arguments if the Icon key is empty or missing. |
| %c | The translated name of the application as listed in the appropriate Name key in the desktop entry. |
| %k | The location of the desktop file as either a URI (if for example gotten from the vfolder system) or a local filename or empty if no location is known. |

### specification

http://standards.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html

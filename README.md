# fm-fix-eps-export-characters

This repo provides a Perl script that fixes broken special-character encodings in EPS files exported by FrameMaker.

## Background

We are converting our documentation from structured FrameMaker to DITA. We configure our FrameMaker XML write rules to export anchored frames in EPS format, which we then convert to SVG using Inkscape 1.0.

However, we found that in FrameMaker 2017 (and likely other versions), the EPS export filter writes incorrect character encodings for special characters. For example, a bullet character is written as `\202\304\242` (octal) instead of `\225` (octal), which renders as garbage characters in the usual reference viewers (Adobe Illustrator, Ghostscript, etc.).

I wrote this Perl script to fix these incorrect character encodings in EPS files written by FrameMaker's EPS export filter.

## Usage

The script accepts one or more EPS filenames as input. The files are modified in place. For example,

```
# fix some specific files
fix_eps_characters.pl pic1.eps pic2.eps pic3.eps

# fix all files in a directory
fix_eps_characters.pl ./graphics/*.eps

# fix all files in a directory, recursively into subdirectories too
find ./graphics -iname '*.eps' -print0 | xargs -0 fix_eps_characters.pl
```

Although this script is written in Perl, it runs very well in Windows 10 via Windows Subsystem for Linux (WSL).

## Additional Information

I found a table of character encodings in the [PostScript Language Reference Manual (third edition)](https://www.google.com/search?q=PostScript+Language+Reference+Manual), Appendix E: Character Sets and Encoding Vectors.

To find all incorrect encodings used by FrameMaker, I pasted the entire table from section E.5 into a FrameMaker anchored text box. The encodings written for the first-column special characters provided the incorrect FrameMaker values. Most of these characters (but not all) pasted properly into FrameMaker.

Next, I determined the correct EPS character encodings by experimentation. I found that for the most part, using the rightmost populated encoding values from the table (CE, then ISO, then STD) provided the best results. There were a couple deviations from this rule that I found and fixed by experimentation.

For clarity, I implemented the encoding remapping in two steps, from bad encoding to character name, then from character name to good encoding. I implemented this partly for clarity and self-documentation, and partly in case FrameMaker used different character encoding maps for different EPS files. (There is a map of named character encodings in the PostScript font section of the EPS file where this could be implemented.)  Fortunately, I haven't seen that happen yet.
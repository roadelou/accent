# Accent

> Disclaimer: This is a small side project.

I recntly bought a new laptop, but it has an ISO keyboard, meaning I no longer have access to the french accents I need for some school reports. Because I have als been implementing the [compass programming language](https://github.com/roadelou/compass) recently, I thought I would use this occasion to create a first real project which uses compass :compass:

The __accent__ executable takes as input a formatted text file (ASCII only) and performs some substitutions to add accents in the text. The outputted file is UTF-8.

| Format Sequence | Replaced By |
----------------- | -------------
| e1 | è |
| e2 | é |
| e3 | ê |
| a1 | à |
| a3 | â |
| c4 | ç |
| E1 | È |
| E2 | É |
| E3 | Ê |
| A1 | À |
| A3 | Â |
| C4 | Ç |

If you want formatting to be ignored for a section of the text, you can use enclosing `{` `}`, but it doesn't work too well yet :wink:

### METADATA

Field | Value
--- | ---
:pencil: Contributors | roadelou
:email: Contacts | 
:date: Creation Date | 2021-03-19
:bulb: Language | Markdown Document

### EOF

param (
    [Parameter(Mandatory=$true)][string]$element,
    [string]$size = "22x22"
)
$PROGDIR = Join-Path ${env:ProgramFiles(x86)} Dia
$BINDIR = Join-Path $PROGDIR bin
$EXENAME = "dia"
$MYSHAPEDIR = "shapes"

$CONTENTS = '<?xml version="1.0" encoding="UTF-8"?>
<dia:diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
  <dia:diagramdata>
    <dia:attribute name="background">
      <dia:color val="#ffffff"/>
    </dia:attribute>
    <dia:attribute name="pagebreak">
      <dia:color val="#000099"/>
    </dia:attribute>
    <dia:attribute name="paper">
      <dia:composite type="paper">
        <dia:attribute name="name">
          <dia:string>#A4#</dia:string>
        </dia:attribute>
        <dia:attribute name="tmargin">
          <dia:real val="2.8222000598907471"/>
        </dia:attribute>
        <dia:attribute name="bmargin">
          <dia:real val="2.8222000598907471"/>
        </dia:attribute>
        <dia:attribute name="lmargin">
          <dia:real val="2.8222000598907471"/>
        </dia:attribute>
        <dia:attribute name="rmargin">
          <dia:real val="2.8222000598907471"/>
        </dia:attribute>
        <dia:attribute name="is_portrait">
          <dia:boolean val="true"/>
        </dia:attribute>
        <dia:attribute name="scaling">
          <dia:real val="1"/>
        </dia:attribute>
        <dia:attribute name="fitto">
          <dia:boolean val="false"/>
        </dia:attribute>
      </dia:composite>
    </dia:attribute>
    <dia:attribute name="grid">
      <dia:composite type="grid">
        <dia:attribute name="width_x">
          <dia:real val="1"/>
        </dia:attribute>
        <dia:attribute name="width_y">
          <dia:real val="1"/>
        </dia:attribute>
        <dia:attribute name="visible_x">
          <dia:int val="1"/>
        </dia:attribute>
        <dia:attribute name="visible_y">
          <dia:int val="1"/>
        </dia:attribute>
        <dia:composite type="color"/>
      </dia:composite>
    </dia:attribute>
    <dia:attribute name="color">
      <dia:color val="#d8e5e5"/>
    </dia:attribute>
    <dia:attribute name="guides">
      <dia:composite type="guides">
        <dia:attribute name="hguides"/>
        <dia:attribute name="vguides"/>
      </dia:composite>
    </dia:attribute>
  </dia:diagramdata>
  <dia:layer name="Background" visible="true" active="true">
    <dia:object type="XXXX" version="1" id="O0">
      <dia:attribute name="obj_pos">
        <dia:point val="0,0"/>
      </dia:attribute>
      <dia:attribute name="obj_bb">
        <dia:rectangle val="0,0;2,2"/>
      </dia:attribute>
      <dia:attribute name="meta">
        <dia:composite type="dict"/>
      </dia:attribute>
      <dia:attribute name="elem_corner">
        <dia:point val="0,0"/>
      </dia:attribute>
      <dia:attribute name="elem_width">
        <dia:real val="2"/>
      </dia:attribute>
      <dia:attribute name="elem_height">
        <dia:real val="2"/>
      </dia:attribute>
      <dia:attribute name="line_width">
        <dia:real val="0.1"/>
      </dia:attribute>
      <dia:attribute name="line_colour">
        <dia:color val="#000000"/>
      </dia:attribute>
      <dia:attribute name="fill_colour">
        <dia:color val="#ffffff"/>
      </dia:attribute>
      <dia:attribute name="show_background">
        <dia:boolean val="true"/>
      </dia:attribute>
      <dia:attribute name="line_style">
        <dia:enum val="0"/>
        <dia:real val="1"/>
      </dia:attribute>
      <dia:attribute name="flip_horizontal">
        <dia:boolean val="false"/>
      </dia:attribute>
      <dia:attribute name="flip_vertical">
        <dia:boolean val="false"/>
      </dia:attribute>
      <dia:attribute name="subscale">
        <dia:real val="1"/>
      </dia:attribute>
    </dia:object>
  </dia:layer>
</dia:diagram>'


# make a template document
$tempfile = New-TemporaryFile
# populate the temp document
$CONTENTS -replace "XXXX", $element | Out-File $tempfile
# feed the document to dia
    # dia -e shapes/nms-source-biofuel.png -s 22x22 test\test.dia
$OUTFILE = Join-Path $MYSHAPEDIR "$element.png"
Start-Process -NoNewWindow -FilePath (Join-Path $BINDIR $EXENAME) -ArgumentList "-e $OUTFILE -s $size $tempfile" -Wait
# delete the template document
Remove-Item $tempfile

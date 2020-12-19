$PROJNAME = "NMSCircuit"

$PROGDIR = Join-Path ${env:ProgramFiles(x86)} Dia
$SHEETDIR = Join-Path $PROGDIR sheets
$SHAPEDIR = Join-Path $PROGDIR shapes
$SHAPEPROJDIR = Join-Path $SHAPEDIR $PROJNAME

$SHEETFILENAME = "$PROJNAME.sheet"
$SHEETPATH = Join-Path $SHEETDIR $SHEETFILENAME

# Messing with Program Files directory requires permission
# https://stackoverflow.com/questions/7690994/running-a-command-as-administrator-using-powershell/57035712#57035712
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    # restart diaw, if running
    $proc = Get-Process diaw -ErrorAction SilentlyContinue
    if( $null -ne $proc ) {
        $proc.Kill()
        $proc.WaitForExit()
        Start-Process -FilePath "C:\Program Files (x86)\Dia\bin\diaw.exe" -ArgumentList "--integrated"
        Start-Sleep -Seconds 3
        $proc = Get-Process diaw
        $proc.Kill()
        $proc.WaitForExit()
        Start-Process -FilePath "C:\Program Files (x86)\Dia\bin\diaw.exe" -ArgumentList "--integrated"
    }
    Break
}

# remove old sheet file
if (Test-Path $SHEETPATH) {
     Remove-Item $SHEETPATH
}
# place new sheet file
Copy-Item $SHEETFILENAME $SHEETPATH

# remove old shape directory
if (Test-Path $SHAPEPROJDIR) {
    Remove-Item $SHAPEPROJDIR -Recurse
}

# make & populate new shape directory
New-Item -Path $SHAPEDIR -Name $PROJNAME -ItemType "directory"
Join-Path "shapes" "*" | Copy-Item -Destination $SHAPEPROJDIR


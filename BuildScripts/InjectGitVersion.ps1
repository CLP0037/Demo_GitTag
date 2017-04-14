# InjectGitVersion.ps1
#
# Set the version in the projects AssemblyInfo.cs file
#



# Get version info from Git. example 1.2.3-45-g6789abc
$gitVersion = git describe --long --always;
$gitModified = git status  --short -uno;

if( -not $? )
{
    $msg = $Error[0].Exception.Message
    "Encountered error during Deleting the Folder. Error Message is $msg. Please check." >> $LogFile
    exit
}

# Parse Git version info into semantic pieces
$gitVersion -match '(.*)-(\d+)-[g](\w+)$';
$gitTag = $Matches[1];
$gitCount = $Matches[2];
$gitSHA1 = $Matches[3];

# Get file Modified info 


If([String]::IsNullOrEmpty($gitModified)) 
{
    $gitStatus ="";
}
Else 
{
    $gitStatus ="-FileModified";
}

# Define file variables
$assemblyFile = $args[0] + "\Properties\AssemblyInfo.cs";
$templateFile =  $args[0] + "\Properties\AssemblyInfo_template.cs";
# $assemblyFile = "F:\Projects\ParamSet_Indicator\ParamSet_Indicator\Properties\AssemblyInfo.cs";
# $templateFile = "F:\Projects\ParamSet_Indicator\ParamSet_Indicator\Properties\AssemblyInfo_template.cs";

# Read template file, overwrite place holders with git version info
$newAssemblyContent = Get-Content $templateFile |
    %{$_ -replace '\$FILEVERSION\$', ($gitTag + "." + $gitCount) } |
    %{$_ -replace '\$INFOVERSION\$', ($gitTag + "." + $gitCount + "-" + $gitSHA1 +$gitStatus) };

# Write AssemblyInfo.cs file only if there are changes
If (-not (Test-Path $assemblyFile) -or ((Compare-Object (Get-Content $assemblyFile) $newAssemblyContent))) {
    echo "Injecting Git Version Info to AssemblyInfo.cs"
    $newAssemblyContent > $assemblyFile;       
}
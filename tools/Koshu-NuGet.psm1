Param(
	[Parameter(Position=0,Mandatory=1)] [hashtable]$config
)

$here = $MyInvocation.MyCommand.Definition.Replace($MyInvocation.MyCommand.Name, "") -replace ".$"
$resourcesDir = "$here\resources"

#------------------------------------------------------------
# Commands
#------------------------------------------------------------

function Generate-NuSpec {
	[CmdletBinding()]
	param(
		[Parameter(Position=0,Mandatory=0,ValueFromPipeline=$False)][string]$template=$null,
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$False)][string]$destination,
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$False)][string]$id,
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$False)][string]$version,
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$False)][string]$author,
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$False)][string]$description,
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$False)][string]$basePath,
		[Parameter(Position=0,Mandatory=0,ValueFromPipeline=$False)][hashtable]$files
	)

	if ($template -eq $null -or $template -eq '') {
		$template = "$resourcesDir\nuspec.template"
	}

	$nuspec = "$destination\$id.nuspec"

	$basePath = (resolve-path $basePath)

	$filesContent = ''
	if ($files -eq $null) {
		get-childitem $basePath -recurse -file | % {
			$target = $_.FullName.substring($basePath.length+1)
			$filesContent += "`r`n`t`t<file src=""$($_.FullName)"" target=""$target"" />"
		}
	} else {
		$files.GetEnumerator() | % {
			$filesContent += "`r`n`t`t<file src=""$($_.key)"" target=""$($_.value)"" />"
		}
	}

	get-content $template |
		% { $_ -replace "#id#",$id } |
		% { $_ -replace "#version#",$version } |
		% { $_ -replace "#author#",$author } |
		% { $_ -replace "#description#",$description } |
		% { $_ -replace "#files#",$filesContent } |
		out-file $nuspec -encoding "Default" -force
}


#------------------------------------------------------------
# Export
#------------------------------------------------------------

export-modulemember -function Generate-NuSpec
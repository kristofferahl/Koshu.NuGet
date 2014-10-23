Param(
	[Parameter(Position=0,Mandatory=1)] [hashtable]$parameters,
	[Parameter(Position=1,Mandatory=1)] [hashtable]$config
)

$module = (join-path (resolve-path $parameters.packageDir) 'tools\Koshu-NuGet.psm1')
import-module $module -disablenamechecking -global -args $config
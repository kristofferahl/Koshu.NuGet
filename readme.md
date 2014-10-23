# Koshu.NuGet

Koshu plugin for NuGet related tasks

## Usage

### Configuration

This plugin currently does not support configuration.

	config @{
		"Koshu.NuGet"=@{}
	}

### Generate nuspec

    Generate-NuSpec `
    	-destination [<PathToNuspecTemplate>] `
		-destination <PathToDestinationDirectory> `
		-id <NugetPackageId> `
		-version <NugetPackageVersion> `
		-author <NugetPackageAuthor> `
		-description <NugetPackageDescription> `
		-basePath <FilesBasePath> `
		-files [<FilesToInclude>]

#### Specifing files explicitly

	Generate-NuSpec `
		-basePath .\ `
		-files @{
			"bin\$configuration\**\*.*" = "lib"
			"install.ps1" = "tools"
		}

By passing in a hastable with file sources and targets you can make sure to only include what you really need.

## License
MIT (http://opensource.org/licenses/mit-license.php)

## Contact
Kristoffer Ahl (project founder)  
Email: koshu@77dynamite.net  
Twitter: http://twitter.com/kristofferahl  
Website: http://www.77dynamite.com/
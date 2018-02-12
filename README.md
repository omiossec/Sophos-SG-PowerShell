# Sophos-SG-PowerShell

PowerShell module to interact with Sophos SG Firewall throug Sophos RestApi.

My initial motivation was to improve the way I manage Sophos Firewall SG during infrastructure deployement. I needed a way to add Host Objects and Packet Filter rules in the same way I create VM and services.
This module enable Network automation from PowerShell on Sophos SG Firewall.

## Table of contents

- [Contributing](#contributing)
- [Installation](#installation)
- [Download from GitHub repository](#Download-from-GitHub-repository)
- [Use Cases](#use-cases)
- [Notes](#notes)
- [Support](#Support)
- [Documentation](#Documentation)

## Contributing

Contributions are welcome via pull requests and issues.
Please see our [contributing guide](https://github.com/omiossec/Sophos-SG-PowerShell/blob/master/CONTRIBUTING.md) for more details

### Download from GitHub repository

1. Download the repository ()
1. Unblock the zip file
1. Extract the folder to a module path (e.g. $home\Documents\WindowsPowerShell\Modules)

## Usage examples

1. Create Object (Host, Dns Host, Network, Range, interface), packetfilters rules (Nat, Firewall) and Routing from your PowerShell Script enabling infrastructure deployement by code.
1. Delegate object creation to non network administration
1. Enable versionning by using script and git instead of traditional click and forget approach
1. Explore Sophos SG internal API

## Notes

## Support

- PowerShell v5 (not tested yet on PowerShell 6 core)
- Sophos SG UTM 4.908 and newer
- A valid certificate on the client computer (the module do not deal yet with invalide certificate)

## Documentation

[See the project Wiki](https://github.com/omiossec/Sophos-SG-PowerShell/wiki)

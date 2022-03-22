## qphospital (WIP)

Hospital treatment system utilizing *oxmysql, ox_lib, ox_inventory, qtarget & nh-context*. This resource is still in *beta phase* and is a *work in progress* so you will run into some some test code, *ex. debug function*. On the other hand, we have decided to declare this resource as *production-ready*.

[Preview Video](https://www.youtube.com/watch?v=4QOwcOOikRg)

## Requirements
- [oxmysql](https://github.com/overextended/oxmysql)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [qtarget](https://github.com/overextended/qtarget)
- [nh-context](https://github.com/nerohiro/nh-context)

## Notes

- This resource is *only* supported by ESX Legacy, it will *not* work on other frameworks without making modifications.
- You must be running the latest versions of the resource requirements.
- 0.01 ms on idle and 0.03 while in use.
- The NativeUI was removed for performance reasons / enhancements, we have decided to use nh-context menu instead.

## Download & Installation

### Using Git:
```
cd resources
git clone https://github.com/ohqpr/qphospital.git
```
### Manual Installation:

- Make sure you have the latest versions of the resource requirements up above or this resource will *not* work.
- Download the [latest version](https://github.com/ohqpr/qphospital/releases) of the resource.
- Unzip and drag the folder into your `resources` directory.
- Open `database.sql` and run it through your database.
- Be sure to add the resource to your `server.cfg` after the dependencies to avoid any problems on startup.
- You can then open the `shared` folder and edit `configuration.lua` to fit your desired needs.

## Support

- Please don't forget to report any bugs/errors you may run into --> [Open a new issue](https://github.com/ohqpr/qphospital/issues/new)
- If you have anything to add improving the features or code feel free to make a pull request --> [Submit a pull request](https://github.com/ohqpr/qphospital/pulls)

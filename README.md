# PAYDAY-2-2013-Update-2-Overhaul
### This is the official repository for the mods I've so far created for PAYDAY 2's update 2 from 2013, hereinafter referred to as u2.
### Content breakdown:
  - Section removed, there is simply too much to write about here. Just give it a go and see for yourself!

### Installation:
  1. **Downloading update 2**
      - Made for the fixed update 2 from 2013 (manifest id 6534432302280289873).
      - Obtain the said version of the game using DepotDownloader (https://github.com/SteamRE/DepotDownloader)
      - You don't need to put the files in the Steam's PD2 directory, you can simply create another folder and drop steam_appid.txt there, this will allows you to run the game using its exe and still be able to use Steam
      - If you want to allow PD2 to access 4GB of RAM rather than just 2, you can check out this (https://ntcore.com/?page_id=371)
  2. **Installing the mods**
      - Drop IPHLPAPI.dll and the mods folder in the main directory
      - Install the mods located within 'required mods' folder
      - You may also install the 'optional mods'
      - Download the original BundleModder (https://modworkshop.net/mod/197)
      - Install the mods from 'required pdmods' using this tool
      - You may also install 'optional pdmods'
  3. **Creating a backup (optional)**
      - Navigate to C:\Users\<your name>\AppData\Local
      - Rename, copy or zip the PAYDAY 2 folder
      - While using the Overhaul won't overwrite your save file, because we occupy a different slot, your renderer_settings.xml will be overwritten

### Contact:
  - Feel free to hit me up with with ideas, improvements or anything
  - **Discord:** marcus_py
  - **Steam:** https://steamcommunity.com/id/MarcusPy/

### Additional information:
  - **Not every feature that can be toggled has a u2mm setting implemented yet. Some of them can be toggled directly within the code**
  - If you want to implement u2mm within your mod, check out Ultrawide Fix's code. It shows the basic implementation of u2mm framework. Source of u2mm also contains useful comments

# PAYDAY-2-2013-Update-2-Overhaul
### This is the official repository for the mods I've so far created for PAYDAY 2's update 2 from 2013, hereafer referred to as u2.
### Content breakdown:
  - **BLT**
    - Edited to work with u2 and decluttered
  - **u2 Mod Manager** (hereafer u2mm)
    - Due to BLT relying on base game functionality that hasn't been implemented yet, its Mod Options menu is completely defunct. So I came up with u2mm to help rectify this issue. While I'm quite certain it's more robust than BLT's, it's also significantly more difficult to use
  - **Overhaul**
    - A comprehensive mod that alters virtually every relevant aspect of the game to some extent. Some of the features are:
      - Alpha/Beta visual restorations, such as GUI or HUD
      - Realism changes, such as reloading deducts the remaining ammo that was left in the clip
      - Crime.Net functionality expansion
      - Skills, Guns, Crew, Enemy rebalancing
      - ...
  - **Ultrawide Fix**
    - Early PD2 offers very limited support for various resolutions, meaning if your monitor isn't 16:9, you may experience black main menu, stretched HUD, etc. This mod will fix that, but remember to check out its u2mm menu!
  - **HoloInfo** (https://modworkshop.net/mod/14859)
    - Edited to work with u2
  - **Kill Feed & HopLib** (https://modworkshop.net/mod/20055)
    - Crudely edited to work with u2

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

Contact:
  - Discord: marcus_py
  - Steam: https://steamcommunity.com/id/MarcusPy/

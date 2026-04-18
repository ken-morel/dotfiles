Remote Gamepad - https://remotegamepad.com

# How to install

1. Extract this archive into the directory where you want to install Remote Gamepad.

2. Open a terminal in the extracted directory.

3. Copy the file "60-remotegamepad.rules" into "/lib/udev/rules.d/" with the following command:
  sudo cp 60-remotegamepad.rules /lib/udev/rules.d/

4. Now restart your PC for these rules to take effect.

5. If you want to use an Android device with Remote Gamepad over USB, install ADB.
  Example for Debian: sudo apt install android-tools-adb
  Example for Fedora: sudo dnf install android-tools

6. If you want to use an iOS device with Remote Gamepad over USB, install usbmuxd.
  Example for Debian: sudo apt install usbmuxd
  Example for Fedora: sudo dnf install usbmuxd

7. Run the file "remotegamepad". This can be done with the following command:
  ./remotegamepad

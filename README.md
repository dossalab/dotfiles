## My ArchLinux dotfiles (zsh, sway, helix, ranger)

This was created in an attempt to simplify installing Arch Linux with my preferred settings.
This repository should contain everything needed for you (and me) to quickly install required packages and configure the system.
I include my packagelists for the base system and the development, in case you want to do some. I mostly work on embedded devices and system level software though. 

## What's included?

The core of this setup is a simple desktop environment called Sway. Majority of tools I use are small independent programs or even terminal-based applications.

- I use `zsh` because of the extended autocompletion support;
- My preferred editor is `helix` - similar to vim, but with good language server support out of the box;
- The menu (application launcher) is `bemenu` - Wayland alternative to `dmenu`. Simple prompts are also based on it;
- The terminal is `alacritty`, but others would probably work as well (just don't forget to change it in the `.profile` so hotkeys will update too);
- My fonts are Google's Noto Fonts.

## Installing the dotfiles:

0. Download this repo from the GitHub
1. Use `pacman -S - < <packagelist>` to install the packagelist. Required packages are in `packagelist.base`. You can also install `packagelist.intel` if you have an Intel-based system. Optionally, install `packagelist.dev` for development packages.
2. Copy contents of `home` directory to your user's home (`~/`). Please note that 'installing' it like that will overwrite any existing configuration (if any). If unsure, create a separate temporary user and try my dotfiles there before doing a permanent install. There is no way to roll back.
3. Execute `chsh <username>`. Select `/usr/bin/zsh` as your new shell.

If you're doing it in clean install, enable and run display manager such as `ly`. If you already have something like Gnome installed, you can select Sway from display environment selection menu at the login screen.

### Capslock as Super, short tap as Esc

Capslock is a useless key in a great reach! You can make more of it if you remap it to the action key (Super). Super is used in Sway to switch workspaces and for executing shortcuts.
It's also possible to make it work like Escape key while short-pressed (tapped). This is useful in editors such as Vim or Helix for switching modes.

On Wayland, this is achieved with `interception-tools`.

Make sure `interception-tools` and `interception-dual-function-keys` are installed.
Copy contents of `capslock-remap` to `/etc/interception/`
Enable and start `udevmon` service.

This solution works both in kernel (boot) console and in window managers.

## Installing Archlinux

This guide is not intended to be complete but rather serve as a set of tips for self-help during installation.

### 1. Bootup the installation medium

Head on to the Archlinux website and make yourself a good installation USB drive.
Insert it into the target computer and boot it up.

### 2. Connect to the Internet

The easiest way to get the WiFi connection is to use tethering on your phone (sharing through USB). You can also use the Ethernet cable. After connecting the hardware, run `dhcpd` to obtain the IP address.

### 3. Disk layout

Make sure the disk layout is correct and the required partitions are formatted:

| part | type  | fs   | size             | description |
|------|-------|------|------------------|-------------|
| esp  | ESP   | vfat | ~300M            | EFI system partition. Only one is required per hard drive. Contains the bootloader or/and kernel |
| root | Linux | ext4 | 40-70G           | Your root filesystem with applications |
| swap | swap  |    - | computer's RAM*2 | Swap partition is used when your computer is low on ram and for hibernation |
| home | Linux | ext4 | remaining space  | Your data, documents, photos... |

Root partition size depends on whether you want to use `multilib` (`wine` support), do you want to install large packages such as `kicad`, `blender`, IDEs such as `idea`...

Some computers may already have ESP created - in that case there is no need to create a duplicate.

Format the partitions using `mkfs.ext4` and `mkfs.vfat`

Mount the `root` partition at `/mnt`.

Create the mountpoints:

```
mkdir -p /mnt/boot
mkdir -p /mnt/home
````

and mount the remaining partitions.

Technically, mounting `home` is not required, though it will help with `genfstab` later.

### 4. Enable the swap partition

```
swapon <your-swap-partition>
```

This is not directly required for the installation, but it will also help with `genfstab`

### 5. Pacstrap the root file system

Do `pacstrap -K /mnt base linux linux-firmware networkmanager sudo nvim`
   
That will install the required packages at the specified directory (your mounted hard drive).

`-K` apparently stands for generating the keyring; if you miss it, you'll have to do it later manually, though it's no big deal...

### 6. Generate `/etc/fstab` using your root mount point:

```
genfstab -U /mnt >> /mnt/etc/fstab
```

See if includes all the partitions you created earlier (including the swap)

### 7. Post-deploy steps

Chroot to your new installation by executing `arch-chroot /mnt`

Create a new user by executing `useradd -m <username>`.
Do `passwd <username>` and set your user password.
Do `passwd root` and set the password for the superuser.

Assign yourself some groups:

```
usermod -a -G audio,video,uucp,wheel <username>
```

Configure `sudo` by running `EDITOR=nvim visudo`. Search for a line:
```
## Uncomment to allow members of group wheel to execute any command
```
and uncomment the next line.

You can now exit chroot by pressing Ctrl+D

### 8. Setting up boot process

We now need a way for the UEFI to find and boot your kernel.
Some people use bootloaders like GRUB. I dislike it - it's an extra piece of software with it's own quirks and bugs.

There is a way for your computer's firmware (UEFI) to load a kernel directly. All you have to do is to add a UEFI entry (a boot option that you can select from your UEFI boot order menu in your UEFI settings).

To just make things work and boot your system you can quickly do something like that:

```
efibootmgr --create --disk /dev/sdX --part Y --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=/dev/sdXZ rw initrd=\initramfs-linux.img'
```

Where `/dev/sdX` and `Y` are the drive (i.e `/dev/sda`) and partition number (i.e `1`) where the ESP is located. `/dev/sdXZ` is the partition where your root is located (i.e `/dev/sda2`)

You can overview the boot entries by executing `efibootmgr` without arguments.
You can remove options that you created previosly using `efibootmgr -B -b <option number>`.

After you boot up and get into a graphical environment you can make a proper boot entry with resume partition, microcode, custom parameters and so on:

```
efibootmgr --create --disk /dev/sdX --part Y --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=PARTUUID=<root partition uuid> rw initrd=\<intel or amd>-ucode.img initrd=\initramfs-linux.img resume=PARTUUID=<resume partition uuid> quiet vt.global_cursor_default=0
  
```

I wish there was a utility to autodetect your settings (or read some configuration file) and create such entries automatically. This is usually a hardest part of installation for me :)

### 9. Post-install (minor steps that you can do after the first boot)

1. Uncomment required locales in `/etc/locale.gen` and run `locale-gen`;
2. Update `/etc/locale.conf`;
3. Seed the `/etc/hostname` (i.e `thinkpad`);
4. Set the timezone by doing `timedatectl set-timezone <timezone>`. <timezone> should be something like `Europe/Warsaw`;
5. Setup the network time by running `timedatectl set-ntp on`;
6. Enable and start the `NetworkManager` service, connect to your WiFi using `nmtui`;
7. Edit `/etc/pacman.conf`, uncomment `Color`, assign `ParallelDownloads`.

## Disclaimer

Inspired mainly by Luke Smith's voidrice and bits found all over the internet


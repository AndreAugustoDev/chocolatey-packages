﻿# KDE Connect - desktop app

KDE Connect is a multi-platform app that allows your devices to communicate (eg: your phone and your computer).

## (Some) Features

- **Shared clipboard**: copy and paste between your phone and your computer (or any other device).
- **Notification sync**: Read and reply to your Android notifications from the desktop.
- **Share files and URLs** instantly from one device to another including some filesystem integration.
- **Multimedia remote control**: Use your phone as a remote for Linux media players.
- **Virtual touchpad**: Use your phone screen as your computer's touchpad and keyboard.
- **Presentation remote**: Advance your presentation slides straight from your phone.

All this is done completely wirelessly, utilising TLS encryption.

## How does it work?

KDE Connect consists of a UI-agnostic "core" library that exposes a series of DBus interfaces, and several UI components that consume these DBus interfaces. This way, new UI components can be added to integrate better with specific platforms or desktops, without having to reimplement the protocol or any of the internals. The core KDE Connect library is also divided into 4 big blocks:

- **LinkProviders**: Are in charge of discovering other KDE Connect-enabled devices in the network and establishing a Link to them.
- **Devices**: Represent a remote device, abstracting the specific Link that is being used to reach it.
- **NetworkPackets**: JSON-serializable and self-contained pieces of information to be sent by the plugins between devices.
- **Plugins**: Independent pieces of code that implement a specific feature. Plugins will use NetworkPackets to exchange information through the network with other Plugins on a remote Device.

## Contributing

To contribute patches, use [KDE Connect's GitLab](https://invent.kde.org/kde/kdeconnect-kde). There you can also find a task list with stuff to do and links to other relevant resources. It is a good idea to also subscribe to the [KDE Connect mailing list](https://mail.kde.org/mailman/listinfo/kdeconnect). We can also be reached on IRC at #kdeconnect on freenode or on [telegram](https://t.me/joinchat/AOS6gA37orb2dZCLhqbZjg), contributions and feedback are warmly welcomed.

Please know that all translations for all KDE apps are handled by the [localization team](https://l10n.kde.org/). If you would like to submit a translation, that should be done by working with the proper team for that language.

## License

[GNU GPL v2](https://www.gnu.org/licenses/gpl-2.0.html) and [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html)

If you are reading this from Github, you should know that this is just a mirror of the [KDE Project repo](https://invent.kde.org/network/kdeconnect-kde).

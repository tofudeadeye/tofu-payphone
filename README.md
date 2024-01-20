# tofu-payphone - work in progress

This script makes any in-world payphone entity usable. Each payphone has its own unique phone number which players can use to make and receive calls.

### Features

- [x] Configure any model with a pre-determined phone number.
- [] Pay Phones can make and receive calls.
- [x] Pay Phones play 3d audio from the model entity when ringing.
- [x] Pay Phone keypad emits DTMF (dual-tone multi frequency) sounds for each key press, simulating real dial tones.
- [x] Automated reply message if a player attempts to message a pay phone.
- [] database logging of calls made from pay phones.

### Dependencies

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [nwpd](https://github.com/project-error/npwd)

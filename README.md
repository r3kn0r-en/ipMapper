# ipMapper
Script to map every IPv4's geolocation
## Script by r3kn0r

This tool is mapping EVERY IPv4 lovated in russia.
The tool is using the third-party-tool "geoiplookup", which is a free usable linux package.

### SHORT:
#### USAGE:
chmod +x RuIpMapper.sh
python3 carrier.py -L INT (lowest IP-Range to start with) -U INT (last ip-Range to map)
EXAMPLE:
- python3 carrier.py -L 130 -U 149
(This would create 20 screens mapping every IP in between the range 130.0.0.0 - 149.255.255.255)

the output-files will be stored in the ./output/ folder.

### ATTENTION:

- This tool is taking much CPU usage and can execute several hours!
- For example: I have an Intel 8700K with 6 cores/12 logical processors.

- If I start the script scanning every 255 ip-ranges, it would take ~4.5 days,
- based on the time the script is executing, and the number of ip's scanned within this time.
- Also my CPU is at 100% Usage.
- In comparsion: If I scan just one ip-range the execution time would be ~8hours, but CPU isn't bottlenecking here at all.
- Scanning every 255 ranges, result in 255 seperate screens running at once so the CPU is the limiting factor here.

- It's not compiled, so you can see by yourself what this script is doing.
- This is important that you dont get infected by malicious software.



#### REMINDER:
- ESPECIALLY IN THIS TIMES
- NEVER USE SOFTWARE WHICH YOU DONT UNDERSTAND
- OR AT LEAST BEING ABLE TO LOOK UP IT'S SOURCE CODE

##### Working with:
- Python 3.9.10
- Screen version 4.09.00 (GNU) 30-Jan-22
- geoip-bin

#### REQUREMENTS:
- python3
- screen
- geoip-bin

##### PREPARATION:
+ TEST:
python3 --version
- expected response similar to:
- "Python 3.9.10"

screen --version
- expected response similar to:
- "Screen version 4.09.00 (GNU) 30-Jan-22"

geoiplookup -h
- expected response similar to:
- "Usage: geoiplookup [-h] [-?] [-d custom_dir] [-f custom_file] [-v] [-i] [-l] <ipaddress|hostname>"

if you dont get the expected response, do the following:

in any case execute (this will get a list of packages which can be updated in your system. this is really linux basic):
apt update

based on not working packages execute:

apt install geoip-bin
apt install python3
apt install screen

##### How it works:
With the carrier.py you can start multiple screens running the mapping. each screen will mapping one major subnet.
Example:
every screen is mapping a specific range:
46 is mapping:
- 46.0.0.0 - 46.255.255.255
120 is mapping:
- 120.0.0.0 - 120.255.255.255
and so on

while executing the carrier.py the file "massKill.py" will be automaticly created.
With this script you can kill all the screens which are created with this tool.
After executing it, the massKill.py will delete itself too.
Alternatively you can run "carrier.py -k" to execute this file.

while the screens are running, the IP's located in russia will be mapped in a text-file-
### ATTENTION
This files can become large!
In this file, every ip will be stored in a seperate line.
That means:
the highest possible ip is "255.255.255.255"
so we assume that we have !PER FILE! a maximum of 255x255x255 (16.581.375 (16.5 Million)) Lines.
And so that the last line and therefore the largest possible string would be 255.255.255.255 + a line break.
So thats max 16 byte per line.
and this will lead to a max file size of
16581375 x 16 bytes
= 265.302.000 bytes
- (265.3 Mbytes/File)

this means, that if we would write down every IPv4 existing, we would get a filesize of ~67.7 GB

just if every ip in this range is geolocated in russia, which it wouldn't.
This is just a theoretical possibility

The files will be named after the IP-Range scanned.
The files will begin with ###BEGINNING OF FILE###
The files will end with ###END OF FILE###
- THE FILES WOUNT DELETE ITSELF IF YOU STOP THE SCREENS!
- YOU'LL HAVE TO DELETE THE FILES BY YOURSELF IF YOU WANT TO RESTART!
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
###Tool by r3kn0r###
### This is just a container to start multiple scripts ###
import os
import sys
import getopt
import subprocess

def main(argv):
    kill = 0
    lowest = 0
    upperst = 255
    processList = []
    try:
        opts, args = getopt.getopt(argv,'hkL:U:',['lowest=','upperst='])
    except getopt.GetoptError:
        print('python3 carrier.py -L <lowest "ip-range" INT> -U <last "ip-range" INT> [-h]\n Example: python3 carrier.py -L 150 -U 250 \n -k for killing the existent screens')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('python3 carrier.py -L <lowest "ip-range" INT> -U <last "ip-range" INT> [-h]\n Example: python3 carrier.py -L 150 -U 250 \n -k for killing the existent screens')
            sys.exit()
        elif opt in ('-L', '--lowest'):
            lowest = int(arg)
        elif opt in ('-U', '--upperst'):
            upperst = int(arg)
        elif opt in ('-k', '--kill'):
            kill = 1
    if kill > 0:
        os.system('python3 massKill.py')
        return 1
    if lowest > upperst:
        print('-L has to be smaller or equal to -U')
    os.system('chmod +x ./RuIpMapper.sh')
    while lowest <= upperst:
        os.system('screen -L -d -m -S GEOIP_' + str(lowest) + ' ./RuIpMapper.sh ' + str(lowest))
        processList.append(subprocess.check_output("screen -ls | awk '/\." + "GEOIP_" + str(lowest) + "\t/ {print strtonum($1)}'", shell=True).decode("utf-8").rstrip("\n"))
        lowest += 1
    shutfile = open("massKill.py", "w")
    shutfile.write("#!/usr/bin/env python3\n# -*- coding: utf-8 -*-\nimport os\n")
    for processNumber in processList:
        shutfile.write("print('Killing " + processNumber + "')\nos.system('screen -X -S "+ processNumber + " quit')\n")
    shutfile.write("os.system('rm massKill.py')")
    shutfile.close()

if __name__ == '__main__':
   main(sys.argv[1:])

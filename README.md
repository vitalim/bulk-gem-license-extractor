# bulk gem license extractor

Extract license information from all ruby projects into a single csv

The script depands on RVM being you ruby manager. You should also make sure to have the latest version of you code (git pull) and install all the gems (although the script will run bundle just in case).

The output file will include the name, version, license and link of the gem.

# How it works
The script will inject a rake file to all the projects that loops from the gem's and outputs them into a single CSV File. The script will invoke the rake tasks one by one.


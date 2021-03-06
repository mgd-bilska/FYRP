#  This PRAAT script takes .wav files and TextGrids from a 
#  user-specified directory and opens them all. 
#  PRAAT-specific format called a TextGrid
#
#  INSTRUCTION:
#  Open this script in PRAAT and run it. Select the directory with the 
#  .wav and .TextGrid files. Make any necessary adjustments and save 
#  the TextGrid.
#
#  WARNING: In case of a high number of files, the processing can take 
#  a few minutes and PRAAT will open a lot of windows, so don't be 
#  surprised 
#
#  Script developed by Magdalena Bilska, Human-Machine Communication 
#  student at the Faculty of Science and Engineering at the University 
#  of Groningen (m.bilska@student.rug.nl/https://github.com/mgd-bilska)
#
#  Project supervisor: dr. Jacolien van Rij-Tange 
#  (https://www.jacolienvanrij.com/)
#
#  Version of PRAAT used: 6.1.16
#
#  Resources used while developing the script: 
#  The official PRAAT manual 
#  (https://www.fon.hum.uva.nl/praat/manual/)
#  PRAAT scripting tutorial by Daniel Riggs 
#  (http://praatscriptingtutorial.com/)
#  PRAAT scripting tutorial by Jörg Mayer 
#  (http://praatscripting.lingphon.net/)
#  Praat scripting manual (workshop) for beginners
#  by Mauricio Figueroa
#  (http://www.mauriciofigueroa.cl/)
#  Praat Scripting for dummies∗ by Shigeto Kawahara
#  (http://user.keio.ac.jp/~kawahara/)
#
#  
#  --------------------------------------------------------------------

# select a directory with the files (all .wav and .TextGrid files will 
# be read in)
directoryName$ = chooseDirectory$: "Choose a directory"
# create a list of sound file names 
wavList = Create Strings as file list: "list", directoryName$ + "/*.wav"
# create a list of sound file names 
textGridList = Create Strings as file list: "list", directoryName$ + "/*.TextGrid"
# find the number of sound files (for the loop)
numberOfFiles = Get number of strings

# load all sound files
for i to numberOfFiles

    # select wavList
    selectObject: wavList
    # extract name of file (one by one)
    wavName$ = Get string: i
    # load sound file
    wavID = Read from file: directoryName$ + "/" + wavName$
    # select textGridList
    selectObject: textGridList
    # extract name of file (one by one)
    textGridName$ = Get string: i
    # load TextGrid
    textGridID = Read from file: directoryName$ + "/" + textGridName$
    # open the TextGrids to make adjustments 
    selectObject: wavID
    plusObject: textGridID
    View & Edit

# end the loop 
endfor

# remove the list of file names from objects
removeObject: wavList
removeObject: textGridList









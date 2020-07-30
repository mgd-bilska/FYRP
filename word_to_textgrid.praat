#  This PRAAT script takes .wav files and annotates them using 
#  PRAAT-specific format called a TextGrid
#  The purpose of this script is to detect intervals of silences
#  and sounds and label them accordingly. To do that, PRAAT 
#  detects the sounds using a built-in function (some options can be 
#  adjusted - see below) and displays all of the created TextGrids 
#  so that the user can make manual adjustments/quality control 
#
#  WARNING: In case of a high number of files, the processing can take 
#  a few minutes and PRAAT will open a lot of windows, so don't be 
#  surprised 
#
#  The label of the sounding interval is taken from the names of the 
#  analyzed .wav  files (example of a name of a .wav file that this 
#  script was developed to process: 1_030_wn_5_meisje_WN.wav; however,
#  other names can be used too if the REGEX is adjusted)
#  
#  In each file ONLY ONE SOUNDING INTERVAL IS EXPECTED!
#
#  Script developed by Magdalena Bilska, Human-Machine Communication 
#  student at the Faculty of Science and Engineering at the University 
#  of Groningen
#
#  Project supervisor: dr. Jacolien van Rij-Tange 
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

# select a directory with the sound files (all .wav files will be read in)
directoryName$ = chooseDirectory$: "Choose a directory"
# create a list of sound file names 
fileList = Create Strings as file list: "list", directoryName$ + "/*.wav"
# find the number of sound files (for the loop)
numberOfFiles = Get number of strings

# load all sound files
for i to numberOfFiles

    # select fileList
    selectObject: fileList
    # extract name of file (one by one)
    fileName$ = Get string: i
    # find start and stop index of the word in the file name 
    # CHANGE THE REGEX (PARTS BETWEEN QUOTATION MARKS) DEPENDING ON YOUR 
    # FILE NAMES
    # find start position of the word
    nameStart = rindex_regex (fileName$, "(?<=_)[a-z]*_")
    # find end position of the word
    nameStop = index_regex (fileName$, "_(?=WN)")
    # subtract one form the other to obtain the length of the word 
    nameLength = nameStop - nameStart 
    # extract the word 
    nameWord$ = mid$ (fileName$, nameStart, nameLength)
    # load sound file
    fileID = Read from file: directoryName$ + "/" + fileName$
    # make TextGrid of file with silence detection 
    # VARIABLES: MINIMUM PITCH (HZ), TIME STEP (S), SILENCE THRESHOLD 
    # (DB), MIN. SILENT INTERVAL DURATION (S), MIN. SOUNDING INTERVAL 
    # DURATION (S), SILENT INTERVAL LABEL, SOUNDING INTERVAL LABEL
    To TextGrid (silences): 80, 0, -25.75, 0.2, 0.12, "silence", nameWord$
    
    # open the TextGrid to make adjustments 
    plusObject: fileID
    View & Edit

# end the loop 
endfor

# remove the list of file names from objects
removeObject: fileList









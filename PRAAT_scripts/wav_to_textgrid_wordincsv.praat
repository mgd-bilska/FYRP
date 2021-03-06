#  This PRAAT script takes .wav files and annotates them using 
#  PRAAT-specific format called a TextGrid
#  The purpose of this script is to detect intervals of silences
#  and sounds and label them accordingly. To do that, PRAAT 
#  detects the sounds using a built-in function (some options can be 
#  adjusted - see below) and displays all of the created TextGrids 
#  so that the user can make manual adjustments/quality control 
#  The TextGrids have to be saved post-adjustment! Ctrl+s does the job
#  
#  INSTRUCTION:
#  Open this script in PRAAT and run it. First select the directory 
#  with the .wav files, and then the .csv file with the word labels.
#  PRAAT will create and open the TextGrids. Make any necessary 
#  adjustments and save the TextGrid.
#
#  WARNING: In case of a high number of files, the processing can take 
#  a few minutes and PRAAT will open a lot of windows, so don't be 
#  surprised 
#
#  The label of the sounding interval is taken from an additional .csv 
#  file provided by the user - the order of the words in the .csv file
#  has to be the same as that of the .wav files in the directory!
#  
#  In each file ONLY ONE SOUNDING INTERVAL IS EXPECTED (if there are 
#  multiple, they will be all labeled with the same word).
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

# select a directory with the sound files (all .wav files will be read in)
directoryName$ = chooseDirectory$: "Choose the directory containing sound files"
# create a list of sound file names 
fileList = Create Strings as file list: "list", directoryName$ + "/*.wav"
# find the number of sound files (for the loop)
numberOfFiles = Get number of strings

# select a directory with the .csv file
csvFileName$ = chooseReadFile$: "Choose the .csv file with typed words"
# create a list of word names 
words$ = readFile$: csvFileName$
# make the .csv into more PRAAT readable format - one in which the words
# are separated by the newline character 
wordsNL$ = replace$ (words$, ",", newline$, 0)
# save the file temporarily 
writeFileLine: "wordsNL.txt", wordsNL$
# load the just created file in a suitable format 
wordList = Read Strings from raw text file: "wordsNL.txt"
# find the number of  words (for the loop)
numberOfWords = Get number of strings
# remove the .txt file with names - it won't be useful anymore
deleteFile: "wordsNL.txt"

# CHECK IF FILES = WORDS

# if they are not equal, display error message and quit script 
if numberOfFiles <> numberOfWords
    # but first remove all created objects
    removeObject: fileList
    removeObject: wordList
    exitScript: "The number of files in the directory is not the same as the number of words in the .csv file."
# else continue
else
# end of the if statement     
endif


# load all sound files
for i to numberOfFiles
    # select fileList
    selectObject: fileList
    # extract i-th name of file
    fileName$ = Get string: i
    # now select the word list and extract the i-th word 
    selectObject: wordList
    wordName$ = Get string: i
    # load sound file
    fileID = Read from file: directoryName$ + "/" + fileName$
    # make TextGrid of file with silence detection 
    # VARIABLES: MINIMUM PITCH (HZ), TIME STEP (S), SILENCE THRESHOLD (DB), 
    # MIN. SILENT INTERVAL DURATION (S), MIN. SOUNDING INTERVAL DURATION (S), 
    # SILENT INTERVAL LABEL, SOUNDING INTERVAL LABEL
    To TextGrid (silences): 80, 0, -25.75, 0.2, 0.12, "silence", wordName$
    # open the TextGrid to make adjustments 
    plusObject: fileID
    View & Edit
# end the loop 
endfor

# remove the list of file names
removeObject: fileList
# remove the list of words 
removeObject: wordList







#  This PRAAT script extracts information (interval onset, offset, 
#  duration and label) from PRAAT .TextGrid files
#  TextGrids used while developing this script had only one tier and 2+ 
#  sounding intervals. Out of them all but one were labeled "silence", 
#  and the sounding one was labeled with the word pronouced by the 
#  participant.
#
#  INSTRUCTION: 
#  Open this script in PRAAT and run it. After selecting the directory 
#  with the .TextGrid files, the .csv file including the data (label, 
#  onset, offset and duration) will appear in the same directory
#  (intervals.csv).
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
#  
#  Structure and some functions based on the script originally written 
#  by Mietta Lennes and revised by Shigeto Kawahara (2009), partly 
#  translated by Frits van Brenk (2015) 
#  (https://lennes.github.io/spect/)
#
#  --------------------------------------------------------------------

# global variable - for the purpose of this script, only tier 1 is taken
# into account 
tier = 1

# select a directory with the sound files (all .TextGrid files will be 
# read in)
directoryName$ = chooseDirectory$: "Choose a directory"
# create a list of .TextGrid file names 
fileList = Create Strings as file list: "list", directoryName$ + "\*.TextGrid"
# find the number of .TextGrid files (for the loop)
numberOfFiles = Get number of strings

# loop for all the .TextGrid files in directory
for fileNumber to numberOfFiles
    
    # select fileList (it needs to be selected for its content to be 
    # used)
    selectObject: fileList
    # extract name of the fileNumber-th file
    fileName$ = Get string: fileNumber
    # load the respective TextGrid
    textGridID = Read from file: directoryName$ + "/" + fileName$
    # select the TextGrid
    selectObject: textGridID
    
    # as of here we're going to start working with the intervals 
    # existing in the TextGrid to extract data

    # get the number of intervals
    numberOfIntervals = Get number of intervals: tier
    
    # loop for every interval 
    for interval from 1 to numberOfIntervals

        # find the label of the interval-th interval (first, second, etc.)
        label$ = Get label of interval: tier, interval
        # if label is not "silence", extract its details (if it is, 
        # then function skips to the next interval and so on)
        if label$ <> "silence"
            # extract the onset, offset, and duration
            onset = Get starting point: tier, interval
            offset = Get end point: tier, interval
            duration = offset - onset
            # append info to a .txt file (it will be saved in the 
            # directory chosen at the beginning)
            appendFileLine: directoryName$ + "/" + "intervals.txt", label$, " ", onset, " ", offset, " ", duration

        endif

    # end the interval loop
    endfor

    # remove the used TextGrid
    removeObject: textGridID

# end the file loop      
endfor

# remove the list of file names 
removeObject: fileList
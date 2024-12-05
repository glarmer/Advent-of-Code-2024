#!/usr/bin/tclsh

#Open and read the file
set file [open "input.txt" r]
set text [read $file]
close $file
set results [split [string map [list "\n\n" "\x00"] $text] "\x00"]
set rulesText [lindex $results 0]
set updatesText [lindex $results 1]

#Create an array storing a list of the rules for each number
set lines [string range $rulesText 0 end-1]
foreach line [split $lines \n] {
    set rule [split $line "|"]
    set number1 [lindex $rule 0] 
    set number2 [lindex $rule 1] 
    if {[info exists ::rules($number1)] != 0} {
        lappend rules($number1) $number2
    } else {
        set rules($number1) [list $number2]
    }
}

set count 0
set lines [string range $updatesText 0 end-1]
foreach line [split $lines \n] {
    set update [split $line ","]
    set previousPages [list 0]
    set invalid "false"
    #Iterate over each 'update' e.g. 61,13,29
    foreach page $update {
        if {[info exists ::rules($page)] != 0} {
            #Check if it violates any rules
            foreach previousPage $previousPages {
                if {[lsearch -exact $rules($page) $previousPage] >= 0} {
                    puts "Invalid!"
                    set invalid "true"
                }
            }
        }
        lappend previousPages $page
    }
    #Add to the total if it is valid
    if {$invalid == "false"} {
        set length [llength $update]
        set middle [expr {((($length * 10) / 2) - 5) / 10}]
        set middleValue [lindex $update $middle]
        set count [expr {($middleValue + $count)}]
    }
}
puts $count

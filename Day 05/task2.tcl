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

proc fixUpdate {update previousPages argRules} {
    #puts $update
    set index 0
    array set rules $argRules
    foreach page $update {
        if {[info exists ::rules($page)] != 0} {
            #Check if it violates any rules
            #puts "START"
            #puts $page
            #puts $rules($page)
            #puts $update
            #puts $index
            
            
            foreach previousPage $previousPages {
                #puts "hi"
                #puts $rules($page)
                #puts $previousPage
                puts $update
                puts [lsearch -exact $rules($page) $previousPage]
                if {[lsearch -exact $rules($page) $previousPage] >= 0} {
                    set index2 [lsearch $update $previousPage]
                    set list2 [lrange $update 0 end]
                    puts "FUCK"
                    puts $list2
                    set invalid "true"
                    set temp [lindex $update $index]
                    lset update $index [lindex $update $index2]
                    lset update $index2 $temp
                    
                    #puts $index2
                    #puts $previousPage
                    puts $update
                    #puts "INVALID"

                    if {$update == $list2} {
                        puts "HELLO BABY"
                        return $update
                    }

                    if {[lindex $update 0] == "93" && [lindex $update 1] == "73" && [lindex $update 2] == "42" && 
                    [lindex $update 3] == "67" && [lindex $update 4] == "26" && [lindex $update 5] == "35" && 
                    [lindex $update 6] == "71" && [lindex $update 7] == "66" && [lindex $update 8] == "45" && 
                    [lindex $update 9] == "96" && [lindex $update 10] == "95" && [lindex $update 11] == "88" && 
                    [lindex $update 12] == "81" && [lindex $update 13] == "24" && [lindex $update 14] == "86"} { 
                        puts [lsearch -exact $rules($page) $previousPage]
                        puts $previousPage
                        puts $rules($page)
                        puts "HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        puts $update
                        return $update
                    }

                    set update [fixUpdate $update [list 0] [array get rules]]
                } 
            }
        }
        incr index
        lappend previousPages $page
    }
    return $update
}

set count 0
set count2 0
set lines [string range $updatesText 0 end]
foreach line [split $lines \n] {
    set update [split $line ","]
    set previousPages [list 0]
    set invalid "false"
    
    #Iterate over each 'update' e.g. 61,13,29
    puts "1"
    puts $update
    set newUpdate [fixUpdate $update $previousPages [array get rules]]
    puts "2"
    puts $newUpdate

    if {$update != $newUpdate} {
        set invalid "true"
    }

    #Add to the total if it is valid
    set length [llength $newUpdate]
    set middle [expr {((($length * 10) / 2) - 5) / 10}]
    set middleValue [lindex $newUpdate $middle]
    puts $middleValue
    if {$invalid == "false"} {
        set count [expr {($middleValue + $count)}]
    } else {
        set count2 [expr {($middleValue + $count2)}]
    }
}

puts $count
puts $count2
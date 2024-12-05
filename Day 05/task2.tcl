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

proc fixUpdate {update argRules} {
    #puts $update
    set index 0
    array set rules $argRules
    set previousPages []
    foreach page $update {
        #puts "COMPARISON"
        puts $update
        puts "PREVIOUS PAGES"
        puts $previousPages
        puts [llength $previousPages]
        #puts [expr ([llength $update] - 2)]
        if {[info exists ::rules($page)] != 0} {
            foreach previousPage $previousPages {
                if {[lsearch -exact $rules($page) $previousPage] >= 0} {
                    
                    set index2 [lsearch $update $previousPage]
                    set temp [lindex $update $index]
                    lset update $index [lindex $update $index2]
                    lset update $index2 $temp

                    set testPages [lrange $update 0 $index]
                    foreach testPage $testPages {
                        if {[lsearch -exact $rules($page) $testPage] >= 0} {
                            set update [fixUpdate $update [array get rules]]
                        } 
                    }
                    #set update [fixUpdate $update [array get rules]]
                } 
            }
        }
        incr index
        set previousPages [lrange $update 0 $index]
        if {$previousPages == $update} {
            puts "RETURNED"
            return $update
        }
    }
    return $update
}

set count 0
set count2 0
set lines [string range $updatesText 0 end]
foreach line [split $lines \n] {
    set update [split $line ","]
    set previousPages [list ]
    set invalid "false"
    
    #Iterate over each 'update' e.g. 61,13,29
    puts "1"
    puts $update
    set newUpdate [fixUpdate $update [array get rules]]
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
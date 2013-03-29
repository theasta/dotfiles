#!/usr/bin/env ruby
# encoding: UTF-8
# everwatch.rb by Brett Terpstra, 2011
# Watch Evernote for updates and put the current content of the editor into a preview file for Marked.app
# <http://markedapp.com>
# Modified by dan@rosenstark.com, 2012
require 'digest/sha2'
 
$debug = false
$last_hash = "no hash yet"
 
def doEverything
    trap("SIGINT") { exit }
 
    marked_note = File.expand_path("~/EvernoteSnippetInMarkdown.md")
    watch_note = File.new("#{marked_note}",'w')
    watch_note.puts "Your markdown will be arriving shortly..."
    watch_note.close
    `open -a Marked "#{marked_note}"`
 
    print_and_flush "Waiting." if $debug
 
    while true do # repeat infinitely
      doEverythingInner marked_note
      sleep 1
    end
end
 
def doEverythingInner marked_note
    note = get_note_content_from_evernote
    unless note.strip == '' # if we got something back from the AppleScript
      hash = (Digest::SHA2.new << note).to_s
      if (hash == $last_hash) then
        print_and_flush "." if $debug
      else
        $last_hash = hash
        note = note.gsub("'","APOSTROPHEEE") 
        # convert the contents to plain text
        txtnote = %x{echo '#{note}'|textutil -stdin -convert txt -stdout}
        txtnote = txtnote.gsub("APOSTROPHEEE", "'") 
     
        txtnote = txtnote.gsub("\t•","-") # you can use the evernotey bullets
        txtnote = txtnote.gsub("\t◦","    -") 
        txtnote = txtnote.gsub(/\t\d{1,4}\.\t/, "1. ")  # use evernote numbering, but only one level
        txtnote = txtnote.gsub("\t", "    ")            # replace tabs
        txtnote = txtnote.gsub("\302\240", " ")         # some bizarre space-looking character textutil or Evernote uses
         
        # write the contents to the preview file
        watch_note = File.new("#{marked_note}",'w')
        watch_note.puts txtnote
        watch_note.close
        sleep 1
      end
    end
end
 
def get_note_content_from_evernote
    # get the contents of the post and continued editor screens
    note = %x{ osascript <<APPLESCRIPT
        tell application "System Events" to set isRunning to the count of (processes whose name is "Evernote")
        if (isRunning > 0)
            tell application "Evernote"
                if selection is not {} then
                    set the_selection to selection
                    return HTML content of item 1 of the_selection
                else
                    return ""
                end if
            end tell
        else
            return ""
        end if
APPLESCRIPT}
    note
end
 
def print_and_flush(str)
  print str
  $stdout.flush
end
 
if __FILE__ == $0
    doEverything
end

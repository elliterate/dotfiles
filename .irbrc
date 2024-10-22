require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

begin
  require 'awesome_print'
rescue LoadError
end

begin
  require 'interactive_editor'
rescue LoadError
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

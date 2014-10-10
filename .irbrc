require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

begin
  require 'ap'
rescue LoadError
end

begin
  require 'wirble'
rescue LoadError
  IRB.conf[:PROMPT_MODE] = :SIMPLE
else
  Wirble.init
  Wirble.colorize
end

begin
  require 'interactive_editor'
rescue LoadError
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

## To add dependencies to default task                 
task :default => [:main,:thanks]

desc 'Calls powershell task from current task'
task :main do
  Rake::Task['powershell'].invoke
end

desc 'Greets with thank you message'
task :thanks => [:main] do
  puts "THANK YOU FOR USING RAKE!!"
end

desc "Calls the normal powershell script"
task :powershell do
  sh 'powershell.exe Manikanta/ps_script3.ps1', verbose: false
  #verbose: false is to not display the command itself in the console
end 



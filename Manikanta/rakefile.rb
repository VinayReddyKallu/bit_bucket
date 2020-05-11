                
task :default => [:hello,:powershell,:thanks]


desc 'Greets with hello message'
  task :hello do
    puts "HELLO USERS!"
    puts ""
  end

desc 'Greets with thank you message'
  task :thanks => [:hello,:main] do
    puts ""
    puts "THANK YOU FOR USING RAKE!!"
    puts ""
  end

desc "Calls the normal powershell script"
  task :powershell do
    sh 'powershell.exe Manikanta/ps_script3.ps1', verbose: false
  end 



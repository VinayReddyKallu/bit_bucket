                
task :default do
  puts "Welcome User.. You are in default task"
  puts ""
  Rake::Task['powershell'].invoke
end

desc 'Greets with thank you message'
  task :thanks do
    puts "THANK YOU FOR USING RAKE!!"
    puts ""
  end

desc "Calls the normal powershell script"
  task :powershell do
    sh 'powershell.exe Manikanta/ps_script3.ps1', verbose: false
    puts ""
    Rake::Task['thanks'].invoke
  end 



## To add dependencies to default task                 
#task :default => [:main,:thanks]

desc 'Calls powershell task from current task'
task :main do
  Rake::Task['cpp'].invoke
end

desc 'Greets with thank you message'
task :thanks => [:main] do
  puts "THANK YOU FOR USING RAKE!!"
end

desc "Calls the normal powershell script"
task :powershell do
  sh 'powershell.exe Manikanta/ps_script.ps1', verbose: false
  #verbose: false is to not display the command itself in the console
end 

task :cpp,[:vnum] do |task,args|
  begin
    version = args[:vnum]
    #sh 'g++ Manikanta/greetings.cpp -o greet'
    #sh "powershell.exe Compress-Archive greet.exe build_version_#{args.vnum}.zip"
    Rake::Task['thanks'].invoke
    #Rake::Task['remove'].invoke
  rescue
    #sh 'powershell.exe Remove-Item greet.exe'
    puts "VERSION ALREADY EXISTS, OVERWRITING IT"
    Rake::Task['version_update'].invoke(version)
  end
end

task :remove do
    sh 'powershell.exe Remove-Item greet.exe'
end

task :version_update,[:vnum] do |task,args|
  puts "WORKING CHECK"
  sh 'g++ Manikanta/greetings.cpp -o greet'
  sh "powershell.exe Compress-Archive -Update greet.exe build_version_#{args.vnum}.zip"
  Rake::Task['thanks'].invoke
  Rake::Task['remove'].invoke
end

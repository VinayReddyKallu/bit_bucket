## To call the names of all tasks as a list or array without any environment
task default: %w(
                  hello
                  main
                  thanks
                 )

## To call the names of all tasks as a list or array with greetings environment
#task default: %w(
#                  greetings:hello
#                  main
#                  greetings:thanks
#                 )
                 
## To add dependencies to default task                 
#task :default => [:hello,:main,:thanks]

desc 'Calls powershell task from current task'
task :main do
   puts "THIS IS FROM DEFAULT TASK"
   puts ""
   Rake::Task['execution:powershell'].invoke
end

#namespace :greetings do
desc 'Greets with hello message'
  task :hello do
    puts "HELLO USERS!"
    puts ""
  end

  desc 'Greets with thank you message'
  task :thanks => [:hello] do
    puts ""
    puts "THANK YOU FOR USING RAKE!!"
    puts ""
  end
#end

namespace :execution do
  desc 'Calls the batch script'
  task :batch do
    sh './batch_script', verbose: false
    #verbose: false is to not display the command itself in the console
  end

  desc "Calls the parameterized powershell script"
  task :param_ps, [:first_name, :last_name] do |task, args|
    sh "powershell.exe ./ps_script1.ps1 #{args.first_name} #{args.last_name}", verbose: false
    #puts args[:first_name]
    #puts args[:last_name]
    #the parameters should be passed form cmd as, rake execution:param_ps[manikanta,shivva]
  end 

  desc "Calls the ps application built earlier"
  task :application_ps do
    sh "powershell.exe -Command './ps_script2.ps1'", verbose: false
  end 

  desc "Calls the normal powershell script"
  task :powershell do
    sh 'powershell.exe Manikanta/ps_script3.ps1'
  end 
end


# encoding: utf-8
namespace :lines do
  

  namespace :db do
    desc "Load lines seeds"
    task :seed do
      Lines::Engine.load_seed
    end
  end


  desc "Create a new Lines User"
  task :create_user => :environment do
    # Get user's credentials
    puts "\n\nLets create a new user for administration. This step is required to be able to login.\n\n"
    get_credentials
    
    # Validate and create user/author
    u = Lines::User.new(email: @emailaddr, password: @pw)
    a = Lines::Author.new(email: @emailaddr, name: @author_name, description: "I am a Ruby on Rails developer who loves great-looking blog frameworks and cares about sharing beautiful code.")
    if u.valid? && a.valid? && u.save! && a.save!
      puts "\n\nUser created.\n\n"
    else
      puts "Something went wrong. lets do it again...\n"
      get_credentials
    end

  end


  desc "Migrate database, create Admin user and default entries."
  task :setup => :environment do

  begin

    # Run migrations
    Rake::Task["db:migrate"].invoke
    puts "Database created and migrations run.\n\n"
    
    # Add user
    Rake::Task["lines:create_user"].invoke

    # Display final instructions
    puts "\n\nCongrats! Your Lines blog is now ready to use. Just start the server:"
    puts "\n  rails server\n"
    puts  "...and head to #{CONFIG[:host]}/login to get started.\n\n"

  rescue SystemExit, Interrupt
    puts "\n\nBye Bye."
  rescue Exception => e
    raise
  end

  end

  
  # Reads credentials(email and password) from STDIN
  def get_credentials
    print "Your name: "
    @author_name = STDIN.gets.strip.to_s
    print "Your Emailaddress: "
    @emailaddr = STDIN.gets.strip.to_s
    print "Choose a password: "
    @pw = STDIN.gets.strip.to_s
    get_credentials if commit_credentials == false
  end

  def commit_credentials
    print "\n\nAre the above values correct? (y/n) "
    if STDIN.gets.strip.to_s == "n"
      return false
    end
    true
  end

end

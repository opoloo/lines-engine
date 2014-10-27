# encoding: utf-8
namespace :lines do
  
  namespace :db do
    desc "Load lines seeds"
    task :seed_articles do
      Lines::Engine.load_seed
    end
  end


  desc "Add a new Lines User"
  task :add_user => :environment do
    # Get user's credentials
    Rake::Task["db:migrate"].invoke
    puts "\n\nLets add a new user for administration. This step is required to be able to login.\n\n"
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

names_f = File.new('randomnames.txt', 'r')
@names = names_f.readlines
names_f.close
careers_f = File.new('randomcareers.txt', 'r')
@careers = careers_f.readlines
careers_f.close

def seed
  seed_users
  seed_labels
  seed_labellings
end

def seed_users
  puts 'Seeding users'
  250.times do |i|
    if i%25 == 0
      puts "#{(i/250.0)*100}% complete."
    end
    generate_user
  end
end

def generate_user
  usr = User.new

  firstname = @names.sample.chomp
  lastname = @names.sample.chomp

  usr.uid = Digest::SHA256.new.update(firstname + lastname).to_s

  usr.name = firstname + ' ' + lastname
  usr.email = firstname[0] + lastname + '@westport.k12.ct.us'

  usr.save
end

def seed_labels
  puts 'seeding labels'
  900.times do |i|
    if i%45 == 0
      puts "#{(i/900.0)*100}% complete."
    end
    generate_label
  end
end

def generate_label
  label = Label.new
  @careers.shuffle!
  label.name = @careers.pop

  label.save
end

def seed_labellings
  puts 'Seeding labellings'
  users = User.all
  labels = Label.all

  users.each_with_index do |user, i|
    if i%5 == 0
      puts "#{(i/250.0)*100}% complete."
    end
    5.times do
      labelling = Labelling.new
      labelling.user = user
      labelling.label = labels.sample
      labelling.weight = rand
      labelling.save
    end
  end
end
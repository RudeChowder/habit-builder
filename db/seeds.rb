puts "Seeding... 🌱"

puts "Creating Users 🙋"
u1 = User.create(email: "email@test.com", password: "password")
u2 = User.create(email: "test@test.com", password: "password")

puts "Creating Habits 📈"
h1 = Habit.create(name: "Read 1 chapter")
h2 = Habit.create(name: "Walk 5,000 steps")
h3 = Habit.create(name: "Go to the gym")
h4 = Habit.create(name: "Cook Lunch")

puts "Creating Checkins ✅"
c1 = Checkin.create(user: u1, date: "2021-10-17", notes: "Read Duma Key")
c1.habits << h1
c1.save
c2 = Checkin.create(user: u1, date: "2021-10-18", notes: "Twisted my ankle")
c2.habits << h1
c2.habits << h2
c2.save


c3 = Checkin.create(user: u2, date: "2021-10-17", notes: "new record!")
c3.habits << h3
c3.save
c4 = Checkin.create(user: u2, date: "2021-10-18", notes: "leg day")
c4.habits << h3
c4.habits << h4
c4.save

puts "Creating Goals 🎆"
Goal.create(user: u1, habit: h1, target: 15)
Goal.create(user: u1, habit: h2, target: 100)

Goal.create(user: u2, habit: h3, target: 365)

puts "Done seeding! 🌱"

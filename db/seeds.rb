puts "Seeding..."

user1 = User.create(email: "email@test.com", password: "password")
user2 = User.create(email: "test@test.com", password: "password")

h1 = Habit.create(name: "Read 1 chapter")
h2 = Habit.create(name: "Walk 5,000 steps")
h3 = Habit.create(name: "Go to the gym")
h4 = Habit.create(name: "Call mom")

c1 = Checkin.create(user: user1, date: "2021-10-17", notes: "Read Duma Key")
c1.habits << h1
c1.save
c2 = Checkin.create(user: user1, date: "2021-10-18", notes: "Twisted my ankle")
c2.habits << h1
c2.habits << h2
c2.save


c3 = Checkin.create(user: user2, date: "2021-10-17", notes: "new record!")
c3.habits << h3
c3.save
c4 = Checkin.create(user: user2, date: "2021-10-18", notes: "leg day")
c4.habits << h3
c4.habits << h4
c4.save

puts "Done seeding!"

puts "Seeding..."

user1 = User.create(email: "email@test.com", password: "password")
user2 = User.create(email: "test@test.com", password: "password")

h1 = Habit.create(name: "Read 1 chapter")
h2 = Habit.create(name: "Walk 5,000 steps")
h3 = Habit.create(name: "Go to the gym")
h4 = Habit.create(name: "Call mom")

Checkin.create(user: user1, habit: h1, date: "2021-10-17", notes: "Read Duma Key")
Checkin.create(user: user1, habit: h1, date: "2021-10-18")
Checkin.create(user: user1, habit: h2, date: "2021-10-18", notes: "Twisted my ankle")

Checkin.create(user: user2, habit: h3, date: "2021-10-17", notes: "new record!")
Checkin.create(user: user2, habit: h3, date: "2021-10-18", notes: "leg day")
Checkin.create(user: user2, habit: h4, date: "2021-10-18")

puts "Done seeding!"

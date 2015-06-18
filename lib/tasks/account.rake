namespace :admin do
  task create: :environment do
    User.create! name: "a",
      email: "a@gmail.com",
      role: 1,
      password:  "123456",
      password_confirmation: "123456"
  end
end

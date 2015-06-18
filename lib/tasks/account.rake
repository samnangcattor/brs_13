namespace :admin do
  task create: :environment do
    User.create! name: "a",
      role: "admin",
      email: "a@gmail.com",
      password: "12345678",
      password_confirmation: "12345678"
  end
end

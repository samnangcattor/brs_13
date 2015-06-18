namespace :request do
  task book: :environment do
    RequestBook.find_by(state: true).destroy
  end
end

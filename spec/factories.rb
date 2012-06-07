FactoryGirl.define do

  factory :user do
    name  'Joe'
    email 'test@gmail.com'
    admin false
  end

  sequence :date do |n|
    day = (n % 28) + 1
    month = ((n / 28) % 12) + 1
    year = ((n / 28) / 12) + 2001
    Date.new(year,month,day)
  end

  factory :tournament do
    date
  end

  factory :player do
    buy_in 20
    winnings 20
    user
    tournament
  end

  factory :tag do
    name 'tag'
  end

  factory :post do
    title 'title'
  end

  factory :album do
    name 'MyAlbum'
  end
end

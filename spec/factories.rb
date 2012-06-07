FactoryGirl.define do

  factory :user do
    name  'Joe'
    email 'test@gmail.com'
    admin false
  end

  factory :tournament do
    date {Date.new(2001,1,1)}
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

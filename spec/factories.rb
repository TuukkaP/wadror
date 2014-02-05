FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anon brewery"
    year 1900
  end

  factory :style do
    name "tyyli"
    description "kuvaus"
  end

  factory :beer do
    name "anon beer"
    brewery
    style
  end

  factory :beer_club do
    name "Anon club"
    year 1900
    city "Helsinki"
    membership
  end

  factory :membership do
    user
    beer_club
  end

end
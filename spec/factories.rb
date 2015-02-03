# This will guess the Question class
# FactoryGirl creates objects
# Faker creates string

FactoryGirl.define do
  factory :test_question do
    title "TDD is boring and meticulous"
    content "Learning a lot though about test driven development"
  end
end

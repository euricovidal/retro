# encoding : utf-8
require 'factory_girl'

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@factory.com"
  end

  sequence :id do |n|
    "1{n}9"
  end
  factory :user do
    id
    email
    name                  'José Ribeiro'
    password              '123456'
    password_confirmation '123456'
  end

  factory :retrospective do
    name               'Sprint# 1 - Mastering on Grosela'
    association :user, factory: :user
  end

  factory :invalid_retrospective, parent: :retrospective do
    name nil
  end

  factory :bad do
    description                    "Descrição Ruim"
    action                         "Acao"
    solved                         false
    votes                          1
    association :retrospective_id, factory: :retrospective
  end

  factory :good do
    description                    "Descrição Boa"
    votes                          1
    association :retrospective_id, factory: :retrospective
  end


end

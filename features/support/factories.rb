FactoryGirl.define do
  
  factory :super_admin, class: User do
    email "john@ait.asia"
  end

  factory :member, class:User do
    is_super_admin false
    is_master_admin false
    is_member true
    sequence(:email) do |n|
      "myemail+#{n}@ait.asia"
    end
  end


  factory :committee, class: Committee do
    name "Gender"
    description "very funny"
  end

  factory :new_idea, class: NewIdea do
    sequence(:name) do |n|
      "NewIdea - #{n}"
    end
    description "This is a new idea"
  end

  factory :event, class: Event do
    name 'Test Event'
    description 'This is an event.'
  end

  factory :announcement, class: Announcement do
    description 'Hello, I want to announce something'
  end
end






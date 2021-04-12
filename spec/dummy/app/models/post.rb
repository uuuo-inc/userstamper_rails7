class Post < ActiveRecord::Base
  stampable stamper_class_name: :person
  validates :creator, presence: true
  has_many :comments
end


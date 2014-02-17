class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic, :image
  has_many :comments
  belongs_to :user
  belongs_to :topic

  # Carrierwave provides a method named mount_uploader which gives an attribute 
  # additional functionality to assist in uploading. 
  # Declare mount_uploader
  mount_uploader :image, ImageUploader
  
  default_scope order('created_at DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

end

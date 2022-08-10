class Item < ApplicationRecord
  has_one_attached :image 

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  def get_image
    if image.attached?
      image
    else
      'no_image2.jpg'
    end
  end
  
end

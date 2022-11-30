class Item < ApplicationRecord
  has_one_attached :image
  has_many :order_details

  def tax_price
    # 税率
    tax_rate = 1.10
    tax_price = self.price * tax_rate
    return tax_price.floor
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end

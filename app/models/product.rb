class Product < ApplicationRecord
  before_create :assign_incremental_slug
  
  belongs_to :category, counter_cache: true 

  before_validation :set_uploaded_at, on: :create 

  has_many_attached :images

  enum :status, { normal: 0, featured: 1, best: 2 }

  def ordered_images
    images.attachments.order(:position)
  end

  private 
  def set_uploaded_at
    self.uploaded_at ||= Time.current 
  end

  

  def assign_incremental_slug
    # If no slug is already set, use the next ID number
    if self.slug.blank?
      last_slug = Product.maximum(:slug)&.to_i || 0
      self.slug = (last_slug + 1).to_s
    end
  end
end

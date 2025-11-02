class Product < ApplicationRecord
  before_create :assign_incremental_slug
  
  belongs_to :category, counter_cache: true 

  before_validation :set_uploaded_at, on: :create 

  before_validation :normalize_name
  before_validation :generate_slug, on: [:create, :update]
  validates :slug, presence: true, uniqueness: true 
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :condition, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to:10 }




  has_many_attached :images

  enum :status, { normal: 0, featured: 1, best: 2 }

  def ordered_images
    images.attachments.order(:position)
  end

  private 
  def set_uploaded_at
    self.uploaded_at ||= Time.current 
  end

  def normalize_name
    self.name = name.to_s.strip
  end

  def generate_slug 
    return if name.blank?
    base_slug = (slug.presence || name).to_s.parameterize
    new_slug = base_slug 
    counter = 2
    while self.class.exists?(slug: new_slug)
      new_slug = "#{base_slug}-#{counter}"
      counter+=1
    end 

    self.slug= new_slug 
  end 

  def assign_incremental_slug
    # If no slug is already set, use the next ID number
    if self.slug.blank?
      last_slug = Product.maximum(:slug)&.to_i || 0
      self.slug = (last_slug + 1).to_s
    end
  end
end

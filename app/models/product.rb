class Product < ApplicationRecord
  belongs_to :category

  before_validation :set_uploaded_at, on: :create 

  private 
  def set_uploaded_at
    self.uploaded_at ||= Time.current 
  end
end

class Category < ApplicationRecord
    # Always read categories in ascending display order
    #prevents you from needing to write this code over and over again 

    has_many :products, dependent: :nullify
    
    has_one_attached :image

    def category_params
      params.require(:category).permit(:name, :image)
    end

    default_scope { order(order: :asc)}
    
    before_validation :normalize_name

    validates :name, presence: true,
                    uniqueness: { case_sensitive: false }

    # CREATE: insert at desired order; push everything at/after it down by 1
    before_validation :assign_default_order, on: :create
    before_create :shift_on_insert

    # UPDATE: when order changes, move this item and shift others
    before_update :reposition_in_list , if: -> {will_save_change_to_order?}

    private
    def assign_default_order
      self.order ||= (Category.maximum(:order)||0)+1


    end 

    def normalize_name
        self.name = name.to_s.strip
    end


    def set_slug
      self.slug = name.parameterize if slug.blank?
    end
    
   def shift_on_insert
    q = Category.connection.quote_column_name('order') # => "\"order\""
    Category.where('categories."order" >= ?', self.order)
            .update_all(%Q{#{q} = #{q} + 1})
  end


  def reposition_in_list
  old_pos, new_pos = changes_to_save['order'] # => [old, new]
  return if old_pos == new_pos

  Category.transaction do
    if new_pos < old_pos
      # Moving up: shift [new_pos..old_pos-1] down by 1
      Category.where.not(id: id)
              .where(order: new_pos..(old_pos - 1))
              .update_all(%Q{"order" = "order" + 1})
    else
      # Moving down: shift [old_pos+1..new_pos] up by 1
      Category.where.not(id: id)
              .where(order: (old_pos + 1)..new_pos)
              .update_all(%Q{"order" = "order" - 1})
    end
  end
end


end
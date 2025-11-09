class CreateSlideShows < ActiveRecord::Migration[8.0]
  def change
    create_table :slide_shows do |t|
      t.integer :order

      t.timestamps
    end
  end
end

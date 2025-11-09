class CreateLogos < ActiveRecord::Migration[8.0]
  def change
    create_table :logos do |t|
      t.timestamps
    end
  end
end

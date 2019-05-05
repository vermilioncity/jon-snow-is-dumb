class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :picture
      t.text :description

      t.timestamps
    end
  end
end

class CreateHighlights < ActiveRecord::Migration[7.0]
  def change
    create_table :highlights do |t|
      t.text :highlight
      t.string :book_title
      t.string :book_author
      t.string :amazon_book_id
      t.text :note
      t.string :color
      t.string :tags
      t.string :location_type
      t.float :location
      t.datetime :highlighted_at
      t.string :document_tags

      t.timestamps
    end
  end
end

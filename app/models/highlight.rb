class Highlight < ApplicationRecord
  require 'csv'
  belongs_to :user

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      highlight_hash = {
        highlight: row['Highlight'],
        book_title: row['Book Title'],
        book_author: row['Book Author'],
        amazon_book_id: row['Amazon Book ID'],
        note: row['Note'],
        color: row['Color'],
        tags: row['Tags'],
        location_type: row['Location Type'],
        location: row['Location'],
        highlighted_at: row['Highlighted at'],
        document_tags: row['Document tags'],
        user_id: user.id
      }
      highlight = create!(highlight_hash)
    end
  end
end

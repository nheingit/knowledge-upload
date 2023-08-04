class AddUserToPrompts < ActiveRecord::Migration[7.0]
  def change
    Prompt.delete_all
    add_reference :prompts, :user, null: false, foreign_key: true
  end
end

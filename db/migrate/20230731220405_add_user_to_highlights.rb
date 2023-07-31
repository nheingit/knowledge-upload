class AddUserToHighlights < ActiveRecord::Migration[7.0]
  def change
    add_reference :highlights, :user, foreign_key: true

    # assign the first user as the default user
    default_user = User.first

    if default_user
      Highlight.update_all(user_id: default_user.id)
    end
  end
end

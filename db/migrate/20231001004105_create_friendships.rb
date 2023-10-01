class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true, null: false
      t.references :friend, references: :users, null: false

      # Guardar coordenadas en donde se origina la amistad en JSON
      # Por detault, guarda {}
      t.string :gps_coordinates, default: "{}", null: false

      t.timestamps
    end

    # Agregar clave foranea friend_id, en friendships, a users
    add_foreign_key :friendships, :users, column: :friend_id

  end
end
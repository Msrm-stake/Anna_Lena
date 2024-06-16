class CreatePublications < ActiveRecord::Migration[7.1]
  def change
    create_table :publications do |t|
      t.string :name
      t.text :description
      t.string :profile_picture

      t.timestamps
    end
  end
end

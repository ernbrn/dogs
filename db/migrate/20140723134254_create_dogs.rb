class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :image_uid
      t.date :birthdate
      t.string :breed
      t.string :summary

      t.timestamps
    end
  end
end

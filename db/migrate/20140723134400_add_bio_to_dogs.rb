class AddBioToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :bio, :text
  end
end

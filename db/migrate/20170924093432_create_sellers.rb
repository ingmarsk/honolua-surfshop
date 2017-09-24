class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
    	t.belongs_to :user
      t.integer :products_count

      t.timestamps
    end
  end
end

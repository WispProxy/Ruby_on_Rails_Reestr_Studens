class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :student, index: true
      t.references :subject, index: true
      t.integer :rating

      t.timestamps null: false
    end
    add_foreign_key :ratings, :students
    add_foreign_key :ratings, :subjects
  end
end

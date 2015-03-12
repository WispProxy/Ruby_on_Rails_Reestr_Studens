class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :surname
      t.references :group, index: true
      t.date :date_of_birth
      t.string :email
      t.string :registration_ip
      t.datetime :registration_time
      t.text :characteristic

      t.timestamps null: false
    end
    add_foreign_key :students, :groups
  end
end

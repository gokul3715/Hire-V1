class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email_
      t.integer :mobile
      t.string :role
      t.string :team
      t.binary :resume

      t.timestamps
    end
  end
end

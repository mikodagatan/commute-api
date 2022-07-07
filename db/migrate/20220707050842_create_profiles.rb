class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :middle_initial
      t.string :last_name
      t.string :sex
      t.datetime :birthday

      t.timestamps
    end
  end
end

class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company_name, null: false
      t.string :company_url
      t.string :company_email
      t.string :title, null: false
      t.text :description
      t.text :how_to_apply
      t.integer :payment_id
      t.datetime :published_at
      t.timestamps null: false
    end
  end
end
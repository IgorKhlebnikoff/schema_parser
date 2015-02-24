class CreateParsings < ActiveRecord::Migration
  def change
    create_table :parsings do |t|
      t.string :name
      t.attachment :schema_attachment
      t.attachment :xml_attachment
      t.string :snapshot

      t.timestamps null: false
    end
  end
end

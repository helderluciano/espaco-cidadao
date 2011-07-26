class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios do |t|
      t.string :content
      t.references :microposts
      t.references :users

      t.timestamps
    end
  end

  def self.down
    drop_table :comentarios
  end
end

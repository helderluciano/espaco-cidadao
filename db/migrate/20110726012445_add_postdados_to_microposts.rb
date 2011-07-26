class AddPostdadosToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :tipo, :string
    add_column :microposts, :governante, :string
    add_column :microposts, :titulo, :string
  end

  def self.down
    remove_column :microposts, :titulo
    remove_column :microposts, :governante
    remove_column :microposts, :tipo
  end
end

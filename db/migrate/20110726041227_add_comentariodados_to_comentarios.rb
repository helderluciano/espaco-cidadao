class AddComentariodadosToComentarios < ActiveRecord::Migration
  def self.up
    add_column :comentarios, :micropost_id, :integer
    add_column :comentarios, :user_id, :integer
  end

  def self.down
    remove_column :comentarios, :user_id
    remove_column :comentarios, :micropost_id
  end
end

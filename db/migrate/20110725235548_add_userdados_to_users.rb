class AddUserdadosToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :cpf, :string
    add_column :users, :rg, :string
    add_column :users, :telefone, :string
    add_column :users, :estado, :string
    add_column :users, :cidade, :string
    add_column :users, :data_nascimento, :date
    add_column :users, :logradouro, :string
    add_column :users, :sexo, :string
    add_column :users, :tipo, :string
  end

  def self.down
    remove_column :users, :sexo
    remove_column :users, :logradouro
    remove_column :users, :data_nascimento
    remove_column :users, :cidade
    remove_column :users, :estado
    remove_column :users, :telefone
    remove_column :users, :rg
    remove_column :users, :cpf
    remove_column :users, :tipo
  end
end

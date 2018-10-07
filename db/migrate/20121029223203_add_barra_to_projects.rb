class AddBarraToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :barra, :string

  end
end

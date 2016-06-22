class RemoveSlugToArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :slug, :string
  end
end

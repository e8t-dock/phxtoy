defmodule App.Repo.Migrations.AddProductSkuIndex do
  use Ecto.Migration

  def change do
    create unique_index(:products, [:sku])
  end
end

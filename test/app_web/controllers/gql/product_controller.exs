defmodule AppWeb.GraphQL.ProductControllerTest do
  use AppWeb.ConnCase, async: true

  alias App.Catalog
  alias App.Catalog.Product

  @gql_path AppWeb.Endpoint.url() <> "/gql"

  @create_attrs %{
    name: "item name",
    sku: 100,
    unit_price: 100.9,
    image_url: "https://loremflickr.com/640/480/animal",
    desc: "item description"
  }

  @update_attrs %{
    name: "item name [update]",
    sku: 100,
    unit_price: 200.9,
    image_url: "https://loremflickr.com/640/480/animal-update",
    desc: "item description [update]"
  }
  @invalid_attrs %{
    name: nil,
    sku: nil,
    unit_price: nil,
    image_url: nil,
    desc: nil
  }

  # def fixture(:product) do
  def create_product(arg) do
    # IO.inspect(arg)
    {:ok, product} = Catalog.create_product(@create_attrs)
    %{product: product}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "fetch all" do
    test "lists all products", %{conn: conn} do
      conn =
        get(conn, @gql_path,
          query: """
          {
          products {id}
          }
          """
        )

      assert json_response(conn, 200) |> Map.has_key?("data")
      assert json_response(conn, 200)["data"]["products"] == []

      # fixture(:product)
      create_product(:product)

      conn =
        get(conn, @gql_path,
          query: """
          {
          products {id name}
          }
          """
        )

      assert json_response(conn, 200)["data"]["products"] |> length() == 1

      assert json_response(conn, 200)["data"]["products"]
             |> hd()
             |> IO.inspect()
             |> Map.get("name") ==
               @create_attrs.name
    end
  end

  describe "fetch one" do
    setup :create_product

    test "lists one product", %{conn: conn, product: product} do
      conn =
        get(conn, @gql_path,
          query: """
          {
          product (id: #{product.id}) {id name}
          }
          """
        )

      assert json_response(conn, 200)["data"]["product" |> IO.inspect()] |> Map.get("name") ==
               @create_attrs.name
    end
  end
end

require 'csv'
class ProductsController < ApplicationController
  before_action :read_csv

  def index
  end

  def index_path
    redirect_to products_path
  end

  def update
    @products[params[:id].to_i][0] = params[:pn]
    @products[params[:id].to_i][1] = params[:pd]
    @products[params[:id].to_i][2] = params[:bn]
    File.open('products.csv', 'w') do |f|
      f.write(@products.to_csv)
    end
  end

  def destroy
    @products.delete(params[:id].to_i)     
    File.open('products.csv', 'w') do |f|
      f.write(@products.to_csv)
    end
  end

  def new
    CSV.open("products.csv", "ab") do |csv|
      csv << ["", "", ""]
    end
  end

  def read_csv
    @products = CSV.table("products.csv", headers: :true)
  end
end
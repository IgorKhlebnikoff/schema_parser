class ParsingsController < ApplicationController
  before_action :parsing, except: [:index, :new, :create]

  respond_to :html

  def index
    @parsings = Parsing.all
  end

  def new
    @parsing = Parsing.new
  end

  def create
    #binding.pry
    respond_with(@parsing = Parsing.create(parsing_params))
  end

  def destroy
    respond_with(parsing)
  end

  def parse
    respond_with(parsing.parse, location: parsing_path(parsing))
  end

  private

  def parsing
    @parsing ||= Parsing.find_by_id(params[:id])
  end

  def parsing_params
    params.require(:parsing).permit(:name, :schema_attachment, :xml_attachment)
  end
end

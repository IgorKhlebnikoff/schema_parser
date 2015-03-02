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
    respond_with(@parsing = Parsing.create(parsing_params))
  end

  def destroy
    respond_with(parsing.destroy, location: root_path)
  end

  def parse
    parsing.parse!
    redirect_to request.referrer
  end

  private

  def parsing
    @parsing ||= Parsing.find_by_id(params[:id])
  end

  def parsing_params
    params.require(:parsing).permit(:name, :schema_attachment, :xml_attachment)
  end
end

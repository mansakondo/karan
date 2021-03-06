module Catalog
  class MARC::RecordsController < ApplicationController
    def index
      params[:show] ||= 10

      case params[:record_type]
      when "authority"
        @records = MARC::Record.authority.page(params[:page]).per(params[:show])
      else
        @records = MARC::Record.bibliographic.page(params[:page]).per(params[:show])
      end
    end

    def show
      @record = MARC::Record.find(params[:id])
    end

    def edit
      @record = MARC::Record.find(params[:id])
    end

    def update
      @record = MARC::Record.find(params[:id])

      if @record.update(record_params)
        redirect_to @record
      else
        render :edit
      end
    end

    def destroy
      @record = MARC::Record.find(params[:id])
      @record.destroy

      redirect_to catalog_marc_records_path, status: :see_other
    end

    private

    def record_params
      params.require(:catalog_marc_record).permit(:record_type, fields_attributes: [
        :id,
        :tag,
        :value,
        :indicator1,
        :indicator2,
        subfields_attributes: [:id, :code, :value]
      ])
    end
  end
end

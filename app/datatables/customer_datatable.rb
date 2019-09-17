class CustomerDatatable < AjaxDatatablesRails::ActiveRecord
  delegate :best_in_place, to: :@view
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
       id: { source: "Customer.id" },
       name: { source: "Customer.name", cond: :like },
       phone: { source: "Customer.phone", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        id: best_in_place(record, :id),
        name: best_in_place(record, :name),
        phone: best_in_place(record, :phone)
      }
    end
  end

  def get_raw_records
    Customer.all
  end

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

end

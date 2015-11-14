module ProductsHelper
  def render_filters_for param_type
    klass   = param_type.constantize
    filters = klass.filters

    filters.each do |filter|
      concat( render template: "filters/#{ filter[:type] }" )
    end

    nil
  end
end

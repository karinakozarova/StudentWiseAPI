module ApplicationHelper
  def present(model, presenter_class = nil)
    presenter_class ||= "#{model.class}Presenter".constantize
    presenter = presenter_class.new(model, self)
    yield(presenter) if block_given?
  end
end

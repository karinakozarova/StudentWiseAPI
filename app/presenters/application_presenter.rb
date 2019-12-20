class ApplicationPresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
    super(@model)
  end

  private

  def self.presents(name)
    define_method(name) { @model }
  end

  def v
    @view
  end
end

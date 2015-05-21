module ApplicationHelper

  def body_classes
    classes = ['app']
    # classes << (signed_in? ? 'signed-in' : 'signed-out')
    # classes << 'admin' if signed_in_as_admin?
    classes << controller_name
    classes << action_name
    classes << @body_classes if @body_classes
    classes = classes - @body_classes_removed if @body_classes_removed
    classes.join(' ')
  end

  def paginate objects, options = {}
    options.reverse_merge!(theme: 'twitter-bootstrap-3')
    super(objects, options)
  end

end

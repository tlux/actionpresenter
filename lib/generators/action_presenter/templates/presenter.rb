<% module_namespacing do -%>
class <%= class_name %>Presenter < ActionPresenter::Base
  presents :<%= class_name.underscore %>

<% attributes.select(&:reference?).each do |attribute| -%>
  delegate_presented :<%= attribute %>
<% end -%>
end
<% end -%>
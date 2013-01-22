require 'redmine'

Redmine::Plugin.register :redmine_url_custom_field do
  name 'RT num to ticket'
  author 'Steve Morrissey'
  description 'Allows linking of a field to a RT ticket'
  version '0.0.1'

  requires_redmine :version_or_higher => '0.9.0'
end

class UrlCustomFieldFormat < Redmine::CustomFieldFormat
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  def format_as_rt(value)
    auto_link h(value)
  end

  def escape_html?
    false
  end

  def edit_as
   "text"
  end
end

Redmine::CustomFieldFormat.map do |fields|
  fields.register UrlCustomFieldFormat.new('rt', :label => :label_rt, :order => 8)
end

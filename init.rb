require 'redmine'

Redmine::Plugin.register :redmine_rt_custom_field do
  name 'RT num to ticket'
  author 'Steve Morrissey'
  description 'Allows linking of a field to a RT ticket'
  version '0.0.1'

  requires_redmine :version_or_higher => '0.9.0'
end

class RtCustomFieldFormat < Redmine::CustomFieldFormat
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  def format_as_rt(value)
    link_to h(value, "https://rt.d.umn.edu/rt/Ticket/Display.html?id=" + value)
  end

  def escape_html?
    false
  end

  def edit_as
   "text"
  end
end

Redmine::CustomFieldFormat.map do |fields|
  fields.register RtCustomFieldFormat.new('rt', :label => "RT", :order => 8)
end

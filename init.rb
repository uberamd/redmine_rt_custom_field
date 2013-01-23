require 'redmine'

Redmine::Plugin.register :redmine_rt_custom_field do
  name 'RT num to ticket'
  author 'Steve Morrissey'
  description 'Allows linking of a field to a RT ticket'
  version '0.0.3'

  requires_redmine :version_or_higher => '0.9.0'

  settings :partial => 'settings/redmine_rt_custom_field_settings',
    :default => {
      'rt_url' => 'http://path.to.your.rt.com/',
    }
end

class RtCustomFieldFormat < Redmine::CustomFieldFormat
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  def format_as_rt(value)
    ActionController::Base.helpers.link_to(value, "https://rt.d.umn.edu/rt/Ticket/Display.html?id=" + value)
  end

  def escape_html?
    false
  end

  def edit_as
   "integer"
  end
end

Redmine::CustomFieldFormat.map do |fields|
  fields.register RtCustomFieldFormat.new('rt', :label => :label_rt, :order => 8)
end

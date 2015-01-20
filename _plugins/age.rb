require 'date'
module Jekyll
  class RenderAgeTag < Liquid::Tag
    def initialize(tag_name, dob, tokens)
      super
    end

    def render(context)
      
    end
  end
end

Liquid::Template.register_tag('renderage', Jekyll::RenderAgeTag)
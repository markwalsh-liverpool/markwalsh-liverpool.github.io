module Jekyll
  class RenderAgeTag < Liquid::Tag

    def initialize(tag_name, dob, tokens)
      super
      now = Time.now.utc.to_date
      @age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

    def render(context)
      "#{@age}"
    end
  end
end

Liquid::Template.register_tag('render_age', Jekyll::RenderAgeTag)
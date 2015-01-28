class Chromatch < Sinatra::Base
  helpers do
    def partial(template, *args)
      options = args.extract_options!
      options.merge!(:layout => false)
      if collection = options.delete(:collection) then
        collection.inject([]) do |buffer, member|
          buffer << erb(template, options.merge(
                                    :layout => false,
                                    :locals => {template.to_sym => member}
                                )
          )
        end.join("\n")
      else
        erb(template, options)
      end
    end

    def options_from_collection(collection, selected)
      collection.collect do |element|
        option_attr = []
        option_attr << "value=\"#{element}\""
        option_attr << 'selected' if selected.to_s == element.to_s
        '<option ' + option_attr.join(' ') + '>' + (block_given? ? yield(element).to_s : element.to_s) + '</option>'
      end.join("\n")
    end

    def h(text)
      Rack::Utils.escape_html(text)
    end

    def j(javascript)
      js_escape_map = {
          '\\'    => '\\\\',
          '</'    => '<\/',
          "\r\n"  => '\n',
          "\n"    => '\n',
          "\r"    => '\n',
          '"'     => '\\"',
          "'"     => "\\'"
      }
      if javascript
        javascript.gsub(/(\\|<\/|\r\n|\342\200\250|[\n\r"'])/u) {|match| js_escape_map[match] }
      else
        ''
      end
    end
  end
end

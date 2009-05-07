module Cell
	class Base
		class DesignProfile

			attr_reader :name

			def initialize(klass, name)
				@klass = klass
				@name = name
				@options = proc {Hash.new}
				if name != :default
					@super = @klass.design_profiles[:default]
				end
				@widths = {}
			end

			def width(width, options = {})
				if options[:for]
					for aspect in [options[:for]].flatten do
						@widths[aspect] = width
					end
				else
					@width = width
				end
			end


			def preferred_width(aspect)
				options
				@widths[aspect] || @width || (@super ? @super.preferred_width(aspect) : 800)
			end

			def options
				self.instance_eval do
					@javascripts = []
				end
				opthash = self.instance_eval(&@options)
				@super ? @super.options.merge(opthash) : opthash
			end

			def javascript(script = nil)
				@javascripts << script if script
				@javascripts.join("\n")
			end
		end

		class << self
			def design_profile(name = :default, &block)
				profile = self.design_profiles[name]
				profile.instance_variable_set(:@options, block)
			end

			def design_profiles
				@design_profiles ||= Hash.new {|h, k| h[k] = DesignProfile.new(self, k)}
			end
		end
	end
end
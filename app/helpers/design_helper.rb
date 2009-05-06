
module DesignHelper
  def design_opts(cell, profile)
		design_profile(cell, profile).options
	end

	def cell_links(cells, current_cell)
		cells.sort{|a,b| a.name <=> b.name}.map do |c|
			case c.name.to_s
			when current_cell.to_s
				%Q{<span class="currentCell">#{c.name}</span>}
			else
				%Q{<a href="/design/#{c.name}/#{c.aspects[0]}">#{c.name}</a>}
			end
		end
	end

	def aspect_links(cell, aspects, current, profile)
		aspects.sort{|a,b| a.to_s <=> b.to_s}.map do |a|
			case a
			when current.to_s
				%Q{<span id="current">#{a}</span>}
			else
				%Q{<a href="/design/#{cell}/#{a}/#{profile}">#{a}</a>}
			end
		end
	end

	def profile_links(cell, aspect, current_profile)
		design_profiles(cell).map {|name, profile|
			if name == current_profile
				%Q{<span class="currentProfile">#{name}</span>}
			else
				%Q{<a href="/design/#{cell}/#{aspect}/#{name}">#{name}</a>}
#				link_to name, "design", :cell => cell, :aspect => aspect, :profile => name
			end
		}
	end

	def cell_class(cell_name)
		Cell::Base.class_from_cell_name(cell_name)
	end

	def design_profiles(cell)
		klass = cell_class(cell)
		klass.instance_variable_get(:@design_profiles) or raise StandardError, "#{klass} does not have any design profiles"
	end

	def design_profile(cell, profile_name)
		profile = design_profiles(cell)[profile_name]
		raise StandardError, "no design profile named '#{profile_name}' for cell '#{cell}'" unless profile
		return profile
	end
end
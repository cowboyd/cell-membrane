require 'ostruct'
class DesignController < ApplicationController
	include DesignHelper
	def index
		@cells = _find_cells
	end

	def cell
		@query = Query.new
		@cells = _find_cells
		@cell_name = params[:cell].intern
    @aspect = params[:aspect].intern
		@profile = params[:profile].intern
		@width = params[:width] || design_profile(@cell_name, @profile).preferred_width(@aspect)
		@aspects = _aspects(@cell_name)
	end

	private

	def _aspects(cell_name)
		klass = cell_class(cell_name)
    # klass.public_instance_methods.select {|m| klass.instance_method(m).owner == klass && !(m =~ /(^_|master_helper_module)/) }
		klass.public_instance_methods false
	end


	def _find_cells
		Dir["#{RAILS_ROOT}/app/cells/*_cell.rb"].map do |file|
			name = File.basename(file).sub(/_cell\.rb$/, '')
			klass = Cell::Base.class_from_cell_name(name)
			OpenStruct.new({
				:name => name,
				:klass => klass,
				:file => file,
				:aspects => _aspects(name)
			})
		end.sort {|a,b| a.name <=> b.name}
	end
end

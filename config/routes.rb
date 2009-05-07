
ActionController::Routing::Routes.draw do |map|
	map.connect 'design/:cell/:aspect/:profile', :controller => 'design', :action => 'cell', :profile => :default
	map.connect 'design', :controller => 'design', :action => 'index'
end



Cell::Base
require 'design'

FileUtils.mkdir_p "#{Rails.public_path}/images/design"
FileUtils.mkdir_p "#{Rails.public_path}/images/pixels"

FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'public', 'images', 'design', '*')], "#{Rails.public_path}/images/design"
FileUtils.cp Dir[File.join(File.dirname(__FILE__), 'public', 'images', 'pixels', '*')], "#{Rails.public_path}/images/pixels" 
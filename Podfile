# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'sedunApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod "Firebase/Analytics"
  pod "Firebase/Database"
  pod "Firebase/Storage"  
# Pods for sedunApp

end
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
      end
    end
  end
end

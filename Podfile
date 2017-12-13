# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'tabbarCustom' do

  use_frameworks!
  pod 'FoldingTabBar', '~> 1.1.2'
  pod 'Floaty', '~> 4.0.0'
  pod 'FSCalendar'
  pod 'SCLAlertView'
  pod 'AvatarImageView'
 

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        compatibility_pods = ['FSCalendar', 'SCLAlertView']
        if compatibility_pods.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end

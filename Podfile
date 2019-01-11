# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'SushiCounter' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for SushiCounter
    # ReactiveX/RxSwift
    pod 'RxSwift',    '4.2.0'
    pod 'RxCocoa',    '4.2.0'
    
    #Storage
    pod 'RealmSwift',   '3.7.6'
    pod 'RxRealm',      '0.7.5'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['RxSwift', 'RxCocoa', 'RealmSwift', 'RxRealm'].include? target.name
            
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end

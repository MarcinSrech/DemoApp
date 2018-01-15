# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

inhibit_all_warnings!

target 'DemoApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'MagicalRecord'
    pod 'HydraAsync', '~> 1.0.2'
    pod 'SwiftyJSON'
    pod 'Fuzi', '~> 1.0.0'
    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireNetworkActivityLogger', '~> 2.0'

  target 'DemoAppTests' do
    inherit! :search_paths
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'MagicalRecord'
    pod 'HydraAsync', '~> 1.0.2'
    pod 'SwiftyJSON'
    pod 'Fuzi', '~> 1.0.0'
    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireNetworkActivityLogger', '~> 2.0'
  end

  target 'DemoAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end

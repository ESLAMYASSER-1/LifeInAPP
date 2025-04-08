def flutter_install_all_ios_pods(flutter_application_path)
  pod 'Flutter', :path => File.join(flutter_application_path, '.ios', 'Flutter')
end

def flutter_additional_ios_build_settings(target)
  target.build_configurations.each do |config|
    config.build_settings['ENABLE_BITCODE'] = 'NO'
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
  end
end
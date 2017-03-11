Pod::Spec.new do |s|
  s.name         = 'FactorySwift'
  s.version      = '0.1.0'
  s.summary      = 'A factory library for building Swift objects inspired by factory_girl.'
  s.homepage     = 'https://github.com/woxtu/FactorySwift'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'woxtu' => 'woxtup@gmail.com' }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.source       = { :git => 'https://github.com/woxtu/FactorySwift.git', :tag => s.version }
  s.source_files = 'Sources/**/*.{swift,h,m}'
end

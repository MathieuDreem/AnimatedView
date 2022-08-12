Pod::Spec.new do |s|
  s.name             = "AnimatedView"
  s.version          = "1.0.0"
  s.summary          = "Super Lightweight way to easily animate SwitUI Views."
  s.homepage         = "https://github.com/MathieuDreem/AnimatedView"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "PERROUD Mathieu" => "mathieu.perroud@dreem.com" }
  s.source           = { :git => "https://github.com/MathieuDreem/AnimatedView.git",
                         :tag => s.version.to_s }
  s.source_files     = "Sources/*.swift"
  s.requires_arc     = true

  s.swift_version = "5.1"
  s.ios.deployment_target = "13.0"
end
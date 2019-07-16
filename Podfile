# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
# ignore all warnings from all dependencies
inhibit_all_warnings!

def mainPods
	#CODEQUALITY
	pod 'SwiftLint'
	pod 'IBLinter'
end

def utest
    pod 'Quick'
    pod 'Nimble'
end

# Pods for 2019_DEV_175
target '2019_DEV_175' do
use_frameworks!
	mainPods
end

target '2019_DEV_175Tests' do
use_frameworks!
	mainPods
	utest
end

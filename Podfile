platform :ios, '13.0'
inhibit_all_warnings!

##
def rx_swift
    pod 'RxSwift', '~> 5.1.1'
end

##
def rx_cocoa
    pod 'RxCocoa', '~> 5.1.1'
end

##
def rx_data_source
  pod 'RxDataSources', '~> 4.0'
end

##
def rx_gesture
  pod 'RxGesture', '~>3.0.2'
end

##
def king_fisher
  pod 'Kingfisher', '~> 5.15.7'
end

##
def network_pods
  rx_swift
  rx_cocoa
end

####
target 'DomainLayer' do
    use_frameworks!
    workspace 'MarvelApiTest'
    project 'DomainLayer/DomainLayer.xcodeproj'
    
    rx_swift

target 'DomainLayerTests' do
      inherit! :search_paths
      # Pods for testing
      
    end
end

####
target 'NetworkLayer' do
    use_frameworks!
    workspace 'MarvelApiTest'
    project 'NetworkLayer/NetworkLayer.xcodeproj'
    
    network_pods
    
    target 'NetworkLayerTests' do
      inherit! :search_paths
      # Pods for testing
      network_pods
      
    end
end

####
target 'DataLayer' do
    use_frameworks!
    workspace 'MarvelApiTest'
    project 'DataLayer/DataLayer.xcodeproj'
    
    rx_swift
    rx_cocoa

target 'DataLayerTests' do
      inherit! :search_paths
      # Pods for testing
      
    end
end

target 'MarvelApiTest' do
  use_frameworks!

  # Pods for MarvelApiTest
  rx_swift
  rx_cocoa
  rx_data_source
  rx_gesture
  king_fisher

  target 'MarvelApiTestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MarvelApiTestUITests' do
    # Pods for testing
  end

end

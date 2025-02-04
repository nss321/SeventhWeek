//
//  ViewController.swift
//  SeventhWeek
//
//  Created by BAE on 2/3/25.
//

import UIKit
import CoreLocation
import MapKit

import SnapKit

final class ViewController: BaseViewController {
    
    /*
     1. 위치 매니저 생성: 위치에 관련된 대부분을 담당
     
     3. 위치 프로토콜 연결
     */
    
    lazy var locationManager = CLLocationManager()
    let mapView = MKMapView()
    let locationButton = UIButton()
    
    override func configView() {                
        navigationItem.title = "응애"
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        locationButton.backgroundColor = .red
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
        
//        checkDeviceLocation()
        checkCurrentLocation()
        NetworkManager.shared.getLotto { response in
            switch response {
            case .success(let successe):
                // lotto
            case .failure(let error):
                // alert
            }
            
        }
    }
    
    override func configDelegate() {
        print(#function)
        locationManager.delegate = self
    }
    
    // 얼럿: 위치 서비스 -> 허용 얼럿
    private func checkDeviceLocation() {
        // iOS의 위치 서비스 활성화 체크 여부
        print(Thread.isMainThread)
        
        DispatchQueue.global().async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                
                // 현재 사용자 위치 권한 상태 확인
                // if 허용된 상태 > 권한 띄울 필요 X
                // if 거부한 상태 > 아이폰 설정 이동
                // if notDetermined > 권한 띄워주기
                print(#function, locationManager.authorizationStatus.rawValue)
                
                DispatchQueue.main.async { [self] in
                }
                // info.plist 에서 요청한 권한과 다른 경우가 종종 있으니 주의!
                locationManager.requestWhenInUseAuthorization()
            } else {
                print(#function, "can not request location data because gps service is off")
            }
        }
    }
    
    // 현재 사용자의 위치 권한 상태 확인
    private func checkCurrentLocation() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print(#function, "이 권한에서만 권한 문구 띄울 수 있음 -> 미결정상태")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print(#function, "설정으로 이동하는 얼럿 띄우기")
        case .authorizedWhenInUse:
            print(#function, "정상적인 동작 실행하면 됨. e.g. 날씨~~ 기타 등등")
            locationManager.startUpdatingLocation()
        default:
            print(#function, "오류 발생")
        }
    }
    
    @objc private func locationButtonClicked() {
        print(#function)
        
        /*
          위치를 가져오는 요청을 하기 전에는 항상 권한 체크를 해주어야 함.
         만약 권한이 없다면 그에 따른 적절한 처리 (e.g. 설정 앱으로 이동 등) 을 해야함
         */
        
        locationManager.startUpdatingLocation()
        NetworkManager.shared.getLotto { Lotto in
            dump(Lotto)
        } failHandler: {
            print(#function, "failed to call lottety api")
        }

        NetworkManager.shared.getLotto { lotto, error in
            dump(lotto)
            dump(error)
            // 1. 문제 발생 - lotto와 error 중 하나는 무조건 Nil 이므로
            // ealry exit 문제가 발생함.
//            guard let lotto = lotto,
//                  let error = error else {
//                return
//            }
            
            // 2. 문제 발생 - lotto가 nil인경우 ealry exit 문제 발생
            guard let lotto = lotto else {
                return
            }
            guard let error = error else {
                return
            }
        }
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let center = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(center, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations.last?.coordinate)
        // 위도 경도를 이용하는 api 호출
        // 날씨, 지도 정보 등
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        
        // start를 했다면 더이상 위치를 안 받아와도 되는 시점에 stop을 해야함.
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자 위치를 성공적으로 가지고 오지 못한 경우
    // e,g, 사용자가 위치 권한을 허용하지 않았을 때, 자녀 보호 기능 등
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
        
        // 위치를 불러오는데 실패했을 때 대응
//        setRegionAndAnnotation(center: <#T##CLLocationCoordinate2D#>)
    }
    
    // locationManager 인스턴스가 생성될 때
    // 사용자의 권한상태가 변경될 때
    // e.g. 허용했었지만 권한을 변경했을때
    // iOS14+
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, manager.authorizationStatus.rawValue)
    }
    
    // iOS14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, status.rawValue)
    }
}

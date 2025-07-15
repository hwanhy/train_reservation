# train_reservation

🚂 Flutter 기차 예매 앱
이 앱은 Flutter를 사용하여 간단한 기차표 예매 과정을 시뮬레이션합니다. 사용자가 출발역과 도착역을 선택하고, 원하는 좌석을 고른 뒤 예매를 확정하는 기능을 제공합니다. 특히, 시스템 설정에 따라 라이트/다크 모드를 자동으로 지원하여 사용자 경험을 향상시킨 것이 특징입니다.

✨ 주요 기능
역 선택: 사용자 친화적인 인터페이스를 통해 출발역과 도착역을 목록에서 쉽게 선택할 수 있습니다.

좌석 선택: 열차의 좌석 배치도를 시각적으로 제공하여 비어 있는 좌석 중 원하는 좌석을 직관적으로 고를 수 있습니다.

예매 확인: 선택한 노선과 좌석 정보를 최종 확인하는 팝업을 통해 예매 실수를 방지하고, 최종 확정할 수 있습니다.

다크 모드 지원: 기기의 시스템 테마 설정(라이트/다크 모드)에 따라 앱의 UI가 자동으로 전환되어, 어떤 환경에서도 눈의 피로를 줄이고 편안하게 앱을 사용할 수 있습니다.

📂 파일 구조 (File Tree)
이 프로젝트는 다음과 같은 핵심 파일 구조를 가집니다:

```
flutter_train_app/
├── lib/
│   ├── main.dart             # 앱의 진입점 및 전역 테마(라이트/다크 모드) 설정
│   ├── home_page.dart        # 출발역/도착역 선택 및 좌석 선택 페이지로 이동
│   ├── station_list_page.dart # 역 목록을 표시하고 역 선택 기능 제공
│   └── seat_page.dart        # 선택된 노선에 대한 좌석 선택 및 예매 확인 기능
└── pubspec.yaml              # 프로젝트 의존성 및 메타데이터 정의
```

⚙️ 앱의 주요 코드 및 동작 설명
```
lib/main.dart
```
이 파일은 앱의 시작점이며, 앱 전체의 시각적 테마를 설정합니다.

```runApp(const MyApp())```으로 앱을 시작합니다.

```MyApp``` 위젯은 ```MaterialApp```을 반환하며, 여기에 앱의 제목, 테마 모드, 라이트 테마(theme) 및 다크 테마(darkTheme)를 정의합니다.

```themeMode: ThemeMode.system``` 설정을 통해 사용자의 기기 시스템 설정에 따라 앱의 테마가 자동으로 변경되도록 합니다.

각 테마에는 ```brightness, primarySwatch, scaffoldBackgroundColor, appBarTheme, cardColor, textTheme``` 등이 정의되어 앱 전반의 색상과 스타일을 일관되게 관리합니다.

lib/home_page.dart
앱의 첫 화면으로, 사용자가 기차표 예매를 시작하는 곳입니다.

_departureStation과 _arrivalStation 변수를 사용하여 사용자가 선택한 출발역과 도착역을 관리합니다.

_buildStationSelector 위젯은 출발역/도착역 선택을 위한 UI를 제공하며, 탭 시 StationListPage로 이동하여 역을 선택할 수 있도록 합니다.

선택된 역 정보를 바탕으로 "좌석 선택" 버튼이 활성화되며, 이 버튼을 누르면 선택된 출발역과 도착역 정보를 가지고 SeatPage로 이동합니다.

이 페이지의 Scaffold 배경색, Container 카드색상, 텍스트 색상 등이 Theme.of(context)를 사용하여 다크 모드를 완벽하게 지원하도록 구현되었습니다.

lib/station_list_page.dart
출발역 또는 도착역을 선택할 수 있는 역 목록을 표시하는 페이지입니다.

단순한 역 이름 목록을 ListView 등으로 보여주며, 사용자가 역 이름을 탭하면 해당 역 이름을 이전 화면(HomePage)으로 반환하고 페이지를 닫습니다 (Navigator.pop).

이 페이지 역시 main.dart에 정의된 전역 테마를 따르도록 구현되어야 합니다.

lib/seat_page.dart
선택된 출발역과 도착역에 대한 좌석을 선택하고 예매를 확정하는 페이지입니다.

departure와 arrival을 HomePage로부터 인자로 전달받아 상단에 표시합니다.

seats 리스트에 정의된 좌석들을 GridView.builder를 통해 시각적으로 배치합니다.

_buildSeatButton 위젯은 각 좌석 버튼의 UI를 담당하며, 선택 여부에 따라 색상이 변경됩니다.

사용자가 좌석을 탭하면 _selectSeat 함수가 호출되며, CupertinoAlertDialog를 통해 선택한 노선 및 좌석에 대한 최종 예매 확인 팝업을 띄웁니다.

확인 팝업에서 '확인'을 누르면 두 번의 Navigator.pop(context)를 통해 현재 좌석 페이지를 닫고 HomePage로 돌아가 예매 과정을 완료합니다.

이 페이지의 Scaffold 배경색, 좌석 버튼의 배경색 및 텍스트 색상 등도 Theme.of(context)를 활용하여 다크 모드에 최적화되어 있습니다.


# TestTaskMosgorpass
# Описание
[Тестовое задание iOS (МТ).pdf](https://github.com/romaarc/TestTaskMosgorpass/files/8771893/iOS.pdf)

Необходимо создать приложение, которое выводит пользователю список остановок общественного транспорта.
При открытии приложения, необходимо запросить список остановок из API (https://api.mosgorpass.ru/v8.2/stop), представить список остановок для пользователя в табличном виде.
# Экраны
![hippo](https://media.giphy.com/media/BC2zmBHD0TiMfHrdB2/giphy.gif)
![hippo](https://media.giphy.com/media/IdsAs8uhOiEUwRAV2w/giphy.gif)
![hippo](https://media.giphy.com/media/DEfYA9IfX3sJbHLyS8/giphy.gif)
![hippo](https://media.giphy.com/media/SYiliZGVSXhlZKPGch/giphy.gif)

## Установка

У вас должны быть установлены SPM:
* <a href="https://github.com/SnapKit/SnapKit">SnapKit</a>
* <a href="https://github.com/mxcl/PromiseKit">PromiseKit</a>
* <a href="https://github.com/ashleymills/Reachability.swift">Reachability</a>
* <a href="https://github.com/realm/realm-swift">Realm</a>

У вас должны быть установлены Pods:
* <a href="https://github.com/Quick/Quick">Quick, Nimble</a>
* <a href="https://github.com/super-ultra/UltraDrawerView">UltraDrawerView</a>

# Детали реализации
## Deployment Target
iOS 13
## Архитектура приложения
**Clean Swift + Services (Realm + URLSession PromiseKit version)**<br>
## UI
**UIKit without Storyboard and Xibs, only layout with code**<br>
## Unit-Tests code coverage
<img width="936" alt="Screenshot 2022-05-26 at 13 01 07" src="https://user-images.githubusercontent.com/28999468/170466206-7e82c918-233b-4a9d-87ea-5c75c1577422.png">

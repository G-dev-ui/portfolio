# Rick and Morty App
<h3>Скриншоты приложения</h3>
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="https://github.com/user-attachments/assets/037ed260-6f68-4b5d-9997-a28396809fb8" alt="Screenshot 2" width="300"/>
  <img src="https://github.com/user-attachments/assets/a1035f82-9080-4f03-929e-701a21b3c1da" alt="Screenshot 1" width="300"/>
</div>


## Описание проекта
Это мобильное приложение на Flutter для просмотра персонажей сериала **Rick and Morty**.  
Приложение использует актуальный стек технологий, расширяя функциональность через полезные библиотеки.  

Основные возможности:
- Просмотр списка персонажей с пагинацией
- Возможность отмечать персонажей как избранные
- Кэширование данных для работы оффлайн

## Версии и зависимости

- **Flutter**: ^3.8.1
- **Dart**: ^3.8.1

### Основные зависимости
- `cupertino_icons` — стандартные иконки для iOS
- **Работа с сетью (API)**
  - `http` — для выполнения HTTP-запросов
- **Локальное хранилище**
  - `hive` и `hive_flutter` — для кэширования данных
  - `cached_network_image` — для кэширования изображений
- **Управление состоянием**
  - `flutter_bloc` — управление состоянием через BLoC
  - `equatable` — для сравнения объектов в BLoC
- **Модели и сериализация**
  - `json_annotation` — аннотации для генерации кода сериализации
- **Навигация и утилиты**
  - `path_provider` — доступ к файловой системе
- **UI и взаимодействие**
  - `flutter_launcher_icons` — генерация иконок приложения
  - `custom_refresh_indicator` — кастомный индикатор обновления
  - `like_button` — кнопка «Нравится»

## Сборка и запуск
1. Клонируйте репозиторий:
```bash
git clone https://github.com/G-dev-ui/portfolio.git
bash```
2. Перейдите в каталог проекта:
```bash
cd portfolio

3. Установите зависимости:
```bash
flutter pub get

4. Запустите приложение на эмуляторе или устройстве:
```bash
flutter run

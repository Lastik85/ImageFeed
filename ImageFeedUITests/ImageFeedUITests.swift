import XCTest

class Image_FeedUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uiTest"]
        app.launch()
    }
    
    func testAuth() throws {
        app.buttons["Войти"].tap()
        //нажали кнопку войти
        let webView = app.webViews["UnsplashWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 15),"WebView не загрузилось")
        //ждем появления страницы 15 сек, с VPN у меня туго работает
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 10), "Поле не найдено")
        //ищем поле логина
        loginTextField.tap()
        sleep(1)
        //даем время отреагировать на касание
        loginTextField.typeText("_____")
        webView.swipeUp()
        //вводим логин
        if app.toolbars.buttons["Done"].exists {
            app.toolbars.buttons["Done"].tap()
            sleep(1)
        }
        //нажали кнопку,если появилась клавиатура
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 10), "Поле password не найдено")
        //нашли поле ввода пароля
        passwordTextField.tap()
        sleep(1)
        //даем время отреагировать на касание
        passwordTextField.typeText("_____")
        webView.swipeUp()
        //ввели пароль
        if app.toolbars.buttons["Done"].exists {
            app.toolbars.buttons["Done"].tap()
            sleep(1)
            //время на закрытие клавиатуры, чтобы ничего не пропустить из-за анимации
        }
        //убрали клавиатуру,закрывает кнопку логин
        webView.buttons["Login"].tap()
        //зашли в приложение
        let tablesQuery = app.tables
        let cell = tablesQuery.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 15))
        //ждем появления первой ячейки
    }
    
    func testFeed() throws {
        
        let tablesQuery = app.tables
        let isUITest = ProcessInfo.processInfo.arguments.contains("-uiTest")
        //проверили режим тестированния, остановили загрузку ленты
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        //нашли первый элемент таблицы
        cell.swipeUp()
        //свапнули вверх
        sleep(2)
        //подождали)))
        let cellToLike = tablesQuery.cells.element(boundBy: 0)
        //взяли первую ячейку
        cellToLike.buttons["LikeButton"].tap()
        cellToLike.buttons["LikeButton"].tap()
        //поставили/сняли лайк
        sleep(2)
        //подождали)))
        cellToLike.tap()
        //зашли в ячейку
        sleep(2)
        //подождали)))
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        //сжатие/растяжение
        let navBackButtonWhiteButton = app.buttons["BackButton"]
        navBackButtonWhiteButton.tap()
        //нашли кнопку возврата и вышли на экран ленты
    }
    
    
    func testProfile() throws {
        
        sleep(3)  // Подождать, пока открывается и загружается экран ленты
        let isUITest = ProcessInfo.processInfo.arguments.contains("-uiTest")
        //проверили режим тестирования,тормознули загрузку ленты
        app.tabBars.buttons.element(boundBy: 1).tap()
        //перешли на страниц профиля
        XCTAssertTrue(app.staticTexts["Андрей Пермяков"].exists)
        XCTAssertTrue(app.staticTexts["@lastik1985"].exists)
        //проверка отображения данных
        app.buttons["exitButton"].tap()
        //нажали кнопку выхода из профиля
        app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
        //нашли алерт нажали ДА
        let authenticateButton = app.buttons["Войти"]
        XCTAssertTrue(authenticateButton.waitForExistence(timeout: 5))
        //проверили что вышли на экран входа
    }
}


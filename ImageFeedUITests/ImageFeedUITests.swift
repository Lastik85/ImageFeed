import XCTest

class Image_FeedUITests: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAuth() throws {
        app.buttons["Войти"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 15),"WebView не загрузилось")
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 10), "Поле не найдено")
        
        loginTextField.tap()
        loginTextField.typeText("Lastik1985@mail.ru")
        webView.swipeUp()
        
        if app.toolbars.buttons["Done"].exists {
            app.toolbars.buttons["Done"].tap()
        }
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 10), "Поле password не найдено")
        
        passwordTextField.tap()
        passwordTextField.typeText("Aa198505")
        webView.swipeUp()
        
        
        if app.toolbars.buttons["Done"].exists {
            app.toolbars.buttons["Done"].tap()
        }
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.cells.element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 15))
    }
    
    func testFeed() throws {
        
            let tablesQuery = app.tables
            
            let cell = tablesQuery.cells.element(boundBy: 0)
            cell.swipeUp()
            
            sleep(2)
            
            let cellToLike = tablesQuery.cells.element(boundBy: 0)
            
            cellToLike.buttons["LikeButton"].tap()
            cellToLike.buttons["LikeButton"].tap()
            
            sleep(2)
            
            cellToLike.tap()
            
            sleep(2)
            
            let image = app.scrollViews.images.element(boundBy: 0)
            image.pinch(withScale: 3, velocity: 1)
            image.pinch(withScale: 0.5, velocity: -1)
            
            let navBackButtonWhiteButton = app.buttons["BackButton"]
            navBackButtonWhiteButton.tap()
        }
    
    
    func testProfile() throws {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["Екатерина Новикова"].exists)
        XCTAssertTrue(app.staticTexts["@ekaterina_nov"].exists)
        
        app.buttons["exitButton"].tap()
        
        app.alerts["Пока, пока"].scrollViews.otherElements.buttons["Да"].tap()
    }
}


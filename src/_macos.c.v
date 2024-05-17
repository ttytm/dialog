module dialog

import webview

fn create() &webview.Webview {
	return webview.create()
}

fn destroy(app &webview.Webview) {
	app.destroy()
}

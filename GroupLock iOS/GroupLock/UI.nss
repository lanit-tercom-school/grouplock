@primaryFontName: HelveticaNeue;
@secondaryFontName: HelveticaNeue-Light;

@mainColor: #303D55;
@primaryBackgroundColor: #E0E8F4;

@primaryFontColor: #FFFFFF;

/* General */

View {
background-color: @primaryBackgroundColor;
}

NavigationBar {
bar-tint-color: @mainColor;
font-color: @primaryFontColor;
background-color: @mainColor;
background-tint-color: @primaryFontColor;
}

TabBar {
background-tint-color: @mainColor;
}

BarButton {
font-color: @primaryFontColor;
background-tint-color: @primaryFontColor;
}



/* PasswordViewController */

PasswordView {
background-color: @mainColor;
}

ProceedButton {
background-color: #40A43D;
font-color: @primaryFontColor;
corner-radius: 0;
}

PasswordTextField {
background-tint-color: @mainColor;
corner-radius: 0;
}

EnterPasswordLabel {
font-color: #FD3A1C;
}
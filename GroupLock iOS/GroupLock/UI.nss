@primaryFontName: HelveticaNeue;
@secondaryFontName: HelveticaNeue-Light;

@mainColor: #303D55;
@primaryBackgroundColor: #E0E8F4;

@primaryFontColor: #FFFFFF;

/* General */

View {
background-color: @primaryBackgroundColor;
exclude-subviews: UITextField;
}

NavigationBar {
bar-tint-color: @mainColor;
font-color: @primaryFontColor;
background-tint-color: @primaryFontColor;
}

TabBar {
background-tint-color: @mainColor;
}

BarButton {
font-color: @primaryFontColor;

}

Button {
background-color: @mainColor;
font-color: @primaryFontColor;
corner-radius: 0;
}

TextField {
tint-color: @mainColor;
corner-radius: 0;
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

EnterPasswordLabel {
font-color: #FD3A1C;
}
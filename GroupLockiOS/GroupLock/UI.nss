/* Please consider adding unit tests for each new class and property */

@primaryFontName: HelveticaNeue;
@secondaryFontName: HelveticaNeue-Light;

@mainColor: #142F4D;
@buttonColor: #335273;
@primaryBackgroundColor: #E0E8F4;

@primaryFontColor: #FFFFFF;

/* General */

View {
  background-color: @primaryBackgroundColor;
  exclude-subviews: UITextField;
}

Table {
  background-color: @primaryBackgroundColor;
  separator-color: @mainColor;
}

TableCell {
  background-color: @primaryBackgroundColor;
  tint-color: @mainColor;
  background-color-selected: @buttonColor;
  font-color-highlighted: @primaryFontColor;
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
  background-color: @buttonColor;
  font-color: @primaryFontColor;
  corner-radius: 0;
}

TextField {
  tint-color: @mainColor;
  corner-radius: 0;
}


/* PasswordViewController */

PasswordView {
  background-color: #142F4DBF;
}

ProceedButton {
  background-color: #4CAF4D;
  font-color: @primaryFontColor;
  corner-radius: 0;
}

EnterPasswordLabel {
  font-color: #FF5222;
}

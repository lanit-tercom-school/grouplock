/* Please consider adding unit tests for each new class and property */

/* IMPORTANT: Do NOT use general classes like View or Table, because the stylesheet gets applied
 * in undesired and unexpected places */

@primaryFontName: HelveticaNeue;
@secondaryFontName: HelveticaNeue-Light;

@mainColor: #142F4D;
@buttonColor: #335273;
@primaryBackgroundColor: #E0E8F4;

@primaryFontColor: #E0E0E0;

/* General */

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

/* PasswordViewController */

PasswordView {
    background-color: #142F4DBF;
}

ProceedButton {
    background-color: #4CAF4D;
    font-color: white;
    corner-radius: 0;
}

EnterPasswordLabel {
    font-color: #FF5222;
}

/* HomeViewController */

HomeView {
    background-color: @primaryBackgroundColor;
    exclude-subviews: UITextField;
}

HomeButton {
    background-color: @buttonColor;
    font-color: @primaryFontColor;
    corner-radius: 0;
}

/* LibraryDirectoryViewController */

DirectoryView {
    background-color: @primaryBackgroundColor;
}

DirectoryButton {
    background-color: @buttonColor;
    font-color: @primaryBackgroundColor;
    corner-radius: 4;
}

/* LibraryViewController */

LibraryTable {
    background-color: @primaryBackgroundColor;
    separator-color: @mainColor;
}

LibraryTableCell {
    background-color: @primaryBackgroundColor;
    tint-color: @mainColor;
    background-color-selected: @buttonColor;
    font-color-highlighted: @primaryFontColor;
}
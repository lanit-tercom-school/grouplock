/*
 * In this file 8-digits hex color representation is used.
 * First 6 of the digits are standard hex representation of a color.
 * Last 2 ones are the value of alpha channel.
 * It means that to get a decimal of this value, you need to translate it into decimal notation and divide by 255.
 *
 *
 * Please consider adding unit tests for each new class and property.
 *
 *
 * IMPORTANT: Do NOT use general classes like View or Table, because the stylesheet gets applied
 * in undesired and unexpected places.
 */

@primaryFontName: HelveticaNeue;
@secondaryFontName: HelveticaNeue-Light;

@mainColor: #142F4D;
@buttonColor: #335273;
@primaryBackgroundColor: #C4DBE8;

@primaryFontColor: #E0E0E0;
@primaryFontColorDisabled: #E0E0E014;

/* General */

GeneralView {
    background-color: @primaryBackgroundColor;
}

GeneralButton {
    background-color: @buttonColor;
    font-color: @primaryFontColor;
    corner-radius: 0;
}

GeneralTable {
    background-color: @primaryBackgroundColor;
    separator-color: @mainColor;
}

GeneralTableCell {
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
    font-color-disabled: @primaryFontColorDisabled;
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

/* LibraryDirectoryViewController */

DirectoryButton {
    background-color: @buttonColor;
    font-color: @primaryBackgroundColor;
    corner-radius: 4;
}

/* ChooseFileViewController */

CollectionViewCell {
    corner-radius: 4;
    border-color: #4CAF4DC7;
    selected-border-width: 10;
}

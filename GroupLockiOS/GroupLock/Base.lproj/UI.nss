/*
 * In this file 8-digits hex color representation is used.
 * First 6 of the digits are standard hex representation of a color.
 * Last 2 ones are the value of alpha channel.
 * It means that to get a decimal of this value, you need to translate it into decimal notation and divide by 255.
 *
 * IMPORTANT: Do NOT use general classes like View or Table, because the stylesheet gets applied
 * in undesired and unexpected places. Use instead custom classes like GeneralView and apply them to each element.
 */

@primaryFontName: HelveticaNeue;
@secondaryFontName: HelveticaNeue-Light;

@mainColor: #142F4D;
@buttonColor: #335273;
@primaryBackgroundColor: #EDF4F8;
@selectionColor: #4CAF4DC7;

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

TranslucentBlackView {
    background-color: #0000007F;
}

WhiteTextButton {
    font-color: white;
    font-color-disabled: @primaryFontColorDisabled;
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

/* Password Scene */

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

/* Choose File Scene */

CollectionViewCell {
    corner-radius: 4;
    border-color: @selectionColor;
    selected-border-width: 10;
}

/* Key Type Scene */

KeyTypeButton {
    background-color: #8A9EA8;
    background-color-selected: @selectionColor;
    background-color-disabled: #B9C9D2;
    font-color: @mainColor;
    font-color-selected: #474747;
    tint-color: clear;
}

/* Number Of Keys Scene */

MaxMinLabel {
    font-color: @mainColor;
}

/* Scanning Scene */

CounterLabel {
    corner-radius: 22;
    font-color: white;
}

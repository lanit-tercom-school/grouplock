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
    background-color: @primaryBackgroundColor;      /* TESTED */
}

GeneralButton {
    background-color: @buttonColor;                 /* TESTED */
    font-color: @primaryFontColor;                  /* TESTED */
    corner-radius: 0;                               /* TESTED */
}

GeneralTable {
    background-color: @primaryBackgroundColor;      /* TESTED */
    separator-color: @mainColor;                    /* TESTED */
}

GeneralTableCell {
    background-color: @primaryBackgroundColor;      /* TESTED */
    tint-color: @mainColor;                         /* TESTED */
    background-color-selected: @buttonColor;        /* TESTED */
    font-color-highlighted: @primaryFontColor;      /* TESTED */
}

NavigationBar {
    bar-tint-color: @mainColor;                     /* TESTED */
    font-color: @primaryFontColor;                  /* TESTED */
    background-tint-color: @primaryFontColor;       /* TESTED */
}

TabBar {
    background-tint-color: @mainColor;              /* TESTED */
}

BarButton {
    font-color: @primaryFontColor;                  /* TESTED */
    font-color-disabled: @primaryFontColorDisabled; /* TESTED */
}

/* PasswordViewController */

PasswordView {
    background-color: #142F4DBF;                    /* TESTED */
}

ProceedButton {
    background-color: #4CAF4D;                      /* TESTED */
    font-color: white;                              /* TESTED */
    corner-radius: 0;                               /* TESTED */
}

EnterPasswordLabel {                                /* TESTED */
    font-color: #FF5222;                            /* TESTED */
}

/* LibraryDirectoryViewController */

DirectoryButton {
    background-color: @buttonColor;                 /* TESTED */
    font-color: @primaryBackgroundColor;            /* TESTED */
    corner-radius: 4;                               /* TESTED */
}

/* ChooseFileViewController */

CollectionViewCell {
    corner-radius: 4;                               /* TESTED */
    border-color: @selectionColor;                  /* TESTED */
    selected-border-width: 10;                      /* CUSTOM */
}

/* KeyTypeViewController */

KeyTypeButton {
    background-color: #8A9EA8;                      /* TESTED */
    background-color-selected: @selectionColor;     /* TESTED */
    background-color-disabled: #B9C9D2;             /* TESTED */
    font-color: @mainColor;                         /* TESTED */
    font-color-selected: #474747;                   /* TESTED */
    tint-color: clear;                              /* TESTED */
}

/* NumberOfKeysViewController */

MaxMinLabel {
    font-color: @mainColor;
}

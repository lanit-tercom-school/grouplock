package com.example.sonya.grouplockapplication;

import android.os.Parcel;
import android.os.Parcelable;
import android.util.Log;

import java.io.File;

/**
 * Entry (file or directory) in the library. Extends <code>File</code> Java type.
 */
public class LibraryEntry extends File implements Parcelable {

    private boolean isSelected;
    private boolean isParent;

    /**
     *
     * @param entryFullName full name of created entry.
     */
    public LibraryEntry(String entryFullName) {
        super(entryFullName);
        isSelected = false;
        isParent = false;
    }

    /**
     *
     * @param entryFullName full name of created entry.
     * @param isParent whether this entry is parent of current directory. Used to make it possible to go back
     *                 and its name is presented as ".." (two dots).
     */
    public LibraryEntry(String entryFullName, boolean isParent) {
        this(entryFullName);
        this.isParent = isParent;
    }

    protected LibraryEntry(Parcel in) {
        this(in.readString());
        boolean[] receivedBooleans = new boolean[2];
        in.readBooleanArray(receivedBooleans);
        isSelected = receivedBooleans[0];
        isParent = receivedBooleans[1];
    }

    public static final Creator<LibraryEntry> CREATOR = new Creator<LibraryEntry>() {
        @Override
        public LibraryEntry createFromParcel(Parcel in) {
            return new LibraryEntry(in);
        }

        @Override
        public LibraryEntry[] newArray(int size) {
            return new LibraryEntry[size];
        }
    };

    /**
     * @return <code>true</code> if this entry is a parent of directory opened by user;
     * <code>false</code> otherwise.
     */
    public boolean isParent() {
        return isParent;
    }

    /**
     * @return <code>true</code> if this entry is selected to be encrypted or decrypted;
     * <code>false</code> otherwise.
     */
    public boolean isSelected() {
        return isSelected;
    }

    /**
     * Sets whether this entry is selected to be encrypted or decrypted.
     * @param isSelected state to be set.
     */
    public void setSelected(boolean isSelected) {
        this.isSelected = isSelected;
    }

    /**
     * Shows whether this entry can be selected to be encrypted or decrypted.
     * In current implementation it depends on the extension of the file - you can select .jpg files only.
     *
     * @return <code>true</code> if this entry is not a directory and can be selected to be encrypted or decrypted;
     *         <code>false</code> otherwise.
     *
     */
    public boolean canBeSelected() {
        String typeF=String.copyValueOf(getName().toCharArray(), getName().lastIndexOf('.') + 1,
                getName().length() - getName().lastIndexOf('.') - 1);
        Log.i("qwwreyyr",typeF);
        return !isDirectory() && (typeF.toLowerCase().equals("jpg")||
                typeF.toLowerCase().equals("jpeg")||
                typeF.toLowerCase().equals("bmp")||
                typeF.toLowerCase().equals("png"));
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(getAbsolutePath());
        dest.writeBooleanArray(new boolean[]{isSelected, isParent});
    }
}

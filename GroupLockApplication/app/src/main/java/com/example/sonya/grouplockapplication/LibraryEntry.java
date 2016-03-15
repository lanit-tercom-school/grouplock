package com.example.sonya.grouplockapplication;

import java.io.File;

/**
 * Entry (file or directory) in the library. Incapsulates <code>File</code> Java type.
 */
public class LibraryEntry {

    private File entry;
    private boolean isSelected;
    private boolean isParent;

    /**
     *
     * @param entry <code>File</code> object to be incapsulated inside this entry. You can get this object later
     *              by calling {@link #getEntry()} method.
     */
    public LibraryEntry(File entry) {
        this.entry = entry;
        isSelected = false;
        isParent = false;
    }

    /**
     *
     * @param entryName full name of created entry.
     */
    public LibraryEntry(String entryName) {
        this.entry = new File(entryName);
        isSelected = false;
        isParent = false;
    }

    /**
     *
     * @param entryName full name of created entry.
     * @param isParent whether this entry is parent of current directory. Used to make it possible to go back
     *                 and its name is presented as ".." (two dots).
     */
    public LibraryEntry(String entryName, boolean isParent) {
        this.entry = new File(entryName);
        isSelected = false;
        this.isParent = isParent;
    }

    public String getName() {
        return entry.getName();
    }

    /**
     * @return <code>File</code> structure incapsulated in this entry.
     */
    public File getEntry() {
        return entry;
    }

    public boolean isDirectory() {
        return entry.isDirectory();
    }

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
        return !isDirectory() && getEntry().getName().endsWith(".jpg");
    }

}

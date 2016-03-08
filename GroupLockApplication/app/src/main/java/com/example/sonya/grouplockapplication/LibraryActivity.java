package com.example.sonya.grouplockapplication;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.*;

import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;


public class LibraryActivity extends AppCompatActivity {

    private ArrayList<LibraryEntry> currentDirectoryEntries = new ArrayList<LibraryEntry>();
    private LibraryEntry currentDirectory;

    /* Names of app directories */
    private String LIBRARY_FOLDER_NAME = "GroupLock";
    private String ENCRYPTED_FOLDER_NAME = "Encrypted";
    private String DECRYPTED_FOLDER_NAME = "Decrypted";
    private String libraryRootPath;

    private ArrayList<LibraryEntry> filesToOperateWith;
    private GridView entriesListView;

    public enum LibraryState {
        BROWSING,
        ENCRYPT_SELECTING,
        DECRYPT_SELECTING
    }
    private LibraryState currentLibraryState;

    private Button btnNext, btnLoadFile;
    MenuItem menuItemEncrypt, menuItemDecrypt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.library_layout);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
        setSupportActionBar(mToolbar);

        /* Check if directories exist, create if needed */
        libraryRootPath = Environment.getExternalStorageDirectory().getPath() + "/" + LIBRARY_FOLDER_NAME;
        File libraryRoot = new File(libraryRootPath);
        if (!libraryRoot.exists()) {
            libraryRoot.mkdir();
        }
        File libraryEncryptedPath = new File(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME);
        File libraryDecryptedPath = new File(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME);
        if (!libraryEncryptedPath.exists()) {
            libraryEncryptedPath.mkdir();
        }
        if (!libraryDecryptedPath.exists()) {
            libraryDecryptedPath.mkdir();
        }

        filesToOperateWith = new ArrayList<LibraryEntry>();
        btnNext = (Button) findViewById(R.id.btnNext);
        btnLoadFile = (Button) findViewById(R.id.btnLoadFile);

        /* Get library state if had been passed to */
        Bundle b = getIntent().getExtras();
        if (b != null && b.containsKey("state")) {
            currentLibraryState = (LibraryState) b.get("state");
            /* Find correct directory */
            if (currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
                showDirectoryLayout(new LibraryEntry(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME));
            } else if (currentLibraryState == LibraryState.DECRYPT_SELECTING) {
                showDirectoryLayout(new LibraryEntry(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME));
            }
            cryptActionSelect(currentLibraryState);
        } else {
            /* Library opened directly from menu */
            currentLibraryState = LibraryState.BROWSING;
            showDirectoryLayout(new LibraryEntry(libraryRoot));
        }
    }

    /**
     * Shows entries of the selected directory on the screen, sets items click listeners
     * and activates buttons Encrypt/Decrypt if needed. Does nothing if <code>entry</code> is not a directory.
     * @param entry selected directory
     */
    private void showDirectoryLayout(LibraryEntry entry) {
        if (entry == null || !entry.isDirectory()) {
            return;
        }

        /* Show list with files from this directory.
         * We need to sort it properly, all files should go after directories.
         * It is not sorted by default. */
        currentDirectory = entry;
        File[] files = entry.getEntry().listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return !pathname.isDirectory();
            }
        });
        Arrays.sort(files);
        File[] dirs = entry.getEntry().listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return pathname.isDirectory();
            }
        });
        Arrays.sort(dirs);

        currentDirectoryEntries.clear();
        if (canGoToParent(currentDirectory)) {
            currentDirectoryEntries.add(new LibraryEntry(currentDirectory.getEntry().getParent(), true));
        }
        for (File directory: dirs) {
            currentDirectoryEntries.add(new LibraryEntry(directory));
        }
        for (File file: files) {
            /* Check whether file had been selected earlier */
            boolean selected = false;
            for (LibraryEntry le : filesToOperateWith) {
                if (le.getEntry().getAbsolutePath().equals(file.getAbsolutePath())) {
                    /* If true, add existing entry pointer to the list of entries of current directory
                     * in order not to redraw checkboxes. */
                    currentDirectoryEntries.add(le);
                    selected = true;
                    break;
                }
            }
            /* If false, create new entry and add it to the list. */
            if (!selected) {
                LibraryEntry fileEntry = new LibraryEntry(file);
                currentDirectoryEntries.add(fileEntry);
            }
        }

        entriesListView = (GridView) findViewById(R.id.entries_list_view);
        LibraryEntriesAdapter adapter = new LibraryEntriesAdapter(this, currentDirectoryEntries, currentLibraryState);
        entriesListView.setAdapter(adapter);

        /* Touch listener */
        entriesListView.setOnItemClickListener(onEntryClickListener);

        TextView currentLocationInLibrary = (TextView) findViewById(R.id.current_location_in_library);
        /* Remove part of the path before the library root -
           user doesn't need to know where library is located physically */
        currentLocationInLibrary.setText(entry.getEntry().getAbsolutePath().replace(libraryRootPath, ""));

        /* Enable/disable crypt menu items.
           We can only encrypt from "Decrypted" directory and decrypt from "Encrypted" directory */
        if (menuItemEncrypt != null && menuItemDecrypt != null) {
            menuItemEncrypt.setEnabled(entry.getEntry().getAbsolutePath()
                                                       .contains(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME));
            menuItemDecrypt.setEnabled(!menuItemEncrypt.isEnabled());
        }
    }

    /**
     * Entries click handler. Gets type of selected entry and performs corresponding actions.
     */
    private AdapterView.OnItemClickListener onEntryClickListener = new AdapterView.OnItemClickListener() {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            LibraryEntry selectedEntry = currentDirectoryEntries.get(position);
            if (selectedEntry.isDirectory()) {
                showDirectoryLayout(selectedEntry);
            } else {
                if (currentLibraryState == LibraryState.DECRYPT_SELECTING ||
                        currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
                    toggleFileSelection(selectedEntry, position);
                }
            }
        }
    };

    /**
     * Toggles file selection, changes checkbox and Next button states if needed.
     * Does nothing if <code>entry</code> is a directory.
     * @param entry file to be toggled
     * @param index index of selected file
     */
    private void toggleFileSelection(LibraryEntry entry, int index) {
        if (entry.isDirectory()) {
            return;
        }

        entry.setSelected(!entry.isSelected());

        // Toogle checkbox
        View v = entriesListView.getChildAt(index - entriesListView.getFirstVisiblePosition());
        if(v == null)
            return;
        CheckBox checkBox = (CheckBox) v.findViewById(R.id.checkboxIsSelected);
        checkBox.setChecked(entry.isSelected());

        // Add/remove file from list
        if (filesToOperateWith.contains(entry)) {
            filesToOperateWith.remove(entry);
        }
        else {
            filesToOperateWith.add(entry);
        }
        btnNext.setEnabled(!filesToOperateWith.isEmpty());
    }

    // TODO: implement replace/rename/remove

    /**
     * Shows whether we can go to the parent of the selected entry.
     * @return <code>true</code> if <code>entry</code> is a directory, is not a root and it is allowed to go upper;
     * <code>false</code> otherwise.
     */
    private boolean canGoToParent(LibraryEntry entry) {
        if (!entry.isDirectory()) {
            return false;
        }

        /* We can't go to the parent of the root.
         * We also can't go out from "Decrypted" directory while encrypting and visa versa. */
        return !entry.getEntry().getAbsolutePath().equals(libraryRootPath)
             && !((entry.getEntry().getAbsolutePath().equals(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME) &&
                   currentLibraryState == LibraryState.DECRYPT_SELECTING)
             ||   (entry.getEntry().getAbsolutePath().equals(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME) &&
                   currentLibraryState == LibraryState.ENCRYPT_SELECTING));
    }

    /**
     * Finishes current activity and thus goes to the previous one.
     * @param v <code>View</code> that this method has been attached to.
     */
    public void goToPrevStep(View v)
    {
        this.finish();
    }

    /**
     * Depending of the current state, calls the encryption or the decryption <code>Activity</code>
     * and transfers it list of files to be enrcypted or decrypted.
     * @param v <code>View</code> that this method has been attached to.
     */
    public void goToNextStep(View v) {
        if (currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
            // TODO: go to encryption, transfer filesToOperateWith list
            /* debug log */
            Log.d("crypt", filesToOperateWith.size() + " items selected to encrypt:\n");
            for (LibraryEntry le : filesToOperateWith) {
                Log.d("crypt", le.getEntry().toString());
            }
        } else if (currentLibraryState == LibraryState.DECRYPT_SELECTING) {
            // TODO: go to decryption, transfer filesToOperateWith list
            /* debug log */
            Log.d("crypt", filesToOperateWith.size() + " items selected to decrypt:\n");
            for (LibraryEntry le : filesToOperateWith) {
                Log.d("crypt", le.getEntry().toString());
            }
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.library_menu, menu);
        menuItemEncrypt = menu.findItem(R.id.action_encrypt);
        menuItemDecrypt = menu.findItem(R.id.action_decrypt);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        switch (id) {
            case R.id.action_settings:
                return true;

            case R.id.action_search:
                return true;
                // TODO: implement search

            case R.id.action_create_folder:

                // Create dialog
                AlertDialog.Builder alert = new AlertDialog.Builder(this)
                        .setTitle(R.string.create_folder_dialogue_title) //title
                        .setMessage(R.string.create_folder_dialogue_description);

                // Set an EditText view to get user input
                final EditText newDirectoryNameInput = new EditText(this);
                alert.setView(newDirectoryNameInput);

                alert.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                        String name = "/" + newDirectoryNameInput.getText().toString();
                        File folder = new File(currentDirectory.getEntry().getAbsolutePath() + name);
                        if (!folder.exists()) {
                            folder.mkdir();
                        }
                        showDirectoryLayout(currentDirectory);
                    }
                });
                alert.show();
                return true;

            case R.id.help_button:
                // Create dialog
                AlertDialog.Builder helpMe = new AlertDialog.Builder(this)
                        .setTitle(R.string.information_window_title)
                        .setMessage(R.string.information_window_description);

                helpMe.show();
                return true;

            case R.id.action_encrypt:
                cryptActionSelect(LibraryState.ENCRYPT_SELECTING);
                /* Debug log */
                Log.d("crypt", "Encrypt action is selected");
                return true;

            case R.id.action_decrypt:
                cryptActionSelect(LibraryState.DECRYPT_SELECTING);
                /* Debug log */
                Log.d("crypt", "Decrypt action is selected");
                return true;

            default:
                return super.onOptionsItemSelected(item);
        }
    }

    /**
     * Enters file selection mode.
     * @param state state to be set. Should be <code>LibraryState.ENCRYPT_SELECTING</code>
     *              or <code>LibraryState.DECRYPT_SELECTING</code> only. Otherwise method does nothing.
     */
    private void cryptActionSelect(LibraryState state) {
        if (state != LibraryState.ENCRYPT_SELECTING && state != LibraryState.DECRYPT_SELECTING) {
            return;
        }
        currentLibraryState = state;
        btnLoadFile.setVisibility(View.INVISIBLE);
        btnNext.setVisibility(View.VISIBLE);
        btnNext.setEnabled(false);
        showDirectoryLayout(currentDirectory);
    }
}
package com.example.sonya.grouplockapplication;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.*;
import android.widget.*;

import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class LibraryActivity extends AppCompatActivity {

    private List<String> currentDirectoryEntries = new ArrayList<String>();
    private File currentDirectory;

    private String LIBRARY_FOLDER_NAME = "GroupLock";
    private String ENCRYPTED_FOLDER_NAME = "Encrypted";
    private String DECRYPTED_FOLDER_NAME = "Decrypted";
    private String libraryRootPath;

    private ArrayList<File> filesToOperateWith;

    private enum LibraryState {
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
        filesToOperateWith = new ArrayList<File>();
        currentLibraryState = LibraryState.BROWSING;
        btnNext = (Button) findViewById(R.id.btnNext);
        btnLoadFile = (Button) findViewById(R.id.btnLoadFile);
        browseTo(libraryRoot);

    }

    private void browseTo(final File selectedItem){
        //if we want to browse directory
        if (selectedItem.isDirectory()){
            /* Show list with files from this directory
               We need to sort it properly, all files should go after directories */
            this.currentDirectory = selectedItem;
            File[] files = selectedItem.listFiles(new FileFilter() {
                @Override
                public boolean accept(File pathname) {
                    return !pathname.isDirectory();
                }
            });
            Arrays.sort(files);
            File[] dirs = selectedItem.listFiles(new FileFilter() {
                @Override
                public boolean accept(File pathname) {
                    return pathname.isDirectory();
                }
            });
            Arrays.sort(dirs);
            showItems(concat(dirs, files));

            TextView currentLocationInLibrary = (TextView) findViewById(R.id.current_location_in_library);
            /* Remove part of the path before the library root -
               user doesn't need to know where library is located physically */
            currentLocationInLibrary.setText(selectedItem.getAbsolutePath().replace(libraryRootPath, ""));

            /* Enable/disable crypt menu items.
               We can only encrypt from "Decrypted" directory and decrypt from "Encrypted" directory */
            if (menuItemEncrypt != null) menuItemEncrypt.setEnabled(
                    selectedItem.getAbsolutePath().contains(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME));
            if (menuItemDecrypt != null) menuItemDecrypt.setEnabled(!menuItemEncrypt.isEnabled());

        } else {
            if (currentLibraryState == LibraryState.DECRYPT_SELECTING ||
                currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
                // Add/remove file from list
                if (filesToOperateWith.contains(selectedItem)) {
                    filesToOperateWith.remove(selectedItem);
                    // TODO: checkbox
                }
                else {
                    filesToOperateWith.add(selectedItem);
                }
                btnNext.setEnabled(!filesToOperateWith.isEmpty());
            }
        }
    }

    private void showItems(File[] files) {
        //clear list
        currentDirectoryEntries.clear();

        /* We can't go to the parent of the root.
         * We also can't go out from "Decrypted" directory while encrypting and visa versa. */
        if (!currentDirectory.getAbsolutePath().equals(libraryRootPath)
             && !((currentDirectory.getAbsolutePath().equals(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME) &&
                   currentLibraryState == LibraryState.DECRYPT_SELECTING)
             ||   (currentDirectory.getAbsolutePath().equals(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME) &&
                   currentLibraryState == LibraryState.ENCRYPT_SELECTING)))
            currentDirectoryEntries.add("..");

        //add every file into list
        for (File file : files) {
            currentDirectoryEntries.add(file.getName());
        }

        GridView entriesListView = (GridView) findViewById(R.id.entries_list_view);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.library_entry, this.currentDirectoryEntries);
        entriesListView.setAdapter(adapter);

        /* Touch listener */
        entriesListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String selectedFileString = currentDirectoryEntries.get(position);
                //if we select ".." then go upper
                if(selectedFileString.equals("..")){
                    browseToParent();
                }
                else {
                    browseTo(new File(currentDirectory.getAbsolutePath() + "/" + selectedFileString));
                }
            }
        });

        // TODO: implement replace/rename/remove
    }

    private void browseToParent(){
        if(this.currentDirectory.getParent() != null) {
            this.browseTo(this.currentDirectory.getParentFile());
        }
    }

    public void goToPrevStep(View v)
    {
        this.finish();
    }

    public void goToNextStep(View v) {
        if (currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
            // TODO: go to encryption, transfer filesToOperateWith list
            /* debug log */
            Log.d("crypt", filesToOperateWith.size() + " items selected to encrypt");
        } else if (currentLibraryState == LibraryState.DECRYPT_SELECTING) {
            // TODO: go to decryption, transfer filesToOperateWith list
            /* debug log */
            Log.d("crypt", filesToOperateWith.size() + " items selected to decrypt");
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
                        File folder = new File(currentDirectory.getAbsolutePath() + name);
                        boolean success = true;
                        if (!folder.exists()) {
                            success = folder.mkdir();
                        }
                        browseTo(currentDirectory);
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

    private void cryptActionSelect(LibraryState state) {
        currentLibraryState = state;
        btnLoadFile.setVisibility(View.INVISIBLE);
        btnNext.setVisibility(View.VISIBLE);
        btnNext.setEnabled(false);
        browseTo(currentDirectory);
    }

    private File[] concat(File[] a, File[] b) {
        int aLen = a.length;
        int bLen = b.length;
        File[] c = new File[aLen+bLen];
        System.arraycopy(a, 0, c, 0, aLen);
        System.arraycopy(b, 0, c, aLen, bLen);
        return c;
    }

}
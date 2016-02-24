package com.example.sonya.grouplockapplication;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
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

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.library_layout);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
        setSupportActionBar(mToolbar);

        /* Check if directories exist, create if needed */
        libraryRootPath = Environment.getExternalStorageDirectory().getPath() + "/" + LIBRARY_FOLDER_NAME;
        File libraryRoot = new File(libraryRootPath);
        boolean success = true;
        if (!libraryRoot.exists()) {
            success = libraryRoot.mkdir();
        }
        File libraryEncryptedPath = new File(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME);
        File libraryDecryptedPath = new File(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME);
        success = true;
        if (!libraryEncryptedPath.exists()) {
            success = libraryEncryptedPath.mkdir();
        }
        success = true;
        if (!libraryDecryptedPath.exists()) {
            success = libraryDecryptedPath.mkdir();
        }
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
        } else {
            // TODO: find out why files don't open
            /*
            //if we want to open file, show this dialog:
            //listener when YES button clicked
            DialogInterface.OnClickListener okButtonListener = new DialogInterface.OnClickListener(){
                public void onClick(DialogInterface arg0, int arg1) {
                    //intent to navigate file
                    Intent i = new Intent(android.content.Intent.ACTION_VIEW, Uri.parse("file://" + selectedItem.getAbsolutePath()));
                    //start this activity
                    startActivity(i);
                }
            };
            //listener when NO button clicked
            DialogInterface.OnClickListener cancelButtonListener = new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface arg0, int arg1) {
                    //do nothing
                    //or add something you want
                }
            };

            //create dialog
            new AlertDialog.Builder(this)
                    .setTitle("Подтверждение") //title
                    .setMessage("Хотите открыть файл "+ selectedItem.getName() + "?") //message
                    .setPositiveButton("Да", okButtonListener) //positive button
                    .setNegativeButton("Нет", cancelButtonListener) //negative button
                    .show(); //show dialog
            */
        }
    }

    private void showItems(File[] files) {
        //clear list
        currentDirectoryEntries.clear();

        if (!currentDirectory.getAbsolutePath().equals(libraryRootPath))
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

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.library_menu, menu);
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

            default:
                return super.onOptionsItemSelected(item);
        }
    }

    public File[] concat(File[] a, File[] b) {
        int aLen = a.length;
        int bLen = b.length;
        File[] c = new File[aLen+bLen];
        System.arraycopy(a, 0, c, 0, aLen);
        System.arraycopy(b, 0, c, aLen, bLen);
        return c;
    }

}
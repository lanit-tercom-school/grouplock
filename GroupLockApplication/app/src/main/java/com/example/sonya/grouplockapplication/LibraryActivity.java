package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Environment;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuInflater;
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
    private boolean showMenu;
    private boolean avoidBrowsingMode;

    public enum LibraryState {
        BROWSING,
        ENCRYPT_SELECTING,
        DECRYPT_SELECTING
    }
    private LibraryState currentLibraryState;
    private TextView btnNext, NamePage, txtStep;
    private Button /*btnNext,*/ btnLoadFile;
    private ImageView btnBack;
    MenuItem menuItemEncrypt, menuItemDecrypt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_library_crypt);

        Bundle b = getIntent().getExtras();
   /*     if (b != null && b.containsKey("state")) {
            setContentView(R.layout.activity_library_crypt);
        }
        else
        {
            setContentView(R.layout.activity_library_tabs);
            ViewPager viewPager = (ViewPager) findViewById(R.id.viewpager);
            SampleFragmentPagerAdapter SMP=new SampleFragmentPagerAdapter(getSupportFragmentManager(),
                    LibraryActivity.this);
            viewPager.setAdapter(SMP);


            // Give the TabLayout the ViewPager
            TabLayout tabLayout = (TabLayout) findViewById(R.id.sliding_tabs);
            tabLayout.setupWithViewPager(viewPager);
            entriesListView = (GridView) SMP.getItem(0).getView().findViewById(R.id.entries_list_view);
            entriesListView=(GridView) viewPager.getRootView().findViewById(R.id.entries_list_view);
            entriesListView=(GridView)tabLayout.getRootView().findViewById(R.id.entries_list_view);
        }*/


        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);
        ImageView imageInfo=(ImageView)findViewById(R.id.imageInfo);
        imageInfo.setVisibility(View.INVISIBLE);

        try {
            ActivityInfo activityInfo = getPackageManager().getActivityInfo(
                    getComponentName(), PackageManager.GET_META_DATA);
            NamePage=(TextView)findViewById(R.id.textViewPage);
            NamePage.setText(activityInfo.loadLabel(getPackageManager())
                    .toString()+" ▼");
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }


        /* Check if directories exist, create if needed */
            libraryRootPath = Environment.getExternalStorageDirectory().getPath() + "/" + LIBRARY_FOLDER_NAME;
        LibraryEntry libraryRoot = new LibraryEntry(libraryRootPath);
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
        btnNext = (TextView) findViewById(R.id.textNext);
        btnBack = (ImageView) findViewById(R.id.buttonBack);
        NamePage =(TextView)findViewById(R.id.textViewPage);
        txtStep =(TextView)findViewById(R.id.textStep);
        btnLoadFile = (Button) findViewById(R.id.btnLoadFile);


        /* Get library state if had been passed to */
       // Bundle b = getIntent().getExtras();

        if (b != null && b.containsKey("state")) {

            /* State had been passed to created Activity. We need to get and save it. */
            currentLibraryState = (LibraryState) b.get("state");

            showMenu = false;

            /* When Back button is pressed, Home screen should be shown,
               so we do not want to enter LibraryState.BROWSING state */
            avoidBrowsingMode = true;

            /* Find correct directory */
            if (currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
                showDirectoryLayout(new LibraryEntry(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME));
            } else if (currentLibraryState == LibraryState.DECRYPT_SELECTING) {
                showDirectoryLayout(new LibraryEntry(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME));
            }

            cryptActionSelect(currentLibraryState);
            NamePage.setVisibility(View.INVISIBLE);
            btnBack.setVisibility(View.VISIBLE);
            txtStep.setVisibility(View.VISIBLE);

        } else {

            /* Library opened directly from menu */

            showMenu = true;
            avoidBrowsingMode = false;
            currentLibraryState = LibraryState.BROWSING;

            showDirectoryLayout(libraryRoot);
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
        Log.i("www","11111111111111111");
        /* Show list with files from this directory.
         * We need to sort it properly, all files should go after directories.
         * It is not sorted by default. */
        currentDirectory = entry;
        File[] files = entry.listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return !pathname.isDirectory();
            }
        });
        Arrays.sort(files);
        File[] dirs = entry.listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return pathname.isDirectory();
            }
        });
        Arrays.sort(dirs);

        /* Form list of entries in the current directory */
        currentDirectoryEntries.clear();
        if (canGoToParent(currentDirectory)) {
            /* Add link to the parent if needed */
            currentDirectoryEntries.add(new LibraryEntry(currentDirectory.getParent(), true));
        }
        for (File directory: dirs) {
            currentDirectoryEntries.add(new LibraryEntry(directory.getAbsolutePath()));
        }
        for (File file: files) {
            /* Check whether file had been selected to be encrypted or decrypted earlier */
            boolean selected = false;
            for (LibraryEntry le : filesToOperateWith) {
                if (le.getAbsolutePath().equals(file.getAbsolutePath())) {
                    /* If true, add existing entry pointer to the list of entries of current directory
                     * in order not to redraw checkboxes. */
                    currentDirectoryEntries.add(le);
                    selected = true;
                    break;
                }
            }
            /* If false, create new entry and add it to the list. */
            if (!selected) {
                LibraryEntry fileEntry = new LibraryEntry(file.getAbsolutePath());
                currentDirectoryEntries.add(fileEntry);
            }
        }

        /* Get container view for the entries */
        Log.i("www","22222222222222222");
        entriesListView = (GridView) findViewById(R.id.entries_list_view);
        Log.i("www","333333333333333333");
        LibraryEntriesAdapter adapter = new LibraryEntriesAdapter(this, currentDirectoryEntries, currentLibraryState);
        Log.i("www","4444444444444444444");
        entriesListView.setAdapter(adapter);
        Log.i("www","5555555555555555555555");


        /* Touch listener */
        entriesListView.setOnItemClickListener(onEntryClickListener);


        /* Set title of the screen */
       // TextView currentLocationInLibrary = (TextView) findViewById(R.id.current_location_in_library);
        /* Remove part of the path before the library root -
           user doesn't need to know where library is located physically */
     //   currentLocationInLibrary.setText(entry.getAbsolutePath().replace(libraryRootPath, ""));

        /* Redraw menu if needed */
        invalidateOptionsMenu();
    }

    /**
     * Enable/disable crypt menu items.
     * We can only encrypt from "Decrypted" directory and decrypt from "Encrypted" directory
     * */
    private void setCryptMenuItemsAccess() {
            if (menuItemEncrypt != null && menuItemDecrypt != null) {
                Log.i("Libr",currentDirectory.getAbsolutePath());
                menuItemEncrypt.setEnabled(currentDirectory.getAbsolutePath()
                        .contains(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME));
                menuItemDecrypt.setEnabled(currentDirectory.getAbsolutePath()
                        .contains(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME));
            }
    }

    /**
     * Entries click handler. Gets type of selected entry and performs corresponding actions.
     */
    private AdapterView.OnItemClickListener onEntryClickListener = new AdapterView.OnItemClickListener() {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            LibraryEntry selectedEntry = currentDirectoryEntries.get(position);
            Log.i("Choose file:", selectedEntry.getAbsolutePath());
            /* If directory is clicked on, go to its content.
             * If file is clicked on and we select files, toggle its selection status */
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
     * If entry is a file that cannot be selected, show warning message.
     * @param entry file to be toggled
     * @param index index of selected file
     */
    private void toggleFileSelection(LibraryEntry entry, int index) {
        if (entry.isDirectory()) {
            return;
        }

        if (!entry.canBeSelected()) {
            Toast.makeText(this, R.string.library_warning_file_cannot_be_selected, Toast.LENGTH_LONG).show();
            return;
        }

        entry.setSelected(!entry.isSelected());

        /* Toggle checkbox */
        View v = entriesListView.getChildAt(index - entriesListView.getFirstVisiblePosition());
        if(v == null)
            return;
        CheckBox checkBox = (CheckBox) v.findViewById(R.id.checkboxIsSelected);
        checkBox.setChecked(entry.isSelected());

        /* Add/remove file from list */
        if (filesToOperateWith.contains(entry)) {
            filesToOperateWith.remove(entry);
        }
        else {
            filesToOperateWith.add(entry);
        }

        /* User must select at least one file to go further */
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
        return !entry.getAbsolutePath().equals(libraryRootPath)
             && !((entry.getAbsolutePath().equals(libraryRootPath + "/" + ENCRYPTED_FOLDER_NAME) &&
                   currentLibraryState == LibraryState.DECRYPT_SELECTING)
             ||   (entry.getAbsolutePath().equals(libraryRootPath + "/" + DECRYPTED_FOLDER_NAME) &&
                   currentLibraryState == LibraryState.ENCRYPT_SELECTING));
    }

    /**
     * Depending of the current state, calls the encryption or the decryption <code>Activity</code>
     * and transfers it list of files to be enrcypted or decrypted.
     * @param v <code>View</code> that this method has been attached to.
     */
    public void goToNextStep(View v) {

        if (currentLibraryState == LibraryState.ENCRYPT_SELECTING) {
            Intent intent = new Intent(this, NumberOfKeysActivity.class);
            /* Pass files list to new activity */
            intent.putExtra("files", filesToOperateWith);
            startActivity(intent);

        } else if (currentLibraryState == LibraryState.DECRYPT_SELECTING) {

            Intent intent = new Intent(this, DecrImg.class);        //???????????
            /* Pass files list to new activity */
            intent.putExtra("files", filesToOperateWith);
            startActivity(intent);

            // TODO: go to decryption, transfer filesToOperateWith list
            /* debug log */
            Log.d("crypt", filesToOperateWith.size() + " items selected to decrypt:\n");
            for (LibraryEntry le : filesToOperateWith) {
                Log.d("crypt", le.toString());
            }
        }

    }


    /**
     * Enters file selection mode, changes title and hides menu.
     * @param state state to be set. Should be <code>LibraryState.ENCRYPT_SELECTING</code>
     *              or <code>LibraryState.DECRYPT_SELECTING</code> only. Otherwise method does nothing.
     */
    private void cryptActionSelect(LibraryState state) {
        if (state != LibraryState.ENCRYPT_SELECTING && state != LibraryState.DECRYPT_SELECTING) {
            return;
        }
        if (state == LibraryState.ENCRYPT_SELECTING) {
            getSupportActionBar().setTitle(R.string.action_encrypt);
        } else {
            getSupportActionBar().setTitle(R.string.action_decrypt);
        }

        currentLibraryState = state;

        setMenuVisible(false);
        btnLoadFile.setVisibility(View.INVISIBLE);
        btnNext.setVisibility(View.VISIBLE);
        btnNext.setEnabled(false);

        /* Redraw current directory in order to show checkboxes */
        showDirectoryLayout(currentDirectory);
    }

    /**
     * Switches current directory to its parent if possible. Otherwise {@link #handleUpAction()} method is called.
     * This method is called when device "Back" button is pressed.
     */
    @Override
    public void onBackPressed() {
        if (canGoToParent(currentDirectory)) {
            showDirectoryLayout(new LibraryEntry(currentDirectory.getParent()));
        }
        else {
            handleUpAction();
        }
    }

    /**
     * Depending on the current state of the library, either closes this activity or
     * sets <code>LibraryState.BROWSING</code> state, shows menu, and hides "Next step" button.
     * This method is called when Back button on the Toolbar is pressed or when device "Back"
     * button is pressed and it is impossible to go to the parent of current directory.
     */
    private void handleUpAction() {
        switch (currentLibraryState) {

            case BROWSING:
                this.finish();
                break;

            case ENCRYPT_SELECTING:
            case DECRYPT_SELECTING:
                if (avoidBrowsingMode) {
                    this.finish();
                } else {
                    getSupportActionBar().setTitle(R.string.library_activity_name);
                    currentLibraryState = LibraryState.BROWSING;

                    setMenuVisible(true);
                    btnLoadFile.setVisibility(View.VISIBLE);
                    btnNext.setVisibility(View.INVISIBLE);

                    /* Forget what user had selected */
                    filesToOperateWith.clear();

                    /* Redraw current directory in order to hide checkboxes */
                    showDirectoryLayout(currentDirectory);
                }
                break;
        }
    }

    /**
     * Sets menu visibility.
     * @param visible whether the menu should be visible
     */
    private void setMenuVisible(boolean visible) {
        showMenu = visible;
        /* Redraw menu if needed */
        invalidateOptionsMenu();
    }

    public void showMenu(View v) {
        IconizedMenu popupMenu = new IconizedMenu(this, v);
        MenuInflater inflater = popupMenu.getMenuInflater();
        inflater.inflate(R.menu.home_menu, popupMenu.getMenu());
        popupMenu.setOnMenuItemClickListener(new IconizedMenu.OnMenuItemClickListener() {

            @Override
            public boolean onMenuItemClick(MenuItem item) {

                switch (item.getItemId()) {

                    case R.id.settings:{
                        Intent intent = new Intent(LibraryActivity.this, SettingsActivity.class);
                        startActivity(intent);
                        return true;
                    }
                    case R.id.home:{
                        Intent intent = new Intent(LibraryActivity.this, ChooseToDoActivity.class);
                        startActivity(intent);
                        return true;
                    }
                    default:
                        return false;
                }
            }
        });
        popupMenu.show();
    }


    public void goBack(View v){
        onBackPressed();
    }
    public void loadPage(View view) {
        Intent intent = new Intent(LibraryActivity.this, LoadActivity.class);
        startActivity(intent);
    }
}
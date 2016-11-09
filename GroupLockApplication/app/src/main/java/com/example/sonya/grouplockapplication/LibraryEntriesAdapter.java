package com.example.sonya.grouplockapplication;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.TextView;

import java.util.ArrayList;


public class LibraryEntriesAdapter extends BaseAdapter {

    private Context context;
    private LayoutInflater layoutInflater;
    private ArrayList<LibraryEntry> libraryEntries;
    private final LibraryActivity.LibraryState libraryState;


    public LibraryEntriesAdapter(Context context,
                                 ArrayList<LibraryEntry> libraryEntries,
                                 LibraryActivity.LibraryState state) {
        this.context = context;
        this.layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.libraryEntries = libraryEntries;
        this.libraryState = state;
    }



    @Override
    public int getCount() {
        return libraryEntries.size();
    }

    @Override
    public Object getItem(int position) {
        return libraryEntries.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        /* Trying to get View that already exists in order to save resources */
        View view = convertView;
        if (view == null) {
            view = layoutInflater.inflate(R.layout.library_entry, parent, false);
        }

        LibraryEntry entry = (LibraryEntry) getItem(position);

        /* Parent of the current directory is presented as ".." (two dots) */
        ((TextView) view.findViewById(R.id.textEntryName))
                        .setText(entry.isParent() ? ".." : entry.getName());

        CheckBox isSelected = (CheckBox) view.findViewById(R.id.checkboxIsSelected);
        isSelected.setTag(position);

        /* Hide checkboxes on directories and files that cannot be selected */
        boolean checkboxVisible = entry.canBeSelected() &&
                                  (libraryState == LibraryActivity.LibraryState.ENCRYPT_SELECTING ||
                                   libraryState == LibraryActivity.LibraryState.DECRYPT_SELECTING);
        isSelected.setVisibility(checkboxVisible ? View.VISIBLE : View.INVISIBLE);

        isSelected.setChecked(entry.isSelected());

        /* Change file view background if it cannot be selected */
        if (!entry.isDirectory() && !entry.canBeSelected() &&
                                    (libraryState == LibraryActivity.LibraryState.ENCRYPT_SELECTING ||
                                     libraryState == LibraryActivity.LibraryState.DECRYPT_SELECTING)) {
            view.findViewById(R.id.textEntryName)
                .setBackgroundResource(R.drawable.library_disabled_entry_background);
        }

        return view;

    }
}

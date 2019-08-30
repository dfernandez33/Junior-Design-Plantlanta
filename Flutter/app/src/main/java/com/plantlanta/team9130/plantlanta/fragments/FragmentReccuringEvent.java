package com.plantlanta.team9130.plantlanta.fragments;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.plantlanta.team9130.plantlanta.R;
import com.plantlanta.team9130.plantlanta.fx.util;

import java.util.Objects;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

public class FragmentReccuringEvent extends Fragment {

    private String name;
    private String location;
    private String time;
    private String description;

    private TextView nameTextView;
    private TextView locationTextView;
    private TextView timeTextView;
    private TextView descriptionTextView;

    private FloatingActionButton expandButton;
    private Button signupButton;
    private Button undoSignupButton;
    private LinearLayout eventInfo;
    private RadioGroup frequencySelector;
    private Spinner weeklySpinner;
    private Spinner monthlySpinner;

    private LinearLayout weeklyActivity;
    private LinearLayout monthlyActivity;

    private boolean weeklySpinnerFirstSelection = true;
    private boolean monthlySpinnerFirstSelection = true;

    public static FragmentReccuringEvent newInstance(String eventName, String eventLocation, String eventTime, String eventDescription) {
        FragmentReccuringEvent fragmentEvent = new FragmentReccuringEvent();
        Bundle args = new Bundle();
        args.putString("eventName", eventName);
        args.putString("eventLocation", eventLocation);
        args.putString("eventTime", eventTime);
        args.putString("eventDescription", eventDescription);

        fragmentEvent.setArguments(args);
        return fragmentEvent;
    }

    // The onCreateView method is called when Fragment should create its View object hierarchy,
    // either dynamically or via XML layout inflation.
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup parent, Bundle savedInstanceState) {
        // Defines the xml file for the fragment
        return inflater.inflate(R.layout.fragment_reccuring_event, parent, false);
    }

    // This event is triggered soon after onCreateView().
    // Any view setup should occur here.  E.g., view lookups and attaching view listeners.
    @Override
    public void onViewCreated(@NonNull final View view, Bundle savedInstanceState) {
        // Setup any handles to view objects here
        // EditText etFoo = (EditText) view.findViewById(R.id.etFoo);
        nameTextView = view.findViewById(R.id.name);
        locationTextView = view.findViewById(R.id.location);
        timeTextView = view.findViewById(R.id.time);
        descriptionTextView = view.findViewById(R.id.description);

        weeklyActivity = view.findViewById(R.id.weekly_activity);
        weeklyActivity.setVisibility(View.GONE);
        monthlyActivity = view.findViewById(R.id.monthly_activity);
        monthlyActivity.setVisibility(View.GONE);

        weeklySpinner = view.findViewById(R.id.weekly_spinner);
        monthlySpinner = view.findViewById(R.id.monthly_spinner);

        weeklySpinner.setOnItemSelectedListener(new Spinner.OnItemSelectedListener() {
            private int lastSelection = -1;
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                if (weeklySpinnerFirstSelection && lastSelection == -1) {
                    weeklySpinnerFirstSelection = false;
                } else {
                    lastSelection = position;
                    signupButton.setEnabled(true);
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }

        });

        monthlySpinner.setOnItemSelectedListener(new Spinner.OnItemSelectedListener() {
            private int lastSelection = -1;
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                if (monthlySpinnerFirstSelection && lastSelection == -1) {
                    monthlySpinnerFirstSelection = false;
                } else {
                    lastSelection = position;
                    signupButton.setEnabled(true);
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        signupButton = view.findViewById(R.id.sign_up_button);
        signupButton.setEnabled(false);
        expandButton = view.findViewById(R.id.expand_button);

        frequencySelector = view.findViewById(R.id.frequency_selector);
        frequencySelector.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                if (checkedId == 1){
                    monthlySpinnerFirstSelection = true;
                    signupButton.setEnabled(false);
                    monthlyActivity.setVisibility(View.GONE);
                    weeklyActivity.setVisibility(View.VISIBLE);
                } else if (checkedId == 2) {
                    weeklySpinnerFirstSelection = true;
                    signupButton.setEnabled(false);
                    weeklyActivity.setVisibility(View.GONE);
                    monthlyActivity.setVisibility(View.VISIBLE);
                }
            }
        });

        expandButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(eventInfo.isShown()){
                    eventInfo.setVisibility(View.GONE);
                    util.slide_up(v.getContext(), eventInfo);
                    expandButton.setImageResource(R.drawable.ic_plus_circle);
                    expandButton.setBackgroundTintList(v.getContext().getColorStateList(R.color.plus_button));
                }
                else{
                    eventInfo.setVisibility(View.VISIBLE);
                    util.slide_down(v.getContext(), eventInfo);
                    expandButton.setImageResource(R.drawable.ic_minus);
                    expandButton.setBackgroundTintList(v.getContext().getColorStateList(R.color.minus_button));
                }
            }
        });

        signupButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                signupButton.setVisibility(View.GONE);
                undoSignupButton.setVisibility(View.VISIBLE);
                Toast.makeText(v.getContext(), "Thank you for signing up!",
                        Toast.LENGTH_LONG).show();
            }
        });

        undoSignupButton = view.findViewById(R.id.cancel_button);
        undoSignupButton.setVisibility(View.GONE);
        undoSignupButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                undoSignupButton.setVisibility(View.GONE);
                signupButton.setVisibility(View.VISIBLE);
                Toast.makeText(v.getContext(), "We are sorry you can't make it :(",
                        Toast.LENGTH_LONG).show();
            }
        });

        eventInfo = view.findViewById(R.id.event_info);
        eventInfo.setVisibility(View.GONE);

        nameTextView.setText(this.name);
        locationTextView.setText("Location: " + this.location);
        timeTextView.setText("Time: " + this.time);
        descriptionTextView.setText("Description: " + this.description);
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.name = Objects.requireNonNull(getArguments()).getString("eventName");
        this.location = Objects.requireNonNull(getArguments()).getString("eventLocation");
        this.time = Objects.requireNonNull(getArguments()).getString("eventTime");
        this.description = Objects.requireNonNull(getArguments()).getString("eventDescription");

    }
}

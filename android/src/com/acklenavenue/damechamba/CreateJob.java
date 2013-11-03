package com.acklenavenue.damechamba;

import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseUser;
import com.parse.SaveCallback;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class CreateJob extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.create_job);
		
		ParseUser user = ParseUser.getCurrentUser();
		final String username = user.getUsername();
		
		Button btn = (Button) findViewById(R.id.btnPostAJob);
		btn.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				TextView title = (TextView) findViewById(R.id.txtJobTitle);
				TextView description = (TextView) findViewById(R.id.txtJobDescription);
				TextView city = (TextView) findViewById(R.id.txtJobCity);
				String skills = "Fontaneria";
								
				ParseObject job = new ParseObject("Jobs");
				job.put("title", title.getText().toString());
				job.put("description", description.getText().toString());
				job.put("city", city.getText().toString());
				job.put("createdBy", username);
				job.put("closed", false);
				job.put("skills", skills);
				
				job.saveInBackground(new SaveCallback() {
					
					@Override
					public void done(ParseException arg0) {
						if(arg0 == null){
							Toast.makeText(CreateJob.this, "Exito de Save", Toast.LENGTH_LONG).show();
						}
						else{
							Toast.makeText(CreateJob.this, "Error!", Toast.LENGTH_LONG).show();
						}
					}
				});
			}
		});
		
	}
}

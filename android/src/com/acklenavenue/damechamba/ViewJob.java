package com.acklenavenue.damechamba;

import java.util.List;
import java.util.Set;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.PushService;

public class ViewJob extends SherlockActivity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.job_view);
		
		Intent intent = getIntent();
		String id = intent.getStringExtra("id");
		
		Toast.makeText(getApplicationContext(), id, Toast.LENGTH_SHORT).show();
		
		if(id != null)
		{
			ParseQuery<ParseObject> query = ParseQuery.getQuery("Jobs");
			query.getInBackground(id, new GetCallback<ParseObject>() {
				
				@Override
				public void done(ParseObject obj, ParseException arg1) {
					if(arg1 == null){
						TextView txt = (TextView) findViewById(R.id.txtViewJobTitle);
						txt.setText(obj.getString("title"));
						
						TextView txtDescription = (TextView) findViewById(R.id.txtViewJobDescription);
						txtDescription.setText(obj.getString("description"));
						
						TextView txtSkills = (TextView) findViewById(R.id.txtViewJobSkills);
						txtSkills.setText(obj.getList("skills")+ "");
						
						Toast.makeText(getApplicationContext(), "Test", Toast.LENGTH_SHORT).show();
					}
					else{
						Toast.makeText(getApplicationContext(), "Error", Toast.LENGTH_SHORT).show();
					}
				}
			});
		}
		
		//Set<String> v = PushService.getSubscriptions(ViewJob.this);
		
		//for(Object str : v.toArray()){
			//Toast.makeText(ViewJob.this, str+"", Toast.LENGTH_SHORT).show();
		//}
		
	}
}

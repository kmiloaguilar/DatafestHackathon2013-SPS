package com.acklenavenue.damechamba;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class Signup extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.signup);
		
		final TextView txtName = (TextView) findViewById(R.id.txtSignupName);
		txtName.requestFocus();
		final TextView txtEmail = (TextView) findViewById(R.id.txtEmail);
		final TextView txtPassword = (TextView) findViewById(R.id.txtSignupPassword);
		final TextView txtConfirmPassword = (TextView) findViewById(R.id.txtSignupConfirmPassword);		
		final TextView txtCity = (TextView) findViewById(R.id.txtSignupCity);
		final TextView txtCellphone = (TextView) findViewById(R.id.txtSignupCellPhone);
		
		Button btnSignup = (Button) findViewById(R.id.btnSaveSignup);
		btnSignup.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				
				if( isEmpty(txtName) && isEmpty(txtEmail) && isEmpty(txtPassword) && isEmpty(txtConfirmPassword) &&
					isEmpty(txtCity) && isEmpty(txtCellphone)){
					// Nice to have ( Color in red )
					Toast.makeText(getApplicationContext(), "You must fill all the fields", Toast.LENGTH_LONG).show();
					return;
				}
				
				ParseUser user = new ParseUser();				
				user.setUsername(getText(txtEmail));
				user.setPassword(getText(txtPassword));
				user.setEmail(getText(txtEmail));
				user.put("name", getText(txtName));
				user.put("city", getText(txtCity));
				user.put("phone", getText(txtCellphone));
				
				user.signUpInBackground(new SignUpCallback() {
					
					@Override
					public void done(ParseException ex) {
						if(ex == null){
							Toast.makeText(Signup.this, "ExitO! You've registered Successfully", Toast.LENGTH_LONG).show();
							startActivity(new Intent(Signup.this, Login.class));
							finish();
						}
						else{
							Toast.makeText(Signup.this, "There has been an error, are you sure you are conected to the internet", Toast.LENGTH_LONG).show();								
						}
					}
				});
			}
		});			
	}

	private boolean getIsEmployer(CheckBox checkbox){
		// TODO: Ver si es o no Employer
		return !checkbox.isChecked();
	}
	
	private boolean isEmpty(TextView textview){
		return getText(textview).equals("");
	}
	
	private String getText(TextView textview){
		return textview.getText().toString();
	}
}

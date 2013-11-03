package com.acklenavenue.damechamba;

import java.util.ArrayList;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.sax.StartElementListener;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.widget.Toast;

import com.fima.cardsui.objects.Card;

public class JobCard extends Card{

	String title;
	ArrayList<Object> skills;
	String createdDate;
	String  id;
	public JobCard(String title, String createdDate, ArrayList<Object> skills, String id){
		super(title);
		this.title = title;
		this.skills = skills;
		this.createdDate = createdDate;		
		this.id = id;
	}
	
	@Override
	public View getCardContent(final Context context) {
		View view = LayoutInflater.from(context).inflate(R.layout.card_play, null);
				
		((TextView) view.findViewById(R.id.txtCardTitle)).setText(title);
		((TextView) view.findViewById(R.id.txtCreatedDate)).setText(createdDate);
		((TextView) view.findViewById(R.id.txtSkills)).setText("Skills("+skills.size()+")");
		
		setOnClickListener(new OnClickListener() {			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(context, ViewJob.class);
				intent.putExtra("id", id);
				Toast.makeText(context, "voy a enviar: " + id, Toast.LENGTH_LONG).show();
				context.startActivity(intent);
			}
		});
		
		return view;
	}
	
	private String getSkillsFormatted()
	{
		String skls = "";
		int count = 0;
		for(Object skill : skills){
			if( count == 2){
				skls += " ...";
				break;
			}
			skls += skill +",";
			count++;
		}
		return skls;
	}

	@Override
	public boolean convert(View convertCardView) {
		// TODO Auto-generated method stub
		return false;
	}

}

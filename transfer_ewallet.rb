require "#{File.dirname(__FILE__)}/robot_lib"
include ROBOT



@acc = ["AD666", "adnan1", "adnan7", "adnan8", "adnan9", "adnan10", "adnan14", "adnan15", "adnan16", "adnan17", "adnan18", "adnan19", "adnan20", "adnan21",
	"adnan2","adnan3","adnan4","adnan5","adnan6","adnan11","adnan12","adnan13","adnan22","adnan23", "adnan24","adnan25","adnan26",
	"adnan27","adnan28","adnan29","adnan30","adnan31","adnan32","adnan33","adnan34", "adnan35", "adnan36", "adnan37",
	"adnan38", "adnan39", "adnan40", "adnan41", "adnan42","adnan43", "adnan44", "adnan45", "adnan46", "adnan47", "adnan48", "adnan49",
	"adnan50", "adnan54", "adnan55", "adnan56", "adnan57", "adnan58", "adnan59", "adnan60", "adnan61", "adnan62", "adnan63", "adnan64", "adnan100",
	"adnan51","adnan52","adnan53","adnan65","adnan66","adnan67","adnan68","adnan70","adnan71","adnan72", "adnan73","adnan74","adnan75", "adnan76","adnan77", "adnan78","adnan79","adnan80",
	"adnan81","adnan82","adnan83","adnan84","adnan85","adnan86","adnan87","adnan88","adnan89","adnan90", "adnan91","adnan92","adnan93", "adnan94","adnan95", "adnan96","adnan97","adnan98", "saari1",
	"adnan99","adnan101","adnan102","adnan103","adnan104","adnan105","adnan106","adnan107","adnan108","adnan109", "adnan110","bakeri1","bakeri2", "bakeri3","halim1", "zaid1","zaid2","amran1", "amran2", "amran3"]


if @acc.count <= 120
	@acc.each do |u|
		t = Transfer.where(:transfer_date => Time.now.strftime("%Y-%m-%d"), :account => u).first
		t = Transfer.create(:transfer_date => Time.now.strftime("%Y-%m-%d"), :account => u) if t.nil?
	end
end

@status_false = Transfer.where( :transfer_date => Time.now.strftime("%Y-%m-%d"), :status => false )


unless @status_false.empty?
	@accounts = []
	@status_false.each do |uu|
		@accounts << uu.account
	end

	until @accounts.empty?
		@status_false.each do |u|
			@u = Utils.new(u.account)
			@u.transfer
			if u.status 
				@accounts.delete(u.account)
			end
		end
	end
end
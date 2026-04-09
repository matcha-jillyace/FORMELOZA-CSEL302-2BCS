model BSCS2BFORMELOZALAB03ASSESSMENTNO4

global {
	init {
		create student number: 20;
	}
}

species student {
	int energy <- 5;
	int score <- 0;
	string status <- "active";

	reflex participate when: status = "active" {
		if flip(0.4) {
			score <- score + 1;
			energy <- energy - 1;
		}
	}

	reflex update_status when: energy <= 0 {
		status <- "inactive";
	}

	aspect default {
		draw circle(1) color: status = "active" ? #green : #red;
	}
}

experiment classroom_exp type: gui {
	output {
		display "Classroom Simulation" type: 2d {
			species student aspect: default;
		}
		monitor "Active Students" value: length(student where (each.status = "active"));
		monitor "Total Score" value: sum(student collect each.score);
	}
}
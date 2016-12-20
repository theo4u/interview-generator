<app>
	<div class="question">{ question }</div>

	<form onsubmit={ nextQuestion }>
		<button class="next">Next Question</button>
	</form>

	<style>
		.question {
			font-size: 40px;
		}

		.next {
			margin-top: 10px;
			font-size: 15px;
		}
	</style>


	<script>
		const company = 'Cryogenic Robotics';

		const allQuestions = [
			'What are your strengths?',
			'What are your weaknesses?',
			`Why are you interested in working for ${company}?`,
			'Where do you see yourself in 5 years? 10 years?',
			'Why do you want to leave your current company?',
			'What can you offer us that someone else can not?',
			'What are three things your former manager would like you to improve on?',
			'Are you willing to relocate?',
			'Are you willing to travel?',
			'Tell me about an accomplishment you are most proud of.',
			'Tell me about a time you made a mistake.',
			'What is your dream job?',
			'How did you hear about this position?',
			'What would you look to accomplish in the first 60 days on the job?',
			'Discuss your resume.',
			'Discuss your educational background.',
			'Describe yourself.',
			'Tell me how you handled a difficult situation.',
			'Why should we hire you?',
			'Why are you looking for a new job?',
			'Would you work holidays/weekends?',
			'How would you deal with an angry or irate customer?',
			'What are your salary requirements?',
			'Give a time when you went above and beyond the requirements for a project.',
			'Who are our competitors?',
			'What was your biggest failure?',
			'What motivates you?',
			'What\'s your availability?',
			'Who\'s your mentor?',
			'Tell me about a time when you disagreed with your boss.',
			'How do you handle pressure?',
			'What is the name of our CEO?',
			'What are your career goals?',
			'What gets you up in the morning?',
			'What would your direct reports say about you?',
			'What were your bosses\' strengths/weaknesses?',
			'If I called your boss right now and asked him what is an area that you could improve on, what would he say?',
			'Are you a leader or a follower?',
			'What was the last book you\'ve read for fun?',
			'What are your co-worker pet peeves?',
			'What are your hobbies?',
			'What is your favorite website?',
			'What makes you uncomfortable?',
			'What are some of your leadership experiences?',
			'How would you fire someone?',
			'What do you like the most and least about working in this industry?',
			'Would you work 50+ hours a week?',
			'What questions haven\'t I asked you?',
			'What questions do you have for me?',
			'If you were to get rid of one province in Canada, which would it be and why?',
			'Are you more of a hunter or a gatherer?',
			'You\'re a new addition to the crayon box. What color would you be and why?',
			'We finish the interview and you step outside the office and find a lottery ticket that ends up winning $10 million. What would you do?',
			'What do you think about when you\'re alone on the bus?',
			'If you could be any animal in the world, what animal would you be and why?',
			'What was the last gift you gave someone?',
			'What were you like in high school?',
			'What\'s the last thing you watched on TV and why did you choose to watch it?',
			'Any advice for your previous boss?',
			'Tell me something about your last job, other than money, that would have inspired you to keep working there.',
			'What is the funniest thing that has happened to you recently?',
			'What do you want to be when you grow up?',
			'Which two organizations outside your own do you know the most people at and why?',
			'Pretend you\'re our CEO. What three concerns about the firm\'s future keep you up at night?',
			'If I were to hire you for this job and I granted you three promises with regard to working here, what would they be?',
			'If you don\'t get this job, what\'s your backup plan?',
			'What inspires you?',
			'Teach me something I don\'t know in the next five minutes.',
			'What are you known for?',
			'What do you work toward in your free time?',
			'What\'s the most interesting thing about you that we wouldn\'t learn from your resume alone?',
			'How would you rate your memory?',
			'If you woke up and had 2,000 unread emails and could only answer 300 of them, how would you choose which ones to answer?',
			'How would you value one of the following stores: Wal-Mart, McDonalds, Hudson Bay, American Apparel, Loblaws',
			'Describe the color yellow to somebody who is blind.',
			'You\'ve been given an elephant. You can\'t give it away or sell it. What would you do with the elephant?',
			'Who would win a fight between Spiderman and Batman?',
			'How would you convince someone to do something they didn\'t want to do?',
			'A penguin walks through that door right now wearing a sombrero. What does he say and why is he here? ',
		];

		let questionsLeft = allQuestions.slice(0);

		nextQuestion(e) {
			const questionIndex = Math.floor(Math.random() * questionsLeft.length);
			this.question = questionsLeft[questionIndex];

			questionsLeft.splice(questionIndex, 1);
			if (questionsLeft.length === 0) {
				questionsLeft = allQuestions.slice(0);
			}

			if (e) {
				e.preventDefault();
			}
		}

		this.on('before-mount', function () {
			this.nextQuestion();
		});
	</script>
</app>
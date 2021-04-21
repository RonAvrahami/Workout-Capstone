//
//  BuiltInExercises.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/19/21.
//

import Foundation

var pushUps = ExerciseData(name: "Push-Ups", timeGoal: 60, reps: 20, requiresEquipment: false, muscle: .chest, description: "Keeping your body in one long line and your core engaged, inhale as you bend your arms to lower your chest to the floor. If you can't maintain a flat back or bend your arms fully so that your chest almost reaches the floor, lower your knees to the floor to do a modified push-up from that position.")
var shoulderTapPlanks = ExerciseData(name: "Shoulder Tap Planks", timeGoal: 60, reps: 20, requiresEquipment: false, muscle: .core, description: "While planking, you rapidly lift one hand to tap the opposite shoulder and put it back down.  Alternate hands rapidly – but make sure the movement stays controlled. No butt wiggles!")
var mountainClimbers = ExerciseData(name: "Mountain Climbers", timeGoal: 60, reps: 1, requiresEquipment: false, muscle: .core, description: "Start in a push-up position.  Then start alternating legs as you bring a knee to your chest, and back to starting position.  Sort of like running in place… horizontally?")
var stepUps = ExerciseData(name: "Step-Ups", timeGoal: 60, reps: 30, requiresEquipment: false, muscle: .legs, description: "Start standing in front of a knee-height bench, or step with your feet together. Step onto the bench with your right foot, pushing through your heel and driving your left knee up, Lower your left leg down, stepping backward off the bench.")
var pullUps = ExerciseData(name: "Pull-Ups", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .back, description: "Stand underneath a pull-up bar and grip it with your hands, placing them slightly wider than shoulder-width apart. Lift your feet off the ground and hang from your arms, then pull yourself up by bending your arms and pulling your elbows toward the ground.")
var barbellBenchPress = ExerciseData(name: "Barbell Bench Press", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .chest, description: "Lie down on the bench and adjust so your eyes are under the bar. Raise your chest up and tuck your shoulder blades down and squeeze them together.")
var inclineBenchPress = ExerciseData(name: "Incline Bench Press", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .chest, description: "Lie on an incline bench holding a barbell with your hands slightly wider than shoulder-width apart. Brace your core, then lower the bar towards your chest. Press it back up to the start.")
var dumbbellBenchPress = ExerciseData(name: "Dumbbell Chest Press", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .chest, description: "Adjust the chest press bench so that you sit with knees bent slightly and your feet on the floor. Grasp the handles, and exhale as you push them away until your arms are straight out. Keep your elbows slightly bent. As you inhale, pull the bars toward you slowly and with control, without letting the weights touch down.")
var inclineDumbbellPress = ExerciseData(name: "Incline Dumbbell Press", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .chest, description: "Lie on an incline bench holding a dumbbell in each hand by your shoulders. Brace your core, then press the weights up until your arms are straight. Lower them back to the start.")
var dips = ExerciseData(name: "Dips", timeGoal: 30, reps: 10, requiresEquipment: true, muscle: .chest, description: "Keeping your arms straight, hold your body up on two parallel bars that are a couple inches wider than shoulder-width apart. Descend until your chest is roughly in line with your hands, then push back up to the starting position, locking out your elbows. Descend while keeping your torso slightly horizontal to the ground, which emphasizes the chest muscles over your triceps.")
var bentOverRow = ExerciseData(name: "Bent-over Row", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .chest, description: "Hold a barbell with an overhand grip, hands just outside your legs. Bend your knees slightly, brace your core, then pull the bar up, leading with your elbows. Lower it back to the start.")
var barbellDeadLift = ExerciseData(name: "Barbell Dead Lift", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .back, description: "Stand with your mid-foot under the barbell. Bend over and grab the bar with a shoulder-width grip. Bend your knees until your shins touch the bar. Lift your chest up and straighten your lower back. Take a big breath, hold it, and stand up with the weight")
var wideGripPullUps = ExerciseData(name: "Wide-Grip Pull-Ups", timeGoal: 60, reps: 10, requiresEquipment: true, muscle: .back, description: "Wide-grip pull-ups are excellent for putting emphasis on the upper lats. Stand underneath a pull-up bar, and grip it with your hands placing them wider than shoulder-width apart. Lift your feet off the ground and hang from your arms, then pull yourself up by bending your arms and pulling your elbows toward the ground.")
var wideGripSeatedCableRow = ExerciseData(name: "Wide-Grip Seated Cable Row", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .back, description: "Bend your knees and hold the bar with an overhand grip, wider than shoulder-width apart. Lean back slightly, keeping your back straight, then use your back muscle to pull the bar towards your belly button. Return the bar to starting position and repeat")
var singleArmDumbbellRow = ExerciseData(name: "Single-Arm Dumbbell Row", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .back, description: "Starting Position: Holding a dumbbell in your right hand, bend over to place your left knee and left hand on a bench to support your body weight. Upward Movement: Exhale and slowly pull the dumbbell upwards, bending your elbow and pulling your upper arm backwards.")
var latPullDown = ExerciseData(name: "Lat Pull Down", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .back, description: "Adjust the pad so it sits snugly on your thighs to minimize movement. Grasp the bar with a wide grip, looking forward with your torso upright. Retract your shoulder blades and pull the bar down in front of you to your upper chest. Squeeze your lats at the bottom of the move. Resist the temptation to lean back to aid the movement.")
var barbellBicepCurl = ExerciseData(name: "Barbell Bicep Curl", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .arms, description: "Classic bad form for the bicep curl includes erratic swinging at the bottom of the rep. Keep your feet planted shoulder-width apart, knees slightly bent and elbows kept strictly by your side. Aim for a powerful contraction to the top of the rep, with a slow three-second eccentric movement.")
var skullCrushers = ExerciseData(name: "Skull Crushers", timeGoal: 30, reps: 10, requiresEquipment: true, muscle: .arms, description: "Skull crushers target your triceps, elbows, and shoulders. Form tips: Focus on hinging at the elbows, versus the shoulder. Start with the weights straight above your body, then only hinge at the elbows. Keep your triceps steady as you bend and extend, really isolating them.  Don't drop the weight; else you'll find out why this exercise is called the 'skull crusher'.")
var singleArmDumbbellTricepsExtension = ExerciseData(name: "Single-Arm Dumbbell Overhead Triceps Extension", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .arms, description: "Start with a light weight and build your way up as your stability, and strength improves. This exercise provides a unique way to isolate the tricep, lifting the arm above the head to stretch the long head of the muscle placing more emphasis on the contraction. When standing, ensure you are contracting your abs to hold your body still and prevent your lower back from arching.")
var cableBicepCurl = ExerciseData(name: "Cable Bicep Curl", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .arms, description: "Cable bicep exercises can often be overlooked for the more favorable barbell or dumbbell variations, but you don't need to fall into that same trap. The Cable Bicep Curl is essential for increasing training volume in your arm workouts, often used towards the end of sessions with a higher repetition focus. The cable machine can be great for drop sets and working to failure, with the weight pin system making it quick and simple to alter resistance.")
var cableTricepPushDown = ExerciseData(name: "Cable Tricep Push Down", timeGoal: 45, reps: 15, requiresEquipment: true, muscle: .arms, description: "Utilizing the cable machine isn't just for bicep exercises... mounting the attachment higher on the frame allows for an abundance of cable tricep extension exercises to be performed. A strict posture is key to isolating the triceps effectively. Position yourself with a balanced stance, soft knees and retracted shoulders; keeping your elbows pinned by your side throughout the movement.")
var seatedDumbbellShouldersPress = ExerciseData(name: "Seated Dumbbell Shoulder Press", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .shoulders, description: "Sit on a low-back bench and hold a dumbbell in each hand at the shoulder level, palms facing forward. Keeping your head and spine perfectly straight, lift the dumbbells overhead toward one another, stopping just short of having them touch at the top. Hold the position for a few seconds and then carefully reverse course. Repeat.")
var frontRaise = ExerciseData(name: "Front Raise", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .shoulders, description: "You can use either a weight plate or barbell for this shoulder exercise, which targets the anterior deltoids, keep your hands at hip height as you hold the weight in front of you. Your feet should be even with your shoulders and your core should be tight. Next, retract your shoulder blades and keep your arms straight as you lift the weight to shoulder level. Breathe steadily and lower the weight carefully. Repeat.")
var bentOverDumbbellLatRaise = ExerciseData(name: "Bent Over Dumbbell Lateral Raise", timeGoal: 45, reps: 15, requiresEquipment: true, muscle: .shoulders, description: "This wildly effective shoulder exercise targets your middle deltoids, though it also builds upon your overall physique. You can perform it in either a standing (bent-over) or seated position. Start with a dumbbell in each hand, keeping your chest up, your back flat, your knees slightly bent, and your eyes focussed toward a fixed point on the floor. Now, bend over until your core is basically parallel with the ground, and hang the dumbbells directly underneath you, all while keeping your elbows in a slightly bent position. Next, raise both dumbbells up and out to your sides, forming an arc until your upper arms are even with your torso. Take a brief pause at the top before lowering the dumbbells back into starting position. Repeat.")
var dumbbellSquatWalk = ExerciseData(name: "Dumbbell Squat Walk", timeGoal: 60, reps: 25, requiresEquipment: true, muscle: .shoulders, description: "Pick up the heaviest set of dumbbells you can handle and walk in place squatting. Squeeze the handles hard and walk with your chest out and shoulders back. ")
var dumbbellDeadliftShrug = ExerciseData(name: "Dumbbell Deadlift/Shrug Combo", timeGoal: 45, reps: 10, requiresEquipment: true, muscle: .shoulders, description: "Hold dumbbells at your sides and stand with feet shoulder width. Bend your hips back to squat down until the weights are knee level. Now explode upward and shrug hard at the top. Reset your feet before beginning the next rep.")
var gobletSquat = ExerciseData(name: "Goblet Squat", timeGoal: 45, reps: 15, requiresEquipment: true, muscle: .legs, description: "Hold a kettlebell or dumbbell close to your chest, push your hips back and squat down slowly until your thighs are parallel to the ground. From this position, drive up to standing, leading with your chest. Working in front of a mirror will help to keep your knees in line with your feet and torso upright.")
var legPress = ExerciseData(name: "Leg Press", timeGoal: 45, reps: 10, requiresEquipment: true, muscle: .legs, description: "The leg press requires a machine move, it works the quads, glutes and hamstrings in one fell swoop. Sit back on the machine with your feet on the plate shoulder-width apart. Release the handles so your legs take the weight, then lower your legs towards your chest slowly. Drive them back up, but don’t lock out your knees.")
var deadlift = ExerciseData(name: "Deadlift", timeGoal: 45, reps: 10, requiresEquipment: true, muscle: .legs, description: "Stand with your feet shoulder-width apart with the bar on the ground in front of you. Reach down and grasp it with your hands slightly wider than your legs, then lift the bar by driving your hips forwards. Lower the bar back to the floor under control. Keep your back straight throughout.")
var squats = ExerciseData(name: "Squats", timeGoal: 45, reps: 15, requiresEquipment: true, muscle: .legs, description: "If you are not experienced, ask someone to spot you. In a squat rack or cage, grasp the bar as far apart as is comfortable and step under it. Place it on your lower traps, squeeze your shoulder blades together, push your elbows up and nudge the bar out of the rack. Take a step or two back and stand with your feet at shoulder width and your toes turned slightly out. Take a deep breath and bend your hips back, then bend your knees to lower your body as far as you can without losing the arch in your lower back. Push your knees out as you descend. Drive vertically with your hips to come back up, continuing to push your knees out")
var seatedCalfRaise = ExerciseData(name: "Seated Calf Raise", timeGoal: 45, reps: 15, requiresEquipment: true, muscle: .legs, description: "Use a seated calf raise machine, or sit on a bench and rest the balls of your feet on a block or step (and hold dumbbells on your thighs for resistance). Perform a calf raise as described at left, but with hips and knees bent 90 degrees.")
var boxJump = ExerciseData(name: "Box Jump", timeGoal: 30, reps: 10, requiresEquipment: true, muscle: .legs, description: "This workout builds strength all over your legs, calves included. Do the following: Find a secure box and stand a short distance away from it, keeping your feet shoulder-width apart. Drop into a quarter squat and swing your arms as you powerfully jump onto the box. Land softly and step backward, maintaining a tight sense of form and control")
var jumpRope = ExerciseData(name: "Jump Rope", timeGoal: 60, reps: 1, requiresEquipment: false, muscle: .core, description: "You're moving quickly on your toes and jumping, a practical use of your calves")
var lungeTwist = ExerciseData(name: "Lunge With a Twist", timeGoal: 60, reps: 15, requiresEquipment: false, muscle: .legs, description: "The lunge with a twist exercise is a great core exercise that builds lower body strength. Performing the lunge while holding and rotating a medicine ball from right to left engages the quads, glutes, and core while improving balance and proprioception, though using this equipment is not required.")
var dumbbellJumpSquat = ExerciseData(name: "Dumbbell Jump Squat", timeGoal: 60, reps: 20, requiresEquipment: true, muscle: .legs, description: "The dumbbell jump squat is nearly identical to other loaded jumping versions, requiring an athlete to transfer force into the floor to create enough energy to explosively jump themselves up into the air.")
var plank = ExerciseData(name: "Plank", timeGoal: 60, reps: 1, requiresEquipment: false, muscle: .core, description: "The plank (also called a front hold, hover, or abdominal bridge) is an isometric core strength exercise that involves maintaining a position similar to a push-up for the maximum possible time.")
var situp = ExerciseData(name: "Situps", timeGoal: 90, reps: 45, requiresEquipment: false, muscle: .core, description: "Situps are classic abdominal exercises done by lying on your back and lifting your torso. They use your body weight to strengthen and tone the core-stabilizing abdominal muscles. ... With a larger range of motion, situps target more muscles than crunches and static core exercises.")
var russianTwist = ExerciseData(name: "Russian Twist", timeGoal: 60, reps: 25, requiresEquipment: false, muscle: .core, description: "The Russian Twist is a popular core exercise that improves oblique strength and definition. The exercise, typically performed with a medicine ball, involves rotating your torso from side to side while holding a sit-up position with your feet off the ground. Holding a med ball or plate makes the movement more difficult.")
var superMan = ExerciseData(name: "Super Man", timeGoal: 60, reps: 1, requiresEquipment: false, muscle: .core, description: "While maintaining the plank position with the rest of your body, slowly lift and extend one arm and the opposite leg. Hold them in the raised position for five seconds (or less depending on how hard you're finding it), then return to the starting position. Repeat on the other side.")
var jumpingJack = ExerciseData(name: "Jumping Jack", timeGoal: 60, reps: 1, requiresEquipment: false, muscle: .core, description: "A conditioning exercise performed from a standing position by jumping to a position with legs spread and arms raised and then to the original position.")
var shoulderPress = ExerciseData(name: "Shoulder Press", timeGoal: 60, reps: 15, requiresEquipment: true, muscle: .shoulders, description: "Machine shoulder press is a exercise machine exercise that primarily targets the shoulders and to a lesser degree also targets the chest, middle back and triceps. ... machine shoulder press is a exercise for those with a intermediate level of physical fitness and exercise experience.")
var scissorKicks = ExerciseData(name: "Scissor Kicks", timeGoal: 60, reps: 1, requiresEquipment: false, muscle: .core, description: "The scissor kick is one of several exercises you can do to build and maintain your core strength. It also targets your lower body, which means you engage multiple muscles in order to complete the move. This exercise is sometimes also called flutter kicks")
    
    
let builtInExercises: [ExerciseData] = [pushUps, shoulderTapPlanks, mountainClimbers, stepUps, pullUps, barbellBenchPress, inclineBenchPress, dumbbellBenchPress, inclineDumbbellPress, dips, bentOverRow, barbellDeadLift, wideGripPullUps, wideGripSeatedCableRow, singleArmDumbbellRow, latPullDown, barbellBicepCurl, skullCrushers, singleArmDumbbellTricepsExtension, cableBicepCurl, cableTricepPushDown, seatedDumbbellShouldersPress, frontRaise, bentOverDumbbellLatRaise, dumbbellSquatWalk, dumbbellDeadliftShrug, gobletSquat, legPress, deadlift, squats, seatedCalfRaise, boxJump, jumpRope, lungeTwist, dumbbellJumpSquat, plank, situp, russianTwist, superMan, jumpingJack, scissorKicks]

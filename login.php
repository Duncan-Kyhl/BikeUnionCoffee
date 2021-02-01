<?php

require_once("../db.php"); 

// checks if the user has clicked the login button
if (isset($_POST["submit"])) {

  // sets the username variable from the form and hash the password before comparing against the password in the database
  $username = $_POST["username"];
  $password = hash("sha512", $_POST["password"]);

  // prepare the query to find users with the entered username and password
  $query =
  "SELECT *
   FROM 354groupb1.user
   WHERE username = ?
   AND password = ?";
  $stmt = $conn->prepare($query);

  // execute the query and store the results
  $stmt->execute([$username, $password]);

  // checks to see if a match is found for a specific username/password combination
  if($stmt->rowCount() > 0){

    // destroys any existing sessions and starts a new session
    session_destroy();
    session_start();

    // sets the username session variable, see the next block of code below to see how it is used!!!
    $_SESSION["user"] = $username;

    // redirects to any page (i.e. home.php)
    header("Location: ../page2_Home/home.html");
    exit();

  // sets the error message if there is no matching username/password combination
  } else {
    echo "Your login credentials are incorrect!";
    exit;
  }
}
?>

<?php

// checks for an existing session ands starts one if there isn't a current session
if (session_status() != PHP_SESSION_ACTIVE) {
  session_start();
}

// checks if the session variable is set
if (isset($_SESSION["user"])) {
  // the code in the if logic is seen only by those with a session (Note: all HTML code may need to be echoed to ensure this works)
}
?>

<!DOCTYPE html>
<html lang="en" >
  <head>
	<meta charset="UTF-8">
	<title>Login</title>
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
	<link href="style.css" rel="stylesheet">

  </head>
  
  <body><link href="style.css" rel="stylesheet">
	<!-- partial:home.partial.html -->
	<body class="align">
	  
	  <div class="grid">
		<img src="https://lh3.googleusercontent.com/proxy/QdjrkEhr_zPpiluYB8r7GgRK47dljQ7-DTIeTZbnw1bLi6JP9inhHiAfAb866ln_PAZqtB7bjC3D0v2_Ynvn-Io7lImWjoIvHOPM_M_e8pSL4WH8Tr2Odi1GISa2Z09W5nU" width="200">
		<h1 align="center">Login</h1>
		
		<form method="post" class="form login">

		  <div class="form__field">
			<label for="login__username" name="username">

			  <span class="hidden">Username</span>
			</label>
			<input id="login__username" type="text" name="username" class="form__input" placeholder="Username" required>
		  </div>

		  <div class="form__field">
			<label for="login__password">

			  <span class="hidden">Password</span>
			</label>
			<input id="login__password" type="password" name="password" class="form__input" placeholder="Password" required>
		  </div>

		  <div class="form__field">
			<input type="submit" name="submit" value="Sign In">
		  </div>

		</form>

		<p class="text--center">Not a member? <br>
		  Ask your supervisor to create an account!<br>

	  </div>


	</body>
	<!-- partial -->

  </body>
</html>

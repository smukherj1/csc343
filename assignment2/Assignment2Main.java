class Assignment2Main
{
	public static void main(String []args)
	{
		Assignment2 a2 = new Assignment2();
		System.out.println("Info: Attempting to connect to the database...");
		if(!a2.connectDB(
			"jdbc:postgresql://localhost:5432/csc343h-c5mukher",
			"c5mukher",
			""
		))
		{
			System.out.println("Error: Connection failed.");
			System.exit(-1);
		}
		else
		{
			System.out.println("Info: Connection established.");
		}

		a2.findCoStars(null);

		if(!a2.disconnectDB())
		{
			System.out.println("Error: Connection release failed.");
			System.exit(-1);
		}
		else
		{
			System.out.println("Info: Connection to database terminated successfully");
		}
	}	
};
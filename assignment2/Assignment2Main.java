import java.util.*;

class Assignment2Main
{
	public static Assignment2 connect()
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
		return a2;
	}

	public static void disconnect(Assignment2 a2)
	{
		if(!a2.disconnectDB())
		{
			System.out.println("Error: Connection release failed.");
			System.exit(-1);
		}
		else
		{
			System.out.println("Info: Connection to database terminated successfully.");
		}
	}

	public static void test_coStars(Assignment2 a2, String name)
	{
		ArrayList<String> coStars = a2.findCoStars(name);
		System.out.println(">>>>>>>> Co Stars for " + name);
		for(String iname : coStars)
		{
			System.out.println(iname);
		}
		System.out.println(">>>>>>>> End List\n");
	}

	public static void main(String []args)
	{

		Assignment2 a2 = connect();

		test_coStars(a2, "Pitt, Brad");
		test_coStars(a2, null);
		test_coStars(a2, "Invalid Name");

		disconnect(a2);
	}	
};
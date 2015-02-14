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
		System.out.println(">>>>>>>> End List");
	}

	public static int test_connectivity(Assignment2 a2, 
										String p1, 
										String p2,
										int expected_connectivity)
	{
		int connectivity = a2.computeConnectivity(p1, p2);
		boolean ok = connectivity == expected_connectivity;
		String result;
		if(ok)
		{
			result = " PASS";
		}
		else
		{
			result = " FAIL (expected " + expected_connectivity + ")";
		}
		System.out.println(p1 + " --> " + p2 + " : " + connectivity +
			result);

		if(ok)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	public static void main(String []args)
	{

		Assignment2 a2 = connect();

		test_coStars(a2, "Pitt, Brad");
		test_coStars(a2, "Actor 10");
		test_coStars(a2, null);
		test_coStars(a2, "Invalid Name");

		int errors = 0;

		errors += test_connectivity(a2, null, null, 0);
		errors += test_connectivity(a2, null, "hi", -1);
		errors += test_connectivity(a2, "hi", "hi", 0);
		errors += test_connectivity(a2, "Actor 10", "Actor 11", 1);
		errors += test_connectivity(a2, "Actor 10", "Actor 13", 2);
		errors += test_connectivity(a2, "Actor 10", "Actor 14", 2);
		errors += test_connectivity(a2, "Actor 10", "Actor 19", 5);
		errors += test_connectivity(a2, "Actor 10", "Actor 20", -1);
		errors += test_connectivity(a2, "Actor 20", "Actor 10", -1);

		disconnect(a2);

		if(errors > 0)
		{
			System.out.println(errors + " test(s) failed");
			System.exit(-1);
		}
	}	
};
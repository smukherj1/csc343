import java.sql.*;
import java.util.*;

public class Assignment2 {

		// A connection to the database
		private Connection connection;
		
		// Empty constructor. There is no need to modify this.
		public Assignment2() {}

				/**
				* Establishes a connection to be used for this session, assigning it to
				* the instance variable 'connection'.
				*
				* @param  url       the url to the database
				* @param  username  the username to connect to the database
				* @param  password  the password to connect to the database
				* @return           true if the connection is successful, false otherwise
				*/
				public boolean connectDB(String url, String username, String password) {
						boolean result = true;
						try
						{
								Class.forName("org.postgresql.Driver");
						}
						catch (ClassNotFoundException e) {
								result = false;
						}
						if(result)
						{
								try
								{
										connection = DriverManager.getConnection(url, username, password);
								}
								catch(SQLException e)
								{
										result = false;
								}
						}
						return result;
				}

				/**
				* Closes the database connection.
				*
				* @return true if the closing was successful, false otherwise
				*/
				public boolean disconnectDB() {
						boolean result = true;
						if(connection != null)
						{
								try
								{
										connection.close();
										connection = null;
								}
								catch(SQLException e)
								{
										result = false;
								}
						}
						return result;
				}

				private int get_person_id(String person) throws SQLException
				{
					PreparedStatement p;
					ResultSet r;
					int person_id = -1;

					if(person == null)
					{
						throw new SQLException("Trying to get person_id for <null>");
					}

					p = connection.prepareStatement("select * from imdb.people where name = ?");
					p.setString(1, person);
					r = p.executeQuery();

					if(r.next())
					{
						String name = r.getString("name");
						person_id = r.getInt("person_id");
						assert(name.equals(person));
					}
					else
					{
						throw new SQLException("Person: '" + person + "' did not exist!");
					}

					return person_id;
				}

				private void findCoStars_helper(String person, ArrayList<String> coStars)
				throws SQLException
				{
					PreparedStatement p;
					ResultSet r;
					LinkedHashSet<Integer> coStarIDs = new LinkedHashSet<Integer>();
					LinkedHashSet<Integer> movies = new LinkedHashSet<Integer>();
					
					// First get the movies this person worked on
					int person_id = get_person_id(person);
					p = connection.prepareStatement("select movie_id from imdb.roles where person_id = " + person_id);
					r = p.executeQuery();
					while(r.next())
					{
						int movie_id = r.getInt("movie_id");
						movies.add(movie_id);
					}

					// Now get the names of all other actors this person worked with
					p = connection.prepareStatement("select * from imdb.roles");
					r = p.executeQuery();
					while(r.next())
					{
						int movie_id = r.getInt("movie_id");
						int co_star_person_id = r.getInt("person_id");
						// Add this person if they worked in the same movie and they
						// the not the person for whom we are looking for co stars
						if((co_star_person_id != person_id) &&
							movies.contains(movie_id))
						{
							coStarIDs.add(co_star_person_id);
						}
					}

					// Now convert these person_ids of the co starts to names
					p = connection.prepareStatement("select * from imdb.people");
					r = p.executeQuery();
					while(r.next())
					{
						int co_star_person_id = r.getInt("person_id");
						String name = r.getString("name");

						if(coStarIDs.contains(co_star_person_id))
						{
							coStars.add(name);
						}
					}
				}

				/**
				* Returns a sorted list of the names of people who have acted in
				* at least one movie with the input person.
				*
				* Returns an empty list if the input person is not found.
				*
				* NOTES:
				* 1. The names should be taken directly from the database,
				*    without any formatting. (So the form is 'Pitt, Brad')
				* 2. Use Collections.sort() to sort the names in ascending
				*    alphabetical order.
				*
				* @param  person  the name of the person to find the co-stars for
				* @return         a sorted list of names of actors who worked with person
				*/
				public ArrayList<String> findCoStars(String person) {
						ArrayList<String> coStars = new ArrayList<String>();
						try 
						{
								findCoStars_helper(person, coStars);
						}
						catch(SQLException e)
						{
						}
						Collections.sort(coStars, new Comparator<String>(){
							@Override
							public int compare(String a, String b)
							{

								return  a.compareTo(b);
							}
						});
						return coStars;
				}

				private int computeConnectivityHelper(String p1, String p2)
				throws SQLException
				{
					Queue<BFSQueueElement> bfsq = new LinkedList<BFSQueueElement>();
					LinkedHashSet<String> seen_people = new LinkedHashSet<String>();
					BFSQueueElement target_element = null;

					bfsq.add(new BFSQueueElement(p1, 0));
					seen_people.add(p1);

					while(bfsq.peek() != null)
					{
						BFSQueueElement head = bfsq.remove();

						if(p2.equals(head.name()))
						{
							target_element = head;
							break;
						}

						ArrayList<String> coStars = findCoStars(head.name());
						for(String coStar : coStars)
						{
							if(!seen_people.contains(coStar))
							{
								BFSQueueElement qe = new BFSQueueElement(coStar, head.level() + 1);
								bfsq.add(qe);
								seen_people.add(coStar);
							}
						}

					}

					if(target_element != null)
					{
						return target_element.level();
					}
					else
					{
						return -1;
					}
				}

				/**
				* Computes and returns the connectivity between two actors.
				*
				* Returns 0 if the two arguments are equal, regardless of whether they are
				* in the database or not.
				* Returns -1 if at least one of the input actors are not found.
				*
				* WARNING:
				* Do not assume the actors are connected; return -1 if they are not.
				* It's easy to write this method naively and get into an infinite loop
				* when the actors are not connected. Make sure you handle this!
				*
				* @param person1  the name of an actor
				* @param person2  the name of an actor
				* @return         the connectivity between the actors, or -1 if they
				*                 are not connected
				*/
				public int computeConnectivity(String person1, String person2) {
						int connectivity = -1;
						try
						{
							if((person1 == person2) || (person1.equals(person2)))
							{
								return 0;
							}
						}
						catch(NullPointerException e)
						{
							return -1;
						}
						try
						{
							// We don't actually need the person_ids, we only use these functions to ensure
							// these people actually exist. If the person doesn't exist, get_person_id will
							// throw an SQLException
							get_person_id(person1);
							get_person_id(person2);
							connectivity = computeConnectivityHelper(person1, person2);
						}
						catch(SQLException e)
						{
							return -1;
						}

						return connectivity;
				}

				private class BFSQueueElement
				{
					private String m_name = null;
					private int m_level = 0;

					public BFSQueueElement(String name, int level)
					{
						if(name == null)
						{
							throw new IllegalArgumentException("Name can't be NULL");
						}
						m_name = new String(name);
						m_level = level;
					}

					public int level()
					{
						return m_level;
					}

					public String name()
					{
						return m_name;
					}
				}
		}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;

namespace Member
{
    class Program
    {

        static void Main(string[] args)
        {
            Console.WriteLine("Log: Start Connection");

            string configDB = Environment.GetEnvironmentVariable("DB_CONNECTION");

            using (var _connection = new MySqlConnection(configDB))
            {
                Console.WriteLine("Log: _connection.ConnectionString: " + _connection.ConnectionString);

                if (_connection.State == ConnectionState.Closed)
                    _connection.Open();

                Console.WriteLine("Log: State: " + _connection.State.ToString());
                Console.WriteLine("Log: DB ServerVersion: " + _connection.ServerVersion);

                using (var cmd = new MySqlCommand("SELECT * FROM member", _connection))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        List<Member> members = new List<Member>();
                        while (reader.Read())
                        {
                            members.Add(new Member()
                            {
                                Id = Convert.ToInt32(reader["id"]),
                                Firstname = reader["firstname"].ToString(),
                                Lastname = reader["lastname"].ToString(),
                            });
                        }

                        Console.WriteLine("Log: Count: " + members.Count);
                        Console.WriteLine("Log: Result: " + JsonConvert.SerializeObject(members));
                    }
                }

            } 

        }
    }

    [Table("member")]
    public class Member
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Column("firstname")]
        public string Firstname { get; set; }

        [Column("lastname")]
        public string Lastname { get; set; }

    }
}

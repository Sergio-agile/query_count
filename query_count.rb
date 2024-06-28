# 1)
Employee.all.each do |emp|
  emp.addresses.each { |addr| puts addr.street }
end
# In this Scenario 9 queries are executed.

# First query is done to retrieve all the employees when executing Employee.all
# For each fetched employee, a new query is launched when executing emp.addresses, since data for addresses is not available yet.

# 2)
Employee.joins(:addresses).all.each do |emp|
  emp.addresses.each { |addr| puts (addr.street) }
end

# In this Scenario 9 queries are executed too.

# First query is done to retrieve all the employees when executing Employee.joins(:addresses).all. Here joins (INNER JOIN) is used to fetch those who has address in the addresses table, but is not including data from addresses.
# For each fetched employee, a new query is launched when executing emp.addresses, since data for addresses is not available yet.

# 3)
Employee.includes(:addresses).all.each do |emp|
  emp.addresses.each { |addr| puts (addr.street) }
end

# In this Scenario 2 queries are executed
# Both are executed when executing Employee.includes(:addresses).all. Using includes means a second query is executed to retrieve data from addresses for every employee id. There's no need to execute more queries, data is avaliable within the each block. This allow us to avoid the execution of extra queries for every employee, loading data related data at the same time as the 'primary' data.

# 4)
Employee.joins(:addresses).includes(:addresses).all.each do |emp|
  emp.addresses.each { |addr| puts(addr.street) }
end
# In this Scenario 1 query is executed.
# In this case one query is executed to fetch all data, employees and its related addresses. Thanks to the concatenation of active record query interface methods joins and includes, first we get all employees with its addresses, and then we include data from addresses from the very begining.




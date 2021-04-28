#!/bin/bash

export HIVE_SKIP_SPARK_ASSEMBLY=true;

userChoice = ""

echo Please pick one of the following options
echo 1, Number of reviews with a specified rating
echo 2, Number of places within each price range
echo 3, All of the people with the IT specialist job
echo 4, Frequent Phrases within specific rating of reviews
echo 5, All places with greater than three reviews
echo 6, All of the IT specialist reviews
echo 7, Show all the closed and open places
echo 8, Inverted Document Index on reviewText
echo 9, Average rating of each review catergory
echo 10, top 5 categories within reviews
echo 11, number of places still open within each price range
echo 12, average rating price range each rating
echo 13, Amount of reviews per price range
echo 14, Characters per review For Ratings
echo 15, Place with the largest number of reviews

function functionality1(){
	while [[ ! $userChoice =~ ^[1-9]{1} ]]; 
	do # While loop prevents user from entering anything other than 1-5 in numbers
		read -p "Enter rating between 1-5: " userChoice #Reads Inputted Number
	done
	echo "Executing Functionality 1..."
	export result=$(hive -S -f "Functionality1.hql" --hiveconf num=$userChoice) 
	#Executes Script in silent mode and saves result to variable

	echo "----------------------------------------------------------------------"
	echo "Number of results with a $userChoice rating: $result" #Prints result
	echo "----------------------------------------------------------------------"

	echo "Functionality 1 Finished"
}

function functionality2(){
	sudo spark-shell -i function2.scala
}

function functionality3(){
	hive -f ITSpecialistSelect.hql
}

function functionality4(){
	echo please choose a rating to check the phrases of
	while [[ ! $userChoice =~ ^[1-5]{1} ]]; 
	do # While loop prevents user from entering anything other than 1-5 in numbers
		read -p "Enter rating between 1-5: " userChoice #Reads Inputted Number
	done
	hdfs dfs -put ./mapReduceReviews.csv /user/cloudera/
	hdfs dfs -rm -r ratingFilterOut
	hdfs dfs -rm -r phrasesOut
	hdfs dfs -rm -r temp
	hadoop jar frequentPhrases.jar frequentPhrases.ratingFilter /user/cloudera/mapReduceReviews.csv /user/cloudera/phrasesOut $userChoice
}

function functionality5(){
	hive -f function5.hql
}

function functionality6(){
	hive -f ITSpecialistReviews.hql
}

function functionality7(){
	sudo spark-shell -i function7.scala	
}

function functionality8(){
	echo "Executing Functionality 8..."
	export result=$(sudo spark-shell -i "Functionality8.scala") 
	echo "Functionality 8 Finished"
}

function functionality9(){
	hive -f function9.hql
}

function functionality10(){
	echo "Executing Functionality 10..."
	export result=$(hive -S -f "Functionality10.hql") #Executes script on silent mode
	echo "----------------------------------------------------------------------"
	echo "Rating | Catagory"
	echo  "$result"
	echo "----------------------------------------------------------------------"
	echo "Functionality 10 Finished"

}

function functionality11(){
	sudo spark-shell -i function11.scala
}

function functionality12(){
	echo "Executing Functionality 12..."
	export result=$(hive -S -f "Functionality12.hql") #Executes script on silent mode
	echo "----------------------------------------------------------------------"
	echo "Price	| Average Rating"
	echo -e "$result"
	echo "----------------------------------------------------------------------"
	echo "Functionality 12 Finished"
}

function functionality13(){
	export result1=$(hive -f 1PriceRange.hql)
	export result2=$(hive -f 2PriceRange.hql)
	export result3=$(hive -f 3PriceRange.hql)
	echo Price range of $ has $result1 reviews
	echo Price range of $ $ has $result2 reviews
	echo Price range of $ $ $ has $result3 reviews
}

function functionality14(){
	export result1=$(hive -f AvgLengthRating1.hql)
	export result2=$(hive -f AvgLengthRating2.hql)
	export result3=$(hive -f AvgLengthRating3.hql)
	export result4=$(hive -f AvgLengthRating4.hql)
	export result5=$(hive -f AvgLengthRating5.hql)
	echo Rating 1 has an average length of $result1
	echo Rating 2 has an average length of $result2
	echo Rating 3 has an average length of $result3
	echo Rating 4 has an average length of $result4
	echo Rating 5 has an average length of $result5
}

function functionality15(){
	echo "Executing Functionality 15..."
	export result=$(hive -S -f "Functionality15.hql") #Executes script on silent mode
	echo "----------------------------------------------------------------------"
	IFS='	' read -r -a array <<< "$result" # Splits results into array by seperating by tabs
	#Prints array
	echo "Review Count: ${array[0]}"
	echo "Place Name: ${array[1]}"
	echo "Place ID: ${array[2]}"
	echo "----------------------------------------------------------------------"
	echo "Functionality 15 Finished"
}

while [[ ! $userChoice =~ ^[1-9] ]]
do
	read userChoice
done

startTimer=$(date +%s)

if [ $userChoice -eq 1 ]; then
	functionality1
elif [ $userChoice -eq 2 ]; then
	functionality2
elif [ $userChoice -eq 3 ]; then
	functionality3
elif [ $userChoice -eq 4 ]; then
	functionality4
elif [ $userChoice -eq 5 ]; then
	functionality5
elif [ $userChoice -eq 6 ]; then
	functionality6
elif [ $userChoice -eq 7 ]; then
	functionality7
elif [ $userChoice -eq 8 ]; then
	functionality8
elif [ $userChoice -eq 9 ]; then
	functionality9
elif [ $userChoice -eq 10 ]; then
	functionality10
elif [ $userChoice -eq 11 ]; then 
	functionality11
elif [ $userChoice -eq 12 ]; then
	functionality12
elif [ $userChoice -eq 13 ]; then
	functionality13
elif [ $userChoice -eq 14 ]; then
	functionality14
elif [ $userChoice -eq 15 ]; then 
	functionality15
fi

endTimer=$(date +%s)

echo Time taken $(($endTimer - $startTimer)) seconds

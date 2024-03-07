CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone https://github.com/ucsd-cse15l-f22/list-methods-corrected student-submission
echo 'Finished cloning'

if [ ! -f student-submission/ListExamples.java ]; then
  echo "Error: Incorrect file submitted. Please submit ListExamples.java."
  exit 1
fi

cp -r student-submission/ListExamples.java grading-area/
cp -r TestListExamples.java grading-area/

cd grading-area
javac -cp .:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar *.java
if [ $? -ne 0 ]; then
  echo "Error: Compilation failed."
  exit 1
fi

java -cp .:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > output.txt

if grep -q "OK" output.txt; then
  echo "Success"
else
  echo "False"
fi

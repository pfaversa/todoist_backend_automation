package helpers;

import com.github.javafaker.Faker;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DataGenerator {
    public static String getRandomProjectName(){
        Faker faker = new Faker();
        String projectName = "How to Cook " + faker.food().dish().toUpperCase() + " like a Pro";
        return projectName;
    }

    public static String getRandomTaskName(){
        Faker faker = new Faker();
        String taskName = " Step 1 - Start cooking first " + faker.food().ingredient().toUpperCase();
        return taskName;
    }

    public static String getRandomTaskDescription(){
        Faker faker = new Faker();
        String taskDescription =  "Serving size: " +faker.food().measurement();
        return taskDescription;
    }

    public static String dueDate(int incrementDay) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
        LocalDateTime now = LocalDateTime.now();  
        return (dtf.format(now.plusDays(incrementDay)));  
    }

}
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws FileNotFoundException {
        File file = new File("src/resources/input.txt");
        int counter = 0;
        int counter2 = 0;
        Scanner scanner = new Scanner(file);
        AdventOfCode adventOfCode = new AdventOfCode();
        while (scanner.hasNextLine()) {
            String data = scanner.nextLine();
            String[] row = data.split(" ");
            ArrayList<Integer> intRow = adventOfCode.convertRow(row);
            if (adventOfCode.validateRow(intRow, 1, false)) {
                counter++;
            }
            if (adventOfCode.validateRow(intRow, 2, false)) {
                counter2++;
            }
        }
        System.out.println("Task 1: " + counter + "\nTask 2: " + counter2);
    }
}


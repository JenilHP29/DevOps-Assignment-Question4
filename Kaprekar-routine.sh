#Assignment Q1(b&c): Handling special case and printing steps including in routine

# Function to sort digits in ascending order
asc_sort() {
    echo "$1" | grep -o . | sort | tr -d "\n"
}

# Function to sort digits in descending order
desc_sort() {
    echo "$1" | grep -o . | sort -r | tr -d "\n"
}

# Function to validate input and applying Kaprekar's Routine
kaprekar_routine() {
    num=$((10#$1)) #Decimal Input

    # Checking some cases:
    # Case 1: Check if input is numeric
    if ! [[ "$num" =~ ^[0-9]+$ ]]; then
        echo "Error: Input must be a numeric value."
        exit 1
    fi

    # Case 2: Check if input is a 4-digit number
    if [[ ${#num} -ne 4 ]]; then
        echo "Error: Please enter a valid 4-digit number."
        exit 1
    fi

    # Case 3: Check if all digits are the same (e.g., 1111, 2222)
    if [[ "$num" =~ ^([0-9])\1{3}$ ]]; then
        echo "Error: The number must have at least two distinct digits."
        exit 1
    fi

    echo "Starting Kaprekar's Routine with $num"

    count=0  # Iteration count
    while [[ $((10#$num)) -ne 6174 ]]; do
        # Format number to always be 4 digits
        num=$(printf "%04d" $((10#$num)))

        # Get ascending and descending order of digits
        asc=$(asc_sort "$num")  # Sorting digits in ascending order
        desc=$(desc_sort "$num")  # Sorting digits in descending order

        # Calculate the difference and ensure it is always 4-digit format
        num=$(printf "%04d" $((10#$desc - 10#$asc)))
        ((count++))

        # Printing the step
        echo "$desc - $asc = $num"

        # Comment: Iterating until we reach 6174
        # Comment: Kaprekar’s routine guarantees reaching 6174 in at most 7 steps
        # Comment: This ensures that the input number follows the routine correctly
        # Comment: Using printf to maintain leading zeros in the number
        # Comment: The number is recalculated in every iteration to move towards 6174
        # Comment: Each iteration reduces randomness and converges to Kaprekar's constant
        # Comment: If we reach 6174, the loop will terminate
        # Comment: Printing each step helps in visualizing the transformation process
        # Comment: Ensuring that we don’t enter an infinite loop
        # Comment: This method works for any 4-digit number that isn’t a repdigit
    done

    echo "Kaprekar's constant (6174) reached in $count steps!"
}

# Read input from the user
read -p "Enter a 4-digit number: " input_num

# Run the code(routine) with input validation
kaprekar_routine "$input_num"
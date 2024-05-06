import argparse
import math

def calculate_trials(p, desired_prob):
    q = 1 - p
    n = math.log(1 - desired_prob) / math.log(q)
    return math.ceil(n)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Calculate number of trials needed to achieve desired probability of winning")
    parser.add_argument("-p", type=float, help="Probability of winning")
    parser.add_argument("-d", "--desired_prob", type=float, help="Desired probability of winning at least once")
    args = parser.parse_args()

    if args.p is None or args.desired_prob is None:
        print("Please provide both -p and -d/--desired_prob arguments.")
    else:
        trials_needed = calculate_trials(args.p, args.desired_prob)
        print(f"The number of trials needed to guarantee winning with probability {args.desired_prob} would be {trials_needed}")

//swift 5.1.5
import Foundation

// This function uses simple sieve of eratosthenes to
// find primes upto sqrt(high)
func simpleSieve(_ limit:Int, _ prime: inout [Int]) {
  // bound is square root of "high"
  let a:Double = Double(limit)
  let b:Double = sqrt(a)
  let c = Int(floor(b))
  let bound = c;

  var mark = Array<Bool>(repeating:true, count:bound+2)

  var i = 2;
  while i * i <= bound {
    if (mark[i] == true) {
      var j = i * i;
      while j <= bound {
        mark[i] = false;
        j += i;
      }
    }
    i+=1
  }

  // adding primes to vector
  for i in 2...bound {
    if (mark[i] == true) {
      prime.append(i);
    }
  }
}

// Finds all prime numbers in range low to high
// using the primes we obtained from
// simple sieve
func segmentedSieve(_ low:Int, _ high:Int) -> String {
  var output = "[OUTPUT] ";
  var prime = Array<Int>();
  simpleSieve(high, &prime); // stores primes upto sqrt(high) in prime
  var mark = Array<Bool>(repeating:true, count:(high-low)*2)

  for i in 0...prime.count-1 {
    // find minimum number in [low...high]
    // that is multiple of prime[i]
    var loLim = (low / prime[i]) * prime[i];
    if (loLim < low) {
      loLim += prime[i];
    }

    if (loLim == prime[i]) {
      loLim += prime[i];
    }

    var j = loLim;
    while j <= high {
      if (j != prime[i]) {
        mark[j - low] = false;
      }
      j += prime[i]
    }
  }
  // print all primes in [low...high]
  for i in low...high {
    if (mark[i - low] == true) {
      output += "\(i), ";
    }
  }
  return output;
}

func main() {
  let low = 10
  let high = 20
  let output = segmentedSieve(low, high);

  print("[INPUT] range \(low) to \(high)");
  print(output);
}

main()

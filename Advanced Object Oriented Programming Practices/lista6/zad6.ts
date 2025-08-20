type A = 'a' | 'b' | 'c'
type B = 'b' | 'c' | 'd'

type extracted = Extract<A, B> // 'b' | 'c' - elementy wspólne
type excluded = Exclude<A, B> // 'a' - elementy tylko w A

// Zastosowanie: zawężanie typów, np. filtrowanie kluczy obiektu

type User = {
    id: number;
    name: string;
    age?: number;
};

// Record<A,B> - tworzy obiekt o kluczach A i wartościach B
// przydatne przy otypowaniu
type UserRecord = Record<'user1' | 'user2', User>; 
  // {
  //   user1: User;
  //   user2: User;
  // }
  

// Required<A> - zmienia wartości z A na wymagane
// Zastosowanie: nakaz przypisywania wartości - antycypacja błędów, gdy chcemy użyć składowe
type AllRequired = Required<User>; 
  // {
  //   id: number;
  //   name: string;
  //   age: number;
  // }

// Readonlu<A> - Zmienia wartości A na ReadOnly
// zastosowanie: aby nie popsuć nic
type ReadonlyUser = Readonly<User>; 
  // {
  //   readonly id: number;
  //   readonly name: string;
  //   readonly age?: number;
  // }
  
// Partial<A> - zamiana składowych na opcjonalne 
// Zastosowanie: elastyczne struktury, np. przy pracy z API
type PartialUser = Partial<User>; 
  // {
  //   id?: number;
  //   name?: string;
  //   age?: number;
  // }
  


type User2 = {
    id: number;
    name: string;
    age?: number;
    role: string;
};
  
// Pick<T, A> - tworzy typ o składowych A z typu T 
type PickedUser = Pick<User2, 'id' | 'name'>;
  // {
  //   id: number;
  //   name: string;
  // }
  
// Omit<T, A> - tworzy typ o składowych z T oprócz A 
type OmittedUser = Omit<User2, 'role'>;
  // {
  //   id: number;
  //   name: string;
  //   age?: number;
  // }

// Zastosowanie: zawężanie typów


type User3 = {
    id: number;
    name: string;
    age: number;
};
  
type UserIdType = User['id'];  // number
type UserNameAndAge = User['name' | 'age']; // string | number
  
import "fmt"

type A struct {
	Name string
	Age int
}

type B struct {
	A
	Haircolor string
}

// this must be a member function, so that it can be called from inherited structs
// func NewA(name string, age int) (a *A) couldn't be utilized from subclass B
func (a *A) _initA(name string, age int) {
	a.Name = name
	a.Age = age
}

func NewB(haircolor string) (b *B) {
	b = new(B)
	b._initA("john", 34)
	b.Haircolor = haircolor
	return
}

func main() {
	x := NewB("brown")
	fmt.Printf("%#v\n", x)
	fmt.Println(x.Name)
	fmt.Println(x.Age)
	fmt.Println(x.Haircolor)
}

/*
output:
    &main.B{A:main.A{Name:"john", Age:34}, Haircolor:"brown"}
    john
    34
    brown
*/

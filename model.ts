export class Model{
    name: string;
    items: TodoItem[];


    constructor(){
    this.name="umut";
    this.items= [
                   new TodoItem("spor",true),
                   new TodoItem("ders",false),
                   new TodoItem("film",true),
                   new TodoItem("yemek",false),
    
                ];
    }
}
export class TodoItem{

    description;
    action;
     
    constructor(description: string, action: boolean){
        this.description = description;
        this.action = action; 
    }
}
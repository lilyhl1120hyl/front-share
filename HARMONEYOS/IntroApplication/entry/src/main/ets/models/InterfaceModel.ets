interface IUser{
  username: string
  age: number
  sex: "男" | "女"
}
export class IUserModel implements IUser {
  username: string = ''
  age: number = 0
  sex: "男" | "女" = "男"

  constructor(model: IUser) {
    this.username = model.username
    this.age = model.age
    this.sex = model.sex
  }
}

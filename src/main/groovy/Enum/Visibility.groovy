package Enum

enum Visibility {
    PUBLIC("public"),
    PRIVATE("private")

    final String code

    Visibility(String code){
        this.code = code
    }
}

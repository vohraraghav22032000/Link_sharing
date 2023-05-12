package Enum

enum Seriousness {
    SERIOUS("serious"),
    VERY_SERIOUS("very_serious"),
    CASUAL("casual")

    final String code

    Seriousness(String code){
        this.code = code
    }
}

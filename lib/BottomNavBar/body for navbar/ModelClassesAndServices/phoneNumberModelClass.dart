class PhoneResponceModel
{
  String token;
    String msg;
    String vToken;
    String error;
  PhoneResponceModel({
    this.msg,this.token,this.vToken,this.error
  });
factory PhoneResponceModel.fromJson(Map<String, dynamic> json) {
return PhoneResponceModel(
        token: json["token"],
        msg: json["msg"],
        vToken: json["v_token"],
        error:json["error"]!=null?json["error"]:null
    );
 }
}
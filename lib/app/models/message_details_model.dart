class MessageDetailsModel {
  String? id;
  String? accountId;
  String? msgid;
  From? from;
  List<From>? to;
  List<From>? cc;
  List<From>? bcc;
  String? subject;
  bool? seen;
  bool? flagged;
  bool? isDeleted;
  bool? retention;
  String? retentionDate;
  String? text;
  bool? hasAttachments;
  List<Attachments>? attachments;
  int? size;
  String? downloadUrl;
  String? createdAt;
  String? updatedAt;

  MessageDetailsModel(
      {this.id,
        this.accountId,
        this.msgid,
        this.from,
        this.to,
        this.cc,
        this.bcc,
        this.subject,
        this.seen,
        this.flagged,
        this.isDeleted,
        this.retention,
        this.retentionDate,
        this.text,
        this.hasAttachments,
        this.attachments,
        this.size,
        this.downloadUrl,
        this.createdAt,
        this.updatedAt});

  MessageDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    msgid = json['msgid'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    if (json['to'] != null) {
      to = <From>[];
      json['to'].forEach((v) {
        to!.add(From.fromJson(v));
      });
    }
    if (json['cc'] != null) {
      cc = <From>[];
      json['cc'].forEach((v) {
        cc!.add(From.fromJson(v));
      });
    }
    if (json['bcc'] != null) {
      bcc = <From>[];
      json['bcc'].forEach((v) {
        bcc!.add(From.fromJson(v));
      });
    }
    subject = json['subject']==null ||json['subject']==''?'No Subject':json['subject'] ;
    seen = json['seen'];
    flagged = json['flagged'];
    isDeleted = json['isDeleted'];
    retention = json['retention'];
    retentionDate = json['retentionDate'];
    text = json['text'];
    hasAttachments = json['hasAttachments'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['msgid'] = msgid;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.map((v) => v.toJson()).toList();
    }
    if (cc != null) {
      data['cc'] = cc!.map((v) => v.toJson()).toList();
    }
    if (bcc != null) {
      data['bcc'] = bcc!.map((v) => v.toJson()).toList();
    }
    data['subject'] = subject;
    data['seen'] = seen;
    data['flagged'] = flagged;
    data['isDeleted'] = isDeleted;
    data['retention'] = retention;
    data['retentionDate'] = retentionDate;
    data['text'] = text;
    data['hasAttachments'] = hasAttachments;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['size'] = size;
    data['downloadUrl'] = downloadUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class From {
  String? address;
  String? name;

  From({this.address, this.name});

  From.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['name'] = name;
    return data;
  }
}

class Attachments {
  String? id;
  String? filename;
  String? contentType;
  String? disposition;
  String? transferEncoding;
  bool? related;
  int? size;
  String? downloadUrl;

  Attachments(
      {this.id,
        this.filename,
        this.contentType,
        this.disposition,
        this.transferEncoding,
        this.related,
        this.size,
        this.downloadUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    contentType = json['contentType'];
    disposition = json['disposition'];
    transferEncoding = json['transferEncoding'];
    related = json['related'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    data['contentType'] = contentType;
    data['disposition'] = disposition;
    data['transferEncoding'] = transferEncoding;
    data['related'] = related;
    data['size'] = size;
    data['downloadUrl'] = downloadUrl;
    return data;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;

  Book(
      {this.kind,
      this.id,
      this.etag,
      this.selfLink,
      this.volumeInfo,
      this.saleInfo,
      this.accessInfo});

  Book.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
    etag = json['etag'];
    selfLink = json['selfLink'];
    volumeInfo = json['volumeInfo'] != null
        ? VolumeInfo.fromJson(json['volumeInfo'])
        : null;
    accessInfo = json['accessInfo'] != null
        ? AccessInfo.fromJson(json['accessInfo'])
        : null;
    saleInfo =
        json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['id'] = id;
    data['etag'] = etag;
    data['selfLink'] = selfLink;
    data['volumeInfo'] = volumeInfo?.toJson(); // VolumeInfo'yu dönüştür
    data['accessInfo'] = accessInfo?.toJson(); // AccessInfo'yu dönüştür
    return data;
  }

  static void uploadPaidBooks(Book book) async {
    try {
      // ImageLinks'i Map'e dönüştür
      Map<String, dynamic>? imageLinksData;
      if (book.volumeInfo?.imageLinks != null) {
        imageLinksData = book.volumeInfo!.imageLinks!.toJson();
      }

      // AccessInfo'yu Map'e dönüştür
      Map<String, dynamic>? accessInfoData;
      if (book.accessInfo != null) {
        accessInfoData = book.accessInfo!.toJson();
      }

      Map<String, dynamic>? saleInfoData;
      if (book.saleInfo != null) {
        saleInfoData = book.saleInfo!.toJson();
      }

      if (imageLinksData != null) {
        await FirebaseFirestore.instance
            .collection('paid_books')
            .doc('${book.id}')
            .set(
          {
            'title': book.volumeInfo!.title,
            'authors': book.volumeInfo!.authors,
            'published_date': book.volumeInfo!.publishedDate,
            'publisher': book.volumeInfo!.publisher,
            'desc': book.volumeInfo!.description,
            'page_count': book.volumeInfo!.pageCount,
            'image_links': imageLinksData, // ImageLinks Map olarak ekleniyor
            'language': book.volumeInfo!.language,
            'preview_links': book.volumeInfo!.previewLink,
            'info_links': book.volumeInfo!.infoLink,
            'access_info': accessInfoData, // AccessInfo Map olarak ekleniyor
            'sale_info': saleInfoData,
          },
        );
        print('Book added to Firebase successfully');
      }
    } catch (error) {
      print('Error adding book to Firebase: $error');
    }
  }

  static void uploadBookToFirebase(Book book, String subject) async {
    try {
      // ImageLinks'i Map'e dönüştür
      Map<String, dynamic>? imageLinksData;
      if (book.volumeInfo?.imageLinks != null) {
        imageLinksData = book.volumeInfo!.imageLinks!.toJson();
      }

      // AccessInfo'yu Map'e dönüştür
      Map<String, dynamic>? accessInfoData;
      if (book.accessInfo != null) {
        accessInfoData = book.accessInfo!.toJson();
      }

      if (imageLinksData != null) {
        await FirebaseFirestore.instance
            .collection('books')
            .doc('${book.id}')
            .set(
          {
            'title': book.volumeInfo!.title,
            'authors': book.volumeInfo!.authors,
            'published_date': book.volumeInfo!.publishedDate,
            'publisher': book.volumeInfo!.publisher,
            'desc': book.volumeInfo!.description,
            'page_count': book.volumeInfo!.pageCount,
            'image_links': imageLinksData, // ImageLinks Map olarak ekleniyor
            'language': book.volumeInfo!.language,
            'preview_links': book.volumeInfo!.previewLink,
            'info_links': book.volumeInfo!.infoLink,
            'access_info': accessInfoData, // AccessInfo Map olarak ekleniyor
          },
        );
        print('Book added to Firebase successfully');
      }
    } catch (error) {
      print('Error adding book to Firebase: $error');
    }
  }

  static void uploadFavoriteToFirebase(Book book) async {
    try {
      // ImageLinks'i Map'e dönüştür
      Map<String, dynamic>? imageLinksData;
      if (book.volumeInfo?.imageLinks != null) {
        imageLinksData = book.volumeInfo!.imageLinks!.toJson();
      }

      // AccessInfo'yu Map'e dönüştür
      Map<String, dynamic>? accessInfoData;
      if (book.accessInfo != null) {
        accessInfoData = book.accessInfo!.toJson();
      }

      if (imageLinksData != null) {
        await FirebaseFirestore.instance
            .collection('favorite_books')
            .doc('${book.id}')
            .set(
          {
            'title': book.volumeInfo!.title,
            'authors': book.volumeInfo!.authors,
            'published_date': book.volumeInfo!.publishedDate,
            'publisher': book.volumeInfo!.publisher,
            'desc': book.volumeInfo!.description,
            'page_count': book.volumeInfo!.pageCount,
            'image_links': imageLinksData, // ImageLinks Map olarak ekleniyor
            'language': book.volumeInfo!.language,
            'preview_links': book.volumeInfo!.previewLink,
            'info_links': book.volumeInfo!.infoLink,
            'access_info': accessInfoData, // AccessInfo Map olarak ekleniyor
          },
        );
        print('Book added to Firebase successfully');
      }
    } catch (error) {
      print('Error adding book to Firebase: $error');
    }
  }
}

class VolumeInfo {
  String? title;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  int? pageCount;
  ImageLinks? imageLinks;
  String? language;
  String? previewLink;
  String? infoLink;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
  });

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authors = (json['authors'] != null) ? json['authors'].cast<String>() : [];
    publisher = json['publisher'];
    publishedDate = json['publishedDate'];
    description = json['description'] ?? 'No descrpition';

    pageCount = json['pageCount'];

    imageLinks = json['imageLinks'] != null
        ? ImageLinks.fromJson(json['imageLinks'])
        : null;
    language = json['language'];
    previewLink = json['previewLink'];
    infoLink = json['infoLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['authors'] = authors;
    data['publisher'] = publisher;
    data['publishedDate'] = publishedDate;
    data['description'] = description;
    data['pageCount'] = pageCount;

    if (imageLinks != null) {
      data['imageLinks'] = imageLinks!.toJson();
    }
    data['language'] = language;
    data['previewLink'] = previewLink;
    data['infoLink'] = infoLink;

    return data;
  }
}

class SaleInfo {
  ListPrice? listPrice;
  String? buyLink;

  SaleInfo({
    this.listPrice,
    this.buyLink,
  });

  SaleInfo.fromJson(Map<String, dynamic> json) {
    listPrice = json['listPrice'] != null
        ? ListPrice.fromJson(json['listPrice'])
        : null;

    buyLink = json['buyLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (listPrice != null) {
      data['listPrice'] = listPrice!.toJson();
    }
    data['buyLink'] = buyLink;
    return data;
  }
}

class ListPrice {
  double? amount;
  String? currencyCode;

  ListPrice({this.amount, this.currencyCode});

  ListPrice.fromJson(Map<String, dynamic> json) {
    amount =
        (json['amount'] is int) ? json['amount'].toDouble() : json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currencyCode'] = currencyCode;
    return data;
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['smallThumbnail'] = smallThumbnail;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class AccessInfo {
  Epub? epub;
  Epub? pdf;
  String? webReaderLink;

  AccessInfo({
    this.epub,
    this.pdf,
    this.webReaderLink,
  });

  AccessInfo.fromJson(Map<String, dynamic> json) {
    epub = json['epub'] != null ? Epub.fromJson(json['epub']) : null;
    pdf = json['pdf'] != null ? Epub.fromJson(json['pdf']) : null;
    webReaderLink = json['webReaderLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (epub != null) {
      data['epub'] = epub!.toJson();
    }
    if (pdf != null) {
      data['pdf'] = pdf!.toJson();
    }
    data['webReaderLink'] = webReaderLink;

    return data;
  }
}

class Epub {
  bool? isAvailable;

  Epub({this.isAvailable});

  Epub.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAvailable'] = isAvailable;
    return data;
  }
}

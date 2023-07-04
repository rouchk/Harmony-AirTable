//
//  NewsPostModel.swift
//  Harmony
//
//  Created by apprenant44 on 27/06/2023.
//

import Foundation

class Post:ObservableObject {
    @Published var newsmodel: [News] = [

       News(title: "Fête de la musique - danse hawaïenne à Lille", photo: "hawaiianDance", author: userTom, content: "L’association des Hawaïens Hauts-de-France a organise une soirée danse hawaïenne Grand’Place de Lille à l’occasion de la 40e anniversaire de la Fête de la musique.", publishDate: Date(), like: 1, comments:  [
        PostComment(user: userAdeline, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965), comlikes: 23),
        PostComment(user: userYuko, content: "@Sonia Si tu arrives à la Part-Dieu, prends le métro B jusqu'à Saxe Gambetta, puis métro D jusqu'à Bellecour. C'est à 2 minutes de la station.", date: Date(timeIntervalSince1970: 1687408200), comlikes: 2),
        PostComment(user: userKelian, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600), comlikes: 32),
        PostComment(user: userMarie, content: "Super !", date: Date(timeIntervalSince1970: 1687522965), comlikes: 1),
        PostComment(user: userJohan, content: "@Sonia C'est super la pluie.", date: Date(timeIntervalSince1970: 1687408200), comlikes: 106),
        PostComment(user: userMax, content: "🌧️", date: Date(timeIntervalSince1970: 1687368600), comlikes: 87)], community: culturehawaienne, commentLikes: [53,29,140,8]),
//------------------------------------------------------------- personne ----------------------------------------------------
       
       News(title: "Le Blind-Tasting c'est Bien passé!!!!", photo: "temple", author: userMarie, content: "Le Blind-Tasting organisé par la communauté japonaise c'est Bien passé! Nous avons eu des bons retours.", publishDate: Date(), like: 1, comments: [
        PostComment(user: userKelian, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965), comlikes: 123),
        PostComment(user: userYuko, content: "@Sonia Si tu arrives à la Part-Dieu, prends le métro B jusqu'à Saxe Gambetta, puis métro D jusqu'à Bellecour. C'est à 2 minutes de la station.", date: Date(timeIntervalSince1970: 1687408200), comlikes: 19),
        PostComment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600), comlikes: 44),
        PostComment(user: userMarie, content: "Super !", date: Date(timeIntervalSince1970: 1687522965), comlikes: 1),
        PostComment(user: userYuko, content: "@Sonia C'est super la pluie.", date: Date(timeIntervalSince1970: 1687408200), comlikes: 106),
        PostComment(user: userSonia, content: "🌧️", date: Date(timeIntervalSince1970: 1687368600), comlikes: 87)], community: culturejaponaise, commentLikes: [53,29,140,8]),
//------------------------------------------------------------- personne ----------------------------------------------------
       
       News(title: "Photo de la rencontre à  coté de la tour Eiffel !!!!", photo: "France", author: userJohan, content: "Photo prise par notre photogrphe Yuku de la fameuse tour parisienne à l'occasion de notre pique nique au bord de la seine", publishDate: Date(), like: 1, comments: [
        PostComment(user: userMarie, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965), comlikes: 32),
        PostComment(user: userYuko, content: "@Sonia Si tu arrives à la Part-Dieu, prends le métro B jusqu'à Saxe Gambetta, puis métro D jusqu'à Bellecour. C'est à 2 minutes de la station.", date: Date(timeIntervalSince1970: 1687408200), comlikes: 5),
        PostComment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600), comlikes: 98)], community: culturefrancaises, commentLikes: [53,29,140,8]),
//------------------------------------------------------------- personne ----------------------------------------------------
              
       News(title: "Petite journée de pluie dans le nord", photo: "Normandie1", author: userTom, content: "Après plusieurs journées sans la fameuse pluie elle est arrivée dans notre petit coin, venez profiter et boire un chocolat chaud.", publishDate: Date(), like: 1, comments: [
        PostComment(user: userMarie, content: "Super !", date: Date(timeIntervalSince1970: 1687522965), comlikes: 1),
        PostComment(user: userYuko, content: "@Sonia C'est super la pluie.", date: Date(timeIntervalSince1970: 1687408200), comlikes: 106),
        PostComment(user: userSonia, content: "🌧️", date: Date(timeIntervalSince1970: 1687368600), comlikes: 87)], community: culturenormande, commentLikes: [53,29,140,8])
       
     ]
}

var exemplePost = News(title: "Fête de la musique - danse hawaïenne à Lille", photo: "MyPhoto", author: userTom, content: "L’association des Hawaïens Hauts-de-France organise une soirée danse hawaïenne Grand’Place de Lille à l’occasion de la 40e anniversaire de la Fête de la musique.", publishDate: Date(), like: 0, comments: [
    PostComment(user: userTom, content: "J'ai hâte", date: Date(timeIntervalSince1970: 1687522965), comlikes: 13),
    PostComment(user: userYuko, content: "@Sonia Prochaine fois on ira ensemble, c'est un évenement à ne pas rater 👍🏼", date: Date(timeIntervalSince1970: 1687408200), comlikes: 98),
    PostComment(user: userSonia, content: "J'aurais trop aimé avoir participé, mais je ne voulais pas aller seule 😿", date: Date(timeIntervalSince1970: 1687368600), comlikes: 33),
    PostComment(user: userMax, content: "J'ai adoré cette événement, j'ai hâte pour le prochain. Continuez Comme ça!", date: Date(timeIntervalSince1970: 1687522965), comlikes: 7),
    PostComment(user: userJohan, content: "@Sonia Prochaine fois on ira ensemble, c'est un évenement à ne pas rater 👍🏼", date: Date(timeIntervalSince1970: 1687408200), comlikes: 4)], community: culturejaponaise, commentLikes: [53,29,140,8])


//class NumberOfLikes:ObservableObject{
//    @Published var numberOfLikes: [Int] = []
//}

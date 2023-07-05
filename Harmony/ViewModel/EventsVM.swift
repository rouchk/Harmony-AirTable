//
//  EventsViewModel.swift
//  Harmony
//
//  Created by apprenant71 on 23/06/2023.
//

import Foundation

class EventsViewModel: ObservableObject {
    
    @Published var eventsList: [Event] = [
        
        Event(
            title: "Saké blind tasting",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1689424200),
            address: Address(city: "Lyon 2e", address: "23 rue Victor Hugo", namePlace: "Espace Culture Japon"),
            listParticipant: [userTom, userThomas, userSonia, userMax, userYuko, userAdeline, userKelian, userSonia, userThomas, userMarie],
            detail: "Aimez-vous le saké ? Venez tester vos connaissances avec la dégustation aveugle en équipe.",
            minParticipants: 8,
            photo: "sake",
            team: [userTom, userMarie, userYuko],
            comments: [
                Comment(user: userTom, content: "J'adore les dégustations à l'aveugle ! Cet événement de blind tasting japonais semble passionnant. J'ai hâte de découvrir de nouveaux arômes et de tester mes papilles. #BlindTasting #SaveursJaponaises", date: Date(timeIntervalSince1970: 1687522965)),
                Comment(user: userYuko, content: "Si tu arrives à la Part-Dieu, prends le métro B jusqu'à Saxe Gambetta, puis métro D jusqu'à Bellecour. C'est à 2 minutes de la station.", date: Date(timeIntervalSince1970: 1687408200)),
                Comment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600)),
                Comment(user: userKelian, content: "Quelle chance d'avoir l'opportunité de participer à un événement de blind tasting japonais ! J'ai hâte de tester ma capacité à identifier les caractéristiques uniques des sakés, whiskies et autres boissons japonaises.", date: Date(timeIntervalSince1970: 1687120417)),
                Comment(user: userMarie, content: "En tant qu'amateur de la culture japonaise, je ne peux pas manquer cet événement de blind tasting.", date: Date(timeIntervalSince1970: 1686192007))],
            community: culturejaponaise
        ),
        
        Event(
            title: "Quiz Culture générale du Japon",
            isOnline: true,
            date: Date(timeIntervalSince1970: 1688722200),
            address: nil,
            listParticipant: [userAlexandre, userMarie, userTom, userThomas, userSonia, userMax, userAdeline, userKelian],
            detail: "Testez vos connaissances sur l'Histoire du Japon !",
            minParticipants: 12,
            photo: "temple",
            team: [userMarie],
            comments: [Comment(user: userAlexandre, content: "Je suis totalement d'accord ! J'adore la culture japonaise, c'est tellement riche et fascinant. Prêt à relever le défi !", date: Date(timeIntervalSince1970: 1687522965)),
                       Comment(user: userTom, content: "Wow, ce quiz sur la culture japonaise semble intéressant ! Je suis prêt à tester mes connaissances et à en apprendre davantage.", date: Date(timeIntervalSince1970: 1687516807)),
                      Comment(user: userThomas, content: "Je suis un grand fan de manga et d'anime japonais, mais je veux voir si mes connaissances vont au-delà de ces domaines. Prêt à découvrir ce quiz !", date: Date(timeIntervalSince1970: 1687426807))],
            community: culturejaponaise
        ),
        
        Event(
            title: "Initiation Calligraphie",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1686846600),
            address: Address(city: "Lyon 2e", address: "23 rue Victor Hugo", namePlace: "Espace Culture Japon"),
            listParticipant: [userJeanChristophe, userMarie, userThomas, userMax, userYuko, userAdeline, userKelian],
            detail: "Explorez la calligraphie japonaise et laissez votre créativité s'exprimer à travers des tracés précis et élégants, dans l'art ancestral de la beauté des mots.",
            minParticipants: 8,
            photo: "MyPhoto",
            team: [userTom, userYuko, userMarie],
            comments: [Comment(user: userTom, content: "Hâte de participer à cette initiation à la calligraphie japonaise ! J'ai déjà préparé mon carnet et mes pinceaux, prêt à laisser ma créativité s'exprimer ! ", date: Date(timeIntervalSince1970: 1687522965)),
                       Comment(user: userSonia, content: "Je suis tellement excitée à l'idée de participer à cette initiation à la calligraphie japonaise ! J'ai déjà commencé à pratiquer quelques techniques de base et j'ai hâte de les perfectionner lors de cet événement. Vivement la semaine prochaine !", date: Date(timeIntervalSince1970: 1687368600))],
            community: culturejaponaise
        ),
        
        Event(
            title: "Initiation Pétanque",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1689424200),
            address: Address(city: "Lyon 6e", address: "Place Maréchal Lyautey", namePlace: "Espace Pétanque de Lyon"),
            listParticipant: [userTom, userAlexandre, userSonia, userMax, userYuko, userAdeline, userKelian, userSonia, userThomas],
            detail: "Découvrez le plaisir de la pétanque en équipe. Rejoignez-nous pour une expérience conviviale et compétitive en lançant les boules de précision.",
            minParticipants: 8,
            photo: "petanque",
            team: [userTom, userYuko, userMarie],
            comments: [
                Comment(user: userTom, content: "Je suis excité de participer à l'événement d'initiation à la pétanque ! Une opportunité de découvrir ce sport, passer du bon temps en plein air et rencontrer de nouvelles personnes.", date: Date(timeIntervalSince1970: 1687522965)),
            Comment(user: userSonia, content: "J'attends avec impatience cet événement d'initiation à la pétanque ! Une occasion de s'amuser en famille ou entre amis, apprendre les règles et profiter du beau temps en jouant aux boules.", date: Date(timeIntervalSince1970: 1687521965))],
            community: culturefrancaises
        ),
        
        Event(
            title: "Rallye urbain Marseille",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1688722200),
            address: Address(city: "Marseille 1er", address: "11 La Canebière", namePlace: "Office de Tourisme de Marseille"),
            listParticipant: [userTom, userThomas, userMax, userYuko, userSonia, userAdeline, userKelian, userJohan, userElodie],
            detail: "Parcourez les rues pittoresques de Marseille, où vous allez résoudre des énigmes et relever des défis en équipe pour découvrir les joyaux cachés de la ville.",
            minParticipants: 8,
            photo: "marseille",
            team: [userTom, userYuko, userMarie],
            comments: [Comment(user: userJohan, content: "Le rallye urbain à Marseille promet une journée d'aventure captivante à travers la ville. Je suis impatient de résoudre des énigmes et de découvrir ses trésors cachés en équipe.", date: Date(timeIntervalSince1970: 1687522965)),
                       Comment(user: userSonia, content: "C'est une façon amusante et interactive de visiter la ville. Je suis excité de relever des défis tout en explorant les quartiers emblématiques et en apprenant son histoire.", date: Date(timeIntervalSince1970: 1687368600)),
                      Comment(user: userAdeline, content: "Je suis enthousiasmé par la perspective de parcourir la ville, de résoudre des énigmes et de profiter de vues magnifiques en équipe", date: Date(timeIntervalSince1970: 1687368400))],
            community: culturefrancaises
        ),
        
        Event(
            title: "Rallye gourmand Lille",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1688900400),
            address: Address(city: "Lille", address: "place du Général de Gaulle", namePlace: "Rendez-vous à Grand'Place"),
            listParticipant: [userTom, userJohan, userMax, userYuko, userAdeline, userKelian],
            detail: "Découverez les spécialités lilloises en parcourant en équipe 5 spots gourmands séléctionnés par les hôtes de la communauté. La consommation à charge de chacun sur place. Réservé aux personnes plus de 18 ans.",
            minParticipants: 4,
            photo: "beer",
            team: [userMax, userAdeline, userMarie],
            comments: [Comment(user: userMax, content: "Je suis impatient de découvrir les spécialités culinaires de Lille. Une expérience savoureuse et conviviale en perspective !", date: Date(timeIntervalSince1970: 1687522965)),
                       Comment(user: userYuko, content: "Je suis tellement gourmande que je viens de Lyon spécialement pour ça.", date: Date(timeIntervalSince1970: 1687368600))],
            community: culturefrancaises
        ),
        
        Event(
            title: "Danse hawaïenne",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1689424200),
            address: Address(city: "Lille", address: "Pl. du Général de Gaulle", namePlace: "Grand'Place"),
            listParticipant: [userAlexandre, userJeanChristophe, userMarie, userTom, userThomas, userSonia, userMax, userYuko, userAdeline, userKelian, userSonia, userThomas],
            detail: "L’association des Hawaïens Hauts-de-France organise une soirée danse hawaïenne Grand’Place de Lille à l’occasion de la 40e anniversaire de la Fête de la musique. Rendez-vous sur la Place pour découvrir la culture hawaïenne et passer un moment convivial.",
            minParticipants: 8,
            photo: "hawaiianDance",
            team: [userAlexandre, userKelian, userMarie],
            comments: [
                Comment(user: userTom, content: "Absolument ! La danse hawaïenne est une danse très participative, et je suis sûr que les organisateurs ont prévu des ateliers pour que tout le monde puisse apprendre et s'amuser. C'est une excellente occasion de découvrir cette forme d'expression culturelle.", date: Date(timeIntervalSince1970: 1687522965)),
                Comment(user: userSonia, content: "J'espère qu'il y aura aussi des ateliers de danse où nous pourrons apprendre les mouvements et les chorégraphies du hula. Ce serait tellement amusant de participer activement à cet événement et d'apprendre des danseurs experts", date: Date(timeIntervalSince1970: 1687368600))],
            community: culturehawaienne
        ),
        
        Event(
            title: "Jeu de piste sur les Traces du film",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1689424200),
            address: Address(city: "Cherbourg-en-Cotentin", address: "Bd Félix Amiot", namePlace: "Cinéma CGR Cherbourg"),
            listParticipant: [userJohan, userTom, userMax, userYuko, userAdeline, userKelian, userSonia, userElodie],
            detail: "Participez au jeu de piste captivant sur les traces du film, Les Parapluies de Cherbourg. Parcourez les rues pittoresques de Cherbourg à la recherche d'indices pour résoudre des énigmes inspirées de cette histoire d'amour légendaire.",
            minParticipants: 8,
            photo: "umbrellas",
            team: [userTom, userYuko, userMarie],
            comments: [
                Comment(user: userTom, content: "Impatient de suivre les indices et de revivre les moments marquants de ce film dans une expérience ludique et immersive.", date: Date(timeIntervalSince1970: 1687522965))],
            community: culturenormande
        ),
        
        Event(
            title: "Atelier Fabrication du camembert",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1686407400),
            address: Address(city: "Camembert", address: "61 Le Bourg", namePlace: "Musée du Camembert"),
            listParticipant: [userMarie, userThomas, userSonia, userMax, userYuko, userAdeline, userKelian, userAlexandre],
            detail: "Apprenez des étapes de fabrication et réalisez votre propre camembert avec Clément, artisan fromager.",
            minParticipants: 12,
            photo: "camenbert",
            team: [userAlexandre, userMarie, userElodie],
            comments: [
                Comment(user: userTom, content: "C'est une occasion unique d'apprendre les secrets de la création de ce fromage emblématique. J'ai hâte de participer et de découvrir le processus de fabrication tout en savourant le délicieux résultat final !", date: Date(timeIntervalSince1970: 1687522965)),
            Comment(user: userYuko, content: "Je suis ravie de pouvoir participer à l'atelier de fabrication du camembert. Apprendre à créer ce fromage traditionnel dans une ambiance conviviale sera une expérience enrichissante et gourmande.", date: Date(timeIntervalSince1970: 1687521965))],
            community: culturenormande
        ),
        
        Event(
            title: "Concours du meilleur poké bowl",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1690540200),
            address: Address(city: "Marseille 6e", address: "9 Place Félix Baret", namePlace: "Lanikai Poké"),
            listParticipant: [userMarie, userThomas, userSonia, userMax, userYuko, userAdeline, userKelian, userAlexandre, userTom, userJohan, userElodie, userHildegarde, userJeanChristophe],
            detail: "Participez au concours du meilleur poké bowl de Marseille et montrez votre talent culinaire ! Mêlez fraîcheur et créativité pour créer des saveurs uniques avec les délices de la mer du célèbre marché de poisson.",
            minParticipants: 20,
            photo: "pokeBowl",
            team: [userAlexandre, userMarie, userHildegarde],
            comments: [
                Comment(user: userTom, content: "Je suis tellement impatient de participer au concours du meilleur poké bowl à Marseille ! J'ai hâte de montrer ma créativité culinaire.", date: Date(timeIntervalSince1970: 1687522965)),
            Comment(user: userYuko, content: "Je suis enthousiaste à l'idée de faire mes emplettes sur place et de créer un bol plein de saveurs marines", date: Date(timeIntervalSince1970: 1687521965))],
            community: culturehawaienne
        ),
        
        Event(
            title: "Fabrication de Lei hawaïen",
            isOnline: false,
            date: Date(timeIntervalSince1970: 1690275600),
            address: Address(city: "Nice", address: "Cours Saleya", namePlace: "Marché aux fleurs"),
            listParticipant: [userAlexandre, userKelian, userMarie, userThomas, userSonia, userMax, userYuko, userAdeline ],
            detail: "Apprenez à fabriquer les célèbres collies de fleurs typique de l'île d'Hawaï. Laissez-vous transporter par l'esprit tropical et ajoutez une touche d'exotisme à votre été.",
            minParticipants: 8,
            photo: "lei",
            team: [userKelian, userAlexandre, userMarie],
            comments: [
                Comment(user: userAlexandre, content: "Je suis tellement excité ! Apprendre à confectionner ces magnifiques colliers de fleurs va ajouter une touche exotique à ma journée.", date: Date(timeIntervalSince1970: 1687522965)),
            Comment(user: userKelian, content: "Je suis prêt à me plonger dans l'art traditionnel de la création de ces ornements floraux colorés et parfumés.", date: Date(timeIntervalSince1970: 1687521964))],
            community: culturehawaienne
        )
    ]
        
    
}


//var eventMarie = Event(
//    title: "Quiz Culture générale du Japon",
//    isOnline: true,
//    date: Date(timeIntervalSince1970: 1688722200),
//    address: nil,
//    listParticipant: [userAlexandre, userMarie, userTom, userThomas, userSonia, userMax, userAdeline, userKelian],
//    detail: "Testez vos connaissances sur l'Histoire du Japon !",
//    minParticipants: 12,
//    photo: "temple",
//    team: [userMarie],
//    comments: [Comment(user: userTom, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965))],
//    community: culturejaponaise
//)


// -------- Ci-dessous, à supprimer après avoir mis en place les filtres sur EventView
//var myEventsList: [Event] = [eventExemple, eventExampleOnline, eventExamplePast, eventExampleNonRegistered]
//// ---> Ajouter une func pour faire un Array with MY events
//
//var eventExemple = Event(
//    title: "Saké blind tasting",
//    isOnline: false,
//    date: Date(timeIntervalSince1970: 1689424200),
//    address: Address(city: "Lyon 2e", address: "23 rue Victor Hugo", namePlace: "Espace Culture Japon"),
//    listParticipant: [userTom, userThomas, userSonia, userMax, userYuko, userAdeline, userKelian, userSonia, userThomas, userMarie],
//    detail: "Aimez-vous le saké ? Venez tester vos connaissances avec la dégustation aveugle en équipe.",
//    minParticipants: 8,
//    photo: "sake",
//    team: [userTom, userMarie, userYuko],
//    comments: Comments(comments:[
//        Comment(user: userTom, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965)),
//        Comment(user: userYuko, content: "@Sonia Si tu arrives à la Part-Dieu, prends le métro B jusqu'à Saxe Gambetta, puis métro D jusqu'à Bellecour. C'est à 2 minutes de la station.", date: Date(timeIntervalSince1970: 1687408200)),
//        Comment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600))]),
//    community: culturejaponaise
//)
//
//var eventExampleOnline = Event(
//    title: "Quiz Culture générale du Japon",
//    isOnline: true,
//    date: Date(timeIntervalSince1970: 1688722200),
//    address: nil,
//    listParticipant: [userTom, userThomas, userSonia, userMax, userAdeline, userKelian, userMarie],
//    detail: "Testez vos connaissances sur l'Histoire du Japon !",
//    minParticipants: 12,
//    photo: "temple",
//    team: [userMarie],
//    comments: Comments(comments:[Comment(user: userTom, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965))]),
//    community: culturejaponaise
//)
//
//var eventExamplePast = Event(
//    title: "Initiation Calligraphie",
//    isOnline: false,
//    date: Date(timeIntervalSince1970: 1686846600),
//    address: Address(city: "Lyon 2e", address: "23 rue Victor Hugo", namePlace: "Espace Culture Japon"),
//    listParticipant: [userTom, userThomas, userMax, userYuko, userAdeline, userKelian, userMarie],
//    detail: "Explorez la calligraphie japonaise et laissez votre créativité s'exprimer à travers des tracés précis et élégants, dans l'art ancestral de la beauté des mots.",
//    minParticipants: 8,
//    photo: "japon",
//    team: [userTom, userYuko, userMarie],
//    comments: Comments(comments:[
//        Comment(user: userTom, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965)),
//        Comment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600))]),
//    community: culturejaponaise
//)

var eventExampleNonRegistered: Event = Event(
    title: "Initiation Calligraphie",
    isOnline: false,
    date: Date(timeIntervalSince1970: 1688722200),
    address: Address(city: "Lyon 2e", address: "23 rue Victor Hugo", namePlace: "Espace Culture Japon"),
    listParticipant: [userJeanChristophe, userThomas, userMax, userYuko, userAdeline, userKelian],
    detail: "Explorez la calligraphie japonaise et laissez votre créativité s'exprimer à travers des tracés précis et élégants, dans l'art ancestral de la beauté des mots.",
    minParticipants: 8,
    photo: "japon",
    team: [userTom, userYuko],
    comments: [
        Comment(user: userMax, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965)),
        Comment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600))],
    community: culturejaponaise
)

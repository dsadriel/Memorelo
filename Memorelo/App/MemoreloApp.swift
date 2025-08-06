//
//  MemoreloApp.swift
//  Memorelo
//
//  Created by Adriel de Souza on 05/08/25.
//

import SwiftUI
import SwiftData

@main
struct MemoreloApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(sharedModelContainer)
    }

    static let activitySuggestions: [ActivitySuggestion] = [
        .init(title: "Piquenique no parque",
              description: "Levem alguns lanches, brinquedos e uma toalha para curtir um momento juntos ao ar livre.",
              goal: "Fortalecer vínculos familiares e estimular o contato com a natureza.",
              durationInMinutes: 90,
              suggestedAgeInMonths: 12..<72),

        .init(title: "Hora do desenho em família",
              description: "Todos desenham o que quiserem e depois compartilham suas criações.",
              goal: "Estimular a expressão criativa e promover conversas leves.",
              durationInMinutes: 30,
              suggestedAgeInMonths: 24..<96),

        .init(title: "Fazer massinha caseira",
              description: "Produzam juntos massinha com farinha, sal e corante alimentício.",
              goal: "Desenvolver coordenação motora e criar oportunidades de aprendizado sensorial.",
              durationInMinutes: 40,
              suggestedAgeInMonths: 24..<72),

        .init(title: "Construção com blocos",
              description: "Criem juntos uma cidade ou castelo com blocos de montar.",
              goal: "Trabalhar colaboração, criatividade e habilidades espaciais.",
              durationInMinutes: 45,
              suggestedAgeInMonths: 36..<84),

        .init(title: "Contação de histórias",
              description: "Leiam ou inventem uma história juntos, com vozes e encenações.",
              goal: "Desenvolver imaginação e habilidades linguísticas.",
              durationInMinutes: 20,
              suggestedAgeInMonths: 24..<96),

        .init(title: "Mini cinema em casa",
              description: "Assistam um filme infantil com pipoca em um ambiente aconchegante.",
              goal: "Oferecer tempo de qualidade juntos e estimular conversas sobre o filme.",
              durationInMinutes: 60,
              suggestedAgeInMonths: 36..<120),

        .init(title: "Oficina de culinária",
              description: "Preparem juntos receitas simples como biscoitos ou pão de queijo.",
              goal: "Ensinar habilidades práticas e promover cooperação.",
              durationInMinutes: 50,
              suggestedAgeInMonths: 48..<120),

        .init(title: "Caça ao tesouro em casa",
              description: "Esconda objetos e dê pistas simples para a criança encontrar.",
              goal: "Estimular o raciocínio lógico e o espírito investigativo.",
              durationInMinutes: 30,
              suggestedAgeInMonths: 36..<96),

        .init(title: "Plantando juntos",
              description: "Plantem uma muda ou sementes em um vaso.",
              goal: "Ensinar paciência, cuidado com o ambiente e responsabilidade.",
              durationInMinutes: 35,
              suggestedAgeInMonths: 36..<108),

        .init(title: "Dança maluca",
              description: "Coloquem músicas divertidas e dancem livremente pela sala.",
              goal: "Gastar energia e se divertir sem regras.",
              durationInMinutes: 15,
              suggestedAgeInMonths: 24..<84),

        .init(title: "Dia de fantasia",
              description: "Vistam fantasias ou roupas criativas e inventem personagens.",
              goal: "Promover o faz-de-conta e a expressão emocional.",
              durationInMinutes: 40,
              suggestedAgeInMonths: 36..<96),

        .init(title: "Cuidando dos brinquedos",
              description: "Hora de limpar e organizar os brinquedos juntos.",
              goal: "Ensinar responsabilidade e autocuidado com os pertences.",
              durationInMinutes: 25,
              suggestedAgeInMonths: 36..<84),

        .init(title: "Desfile de moda",
              description: "Montem looks com roupas de casa e desfilem como em uma passarela.",
              goal: "Explorar a criatividade e aumentar a autoestima.",
              durationInMinutes: 30,
              suggestedAgeInMonths: 48..<108),

        .init(title: "Jogo de mímica",
              description: "Brinquem de adivinhar palavras ou animais através de gestos.",
              goal: "Estimular a expressão corporal e a comunicação não verbal.",
              durationInMinutes: 20,
              suggestedAgeInMonths: 60..<120),

        .init(title: "Criando um brinquedo reciclado",
              description: "Utilizem caixas, garrafas e rolos de papel para criar brinquedos.",
              goal: "Incentivar sustentabilidade e imaginação.",
              durationInMinutes: 45,
              suggestedAgeInMonths: 48..<120),

        .init(title: "Tarde de boardgames",
              description: "Joguem jogos de tabuleiro simples como dominó ou memória.",
              goal: "Ensinar regras, paciência e cooperação.",
              durationInMinutes: 50,
              suggestedAgeInMonths: 48..<120),

        .init(title: "Caminhada exploratória",
              description: "Passeiem juntos pelo bairro observando animais, árvores e sons.",
              goal: "Aumentar a curiosidade e conexão com o ambiente.",
              durationInMinutes: 30,
              suggestedAgeInMonths: 24..<96),

        .init(title: "Desenhando a família",
              description: "Peça para desenharem cada membro da família com suas características.",
              goal: "Fortalecer vínculos familiares e reconhecimento emocional.",
              durationInMinutes: 25,
              suggestedAgeInMonths: 36..<108),

        .init(title: "Jogo do sim e não",
              description: "Jogam tentando fazer o outro dizer 'sim' ou 'não' sem querer.",
              goal: "Estimular atenção, lógica e diversão verbal.",
              durationInMinutes: 20,
              suggestedAgeInMonths: 72..<120),

        .init(title: "Roda de gratidão",
              description: "Cada um fala algo pelo qual é grato naquele dia.",
              goal: "Fomentar empatia, reconhecimento e presença no momento.",
              durationInMinutes: 15,
              suggestedAgeInMonths: 48..<120)
    ]

}

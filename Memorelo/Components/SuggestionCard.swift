//
//  SuggestionCard.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct SuggestionCard: View {
    var color: ColorfulStyle
    var title: String
    var description: String
    var objetive: String
    var duration: Int

    var durationText: String {
        if duration > 60 {
            return "\(duration / 60)h\(duration%60)min"
        } else {
            return "\(duration%60)min"
        }
    }

    init(color: ColorfulStyle, title: String, description: String, objetive: String, duration: Int) {
        self.color = color
        self.title = title
        self.description = description
        self.objetive = objetive
        self.duration = duration
    }

    init(title: String, description: String, objetive: String, duration: Int) {
        self.color = ColorfulStyle.allCases.randomElement() ?? .blue
        self.title = title
        self.description = description
        self.objetive = objetive
        self.duration = duration
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(.title3, weight: .semibold))
                    .foregroundStyle(color.solidColor)

                Text(description)
                    .font(.body)
                    .foregroundStyle(Color.SystemColors.labelsPrimary)

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            HStack(spacing: 4) {
                Text(objetive)
                    .font(.caption2)
                    .foregroundStyle(Color.SystemColors.labelsSecondary)

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text(durationText)
                }

                .font(.caption)
                .foregroundStyle(.labelsInverted)
                .padding(.all, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(color.solidColor)
                )
            }
        }
        .padding(12)
        .frame(width: 340, height: 153)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(color.translucentColor)
        )
    }
}

#Preview {
    ScrollView{
        VStack {
            SuggestionCard(color: .green,
                           title: "Piquenique no parque",
                           description: "Levem alguns lanches, brinquedos e uma toalha para curtir um momento juntos ao ar livre.",
                           objetive: "Fortalecer vínculos familiares e estimular o contato com a natureza.",
                           
                           duration: 90
            )
            SuggestionCard(
                title: "Hora do desenho em família",
                description: "Todos desenham o que quiserem e depois compartilham suas criações.",
                objetive: "Estimular a expressão criativa e promover conversas leves.",
                
                duration: 30
            )
            SuggestionCard(
                title: "Fazer massinha caseira",
                description: "Produzam juntos massinha com farinha, sal e corante alimentício.",
                objetive: "Desenvolver coordenação motora e criar oportunidades de aprendizado sensorial.",
                
                duration: 40
            )
            SuggestionCard(
                title: "Construção com blocos",
                description: "Criem juntos uma cidade ou castelo com blocos de montar.",
                objetive: "Trabalhar colaboração, criatividade e habilidades espaciais.",
                
                duration: 45
            )
            SuggestionCard(
                title: "Contação de histórias",
                description: "Leiam ou inventem uma história juntos, com vozes e encenações.",
                objetive: "Desenvolver imaginação e habilidades linguísticas.",
                
                duration: 20
            )
            SuggestionCard(
                title: "Mini cinema em casa",
                description: "Assistam um filme infantil com pipoca em um ambiente aconchegante.",
                objetive: "Oferecer tempo de qualidade juntos e estimular conversas sobre o filme.",
                
                duration: 60
            )
            SuggestionCard(
                title: "Oficina de culinária",
                description: "Preparem juntos receitas simples como biscoitos ou pão de queijo.",
                objetive: "Ensinar habilidades práticas e promover cooperação.",
                
                duration: 50
            )
            SuggestionCard(
                title: "Caça ao tesouro em casa",
                description: "Esconda objetos e dê pistas simples para a criança encontrar.",
                objetive: "Estimular o raciocínio lógico e o espírito investigativo.",
                
                duration: 30
            )
            SuggestionCard(
                title: "Plantando juntos",
                description: "Plantem uma muda ou sementes em um vaso.",
                objetive: "Ensinar paciência, cuidado com o ambiente e responsabilidade.",
                
                duration: 35
            )
            SuggestionCard(
                title: "Dança maluca",
                description: "Coloquem músicas divertidas e dancem livremente pela sala.",
                objetive: "Gastar energia e se divertir sem regras.",
                
                duration: 15
            )
            SuggestionCard(
                title: "Dia de fantasia",
                description: "Vistam fantasias ou roupas criativas e inventem personagens.",
                objetive: "Promover o faz-de-conta e a expressão emocional.",
                
                duration: 40
            )
            SuggestionCard(
                title: "Cuidando dos brinquedos",
                description: "Hora de limpar e organizar os brinquedos juntos.",
                objetive: "Ensinar responsabilidade e autocuidado com os pertences.",
                
                duration: 25
            )
            SuggestionCard(
                title: "Desfile de moda",
                description: "Montem looks com roupas de casa e desfilem como em uma passarela.",
                objetive: "Explorar a criatividade e aumentar a autoestima.",
                
                duration: 30
            )
            SuggestionCard(
                title: "Jogo de mímica",
                description: "Brinquem de adivinhar palavras ou animais através de gestos.",
                objetive: "Estimular a expressão corporal e a comunicação não verbal.",
                
                duration: 20
            )
            SuggestionCard(
                title: "Criando um brinquedo reciclado",
                description: "Utilizem caixas, garrafas e rolos de papel para criar brinquedos.",
                objetive: "Incentivar sustentabilidade e imaginação.",
                
                duration: 45
            )
            SuggestionCard(
                title: "Tarde de boardgames",
                description: "Joguem jogos de tabuleiro simples como dominó ou memória.",
                objetive: "Ensinar regras, paciência e cooperação.",
                
                duration: 50
            )
            SuggestionCard(
                title: "Caminhada exploratória",
                description: "Passeiem juntos pelo bairro observando animais, árvores e sons.",
                objetive: "Aumentar a curiosidade e conexão com o ambiente.",
                
                duration: 30
            )
            SuggestionCard(
                title: "Desenhando a família",
                description: "Peça para desenharem cada membro da família com suas características.",
                objetive: "Fortalecer vínculos familiares e reconhecimento emocional.",
                
                duration: 25
            )
            SuggestionCard(
                title: "Jogo do sim e não",
                description: "Jogam tentando fazer o outro dizer 'sim' ou 'não' sem querer.",
                objetive: "Estimular atenção, lógica e diversão verbal.",
                
                duration: 20
            )
            SuggestionCard(
                title: "Roda de gratidão",
                description: "Cada um fala algo pelo qual é grato naquele dia.",
                objetive: "Fomentar empatia, reconhecimento e presença no momento.",
                
                duration: 15
            )
        }
    }
}

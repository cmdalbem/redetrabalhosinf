# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tags = [
	"cpp", "linux", "windows", "java", "python", "ruby", "gtk", "qt", "cg", "mac", "ihc", "graph", "trees", 
	"estrutura de dados", "algorithm", "algoritmo", "otimizacao", "relatorio", "trabalho final",
	"svn", "git", "versionamento", "tcp", "engenharia de software", "uml", "eclipse", "visual studio", "microsoft",
	"banco de dados", "database", "image processing", "sql"
]

tags.size.times do |i|
	Tag.create(tag_text: tags[i])
end

names = [
	"ADMINISTRAÇÃO E FINANÇAS",
	"ÁLGEBRA LINEAR I - A",
	"ALGORITMOS AVANÇADOS",
	"ALGORÍTMOS E PROGRAMAÇÃO - CIC",
	"ARQUITETURA E DESEMPENHO DE BANCO DE DADOS",
	"ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES I",
	"ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES II",
	"ARQUITETURAS AVANÇADAS DE COMPUTADORES",
	"AVALIAÇÃO DE DESEMPENHO",
	"CAD PARA SISTEMAS DIGITAIS",
	"CÁLCULO E GEOMETRIA ANALÍTICA I - A",
	"CÁLCULO E GEOMETRIA ANALÍTICA II - A",
	"CÁLCULO NUMÉRICO A",
	"CATEGORIAS COMPUTACIONAIS N",
	"CIRCUITOS DIGITAIS",
	"CLASSIFICAÇÃO E PESQUISA DE DADOS",
	"COMPILADORES",
	"COMPLEXIDADE DE ALGORITMOS - B",
	"COMPUTAÇÃO E MÚSICA",
	"COMPUTAÇÃO EVOLUTIVA",
	"COMPUTAÇÃO GRÁFICA",
	"COMPUTAÇÃO SIMBÓLICA E NUMÉRICA",
	"COMPUTADOR E SOCIEDADE",
	"COMUNICAÇÃO DE DADOS",
	"CONCEPÇÃO DE CIRCUITOS INTEGRADOS I",
	"CONCEPÇÃO DE CIRCUITOS INTEGRADOS II",
	"DESAFIOS DE PROGRAMAÇÃO",
	"ECONOMIA A",
	"EMPREENDIMENTO EM INFORMÁTICA",
	"ENGENHARIA DE SOFTWARE II",
	"ENGENHARIA DE SOFTWARE N",
	"ESPECIFICAÇÃO FORMAL N",
	"ESTRUTURAS DE DADOS",
	"FOTOGRAFIA COMPUTACIONAL",
	"FUNDAMENTOS DE ALGORITMOS",
	"FUNDAMENTOS DE BANCO DE DADOS",
	"FUNDAMENTOS DE COMPUTAÇÃO GRÁFICA",
	"FUNDAMENTOS DE PROCESSAMENTO DE IMAGENS",
	"FUNDAMENTOS DE TOLERÂNCIA A FALHAS",
	"GERÊNCIA E ADMINISTRAÇÃO DE PROJETOS",
	"GERÊNCIA E APLICAÇÕES EM REDES",
	"HISTÓRIA DA COMPUTAÇÃO",
	"INTELIGÊNCIA ARTIFICIAL",
	"INTELIGÊNCIA ARTIFICIAL AVANÇADA",
	"INTERAÇÃO HOMEM-COMPUTADOR",
	"INTRODUÇÃO À ARQUITETURA DE COMPUTADORES",
	"INTRODUÇÃO À INFORMÁTICA",
	"INTRODUÇÃO À PESQUISA EM INFORMÁTICA",
	"INTRODUÇÃO À PROGRAMAÇÃO",
	"LABORATÓRIO DE SISTEMA DE SOFTWARE",
	"LINGUAGENS FORMAIS E AUTÔMATOS N",
	"LÓGICA PARA COMPUTAÇÃO",
	"MATEMÁTICA DISCRETA B",
	"MODELOS DE LINGUAGEM DE PROGRAMAÇÃO",
	"ORGANIZAÇÃO DE COMPUTADORES B",
	"OTIMIZAÇÃO COMBINATÓRIA",
	"PROBABILIDADE E ESTATÍSTICA",
	"PROJETO DE BANCO DE DADOS",
	"PROJETO DE HIPERDOCUMENTOS",
	"PROJETO EM COMPUTAÇÃO E MÚSICA",
	"PROJETO EM COMPUTAÇÃO GRÁFICA",
	"PROTOCOLOS DE COMUNICAÇÃO",
	"REDES DE COMPUTADORES N",
	"REDES NEURAIS E SISTEMAS FUZZY",
	"ROBÓTICA II",
	"SEGURANÇA EM SISTEMAS DE COMPUTAÇÃO",
	"SEMÂNTICA FORMAL N",
	"SISTEMAS DE BANCO DE DADOS DISTRIBUÍDOS",
	"SISTEMAS DIGITAIS PARA COMPUTADORES A",
	"SISTEMAS EMBARCADOS",
	"SISTEMAS ESPECIALISTAS N",
	"SISTEMAS OPERACIONAIS I N",
	"SISTEMAS OPERACIONAIS II N",
	"TÉCNICAS DE CONSTRUÇÃO DE PROGRAMAS",
	"TÉCNICAS DIGITAIS PARA COMPUTAÇÃO",
	"TEORIA DA COMPUTAÇÃO N",
	"TEORIA DOS GRAFOS E ANÁLISE COMBINATÓRIA",
	"TRABALHO DE GRADUAÇÃO"
]

codes = [
	"ADM01134",
	"MAT01355",
	"INF01064",
	"INF01202",
	"INF01023",
	"INF01108",
	"INF01112",
	"INF01191",
	"INF01146",
	"INF01205",
	"MAT01353",
	"MAT01354",
	"MAT01032",
	"INF05006",
	"INF01058",
	"INF01124",
	"INF01147",
	"INF05515",
	"INF01062",
	"INF01037",
	"INF01009",
	"INF05513",
	"INF01140",
	"INF01005",
	"INF01185",
	"INF01194",
	"INF01056",
	"ECO02254",
	"INF01032",
	"INF01003",
	"INF01127",
	"INF01001",
	"INF01203",
	"INF01065",
	"INF05008",
	"INF01145",
	"INF01047",
	"INF01046",
	"INF01209",
	"INF01016",
	"INF01015",
	"INF01061",
	"INF01048",
	"INF05004",
	"INF01043",
	"INF01107",
	"INF01210",
	"INF01049",
	"INF01240",
	"INF01022",
	"INF05005",
	"INF05508",
	"MAT01375",
	"INF01121",
	"INF01113",
	"INF05010",
	"MAT02219",
	"INF01006",
	"INF01021",
	"INF01066",
	"INF01019",
	"INF01002",
	"INF01154",
	"INF01017",
	"INF01034",
	"INF01045",
	"INF05516",
	"INF01014",
	"INF01175",
	"INF01059",
	"INF01038",
	"INF01142",
	"INF01151",
	"INF01120",
	"INF01118",
	"INF05501",
	"INF05512",
	""
]

names.size.times do |i|
	Course.create(name: names[i], code: codes[i])
end
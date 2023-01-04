# scm_engenharia_app

Aplicativo mobile da empresa SCM Engenharia

## Começando

Este projeto é um ponto de partida para um aplicativo Flutter.

Alguns recursos para você começar se este for seu primeiro projeto Flutter::

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


  -- Windows
     Baixar o sdk flutter
  - [Baixar o sdk  flutter](https://github.com/flutter/flutter) 

 Colocar em uma (PATH)  no C: Ex: C:\flutter\bin

 Add a SDK  Flutter variáveis do sistema (PATH)   Ex: C:\flutter\bin
        1- Meu Computado  Propriedade  
        2- Configuração avançada do sistema
        3- Variáveis de Ambiente
        4- variável de ambiente %username%
        5- Selecione a variavel Patch 
        6- Editar
        7- Novo
        8- Add Ex: C:\flutter\bin

Reinicia o computador


  --  MacOS
      Baixar o sdk flutter
  -- [Baixar o sdk  flutter](https://github.com/flutter/flutter)

##


## Building Android

Adicionar  key.properties  Em [project]/android 

Que está em Ex: D:\GitHub\scmmobile\build_android

Abra o key.properties 
Mapear storeFile -  Ex: D:\GitHub\scmmobile\build_android\ScmEngenharia.jks

    -----------------------------  INICIO  PUBLICACAO  -----------------------------
Arquivo: [project]/android/app/build.gradle
         versionCode 30050  ( Substituir o valor por sua versão )
         versionName 3.50.0 ( Substituir o valor por sua versão )

flutter clean
flutter build apk --obfuscate --split-debug-info=/obfuscate

cd [project]
flutter build appbundle
[project]/build/app/outputs/bundle/release/app.aab

Submeter a google play   (app.aab)

##

## Building IOS
**pod install --repo-update**

flutter clean
flutter build ios --obfuscate --split-debug-info=/obfuscate

Abrir o arquivo ios/Runner.xcworkspace  ( Isso irá abrir o Xcode - Os passos abaixo são dentro do Xcode)

Alterar na aba general:
        Version: 30049 ( Substituir o valor por sua versão )
        Build: 3.44.9  ( Substituir o valor por sua versão )

Escolher um emulador de teste(Iphone 12 pro max):  No menu superior ( Runner ) e Clicar no play
Build :  No menu superior ( Runner ) selecionar a opção ( Any IOS Device)
Após gerar a build acima clicar no Menu de Contexto ( Product >  Archive )
Após clicar em Archive clicar no botão Distribute App e clicar sempre em next

##

## Building Windows

-- Building Windows (error Nuget.exe not found, trying to download or use cached version.)
   Install nuget.exe
   https://www.nuget.org/downloads

1- Colocar o  nuget.exe em uma path Ex: C:\Flutter\tools

2- add nuget.exe variáveis do sistema  (PATH) 

3- Restart Android Studio

##

## Building Windows
flutter build macos
##

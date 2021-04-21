plugins {
    java
    antlr
}

repositories {
    mavenCentral()
}

dependencies {
    antlr("org.antlr:antlr4:4.5") // use ANTLR version 4
}

tasks.compileJava {
    dependsOn("generateGrammarSource")
    options.release.set(11)
}

tasks.generateGrammarSource {
    maxHeapSize = "128m"
    arguments = arguments + listOf("-package", "gen", "-visitor", "-no-listener")
    outputDirectory = file("${rootDir}/src/main/gen")
    source = fileTree("${rootDir}/src/main/antlr/SuperLanguage.g4")
}

java {
    sourceSets {
        main {
            java.setSrcDirs(listOf("src/main"))
        }
    }
}

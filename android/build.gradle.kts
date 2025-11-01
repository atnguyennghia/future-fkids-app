allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
    
    // Auto-fix namespace and JVM target for plugins that don't have it (required for AGP 8.x)
    project.plugins.withId("com.android.library") {
        val manifestFile = project.file("src/main/AndroidManifest.xml")
        if (manifestFile.exists()) {
            val manifestContent = manifestFile.readText()
            val packageMatch = Regex("""package=["']([^"']+)["']""").find(manifestContent)
            if (packageMatch != null) {
                val packageName = packageMatch.groupValues[1]
                
                val androidExtension = project.extensions.getByType<com.android.build.gradle.LibraryExtension>()
                androidExtension.namespace = packageName
            }
        }
    }
    
    // Fix JVM target compatibility for old plugins that need it
    val oldPluginsList = listOf("audioplayers_android")
    if (oldPluginsList.contains(project.name)) {
        project.plugins.withId("com.android.library") {
            val androidExtension = project.extensions.getByType<com.android.build.gradle.LibraryExtension>()
            // Set both Java and Kotlin to JVM 11 for audioplayers_android
            androidExtension.compileOptions {
                sourceCompatibility = JavaVersion.VERSION_11
                targetCompatibility = JavaVersion.VERSION_11
            }
            project.tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
                kotlinOptions {
                    jvmTarget = "11"
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

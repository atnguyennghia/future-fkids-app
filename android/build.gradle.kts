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
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

import androidx.compose.foundation.layout.Column
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
class Main {
    @Composable
    fun Main(){
        MaterialTheme { val title =("This is a test file for building the manual build!")
            val platform = getPlatform()
            Column {
                Text(title)
                Button(onClick = {platform.name}) {
                    Text("Show the current platform Name")
                }


            }

        }
    }
}
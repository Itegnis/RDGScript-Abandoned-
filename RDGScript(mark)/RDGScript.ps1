function global:RDGScript()
{

$games = $PlayniteAPI.Database.Games
        $num = 0
        foreach($game in $games)
        {
                $insdir = ""
                $res = ""
                $check = ""
                $name = $PlayniteAPI.ExpandGameVariables($game, $game.Name)
				$dir = $PlayniteApi.ExpandGameVariables($game, $game.InstallDirectory)
                $playact = $PlayniteApi.ExpandGameVariables($game, $game.PlayAction.Path)
                $lengthdir = $dir.Length -1
                if ($lengthdir -eq -1){
					$insdir = $playact
					$check = $playact -match ".exe"
                }elseif ($dir.Chars($lengthdir) -eq "\"){
					$insdir = $dir + $playact
					$check = $playact -match ".exe"
                }else{
                    $insdir = $dir + "\" + $playact
					$check = $playact -match ".exe"
                }if ($check -eq $TRUE){
					$res = [System.IO.File]::Exists($insdir)
					$res2 = [System.IO.File]::Exists($playact) #Fix for only playact path
                    if (![System.IO.File]::Exists($insdir) -and ![System.IO.File]::Exists($playact)){
                        $info = $info + $name + " is exist: " + $res + "`n" +  $insdir + "`n" + "`n"
						$game.IsInstalled = $false
                        $PlayniteApi.Database.Games.Update($game)
                        $num = $num + 1

                    }else{}
               
                }else{}
		}
		$PlayniteAPI.Dialogs.ShowMessage("Marked as unistalled " + $num + " games of the list")
	}
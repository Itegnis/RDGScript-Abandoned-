function global:RDGScript()
{
    [void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')

    [System.Windows.Forms.Application]::EnableVisualStyles()
	$formRDGScriptMenu = New-Object 'System.Windows.Forms.Form'
	$labelGamesThatYouHaveDele = New-Object 'System.Windows.Forms.Label'
	$checkedlistbox1 = New-Object 'System.Windows.Forms.CheckedListBox'
	$buttonDeleteALL = New-Object 'System.Windows.Forms.Button'
	$buttonRemoveSelected = New-Object 'System.Windows.Forms.Button'
	$buttonExit = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'

    $buttonDeleteALL_Click={
		foreach ($item in $checkedlistbox1.Items)
        {
           $PlayniteApi.Database.Games.Remove($item.Id)
           $num = $num + 1
        }
        $formRDGScriptMenu.Close()
        $PlayniteAPI.Dialogs.ShowMessage("Removed " + $num + " games of the list")
	}
	
	$buttonRemoveSelected_Click={
        $num = 0
		foreach ($item in $checkedlistbox1.CheckedItems)
        {
            $PlayniteApi.Database.Games.Remove($item.Id)
            $num = $num + 1
        }
        $formRDGScriptMenu.Close()
        $PlayniteAPI.Dialogs.ShowMessage("Removed " + $num + " games of the list")
	}
	
	$buttonExit_Click={
		$formRDGScriptMenu.Close()
	}
	
	$formRDGScriptMenu_Load={
		
        #$gameCount = $PlayniteAPI.Database.Games.InstallDirectory
        $games = $PlayniteAPI.Database.Games
        $i = 0
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
                        # Add $i items to the CheckedListBox
						$checkedlistbox1.Items.Add($game)
						
                    }else{}
               
                }else{}
           
                $i = $i + 1
			
			
		}
		if ($info -ne $NULL) { $PlayniteAPI.Dialogs.ShowMessage($info) }
		
		if ($checkedlistbox1.Items.Count -eq 0)
		{
			$formRDGScriptMenu.Close()
			$PlayniteAPI.Dialogs.ShowMessage("All games are ready to run. :3")
		}

		
	}

    $Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formRDGScriptMenu.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_checkedlistbox1 = $checkedlistbox1.SelectedItems
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonDeleteALL.remove_Click($buttonDeleteALL_Click)
			$buttonRemoveSelected.remove_Click($buttonRemoveSelected_Click)
			$buttonExit.remove_Click($buttonExit_Click)
			$formRDGScriptMenu.remove_Load($formRDGScriptMenu_Load)
			$formRDGScriptMenu.remove_Load($Form_StateCorrection_Load)
			$formRDGScriptMenu.remove_Closing($Form_StoreValues_Closing)
			$formRDGScriptMenu.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
    

    $formRDGScriptMenu.Controls.Add($labelGamesThatYouHaveDele)
	$formRDGScriptMenu.Controls.Add($checkedlistbox1)
	$formRDGScriptMenu.Controls.Add($buttonDeleteALL)
	$formRDGScriptMenu.Controls.Add($buttonRemoveSelected)
	$formRDGScriptMenu.Controls.Add($buttonExit)
	$formRDGScriptMenu.AutoScaleDimensions = '6, 13'
	$formRDGScriptMenu.AutoScaleMode = 'Font'
	$formRDGScriptMenu.ClientSize = '452, 412'


    $formRDGScriptMenu.Icon = [System.Convert]::FromBase64String('
AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAgBAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGRk3m1kZN7/AAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZGTe
emRk3v8AAAAAAAAAAAAAAABkZN5tZGTe/wAAAAAAAAAAAAAAAGRk3m1kZN7/ZGTe/2Rk3v9kZN7/
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAABkZN56ZGTe/wAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAAAAAAAAZGTeFmRk
3rZkZN7/ZGTer2Rk3v9kZN7/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZN5tZGTe
/2Rk3v9kZN7/AAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAAAAAAAAZGTeemRk3v8AAAAA
AAAAAAAAAAAAAAAAZGTeemRk3v9kZN4WZGTer2Rk3v9kZN7/AAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAZGTebWRk3v9kZN7/ZGTer2Rk3v9kZN7/AAAAAAAAAAAAAAAAZGTeemRk3v8AAAAAAAAAAGRk
3m1kZN7/ZGTe/wAAAAAAAAAAAAAAAAAAAABkZN56ZGTe/wAAAABkZN4WZGTer2Rk3v8AAAAAAAAA
AAAAAAAAAAAAAAAAAGRk3m1kZN7/ZGTe/2Rk3mZkZN4WZGTer2Rk3v8AAAAAAAAAAAAAAABkZN56
ZGTe/wAAAAAAAAAAZGTeemRk3v9kZN5mAAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAABk
ZN56ZGTe/2Rk3v8AAAAAAAAAAAAAAAAAAAAAZGTeemRk3v9kZN5mAAAAAAAAAABkZN56ZGTe/2Rk
3v8AAAAAAAAAAGRk3npkZN7/AAAAAGRk3m1kZN7/ZGTe/wAAAAAAAAAAAAAAAAAAAAAAAAAAZGTe
emRk3v8AAAAAAAAAAGRk3hZkZN6vZGTe/wAAAAAAAAAAAAAAAGRk3m1kZN7/ZGTe/wAAAAAAAAAA
AAAAAGRk3hZkZN6vZGTe/wAAAAAAAAAAZGTeemRk3v8AAAAAZGTeemRk3v9kZN5mAAAAAAAAAAAA
AAAAAAAAAGRk3m1kZN7/ZGTe/wAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAAAAAAAAZGTeemRk
3v9kZN5mAAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAABkZN56ZGTe/2Rk3m1kZN7/ZGTe
/wAAAAAAAAAAAAAAAAAAAAAAAAAAZGTeemRk3v9kZN5mAAAAAAAAAAAAAAAAZGTeemRk3v8AAAAA
AAAAAAAAAABkZN56ZGTe/wAAAABkZN5tZGTe/2Rk3v9kZN7/ZGTe/2Rk3v8AAAAAAAAAAGRk3npk
ZN7/ZGTeemRk3v9kZN5mAAAAAAAAAAAAAAAAAAAAAAAAAABkZN56ZGTe/wAAAAAAAAAAAAAAAAAA
AABkZN56ZGTe/wAAAAAAAAAAZGTebWRk3v9kZN7/AAAAAGRk3hZkZN5zZGTec2Rk3nNkZN5zZGTe
ZgAAAAAAAAAAZGTeemRk3v9kZN7/ZGTe/2Rk3v8AAAAAAAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/
AAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAABkZN56ZGTe/2Rk3mYAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZN56ZGTe/2Rk3n9kZN7PZGTe/2Rk3v8AAAAAAAAAAAAA
AAAAAAAAZGTeemRk3v8AAAAAAAAAAAAAAAAAAAAAZGTeemRk3v8AAAAAAAAAAGRk3npkZN7/AAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZGTebWRk3v9kZN5mAAAAAGRk3hZkZN6v
ZGTe/wAAAAAAAAAAAAAAAAAAAABkZN56ZGTe/wAAAAAAAAAAAAAAAGRk3m1kZN7/ZGTe/wAAAAAA
AAAAZGTeemRk3v9kZN7/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZN56ZGTe/wAA
AAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/AAAAAAAAAAAAAAAAZGTe
emRk3v9kZN5mAAAAAAAAAABkZN4WZGTer2Rk3v8AAAAAAAAAAAAAAAAAAAAAZGTebWRk3v8AAAAA
AAAAAGRk3npkZN7/AAAAAAAAAAAAAAAAZGTeemRk3v8AAAAAAAAAAAAAAAAAAAAAZGTeemRk3v8A
AAAAAAAAAGRk3m1kZN7/ZGTe/wAAAAAAAAAAAAAAAAAAAABkZN56ZGTe/wAAAAAAAAAAAAAAAAAA
AABkZN56ZGTe/wAAAAAAAAAAZGTes2Rk3v8AAAAAAAAAAAAAAABkZN56ZGTe/wAAAAAAAAAAAAAA
AAAAAABkZN6zZGTe/2Rk3m1kZN7/ZGTe/2Rk3v9kZN5mAAAAAAAAAAAAAAAAAAAAAGRk3npkZN7/
ZGTe/wAAAAAAAAAAZGTebWRk3v9kZN7/AAAAAAAAAABkZN66ZGTe/2Rk3v9kZN7/ZGTe/2Rk3v9k
ZN5mAAAAAAAAAAAAAAAAAAAAAGRk3rpkZN7/ZGTe/2Rk3v9kZN5zZGTeZgAAAAAAAAAAAAAAAAAA
AAAAAAAAZGTeFmRk3q9kZN7/AAAAAGRk3m1kZN7/ZGTe/2Rk3mYAAAAAAAAAAGRk3ipkZN6rZGTe
c2Rk3nNkZN5zZGTeZgAAAAAAAAAAAAAAAAAAAAAAAAAAZGTeKmRk3qtkZN5zZGTeZgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZGTeemRk3v9kZN7/ZGTe/2Rk3v9kZN5mAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZN4WZGTec2Rk3nNkZN5zZGTe
ZgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////
////////////////////////////z////85wf//OcD/Dzngfgcx5HwHMeY8YyPmOOMjxzjzB8c5A
wfPMQMHzzH/A88z/iPOMf5zzjHmc8x55nPAeMYDwPiGB8P8D////B///////////////////////
//////////////8=')

    $formRDGScriptMenu.Name = 'formRDGScriptMenu'
	$formRDGScriptMenu.StartPosition = 'CenterScreen'
	$formRDGScriptMenu.Text = 'RDGScript Menu'
	$formRDGScriptMenu.add_Load($formRDGScriptMenu_Load)

    $labelGamesThatYouHaveDele.AutoSize = $True
	$labelGamesThatYouHaveDele.Font = 'Microsoft Sans Serif, 12.25pt'
	$labelGamesThatYouHaveDele.Location = '13, 13'
	$labelGamesThatYouHaveDele.Name = 'labelGamesThatYouHaveDele'
	$labelGamesThatYouHaveDele.Size = '427, 61'
	$labelGamesThatYouHaveDele.TabIndex = 5
	$labelGamesThatYouHaveDele.Text = 'Games that you have deleted, select the ones you wish
to remove from playnite list and click Remove Selected.
Or click on the Remove All button.'
	$labelGamesThatYouHaveDele.UseCompatibleTextRendering = $True

    $checkedlistbox1.Font = 'Microsoft Sans Serif, 12.25pt'
	$checkedlistbox1.FormattingEnabled = $True
	$checkedlistbox1.HorizontalScrollbar = $True
	$checkedlistbox1.Location = '12, 74'
	$checkedlistbox1.Name = 'checkedlistbox1'
	$checkedlistbox1.Size = '428, 277'
	$checkedlistbox1.TabIndex = 4
	$checkedlistbox1.UseCompatibleTextRendering = $True


    $buttonDeleteALL.Anchor = 'Bottom'
	$buttonDeleteALL.Location = '187, 377'
	$buttonDeleteALL.Name = 'buttonDeleteALL'
	$buttonDeleteALL.Size = '82, 23'
	$buttonDeleteALL.TabIndex = 3
	$buttonDeleteALL.Text = 'Remove All'
	$buttonDeleteALL.UseCompatibleTextRendering = $True
	$buttonDeleteALL.UseVisualStyleBackColor = $True
	$buttonDeleteALL.add_Click($buttonDeleteALL_Click)

    $buttonRemoveSelected.Anchor = 'Bottom, Right'
	$buttonRemoveSelected.Location = '346, 377'
	$buttonRemoveSelected.Name = 'buttonRemoveSelected'
	$buttonRemoveSelected.Size = '94, 23'
	$buttonRemoveSelected.TabIndex = 2
	$buttonRemoveSelected.Text = 'Remove Selected'
	$buttonRemoveSelected.UseCompatibleTextRendering = $True
	$buttonRemoveSelected.UseVisualStyleBackColor = $True
	$buttonRemoveSelected.add_Click($buttonRemoveSelected_Click)

    $buttonExit.Anchor = 'Bottom, Left'
	$buttonExit.Location = '13, 377'
	$buttonExit.Name = 'buttonExit'
	$buttonExit.Size = '83, 23'
	$buttonExit.TabIndex = 1
	$buttonExit.Text = 'Exit'
	$buttonExit.UseCompatibleTextRendering = $True
	$buttonExit.UseVisualStyleBackColor = $True
	$buttonExit.add_Click($buttonExit_Click)
	$formRDGScriptMenu.ResumeLayout()

    #Save the initial state of the form
	$InitialFormWindowState = $formRDGScriptMenu.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formRDGScriptMenu.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formRDGScriptMenu.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$formRDGScriptMenu.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $formRDGScriptMenu.ShowDialog()
    
    
}
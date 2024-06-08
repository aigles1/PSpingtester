[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

#Powershell Pingtester written by aigles1 with parts of code taken from open-sources found on the web
 
$host2 = "1.1.1.1"
$hostlabel2 = "Cloudflare DNS 1.1.1.1"

$host3 = "speedtest.net"
$hostlabel3 = "speedtest.net"

$host4 = "8.8.8.8"
$hostlabel4 = "Google DNS 8.8.8.8"

$host5 = "205.251.196.120"
$hostlabel5 = "Amazon DNS 205.251.196.120"

$host6 = "208.67.222.222"
$hostlabel6 = "Cisco OpenDNS 208.67.222.222"

$host7 = "127.0.0.1"
$hostlabel7 = "ISP Primary DNS placeholder"

$host8 = "127.0.0.1"
$hostlabel8 = "ISP Secondary DNS placeholder"

$host9 = "127.0.0.1"
$hostlabel9 = "ISP Default Gateway placeholder"

 
 
# form specs
$objForm = New-Object System.Windows.Forms.Form
$objForm.Text = "Check Network Status"
$objForm.Size = New-Object System.Drawing.Size(380,480)
$objForm.StartPosition = "CenterScreen"
$objForm.KeyPreview = $True
$objForm.MaximumSize = $objForm.Size
$objForm.MinimumSize = $objForm.Size

# combobox label
$objLabelbox = New-Object System.Windows.Forms.Label
$objLabelbox.Location = New-Object System.Drawing.Size(292,10)
$objLabelbox.Size = New-Object System.Drawing.Size(50,25)
$objLabelbox.BackColor = "Transparent"
$objLabelbox.ForeColor = "Black"
$objLabelbox.Text = "Count:"
$objForm.Controls.Add($objLabelbox)


$List = New-Object system.Windows.Forms.ComboBox
$List.TabIndex = 1
$List.width = 40
@('1','2','3','4','5','6') | ForEach-Object {[void] $List.Items.Add($_)}
# Select the default value
$List.SelectedIndex = 0
$List.location = New-Object System.Drawing.Point(295,35)
$List.Font = "Microsoft Sans Serif,10"

 

$objForm.Controls.Add($List)
 
# label
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(17,10)
$objLabel.Size = New-Object System.Drawing.Size(130,25)
$objLabel.BackColor = "Transparent"
$objLabel.ForeColor = "Black"
$objLabel.Text = "Enter Address:"
$objForm.Controls.Add($objLabel)
 
# input box
$objTextbox = New-Object System.Windows.Forms.TextBox
$objTextbox.TabIndex = 0
$objTextbox.Location = New-Object System.Drawing.Size(20,35)
$objTextbox.Size = New-Object System.Drawing.Size(180,20)
$objTextbox.MaxLength = 33
$objTextbox.Font = New-Object System.Drawing.Font("Segoe UI",11,[System.Drawing.FontStyle]::Regular)
$objForm.Controls.Add($objTextbox)
$ErrorProvider = New-Object System.Windows.Forms.ErrorProvider
 
# ok button
$objButton = New-Object System.Windows.Forms.Button
$objButton.Location = New-Object System.Drawing.Size(210,37)
$objButton.Size = New-Object System.Drawing.Size(75,23)
$objButton.Text = "OK"
$objButton.Add_Click({Button_Click})
$objForm.Controls.Add($objButton)

# cloudflare dns button
$objButton2 = New-Object System.Windows.Forms.Button
$objButton2.Location = New-Object System.Drawing.Size(170,94)
$objButton2.Size = New-Object System.Drawing.Size(75,23)
$objButton2.Text = "OK"
$objButton2.Add_Click({Button_Click2})
$objForm.Controls.Add($objButton2)

# form cloudflare dns label
$objLabel2 = New-Object System.Windows.Forms.Label
$objLabel2.Name = "cloudflaredns"
$objLabel2.Text = $hostlabel2
$objLabel2.location = New-Object System.Drawing.Point(39, 98)
$objLabel2.Size = New-Object System.Drawing.Size(130,25)
$objLabel2.Enabled = $true
$objForm.Controls.Add($objLabel2)

# speedtest.net button
$objButton3 = New-Object System.Windows.Forms.Button
$objButton3.Location = New-Object System.Drawing.Size(170,134)
$objButton3.Size = New-Object System.Drawing.Size(75,23)
$objButton3.Text = "OK"
$objButton3.Add_Click({Button_Click3})
$objForm.Controls.Add($objButton3)

# form speedtest label
$objLabel3 = New-Object System.Windows.Forms.Label
$objLabel3.Name = "speedtest"
$objLabel3.Text = $hostlabel3
$objLabel3.location = New-Object System.Drawing.Point(90, 138)
$objLabel3.Enabled = $true
$objForm.Controls.Add($objLabel3)

# google dns button
$objButton4 = New-Object System.Windows.Forms.Button
$objButton4.Location = New-Object System.Drawing.Size(170,174)
$objButton4.Size = New-Object System.Drawing.Size(75,23)
$objButton4.Text = "OK"
$objButton4.Add_Click({Button_Click4})
$objForm.Controls.Add($objButton4)

# form google dns label
$objLabel4 = New-Object System.Windows.Forms.Label
$objLabel4.Name = "googledns"
$objLabel4.Text = $hostlabel4
$objLabel4.location = New-Object System.Drawing.Point(55, 178)
$objLabel4.Size = New-Object System.Drawing.Size(150,25)
$objLabel4.Enabled = $true
$objForm.Controls.Add($objLabel4)

# amazon dns button
$objButton5 = New-Object System.Windows.Forms.Button
$objButton5.Location = New-Object System.Drawing.Size(170,215)
$objButton5.Size = New-Object System.Drawing.Size(75,23)
$objButton5.Text = "OK"
$objButton5.Add_Click({Button_Click5})
$objForm.Controls.Add($objButton5)

# form amazon dns label
$objLabel5 = New-Object System.Windows.Forms.Label
$objLabel5.Name = "amazondns"
$objLabel5.Text = $hostlabel5
$objLabel5.location = New-Object System.Drawing.Point(68, 210)
$objLabel5.Size = New-Object System.Drawing.Size(160,36)
$objLabel5.Enabled = $true
$objForm.Controls.Add($objLabel5)

# cisco opendns button
$objButton6 = New-Object System.Windows.Forms.Button
$objButton6.Location = New-Object System.Drawing.Size(170,255)
$objButton6.Size = New-Object System.Drawing.Size(75,23)
$objButton6.Text = "OK"
$objButton6.Add_Click({Button_Click6})
$objForm.Controls.Add($objButton6)

# form cisco opendns label
$objLabel6 = New-Object System.Windows.Forms.Label
$objLabel6.Name = "ciscoopendns"
$objLabel6.Text = $hostlabel6
$objLabel6.location = New-Object System.Drawing.Point(70, 250)
$objLabel6.Size = New-Object System.Drawing.Size(160,35)
$objLabel6.Enabled = $true
$objForm.Controls.Add($objLabel6)

# Your ISP Primary DNS button
$objButton7 = New-Object System.Windows.Forms.Button
$objButton7.Location = New-Object System.Drawing.Size(170,295)
$objButton7.Size = New-Object System.Drawing.Size(75,23)
$objButton7.Text = "OK"
$objButton7.Add_Click({Button_Click7})
$objForm.Controls.Add($objButton7)

# form Your ISP Primary DNS label
$objLabel7 = New-Object System.Windows.Forms.Label
$objLabel7.Name = "ispdns"
$objLabel7.Text = $hostlabel7
$objLabel7.location = New-Object System.Drawing.Point(56, 290)
$objLabel7.Size = New-Object System.Drawing.Size(160,35)
$objLabel7.Enabled = $true
$objForm.Controls.Add($objLabel7)

# Your ISP Secondary DNS button
$objButton8 = New-Object System.Windows.Forms.Button
$objButton8.Location = New-Object System.Drawing.Size(170,335)
$objButton8.Size = New-Object System.Drawing.Size(75,23)
$objButton8.Text = "OK"
$objButton8.Add_Click({Button_Click8})
$objForm.Controls.Add($objButton8)

# form Your ISP Secondary DNS label
$objLabel8 = New-Object System.Windows.Forms.Label
$objLabel8.Name = "ispdnstwo"
$objLabel8.Text = $hostlabel8
$objLabel8.location = New-Object System.Drawing.Point(42, 330)
$objLabel8.Size = New-Object System.Drawing.Size(160,42)
$objLabel8.Enabled = $true
$objForm.Controls.Add($objLabel8)

# Your ISP default gateway button
$objButton9 = New-Object System.Windows.Forms.Button
$objButton9.Location = New-Object System.Drawing.Size(170,375)
$objButton9.Size = New-Object System.Drawing.Size(75,23)
$objButton9.Text = "OK"
$objButton9.Add_Click({Button_Click9})
$objForm.Controls.Add($objButton9)

# form Your ISP default gateway label
$objLabel9 = New-Object System.Windows.Forms.Label
$objLabel9.Name = "ispgateway"
$objLabel9.Text = $hostlabel9
$objLabel9.location = New-Object System.Drawing.Point(40, 370)
$objLabel9.Size = New-Object System.Drawing.Size(140,55)
$objLabel9.Enabled = $true
$objForm.Controls.Add($objLabel9)
 
Function Button_Click()
{
	
if ($objTextbox.Text.Length -lt 1) 	{
		$objButton.Enabled = $false
		$ErrorProvider.SetError($objTextbox, "Please enter a valid IP address or domain name eg: 127.0.0.1")
		$objButton.Enabled = $true
	}
	else
	{
		$objButton.Enabled = $true
		$ErrorProvider.Clear()
		$objStatusBar.Text = "Pinging host..."
		$hostaddress = $objTextbox.Text
		$tries =$List.text

		Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
		$objStatusBar.Text = "Done"
}
}
Function Button_Click2()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host2
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click3()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host3
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click4()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host4
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click5()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host5
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click6()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host6
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click7()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host7
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click8()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host8
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

Function Button_Click9()
{
$objStatusBar.Text = "Pinging host..."
$hostaddress = $host9
$tries =$List.text
Invoke-Expression "Test-Connection -TargetName $hostaddress -Count $tries" | Out-Host
$objStatusBar.Text = "Done"
}

# form status bar
$objStatusBar = New-Object System.Windows.Forms.Label
$objStatusBar.Name = "statusBar"
$objStatusBar.Text = "Ready"
$objStatusBar.ForeColor = "blue"
$objStatusBar.location = New-Object System.Drawing.Point(23, 70)
$objStatusBar.Enabled = $true
$objForm.Controls.Add($objStatusBar)
 
$objForm.Add_KeyDown({ 
$_.SuppressKeyPress = $True
if ($_.KeyCode -eq "Enter"){Button_Click}
elseif (($_.Control) -and ($_.KeyCode -eq 'A')){$objTextbox.SelectAll()}
elseif ($_.KeyCode -eq "Escape"){$objForm.Close()}
else {$_.SuppressKeyPress = $False}
})
 
$objForm.ShowDialog()| Out-Null 

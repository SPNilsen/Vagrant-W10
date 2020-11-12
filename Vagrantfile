# -*- mode: ruby -*-
# vi: set ft=ruby :
TIME = Time.now.strftime('%Y%m%d%H%M%S')

Vagrant.configure("2") do |config|

  #config.vm.box = "gusztavvargadr/windows-10"
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    vb.cpus = "2"
    vb.name = "devbox_#{TIME}" 
    vb.memory = "12000"
    vb.customize ["storageattach", :id, 
                "--storagectl", "IDE Controller", 
                "--port", "0", "--device", "1", 
                "--type", "dvddrive", 
                "--medium", "emptydrive"]

    # Add sound card (platform specfic)
    if Vagrant::Util::Platform.windows?
        # is windows
        vb.customize ["modifyvm", :id, '--audio', 'dsound', '--audiocontroller', 'ac97']
    elsif Vagrant::Util::Platform.darwin?
        # is mac
        vb.customize ["modifyvm", :id, '--audio', 'coreaudio', '--audiocontroller', 'hda']
    else
        # is linux or some other OS
        vb.customize ["modifyvm", :id, "--audio", "pulse", "--audiocontroller", "hda"]
    end
    
    # Clipboard sync (copying text is often needed)
    vb.customize ["modifyvm", :id, '--clipboard', 'bidirectional']
    vb.customize ["modifyvm", :id, "--vram", "64"]
    vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  #config.vm.provision "shell", inline: "\\\\VBOXSVR\\LaSalle-LabVM\\cipc-Admin-fmr.8-6-6-0\\CiscoIPCommunicatorSetup.exe"
  config.vm.define "win" do |win|
    #win.vm.box = ENV['VAGRANT_BOX_WIN'] || "gusztavvargadr/windows-10"
    win.vm.box = "gusztavvargadr/visual-studio"
    #win.vm.box = "mwrock/Windows2016"
    win.vm.boot_timeout = 15*60 # user interaction is required on first boot

    # set up provisioning prerequisities
    #win.vm.provision "shell", path: "vagrant/fixnetwork.ps1" # strangely, network gets randomly set to Public on first box boot
    #win.vm.provision "file", source: "vagrant/provutils.psm1", destination: "Documents/WindowsPowerShell/Modules/provutils/provutils.psm1"
    #win.vm.provision "shell", path: "vagrant/sharedfolder.cmd"
    dir = File.expand_path("..", __FILE__)
    puts "DIR: #{dir}"
    # now for the real work:
    win.vm.provision "shell", path: File.join(dir, "init-machine.ps1"), upload_path: "C:/tmp/init-machine_01.ps1", privileged: true, powershell_elevated_interactive: true
    win.vm.provision :reload
  end
end

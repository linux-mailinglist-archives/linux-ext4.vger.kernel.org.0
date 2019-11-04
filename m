Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6AEE0CC
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 14:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfKDNOd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 4 Nov 2019 08:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfKDNOc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Nov 2019 08:14:32 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205417] New: Files corruption ( fs/ext4/inode.c:3941
 ext4_set_page_dirty+0x3e/0x50 [ext4] )
Date:   Mon, 04 Nov 2019 13:14:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: the.dmol@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205417-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205417

            Bug ID: 205417
           Summary: Files corruption ( fs/ext4/inode.c:3941
                    ext4_set_page_dirty+0x3e/0x50 [ext4] )
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: the.dmol@gmail.com
        Regression: No

Symptoms: after receiving the warning below I continued to work, but some
processes with heavy I/O (namely g++), started to hang. I could kill them only
via ctrl+c. The reboot program hanged too (no any reaction). Then I forced to
turn off power and got corrupted files.



2019-11-04T12:31:44.706915+03:00 localhost kernel: [  263.974691] WARNING: CPU:
3 PID: 138 at fs/ext4/inode.c:3941 ext4_set_page_dirty+0x3e/0x50 [ext4]
2019-11-04T12:31:44.706932+03:00 localhost kernel: [  263.974694] Modules
linked in: psmouse rfcomm 8021q garp mrp stp ctr ccm psnap llc cmac algif_hash
algif_skcipher af_alg bnep joydev cor
etemp hwmon hid_multitouch hid_generic x86_pkg_temp_thermal intel_powerclamp
kvm_intel i2c_designware_platform iTCO_wdt iTCO_vendor_support
i2c_designware_core intel_rapl_msr mei_hdcp kvm ir
qbypass snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core snd_soc_skl_ipc
snd_soc_sst_ipc crct10dif_pclmul snd_soc_sst_dsp snd_soc_acpi_intel_match
snd_soc_acpi ghash_clmulni_intel aesni_intel a
es_x86_64 snd_hda_codec_hdmi crypto_simd iwlmvm snd_soc_core cryptd
snd_hda_codec_conexant glue_helper snd_hda_codec_generic snd_compress
intel_cstate ledtrig_audio snd_pcm_dmaengine intel_r
apl_perf ac97_bus mac80211 snd_hda_intel hp_wmi input_leds sparse_keymap
libarc4 wmi_bmof snd_hda_codec iwlwifi snd_hda_core uvcvideo snd_hwdep
videobuf2_vmalloc i2c_i801 snd_pcm videobuf2_m
emops r8169 rtsx_pci_ms videobuf2_v4l2 memstick cfg80211 realtek
videobuf2_common mei_me mei videodev btusb
2019-11-04T12:31:44.706938+03:00 localhost kernel: [  263.974729]  idma64
virt_dma btbcm btrtl intel_lpss_pci mc btintel intel_lpss
intel_xhci_usb_role_switch processor_thermal_device roles 
intel_soc_dts_iosf intel_rapl_common intel_pch_thermal battery int3403_thermal
int340x_thermal_zone tpm_crb tpm_tis tpm_tis_core hp_accel lis3lv02d tpm
input_polldev rng_core int3400_thermal
 acpi_thermal_rel hp_wireless acpi_pad evdev ac mac_hid thermal pci_stub
vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) snd_seq snd_seq_device
snd_timer snd soundcore vhost_vsock vmw_vsoc
k_virtio_transport_common vsock vhost_net vhost tap uhid hci_vhci bluetooth
ecdh_generic rfkill ecc vfio_iommu_type1 vfio uinput userio ppp_generic slhc
tun loop nvram btrfs xor raid6_pq lib
crc32c cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 i915 intel_gtt
i2c_algo_bit rtsx_pci_sdmmc drm_kms_helper mmc_core ahci syscopyarea
sysfillrect libahci xhci_pci sysimgblt fb_sys_fops
 xhci_hcd libata crc32_pclmul drm crc32c_intel serio_raw usbcore rtsx_pci
scsi_mod i2c_hid agpgart hid wmi
2019-11-04T12:31:44.706940+03:00 localhost kernel: [  263.974772] 
pinctrl_sunrisepoint video pinctrl_intel button dm_mirror dm_region_hash dm_log
dm_mod [last unloaded: psmouse]
2019-11-04T12:31:44.706941+03:00 localhost kernel: [  263.974781] CPU: 3 PID:
138 Comm: kworker/u16:2 Tainted: G           O      5.3.8_2 #1
2019-11-04T12:31:44.706943+03:00 localhost kernel: [  263.974782] Hardware
name: HP HP ProBook 450 G5/837D, BIOS Q85 Ver. 01.01.00 08/19/2017
2019-11-04T12:31:44.706944+03:00 localhost kernel: [  263.974835] Workqueue:
i915 __i915_gem_free_work [i915]
2019-11-04T12:31:44.706945+03:00 localhost kernel: [  263.974850] RIP:
0010:ext4_set_page_dirty+0x3e/0x50 [ext4]
2019-11-04T12:31:44.706945+03:00 localhost kernel: [  263.974853] Code: 48 8b
00 a8 01 75 16 48 8b 57 08 48 8d 42 ff 83 e2 01 48 0f 44 c7 48 8b 00 a8 08 74
0d 48 8b 07 f6 c4 20 74 0f e9 32 6
7 bd c6 <0f> 0b 48 8b 07 f6 c4 20 75 f1 0f 0b e9 21 67 bd c6 90 0f 1f 44 00
2019-11-04T12:31:44.706947+03:00 localhost kernel: [  263.974854] RSP:
0018:ffffa0814039bd98 EFLAGS: 00010246
2019-11-04T12:31:44.706948+03:00 localhost kernel: [  263.974856] RAX:
017fff8000002036 RBX: ffff901a846f6000 RCX: 0000000000000000
2019-11-04T12:31:44.706949+03:00 localhost kernel: [  263.974857] RDX:
0000000000000000 RSI: 0000000000000282 RDI: fffff783cffce540
2019-11-04T12:31:44.706950+03:00 localhost kernel: [  263.974858] RBP:
fffff783cffce540 R08: 00000000000f6798 R09: 0000000000000000
2019-11-04T12:31:44.706952+03:00 localhost kernel: [  263.974859] R10:
0000000000000000 R11: 0000000000000004 R12: 00000000003ff395
2019-11-04T12:31:44.706953+03:00 localhost kernel: [  263.974860] R13:
ffff901a8093ed00 R14: ffff901a8343cf90 R15: 0000000000000000
2019-11-04T12:31:44.706954+03:00 localhost kernel: [  263.974861] FS: 
0000000000000000(0000) GS:ffff901a888c0000(0000) knlGS:0000000000000000
2019-11-04T12:31:44.706955+03:00 localhost kernel: [  263.974862] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
2019-11-04T12:31:44.706956+03:00 localhost kernel: [  263.974863] CR2:
00007f0a9e0a1d78 CR3: 00000003b800a006 CR4: 00000000003606e0
2019-11-04T12:31:44.706957+03:00 localhost kernel: [  263.974864] Call Trace:
2019-11-04T12:31:44.706959+03:00 localhost kernel: [  263.974899] 
i915_gem_userptr_put_pages+0x148/0x1d0 [i915]
2019-11-04T12:31:44.706960+03:00 localhost kernel: [  263.974934] 
__i915_gem_object_put_pages+0x5e/0xa0 [i915]
2019-11-04T12:31:44.706961+03:00 localhost kernel: [  263.974968] 
__i915_gem_free_objects+0x12c/0x240 [i915]
2019-11-04T12:31:44.706962+03:00 localhost kernel: [  263.975005] 
__i915_gem_free_work+0x69/0x90 [i915]
2019-11-04T12:31:44.706963+03:00 localhost kernel: [  263.975014] 
process_one_work+0x186/0x390
2019-11-04T12:31:44.706964+03:00 localhost kernel: [  263.975018] 
worker_thread+0x50/0x3a0
2019-11-04T12:31:44.706965+03:00 localhost kernel: [  263.975023] 
kthread+0xfb/0x130
2019-11-04T12:31:44.706966+03:00 localhost kernel: [  263.975027]  ?
process_one_work+0x390/0x390
2019-11-04T12:31:44.706967+03:00 localhost kernel: [  263.975029]  ?
kthread_park+0x80/0x80
2019-11-04T12:31:44.706967+03:00 localhost kernel: [  263.975035] 
ret_from_fork+0x35/0x40
2019-11-04T12:31:44.706968+03:00 localhost kernel: [  263.975039] ---[ end
trace b7a4449c28785cdf ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

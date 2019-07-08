Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7E61F1D
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jul 2019 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfGHM5r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 8 Jul 2019 08:57:47 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43786 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727663AbfGHM5r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jul 2019 08:57:47 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B4D1A285B3
        for <linux-ext4@vger.kernel.org>; Mon,  8 Jul 2019 12:57:45 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id A4DB6285C9; Mon,  8 Jul 2019 12:57:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 204095] New: freeze while write on external usb 3.0 hard disk
Date:   Mon, 08 Jul 2019 12:57:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: antdev66@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204095-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204095

            Bug ID: 204095
           Summary: freeze while write on external usb 3.0 hard disk
           Product: File System
           Version: 2.5
    Kernel Version: 5.2.0
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: antdev66@gmail.com
        Regression: No

Updating the kernel from version 5.1.6 to version 5.2.0, I found the following
bug:


lug 08 14:05:04 SOLE kernel: xhci_hcd 0000:03:00.0: swiotlb buffer is full (sz:
270336 bytes), total 32768 (slots), used 277 (slots)
lug 08 14:05:04 SOLE kernel: xhci_hcd 0000:03:00.0: overflow
0x0000000730f81000+270336 of DMA mask ffffffff bus mask 0
lug 08 14:05:04 SOLE kernel: WARNING: CPU: 5 PID: 678 at kernel/dma/direct.c:43
report_addr+0x33/0x60
lug 08 14:05:04 SOLE kernel: Modules linked in: battery rfcomm bnep mei_hdcp
pktcdvd binfmt_misc snd_hda_codec_hdmi b43 dib7000p x86_pkg_temp_thermal
intel_powerclamp mac80211 dvb_usb_dib0700 coretemp dib7000m dib0090 btusb btrtl
dib0070 btbcm dib3000mc btintel dvb_usb eeepc_wmi dibx000_common asus_wmi
wmi_bmof bluetooth cfg80211 input_leds ssb mmc_core pcmcia
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel
snd_hda_codec mei_me snd_hda_core mei snd_hwdep ie31200_edac pcc_cpufreq
snd_seq snd_seq_device sky2 skge tun hso option usb_wwan usbserial af_packet
joydev yenta_socket pcmcia_rsrc pcmcia_core snd_aloop snd_pcm snd_timer snd
soundcore sbs sbshc ac serio_raw evdev ata_piix ata_generic e1000 uhci_hcd
mptspi mptscsih mptbase parport_pc ppdev lp parport ip_tables x_tables ipv6
crc_ccitt algif_skcipher af_alg usbhid linear nbd loop uas usb_storage
ghash_clmulni_intel nouveau i2c_algo_bit ttm drm_kms_helper ahci libahci bcma
psmouse r8169 xhci_pci ehci_pci realtek libata drm e1000e
lug 08 14:05:04 SOLE kernel:  ehci_hcd xhci_hcd mxm_wmi thermal aesni_intel fan
wmi video button
lug 08 14:05:04 SOLE kernel: CPU: 5 PID: 678 Comm: usb-storage Not tainted
5.2.0-custom #1
lug 08 14:05:04 SOLE kernel: Hardware name: System manufacturer System Product
Name/P8Z77-V DELUXE, BIOS 0703 02/14/2012
lug 08 14:05:04 SOLE kernel: RIP: 0010:report_addr+0x33/0x60
lug 08 14:05:04 SOLE kernel: Code: 48 8b 87 28 02 00 00 48 89 34 24 48 85 c0 74
2d 4c 8b 00 b8 fe ff ff ff 49 39 c0 76 14 80 3d 0b 16 23 02 00 0f 84 a9 0b 00
00 <0f> 0b 48 83 c4 08 c3 48 83 bf 38 02 00 00 00 74 ef eb e0 80 3d ec
lug 08 14:05:04 SOLE kernel: RSP: 0018:ffffc90008627bd0 EFLAGS: 00010246
lug 08 14:05:04 SOLE kernel: RAX: 0000000000000000 RBX: ffff8887eab08430 RCX:
0000000000000000
lug 08 14:05:04 SOLE kernel: RDX: 0000000000000007 RSI: ffffffff8120a6a4 RDI:
0000000000000000
lug 08 14:05:04 SOLE kernel: RBP: 000000000000000c R08: 0000000000000001 R09:
0000000000000000
lug 08 14:05:04 SOLE kernel: R10: 0000000000000000 R11: 00000000000060a8 R12:
0000000000000011
lug 08 14:05:04 SOLE kernel: R13: 0000160000000000 R14: ffff8887eab082b0 R15:
ffff8887fa5530b0
lug 08 14:05:04 SOLE kernel: FS:  0000000000000000(0000)
GS:ffff8887feb40000(0000) knlGS:0000000000000000
lug 08 14:05:04 SOLE kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
lug 08 14:05:04 SOLE kernel: CR2: 000055c3e9c86378 CR3: 000000000320a003 CR4:
00000000001606e0
lug 08 14:05:04 SOLE kernel: Call Trace:
lug 08 14:05:04 SOLE kernel:  dma_direct_map_sg+0x163/0x190
lug 08 14:05:04 SOLE kernel:  usb_hcd_map_urb_for_dma+0x33f/0x590
lug 08 14:05:04 SOLE kernel:  usb_hcd_submit_urb+0x9b/0xc80
lug 08 14:05:04 SOLE kernel:  ? __kmalloc+0x189/0x220
lug 08 14:05:04 SOLE kernel:  ? usb_alloc_urb+0x23/0x70
lug 08 14:05:04 SOLE kernel:  usb_sg_wait+0x82/0x160
lug 08 14:05:04 SOLE kernel:  usb_stor_bulk_transfer_sglist.part.3+0x5b/0x100
[usb_storage]
lug 08 14:05:04 SOLE kernel:  usb_stor_Bulk_transport+0x192/0x420 [usb_storage]
lug 08 14:05:04 SOLE kernel:  ? preempt_count_sub.constprop.17+0xbe/0xc0
lug 08 14:05:04 SOLE kernel:  usb_stor_invoke_transport+0x3a/0x530
[usb_storage]
lug 08 14:05:04 SOLE kernel:  ? preempt_count_sub+0x98/0xe0
lug 08 14:05:04 SOLE kernel:  usb_stor_control_thread+0x205/0x4a0 [usb_storage]
lug 08 14:05:04 SOLE kernel:  ? usb_stor_disconnect+0xb0/0xb0 [usb_storage]
lug 08 14:05:04 SOLE kernel:  kthread+0x157/0x170
lug 08 14:05:04 SOLE kernel:  ? kthread_park+0x80/0x80
lug 08 14:05:04 SOLE kernel:  ret_from_fork+0x3a/0x50
lug 08 14:05:04 SOLE kernel: ---[ end trace 29f12689feaddfde ]---


next messages:

lug 08 14:05:04 SOLE kernel: xhci_hcd 0000:03:00.0: swiotlb buffer is full (sz:
270336 bytes), total 32768 (slots), used 277 (slots)
lug 08 14:05:04 SOLE kernel: xhci_hcd 0000:03:00.0: swiotlb buffer is full (sz:
270336 bytes), total 32768 (slots), used 277 (slots)
lug 08 14:05:04 SOLE kernel: xhci_hcd 0000:03:00.0: swiotlb buffer is full (sz:
270336 bytes), total 32768 (slots), used 277 (slots)
...
lug 08 14:05:09 SOLE kernel: swiotlb_tbl_map_single: 72389 callbacks suppressed
...


Details:

- connect external usb 3.0 hard disk
- mount ext4 partition
- write some data
- after some freeze copy with bash / cp

note: previous kernel versions work correctly

Thanks,
Antonio

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37D66821B
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2019 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfGOBtY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 14 Jul 2019 21:49:24 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35658 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfGOBtX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 14 Jul 2019 21:49:23 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 51FD526242
        for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2019 01:49:22 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 4639E27F3E; Mon, 15 Jul 2019 01:49:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 204095] freeze while write on external usb 3.0 hard disk
Date:   Mon, 15 Jul 2019 01:49:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: USB
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: AlleyTrotter@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204095-13602-bHodPBv49h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204095-13602@https.bugzilla.kernel.org/>
References: <bug-204095-13602@https.bugzilla.kernel.org/>
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

--- Comment #4 from John Yost (AlleyTrotter@gmail.com) ---
This info may help the person trying to solve the issus

Jul 12 11:16:12 NVMe kernel: [  123.758841] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)
Jul 12 11:16:12 NVMe kernel: [  123.758845] xhci_hcd 0000:07:00.0: overflow
0x00000007c67ab000+348160 of DMA mask ffffffff bus mask 0
Jul 12 11:16:12 NVMe kernel: [  123.758856] WARNING: CPU: 0 PID: 924 at
kernel/dma/direct.c:43 report_addr+0x2f/0x90
Jul 12 11:16:12 NVMe kernel: [  123.758857] Modules linked in: ipv6 xt_limit
xt_pkttype ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_log_ipv4 nf_log_common xt_LOG
xt_conntrack iptable_mangle iptable_nat iptable_filter nf_conntrack_irc
nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip_tables x_tables cfg80211 rfkill hid_generic usbhid hid fuse uas usb_storage
snd_hda_codec_hdmi coretemp intel_rapl x86_pkg_temp_thermal intel_powerclamp
snd_hda_codec_realtek kvm_intel snd_hda_codec_generic ledtrig_audio kvm
irqbypass i2c_dev mxm_wmi crct10dif_pclmul crc32_pclmul i915 crc32c_intel cec
rc_core drm_kms_helper ghash_clmulni_intel snd_hda_intel drm snd_hda_codec
intel_cstate snd_hda_core intel_gtt snd_hwdep intel_rapl_perf snd_pcm snd_timer
evdev agpgart i2c_algo_bit serio_raw fb_sys_fops snd syscopyarea sysfillrect
tg3 sysimgblt i2c_i801 xhci_pci soundcore mei_me xhci_hcd lpc_ich i2c_core
ehci_pci libphy mei ehci_hcd ie31200_edac hwmon wmi video pcc_cpufreq
intel_smartconnect button loop
Jul 12 11:16:12 NVMe kernel: [  123.758903] CPU: 0 PID: 924 Comm: usb-storage
Not tainted 5.2.0 #3
Jul 12 11:16:12 NVMe kernel: [  123.758904] Hardware name: To Be Filled By
O.E.M. To Be Filled By O.E.M./Z77 Extreme4, BIOS P2.90 07/11/2013
Jul 12 11:16:12 NVMe kernel: [  123.758907] RIP: 0010:report_addr+0x2f/0x90
Jul 12 11:16:12 NVMe kernel: [  123.758909] Code: 48 83 ec 08 48 8b 87 28 02 00
00 48 89 34 24 48 85 c0 74 29 4c 8b 00 b8 fe ff ff ff 49 39 c0 76 10 80 3d 43
cf a7 01 00 74 31 <0f> 0b 48 83 c4 08 c3 48 83 bf 38 02 00 00 00 75 e6 eb ed 80
3d 28
Jul 12 11:16:12 NVMe kernel: [  123.758911] RSP: 0018:ffffa46203ef7bc8 EFLAGS:
00010282
Jul 12 11:16:12 NVMe kernel: [  123.758912] RAX: 0000000000000000 RBX:
ffff90f1fb5b30b0 RCX: 0000000000000006
Jul 12 11:16:12 NVMe kernel: [  123.758913] RDX: 0000000000000000 RSI:
0000000000000082 RDI: ffff90f1ff4164c0
Jul 12 11:16:12 NVMe kernel: [  123.758914] RBP: 0000000000055000 R08:
000000000001279c R09: 0000000000000384
Jul 12 11:16:12 NVMe kernel: [  123.758915] R10: 0000000000000000 R11:
0000000000000384 R12: ffff90f1fb5b30b0
Jul 12 11:16:12 NVMe kernel: [  123.758916] R13: 0000000000000001 R14:
0000000000000000 R15: ffff90f1f13102b0
Jul 12 11:16:12 NVMe kernel: [  123.758918] FS:  0000000000000000(0000)
GS:ffff90f1ff400000(0000) knlGS:0000000000000000
Jul 12 11:16:12 NVMe kernel: [  123.758919] CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jul 12 11:16:12 NVMe kernel: [  123.758921] CR2: 000000000189b000 CR3:
0000000320a0a005 CR4: 00000000001606f0
Jul 12 11:16:12 NVMe kernel: [  123.758921] Call Trace:
Jul 12 11:16:12 NVMe kernel: [  123.758927]  dma_direct_map_page+0xd9/0xf0
Jul 12 11:16:12 NVMe kernel: [  123.758930]  dma_direct_map_sg+0x64/0xb0
Jul 12 11:16:12 NVMe kernel: [  123.758934] 
usb_hcd_map_urb_for_dma+0x3d1/0x540
Jul 12 11:16:12 NVMe kernel: [  123.758937]  usb_hcd_submit_urb+0x84/0xa00
Jul 12 11:16:12 NVMe kernel: [  123.758941]  ? schedule_timeout+0x1dc/0x2f0
Jul 12 11:16:12 NVMe kernel: [  123.758943]  ? usb_hcd_submit_urb+0xa9/0xa00
Jul 12 11:16:12 NVMe kernel: [  123.758946]  ? __switch_to_asm+0x40/0x70
Jul 12 11:16:12 NVMe kernel: [  123.758948]  ? _cond_resched+0x16/0x40
Jul 12 11:16:12 NVMe kernel: [  123.758951]  ? __kmalloc+0x5d/0x200
Jul 12 11:16:12 NVMe kernel: [  123.758954]  ? usb_alloc_urb+0x24/0x60
Jul 12 11:16:12 NVMe kernel: [  123.758956]  usb_sg_wait+0x64/0x110
Jul 12 11:16:12 NVMe kernel: [  123.758963] 
usb_stor_bulk_transfer_sglist.part.4+0x69/0xc0 [usb_storage]
Jul 12 11:16:12 NVMe kernel: [  123.758967]  usb_stor_bulk_srb+0x68/0x80
[usb_storage]
Jul 12 11:16:12 NVMe kernel: [  123.758971] 
usb_stor_Bulk_transport+0x184/0x3e0 [usb_storage]
Jul 12 11:16:12 NVMe kernel: [  123.758973]  ? schedule+0x33/0x90
Jul 12 11:16:12 NVMe kernel: [  123.758976] 
usb_stor_invoke_transport+0x3a/0x4e0 [usb_storage]                          
Jul 12 11:16:12 NVMe kernel: [  123.758979]  ?
wait_for_completion_interruptible+0xaf/0x170                                    
Jul 12 11:16:12 NVMe kernel: [  123.758983]  ? wake_up_q+0x80/0x80              
Jul 12 11:16:12 NVMe kernel: [  123.758986] 
usb_stor_control_thread+0x165/0x270 [usb_storage]                               
Jul 12 11:16:12 NVMe kernel: [  123.758990]  ? fill_inquiry_response+0x20/0x20
[usb_storage]                                                                   
Jul 12 11:16:12 NVMe kernel: [  123.758993]  kthread+0xf8/0x130                 
Jul 12 11:16:12 NVMe kernel: [  123.758996]  ? kthread_destroy_worker+0x40/0x40 
Jul 12 11:16:12 NVMe kernel: [  123.758999]  ret_from_fork+0x35/0x40            
Jul 12 11:16:12 NVMe kernel: [  123.759001] ---[ end trace 10d0ae5c82ba2fb9
]---                                                                            
Jul 12 11:16:12 NVMe kernel: [  123.759072] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)          
Jul 12 11:16:12 NVMe kernel: [  123.759141] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)          
Jul 12 11:16:12 NVMe kernel: [  123.759210] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)          
Jul 12 11:16:12 NVMe kernel: [  123.759278] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)          
Jul 12 11:16:12 NVMe kernel: [  123.759363] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)          
Jul 12 11:16:12 NVMe kernel: [  123.759433] xhci_hcd 0000:07:00.0: swiotlb
buffer is full (sz: 348160 bytes), total 32768 (slots), used 1 (slots)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

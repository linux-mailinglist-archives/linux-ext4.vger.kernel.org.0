Return-Path: <linux-ext4+bounces-2570-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCD8C8FB2
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 07:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121D61F22B72
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 05:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB75C152;
	Sat, 18 May 2024 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="NUDB/aVH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC87BE49;
	Sat, 18 May 2024 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716009882; cv=none; b=V+WlvZsXluITLDNiCpqiiDYsKKZydf5j239ISBv3pfv/mPw4qdXXd6go//vBaS+4Ug27JKpST+N9cbKZ0g8Y0n+t8hFzZt1Jjj0XLCCcsKKzEWDuH+VNVSxr0RtEOPb3zehwTNUvwlM54dVhacuWuZeUnG+OWguzYNSvKSiUZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716009882; c=relaxed/simple;
	bh=nfZOaecXBC4wRDEmllbVpPGj/YepINCTVr/wR6rwccc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=vD9OB4DvRoIhgs5fPKnCmchsRw8zCgqzbuzr8pP/8KrH5Bqk7aykKMAn98KO/B1m7mvirdx99YJzmCAPq1wf8TrKsTot+3t4JukJl31yl/vG4J3teQcNRZQFqdEkLWwQbXSQnnGP686edivVamry+QXncRo0McvLMCa2x6czwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=NUDB/aVH; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44I5OKKp023752
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 18 May 2024 07:24:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716009863; bh=o6hd3SkLa03e+xL1CQ0QAcOPsqD0bRwjs/++yK/bNzw=;
	h=Date:From:To:Subject:Cc;
	b=NUDB/aVHRPHANiLoQx0q2OEKdS8YKF0x774XGnrt7rrdMUKDpcCDxZtZoZ+BhHJJ2
	 x0wUAqfOqVDbn9cQe5AgHicDfP8nooBZge4ALssaukr1oqnMaZ4vgUDQ6lxl2OBQwe
	 eECw0B0CxVsq3MyPai/EU9283gQZd3QqRA99uUQk=
Message-ID: <a4ed8496-60f6-4036-b1f9-75e3448510ec@ans.pl>
Date: Fri, 17 May 2024 22:24:18 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: WARNING: CPU: 5 PID: 23226 at fs/ext4/ext4_jbd2.c:73
 ext4_journal_check_start+0x2c/0x82 [Linux 6.6.30, data=journal]
Cc: tytso@mit.edu, adilger.kernel@dilger.ca
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I noticed that once a while my system generates a WARNING during shutdown and this has been ongoing for some time, perhaps since upgrading to 6.6-stable and/or migrating to "-o 64bit". However, I cannot be 100% sure if this is a relatively recent regression or not, as I think it does not happen very frequently and usually I don't look at the console during shutdown.

The WARNING happens after all filesystems except the root fs (253:0) get unmounted and root is already mounted read-only. Today, I was finally able to capture it with the serial console attached.

[ 5802.007527] EXT4-fs (dm-0): re-mounted 5a3b300a-6b1a-4ff1-9138-287dec4dcdd7 ro. Quota mode: none.
[ 5803.382293] sd 0:0:7:0: [sdh] Synchronizing SCSI cache
[ 5803.388868] sd 0:0:7:0: [sdh] Stopping disk
[ 5821.086972] sd 0:0:6:0: [sdg] Synchronizing SCSI cache
[ 5821.093581] sd 0:0:6:0: [sdg] Stopping disk
[ 5832.944678] ------------[ cut here ]------------
[ 5832.950507] WARNING: CPU: 5 PID: 23226 at fs/ext4/ext4_jbd2.c:73 ext4_journal_check_start+0x2c/0x82
[ 5832.961303] CPU: 5 PID: 23226 Comm: kworker/u16:28 Not tainted 6.6.30-o4 #2
[ 5832.969772] Hardware name: Dell Inc. PowerEdge T330/06FW8M, BIOS 2.20.0 02/22/2024
[ 5832.978872] Workqueue: writeback wb_workfn (flush-253:0)
[ 5832.985498] RIP: 0010:ext4_journal_check_start+0x2c/0x82
[ 5832.992079] Code: 89 3c 24 2e 2e 2e 31 c0 48 8b 3c 24 b8 fb ff ff ff 48 8b 97 78 03 00 00 48 8b 8a 30 02 00 00 80 e1 02 75 56 f6 47 50 01 74 04 <0f> 0b eb 47 66 83 bf 50 02 00 00 04 75 00
[ 5833.014495] RSP: 0018:ffffc9000eff7908 EFLAGS: 00010202
[ 5833.021000] RAX: 00000000fffffffb RBX: ffffc9000eff7b18 RCX: 0000000000000000
[ 5833.029711] RDX: ffff8881021f5000 RSI: ffff888100f8c000 RDI: ffff888100f8c000
[ 5833.038392] RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
[ 5833.047028] R10: 8080808080808080 R11: fefefefefefefeff R12: ffff888100f8c000
[ 5833.055698] R13: 0000000000000008 R14: 0000000000000959 R15: ffffffff95c7c06f
[ 5833.064377] FS:  0000000000000000(0000) GS:ffff889030140000(0000) knlGS:0000000000000000
[ 5833.074106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5833.081239] CR2: 00007f8bac652120 CR3: 0000000309e44001 CR4: 00000000003706e0
[ 5833.089883] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5833.098573] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5833.107255] Call Trace:
[ 5833.110693]  <TASK>
[ 5833.113727]  ? __warn+0x93/0x11a
[ 5833.117961]  ? report_bug+0xeb/0x162
[ 5833.122630]  ? ext4_journal_check_start+0x2c/0x82
[ 5833.128636]  ? handle_bug+0x3c/0x63
[ 5833.133212]  ? exc_invalid_op+0x17/0x64
[ 5833.138176]  ? asm_exc_invalid_op+0x1a/0x20
[ 5833.143530]  ? __ext4_journal_start+0x15/0x1b
[ 5833.149031]  ? ext4_journal_check_start+0x2c/0x82
[ 5833.154920]  __ext4_journal_start_sb+0xe5/0x152
[ 5833.160753]  __ext4_journal_start+0x15/0x1b
[ 5833.166046]  mpage_prepare_extent_to_map+0xd1/0x38b
[ 5833.172142]  ext4_do_writepages+0x2a9/0x922
[ 5833.177490]  ext4_writepages+0x83/0xda
[ 5833.182332]  do_writepages+0xca/0x177
[ 5833.187024]  ? lock_timer_base+0x3b/0x64
[ 5833.192001]  __writeback_single_inode+0x83/0x301
[ 5833.197760]  writeback_sb_inodes+0x251/0x418
[ 5833.203168]  __writeback_inodes_wb+0x80/0xc8
[ 5833.208574]  wb_writeback+0x142/0x266
[ 5833.213307]  wb_workfn+0x212/0x3ac
[ 5833.217733]  ? __raw_spin_unlock_irqrestore+0x14/0x29
[ 5833.223973]  process_scheduled_works+0x196/0x29d
[ 5833.229723]  worker_thread+0x1c5/0x21f
[ 5833.234523]  ? __pfx_worker_thread+0x10/0x10
[ 5833.239850]  kthread+0xf3/0xfe
[ 5833.243826]  ? __pfx_kthread+0x10/0x10
[ 5833.248633]  ret_from_fork+0x20/0x35
[ 5833.253239]  ? __pfx_kthread+0x10/0x10
[ 5833.257963]  ret_from_fork_asm+0x1b/0x30
[ 5833.262874]  </TASK>
[ 5833.265828] ---[ end trace 0000000000000000 ]---
[ 5838.780155] sd 0:0:5:0: [sdf] Synchronizing SCSI cache
[ 5838.788570] sd 0:0:5:0: [sdf] Stopping disk
[ 5856.502606] sd 0:0:4:0: [sde] Synchronizing SCSI cache
[ 5856.510119] sd 0:0:4:0: [sde] Stopping disk
[ 5874.197657] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[ 5874.204287] sd 0:0:3:0: [sdd] Stopping disk
[ 5882.659434] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[ 5882.666164] sd 0:0:2:0: [sdc] Stopping disk
[ 5891.129810] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[ 5891.136410] sd 0:0:1:0: [sdb] Stopping disk
[ 5899.598645] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 5899.605233] sd 0:0:0:0: [sda] Stopping disk
[ 5908.184767] megaraid_sas 0000:02:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
[ 5908.198623] mlx4_core 0000:01:00.0: mlx4_shutdown was called
[ 5908.250311] bond0: (slave eth2): Releasing backup interface
[ 5908.257384] bond0: (slave eth2): the permanent HWaddr of slave - XX:XX:XX:XX:XX:XX - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts
[ 5908.290793] mlx4_en 0000:01:00.0: removed PHC
[ 5908.327539] bond0: (slave eth3): Releasing backup interface
[ 5909.421105] ACPI: PM: Preparing to enter system sleep state S5
[ 5909.428720] kvm: exiting hardware virtualization
[ 5909.434855] reboot: Power down

# tune2fs -l /dev/VG0/root |head -12
tune2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   /
Last mounted on:          /
Filesystem UUID:          5a3b300a-6b1a-4ff1-9138-287dec4dcdd7
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index orphan_file filetype needs_recovery extent 64bit flex_bg metadata_csum_seed sparse_super large_file huge_file dir_nlink extra_isize metadata_csum orphan_present
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Remount read-only
Filesystem OS type:       Linux

# grep /dev/mapper/VG0-root /proc/mounts
/dev/mapper/VG0-root / ext4 rw,relatime,nodioread_nolock,nodelalloc,stripe=192,data=journal 0 0

Best regards,
 Krzysztof Olędzki


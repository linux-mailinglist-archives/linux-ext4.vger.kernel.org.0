Return-Path: <linux-ext4+bounces-1760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7D88E885
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 16:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094C01F32CFF
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85456146580;
	Wed, 27 Mar 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mephis.to header.i=@mephis.to header.b="X/jshZo1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.niedermayr.net (mail5.niedermayr.net [213.166.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656A136E1C
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.166.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551929; cv=none; b=VTRAW6gQLwOoOxTU7SY8AQ0r93dWK72pvSt3+9L0q6leF2aFC6KYyzKVTK4ej2chagKAYOxwZIH8qbT3o2G7d3iT5564bj6KeXGmkVRMRvXQrGqLHjtnPPzA35adZgERMCMBc/ki9JavIs9fI4B7xsfZFC9EyzmiN4/5GpKaOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551929; c=relaxed/simple;
	bh=IB9zYbeS5irLHedh2xPBuNwHL3sgqsbb2PZGlobyxxY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Uja12wixgmGivColxNuJ+OEu4wBGHKmkJ/3z+SyBCJB7449EvUhI4Dkdqg9Gtl0Q8lliMC3XcZKEWceOaeEOVJaRY+9FC66Po89A2ISjxSpwAdedLIQ02gzOJ/+h98at6obYdeM9tY2qSBf+ZcbxFJnom/GK4kHVMBMiMf05nDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mephis.to; spf=pass smtp.mailfrom=mephis.to; dkim=pass (2048-bit key) header.d=mephis.to header.i=@mephis.to header.b=X/jshZo1; arc=none smtp.client-ip=213.166.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mephis.to
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mephis.to
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.niedermayr.net (Postfix) with ESMTP id 82196A017D
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 15:55:55 +0100 (CET)
Authentication-Results: mail.niedermayr.net;
	dkim=pass (2048-bit key; unprotected) header.d=mephis.to header.i=@mephis.to header.b="X/jshZo1";
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mephis.to; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id; s=mail; t=1711551355; x=1713365756; bh=IB9zYbe
	S5irLHedh2xPBuNwHL3sgqsbb2PZGlobyxxY=; b=X/jshZo1aW+O1FW83IaKnyJ
	SySKhvXRQS8KPeakqh0ewuV4wIYOaFd8XOYirdlBK1XNxD+xlxKcYuiZzemUDCfb
	UOxITsfQKxgcFhybTrv7GJugfC9BN/Vu5ces2XxiOpGTNXwiMDL9xES2SF2fpi/s
	CmBZwnsyEts7Yb2vh4d9qTsUGfYApYtPy9X4IRSShpSveKlobJuWpIXNRmBc3Pzz
	TzO6Cva4ON0y6QE/oRZ7jDLXzqsBSgTFzdq73XBgBxHbUWvWDqs8+pfpuENf8k/D
	gqq1cCg65s1Q4m5VkiSNn/ktI3S3gsdcWEWFgnBv0crbJboetSVK57sl1826DkQ=
	=
X-Virus-Scanned: Debian amavisd-new at mail.niedermayr.net
Received: from mail.niedermayr.net ([127.0.0.1])
	by localhost (mail.niedermayr.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d8q65lQBpYmm for <linux-ext4@vger.kernel.org>;
	Wed, 27 Mar 2024 15:55:55 +0100 (CET)
Received: from [IPV6:2a02:958:0:3:5df6:c66f:4300:979a] (unknown [IPv6:2a02:958:0:3:5df6:c66f:4300:979a])
	(Authenticated sender: mephisto@mephis.to)
	by mail.niedermayr.net (Postfix) with ESMTPSA id 03878A005E
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 15:55:55 +0100 (CET)
Message-ID: <85adef0b-3a6f-49e1-b4c9-f9ad8a5a6afc@mephis.to>
Date: Wed, 27 Mar 2024 15:55:54 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-ext4@vger.kernel.org
From: =?UTF-8?Q?Bastian_M=C3=A4user?= <mephisto@mephis.to>
Subject: Probable EXT4 bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

i have the following Kernel Message throwing up on a System that is=20
firing every time is issue a fsfreeze command every night when taking=20
backups.

Mar 26 01:30:00 XXX-data qemu-ga: info: guest-ping called
Mar 26 01:30:00 XXX-data qemu-ga: info: guest-fsfreeze called
Mar 26 01:30:01 XXX-data kernel: [10844965.818729] ------------[ cut=20
here ]------------
Mar 26 01:30:01 XXX-data kernel: [10844965.818732] WARNING: CPU: 1 PID:=20
811 at fs/ext4/ext4_jbd2.c:75 ext4_journal_check_start+0x68/0xb0
Mar 26 01:30:01 XXX-data kernel: [10844965.818739] Modules linked in:=20
nfnetlink tls binfmt_misc nls_iso8859_1 joydev input_leds serio_raw=20
sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua drm nfsd=20
auth_rpcgss efi_pstore nfs_acl lockd grace sunrpc ip_tables x_tables=20
autofs4 btrfs blake2b_generic zstd_compress raid10 raid456=20
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq=20
libcrc32c raid1 raid0 multipath linear virtio_net net_failover psmouse=20
failover virtio_scsi floppy
Mar 26 01:30:01 XXX-data kernel: [10844965.818766] CPU: 1 PID: 811 Comm:=20
nfsd Tainted: G        W         5.15.0-89-generic #99-Ubuntu
Mar 26 01:30:01 XXX-data kernel: [10844965.818768] Hardware name: QEMU=20
Standard PC (i440FX + PIIX, 1996), BIOS=20
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
Mar 26 01:30:01 XXX-data kernel: [10844965.818770] RIP:=20
0010:ext4_journal_check_start+0x68/0xb0
Mar 26 01:30:01 XXX-data kernel: [10844965.818772] Code: 02 00 00 31 c0=20
48 85 d2 74 07 8b 02 83 e0 02 75 24 4c 8b 65 f8 c9 c3 cc cc cc cc 4c 8b=20
65 f8 b8 fb ff ff ff c9 c3 cc cc cc cc <0f> 0b eb ce b8 e2 ff ff ff eb=20
dc 44 8b 42 10 68 08 50 c1 91 45 31
Mar 26 01:30:01 XXX-data kernel: [10844965.818773] RSP:=20
0018:ffffad69c0abbad8 EFLAGS: 00010246
Mar 26 01:30:01 XXX-data kernel: [10844965.818775] RAX: ffff8ab5c8a38000=20
RBX: 0000000000000001 RCX: 0000000000000002
Mar 26 01:30:01 XXX-data kernel: [10844965.818777] RDX: 0000000000000000=20
RSI: 0000000000001766 RDI: ffff8ab5c8b29000
Mar 26 01:30:01 XXX-data kernel: [10844965.818778] RBP: ffffad69c0abbae0=20
R08: 0000000000000000 R09: ffffffff90a7e73a
Mar 26 01:30:01 XXX-data kernel: [10844965.818779] R10: ffff8ab5c434ad68=20
R11: 0000000000000000 R12: ffff8ab5c8b29000
Mar 26 01:30:01 XXX-data kernel: [10844965.818780] R13: 0000000000000000=20
R14: 0000000000000008 R15: ffff8ab5c8b29000
Mar 26 01:30:01 XXX-data kernel: [10844965.818783] FS:=20
0000000000000000(0000) GS:ffff8ab6f7d00000(0000) knlGS:0000000000000000
Mar 26 01:30:01 XXX-data kernel: [10844965.818785] CS:  0010 DS: 0000=20
ES: 0000 CR0: 0000000080050033
Mar 26 01:30:01 XXX-data kernel: [10844965.818786] CR2: 00007f5d91b721a0=20
CR3: 0000000103500000 CR4: 00000000000006e0
Mar 26 01:30:01 XXX-data kernel: [10844965.818790] Call Trace:
Mar 26 01:30:01 XXX-data kernel: [10844965.818792]  <TASK>
Mar 26 01:30:01 XXX-data kernel: [10844965.818795]  ?=20
show_trace_log_lvl+0x1d6/0x2ea
Mar 26 01:30:01 XXX-data kernel: [10844965.818800]  ?=20
show_trace_log_lvl+0x1d6/0x2ea
Mar 26 01:30:01 XXX-data kernel: [10844965.818803]  ?=20
__ext4_journal_start_sb+0x35/0x130
Mar 26 01:30:01 XXX-data kernel: [10844965.818805]  ?=20
show_regs.part.0+0x23/0x29
Mar 26 01:30:01 XXX-data kernel: [10844965.818807]  ? show_regs.cold+0x8/=
0xd
Mar 26 01:30:01 XXX-data kernel: [10844965.818809]  ?=20
ext4_journal_check_start+0x68/0xb0
Mar 26 01:30:01 XXX-data kernel: [10844965.818811]  ? __warn+0x8c/0x100
Mar 26 01:30:01 XXX-data kernel: [10844965.818814]  ?=20
ext4_journal_check_start+0x68/0xb0
Mar 26 01:30:01 XXX-data kernel: [10844965.818816]  ? report_bug+0xa4/0xd=
0
Mar 26 01:30:01 XXX-data kernel: [10844965.818821]  ? handle_bug+0x39/0x9=
0
Mar 26 01:30:01 XXX-data kernel: [10844965.818825]  ?=20
exc_invalid_op+0x19/0x70
Mar 26 01:30:01 XXX-data kernel: [10844965.818827]  ?=20
asm_exc_invalid_op+0x1b/0x20
Mar 26 01:30:01 XXX-data kernel: [10844965.818830]  ?=20
ext4_dirty_inode+0x3a/0x80
Mar 26 01:30:01 XXX-data kernel: [10844965.818833]  ?=20
ext4_journal_check_start+0x68/0xb0
Mar 26 01:30:01 XXX-data kernel: [10844965.818835]  ?=20
ext4_journal_check_start+0x13/0xb0
Mar 26 01:30:01 XXX-data kernel: [10844965.818836]=20
__ext4_journal_start_sb+0x35/0x130
Mar 26 01:30:01 XXX-data kernel: [10844965.818838]=20
ext4_dirty_inode+0x3a/0x80
Mar 26 01:30:01 XXX-data kernel: [10844965.818840]=20
__mark_inode_dirty+0x5e/0x330
Mar 26 01:30:01 XXX-data kernel: [10844965.818843]=20
generic_update_time+0x6c/0xd0
Mar 26 01:30:01 XXX-data kernel: [10844965.818845]=20
file_update_time+0x127/0x140
Mar 26 01:30:01 XXX-data kernel: [10844965.818848]  ?=20
mk_fsid+0x110/0x110 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818869]  file_modified+0x27/0x=
40
Mar 26 01:30:01 XXX-data kernel: [10844965.818870]=20
ext4_buffered_write_iter+0x57/0x170
Mar 26 01:30:01 XXX-data kernel: [10844965.818873]=20
ext4_file_write_iter+0x43/0x60
Mar 26 01:30:01 XXX-data kernel: [10844965.818875]=20
do_iter_readv_writev+0x14a/0x1b0
Mar 26 01:30:01 XXX-data kernel: [10844965.818878]  do_iter_write+0x8c/0x=
160
Mar 26 01:30:01 XXX-data kernel: [10844965.818881]  vfs_iter_write+0x19/0=
x30
Mar 26 01:30:01 XXX-data kernel: [10844965.818883]=20
nfsd_vfs_write+0x149/0x610 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818901]  ?=20
nfs4_put_stid+0xa4/0xc0 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818923]=20
nfsd4_write+0x130/0x1b0 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818941]=20
nfsd4_proc_compound+0x41c/0x770 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818958]  ?=20
nfsd_cache_lookup+0x3b7/0x4a0 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818977]=20
nfsd_dispatch+0x16c/0x270 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.818994]=20
svc_process_common+0x3da/0x720 [sunrpc]
Mar 26 01:30:01 XXX-data kernel: [10844965.819021]  ?=20
nfsd_svc+0x190/0x190 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.819035]=20
svc_process+0xbc/0x100 [sunrpc]
Mar 26 01:30:01 XXX-data kernel: [10844965.819057]  nfsd+0xed/0x150 [nfsd=
]
Mar 26 01:30:01 XXX-data kernel: [10844965.819071]  ?=20
nfsd_shutdown_threads+0x90/0x90 [nfsd]
Mar 26 01:30:01 XXX-data kernel: [10844965.819085]  kthread+0x12a/0x150
Mar 26 01:30:01 XXX-data kernel: [10844965.819089]  ?=20
set_kthread_struct+0x50/0x50
Mar 26 01:30:01 XXX-data kernel: [10844965.819091]  ret_from_fork+0x22/0x=
30
Mar 26 01:30:01 XXX-data kernel: [10844965.819096]  </TASK>
Mar 26 01:30:01 XXX-data kernel: [10844965.819096] ---[ end trace=20
a8672e992bf3892a ]---
Mar 26 01:30:01 XXX-data kernel: [10844965.819115] ------------[ cut=20
here ]------------


Is this EXT4 and/or NFSD related?

--=20
Bastian M=C3=A4user
IT Consultant


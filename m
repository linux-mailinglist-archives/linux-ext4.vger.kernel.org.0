Return-Path: <linux-ext4+bounces-13637-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lPTMJwA0iml5IQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13637-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 20:22:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA01140BF
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C59F300AB2A
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Feb 2026 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5841B34F;
	Mon,  9 Feb 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KUyje+fx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB022DCC08;
	Mon,  9 Feb 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664957; cv=none; b=WMbAFCq6iPKhh25pIB+cnhZxB4dBNrImMiddYbMEY1tntla7e1qK5qpa+Fl53ZwszdvOH5XErYfoAWjhXVgPtPhure9+N5cJIeXTByrDdfJ8+9ZdbmcnJLMFzi0KKBIecZKIcswsH/KOYXX+NkIeRVXWBkuxFqPsTxC7cR8xDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664957; c=relaxed/simple;
	bh=ujOWmc/pk55GXtO5FPDNOkmuFlTvOURkOXLdfNBqNbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRHaavMhPu+hzFIPAPihiIHvd6ZAtjRvjappyWujvOIN6CCIPXpTEHn7k65Jl47R6zkkKZ5kt+pw4zBrmn3DilpOTgNw31eteD3wILem4rj+EpxJeLmkza7uoOnHyQSiLUSWksck7QUQBejTKerdPsG5hgXlyWM3Jta7TMXJi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KUyje+fx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619GUJqO460891;
	Mon, 9 Feb 2026 19:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nKfHORbouj/Vl2X49h99ZAV8wWCZH9
	6cpT0J442yBU8=; b=KUyje+fxTT4Kfuo3JAXVWi/8EVOJvL5KYRYfHphlqf0lUL
	OmkxT3mNsyWn+N5Ft2Vql23F/s6l9D875WG5DjVLoSyxYjf0fo9Jm2okYR21jB3B
	e7caeenWAkF+tscxsmnwV1UTQQtkcR0M41G35eXu62ZDzBtLIS5IIrOtKqINVgnN
	9lS7IvXwa4OybejTkQj9QTJ3R3kpzMIY8Fg9IadZNJaALV7ObAkEYA/UVgDhS8db
	KSWIzCyGTVpEYNabo79W3TJPvURJ4yQmvkFmsYfe4eIJGsDR1DLnrW7ASVxFivfo
	xd6Tc41k60hJJBt5+XHxJY7MkAKAJa46L8Qm4zGA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u8x0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 19:22:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619Gecxb002631;
	Mon, 9 Feb 2026 19:22:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsems4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 19:22:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619JMMjn57410018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 19:22:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E4E20043;
	Mon,  9 Feb 2026 19:22:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 091BB20040;
	Mon,  9 Feb 2026 19:22:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Feb 2026 19:22:20 +0000 (GMT)
Date: Tue, 10 Feb 2026 00:52:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
Message-ID: <aYoz6l_q2t-Wa5TP@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <6989419b.050a0220.3b3015.0065.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6989419b.050a0220.3b3015.0065.GAE@google.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698a33f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8
 a=3g80flMcAAAA:8 a=VwQbUJbxAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8
 a=4RBUngkUAAAA:8 a=0qxsvyZFxHPqwYWfoK0A:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22
 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2MyBTYWx0ZWRfX1QkFJBlzV/1z
 JkuXIUIFA7T93arGV3zD0cj/I0Bl+ygepCNrFqQnczjC8fOhdwzuDLRpNmlI5kvSRqOg3WPFGg0
 vtzBwKj0MjAIS1qSV0ILA88AZGhzsf1dowmZ9S2KCfY54L2lAV3PnKCgXmoXTT7p4NkIDSiD66+
 IS7VOay9SFajbWR2OQiRc0G6O1TF/Ib7rQoKnqrpp7zJGcPCyx1GWGy5Nx/cvvJQtdDGbsNRZf3
 nawWFH9a05/2ys3qg7Rzv1RjZVaXXHyC8oBXR8ozhva34GRzkAJ/hYVbi19YEsCPrw91MTSIT/A
 YSfyrXIyCNJBYeGjcBdcuWpFttCKfYV98nzBjF1MEXzSyEfLaZk7SF6MP7XaCyAojdDDIKl4/fW
 LeYSeAw6UGTcjHp13ewnz2cEYHpo9tRCnJA07oIH1x44GKfsKmegJcn7PXmwz0xzIRwzVQ+Z9cd
 s65i8QRfG67YdVHwkLg==
X-Proofpoint-ORIG-GUID: ndgeFbXf4zUtT6HfRxStBFqZxQAkf_BY
X-Proofpoint-GUID: ndgeFbXf4zUtT6HfRxStBFqZxQAkf_BY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090163
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c09aefae2687abea];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13637-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,storage.googleapis.com:url];
	TAGGED_RCPT(0.00)[linux-ext4,ccf1421545dbe5caa20c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 38DA01140BF
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 06:08:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f8a890c4524 Add linux-next specific files for 20260204
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d547fa580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c09aefae2687abea
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16420a52580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3c923d50ef46/disk-0f8a890c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3a560206fcf3/vmlinux-0f8a890c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e0826a2ee028/bzImage-0f8a890c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4532e6e390d7/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1533aa5a580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com
> 
> EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [22,10,230,0x1] conflict with existing [17,15,145,0x2]
> EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [32,1,353,0x1] conflict with existing [32,1,161,0x2]
> EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [33,15,353,0x1] conflict with existing [33,15,161,0x2]
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/extents_status.c:1044!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6168 Comm: syz.0.37 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> RIP: 0010:ext4_es_cache_extent+0x875/0x9e0 fs/ext4/extents_status.c:1044
> Code: e1 07 80 c1 03 38 c1 0f 8c 5c fe ff ff 48 8b 7c 24 18 e8 7e 15 ae ff e9 4d fe ff ff e8 a4 32 44 ff 90 0f 0b e8 9c 32 44 ff 90 <0f> 0b 65 8b 1d f6 c4 99 10 bf 07 00 00 00 89 de e8 c6 36 44 ff 83
> RSP: 0018:ffffc90003dedb80 EFLAGS: 00010293
> RAX: ffffffff82816b34 RBX: 0000000000000023 RCX: ffff8880271c9e40
> RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
> RBP: ffffc90003dedcc8 R08: ffffc90003dedc37 R09: 0000000000000000
> R10: ffffc90003dedc20 R11: fffff520007bdb87 R12: ffffc90003dedc20
> R13: 0000000000000030 R14: 000000000000000f R15: dffffc0000000000
> FS:  000055556ddfe500(0000) GS:ffff88812546d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f56b9c15000 CR3: 0000000079388000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ext4_cache_extents fs/ext4/extents.c:539 [inline]
>  __read_extent_tree_block+0x4b4/0x890 fs/ext4/extents.c:586
>  ext4_find_extent+0x76b/0xcc0 fs/ext4/extents.c:941
>  ext4_ext_map_blocks+0x283/0x58b0 fs/ext4/extents.c:4263
>  ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
>  ext4_map_blocks+0x7cd/0x11d0 fs/ext4/inode.c:809
>  _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:909
>  ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:942
>  ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1196
>  ext4_write_begin+0xb40/0x18c0 fs/ext4/ext4_jbd2.h:-1
>  ext4_da_write_begin+0x355/0xd80 fs/ext4/inode.c:3123
>  generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
>  ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:300
>  ext4_file_write_iter+0x298/0x1bf0 fs/ext4/file.c:-1
>  __kernel_write_iter+0x41e/0x880 fs/read_write.c:621
>  dump_emit_page fs/coredump.c:1299 [inline]
>  dump_user_range+0xb89/0x12d0 fs/coredump.c:1373
>  elf_core_dump+0x34c2/0x3ad0 fs/binfmt_elf.c:2111
>  coredump_write+0x1219/0x1950 fs/coredump.c:1050
>  do_coredump fs/coredump.c:1127 [inline]
>  vfs_coredump+0x36a9/0x4280 fs/coredump.c:1201
>  get_signal+0x1107/0x1330 kernel/signal.c:3019
>  arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:98 [inline]
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
>  irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
>  irqentry_exit+0x176/0x620 kernel/entry/common.c:219
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
> RIP: 0033:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 002b:0000200000000548 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: 00007efd00215fa0 RCX: 00007efcfff9aeb9
> RDX: 0000000000000000 RSI: 0000200000000540 RDI: 0000000000000000
> RBP: 00007efd00008c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007efd00215fac R14: 00007efd00215fa0 R15: 00007efd00215fa0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_es_cache_extent+0x875/0x9e0 fs/ext4/extents_status.c:1044
> Code: e1 07 80 c1 03 38 c1 0f 8c 5c fe ff ff 48 8b 7c 24 18 e8 7e 15 ae ff e9 4d fe ff ff e8 a4 32 44 ff 90 0f 0b e8 9c 32 44 ff 90 <0f> 0b 65 8b 1d f6 c4 99 10 bf 07 00 00 00 89 de e8 c6 36 44 ff 83
> RSP: 0018:ffffc90003dedb80 EFLAGS: 00010293
> RAX: ffffffff82816b34 RBX: 0000000000000023 RCX: ffff8880271c9e40
> RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
> RBP: ffffc90003dedcc8 R08: ffffc90003dedc37 R09: 0000000000000000
> R10: ffffc90003dedc20 R11: fffff520007bdb87 R12: ffffc90003dedc20
> R13: 0000000000000030 R14: 000000000000000f R15: dffffc0000000000
> FS:  000055556ddfe500(0000) GS:ffff88812556d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00426e000 CR3: 0000000079388000 CR4: 00000000003526f0

Okay so I've been looking into this and it is a bit confusing to me. I
see that we crash because of this line in ext4_es_cache_extent()

	ext4_lblk_t end = lblk + len - 1;
	...
  BUG_ON(end < lblk);

which means out len was somehow 0 or negative which ideally shouldn't be
possible. Further, seems like the syzcaller program itself segfaults
causing a core dump which then calls ext4 to write the dump and we fail. 

Now, theres no C reproducer but I managed to run the syz repro in a VM
with same commit and .config as syzcaller but I'm unable to hit the
issue, syzbot however is able to hit it consistently. 

In the console logs I see

[  170.335935][ T5956] EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
[  170.401257][ T6165] loop0: detected capacity change from 0 to 1024
[  170.429239][ T6165] EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
[  170.501277][ T6165] EXT4-fs error (device loop0): mb_free_blocks:2047: group 0, inode 15: block 369:freeing already freed block (bit 23); block bitmap corrupt.
[  170.516829][ T6168] EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [1,20,18446744073709551615,0x8] conflict with existing [1,15,129,0x2]

before the crash which suggests we might have some sort of corruption
going on, maybe the syscaller image is corrupted. Fsck.ext4 is returning

  Illegal block number passed to ext2fs_mark_block_bitmap #0 for check_desc map
  Superblock first_data_block = 1, should have been 0

debugfs is able to open it however, but I don't see any obvious signs of
corruption yet. I'll check a bit more on this.

In the mean time lets see if syzcaller can hit it on the Ted's latest
branch as well.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev

Regards,
ojaswin

> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


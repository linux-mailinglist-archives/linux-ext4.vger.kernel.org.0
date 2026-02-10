Return-Path: <linux-ext4+bounces-13657-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BzBCuQli2mYQQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13657-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 13:34:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782DB11AE44
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEE86301904C
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353B145A1F;
	Tue, 10 Feb 2026 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YTN1HLeA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC07DDA9;
	Tue, 10 Feb 2026 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726851; cv=none; b=mO/QSyiH4pwbAKeWIKVOuYWay2gF/B7wTE6rYpZ+FxrjSSuUAGpkImLWirhRxvRo6D5bEf/vD6D8/NzhOS9lYUhFW13vt5QibYDu6t+jbKU6ZNhFO+nAysdhPTr5XvcSKreOZtgN5lyCY5rn2oQzvJs7PbngnpwUhfMVhFx07cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726851; c=relaxed/simple;
	bh=8UxH6PyHt4yK0D1dPRq5kT7B00ZKoD3gERra0H8avMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki55oOd8Vm81cmIhC45BXcT/C2fzWLdqr4LS8EcCuPaoIitK8oLxCOIrxrfvEgwY+umzKYjuUw2T01Sbb8PXM+9TaZjwFqsg9esoO3r0yRMhmcXlE0O2AjqZXbO58jzBngLNjGNV1L4LPhw/xkPKK6ZGNeJ4oFBU95Y3Hytj0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YTN1HLeA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619NiX5j3313322;
	Tue, 10 Feb 2026 12:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=q9qHA53YRdSl7I3sNXjEVkzHxI2TAU
	6GkIwOcFowOwU=; b=YTN1HLeAmki98FfsCCrjRNgWkp+QQEZxcomSIFwIhSpiPF
	kkkouIXDOMJpbIuUzkw+A+iwduWGfiufKWU/LxTd5bfgFHB+bcV4Tgrzr3ZvHCVK
	N0ZCoYYxOFFsooxbfIPCqjCLmfAuIfL/rpWx4yg5B0aNTkUvz1WcAJa3TlajY20b
	RfjOJLr40myL3Du+YyLKn7TFlN9EjVrzWO8LnPq3W065ZGdEFTfgNeV8SOOWK+XU
	jCT/k6zuplcPsUwjwHXcAE0za2uCD0DCY5DpMuB8Gl5dCsgiFYqpciwlzNws4lfY
	8cg+EB/f4GC508+YjLqAmE3gQaiUmHjlw1PAIzEQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w450h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 12:34:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A90opp002563;
	Tue, 10 Feb 2026 12:34:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqshe20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 12:34:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61ACY01R8913260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 12:34:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5129F20043;
	Tue, 10 Feb 2026 12:34:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C448320040;
	Tue, 10 Feb 2026 12:33:58 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Feb 2026 12:33:58 +0000 (GMT)
Date: Tue, 10 Feb 2026 18:03:56 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
Message-ID: <aYsltA41z7B23GVN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYrG032GU9Nesjsz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <698ace13.050a0220.1ad825.004f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hc176XNAWwYAsIiG"
Content-Disposition: inline
In-Reply-To: <698ace13.050a0220.1ad825.004f.GAE@google.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698b25bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8
 a=4Fp-1wmYg2Q2mfZcYqAA:9 a=CjuIK1q_8ugA:10 a=GtQkV5SuieNGnhpWqh4A:9
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: ewYvWNz9FY3fytbuhAM-m5I5WlQocuVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMyBTYWx0ZWRfX68W2rJfma6wK
 HFemoVRSszUM/nXQU8bJKIH0OnaOhAN2vxJcMwEZNuHvFnutx7UW3ZZ5SRNu/G+uELo5gFpQ16D
 aYmsVljXZ95jviXXYXHrnaPC+gTQ6ROiENDd7OYOZq8uXF1xrzooYM+6OCXtcAABY7AWNQr/WvZ
 9dv8hhRSVGlbudcfnGe5+h2MRic7xGS7/y0lkwm+tGK3fFovaVCjVGZPOvqv7+Kimmhat9hE8l4
 RhyhmNRVM7fvtGc5svImSamOlh3ZxkriD5w3uPgr0B/Hl8iU1+g2GDb/w4VWeiAVZ12e305i/xU
 t6uR/tu6veFxaBgikOaN/pDu/BDR01URO6F/gxLNIZjJbebwT6f9kaCPL0kuWRfLJkCsvOnol12
 j+DKZaJCDD8WRxQ6v7veNSFINEmFC7U5tCZzYzMpo70p7NcboUTOGm2npoJtuaUSNRGsZ9a6cL2
 kqMRpTi0+miEQbyuTLw==
X-Proofpoint-ORIG-GUID: ewYvWNz9FY3fytbuhAM-m5I5WlQocuVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13657-lists,linux-ext4=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-ext4,ccf1421545dbe5caa20c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 782DB11AE44
X-Rspamd-Action: no action


--hc176XNAWwYAsIiG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2026 at 10:20:03PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> kernel BUG in ext4_es_cache_extent
> 
> EXT4-fs warning (device loop7): ext4_es_cache_extent:1081: inode #18: comm syz.7.209: ES cache extent failed: add [33,3,18446744073709551615,0x8] conflict with existing [33,15,257,0x2]
> EXT4-fs warning (device loop7): ext4_es_cache_extent:1081: inode #18: comm syz.7.209: ES cache extent failed: add [36,12,292,0x1] conflict with existing [33,15,257,0x2]
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/extents_status.c:1043!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 9040 Comm: syz.7.209 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> RIP: 0010:ext4_es_cache_extent+0x86e/0x990 fs/ext4/extents_status.c:1043
> Code: e1 07 80 c1 03 38 c1 0f 8c 5d fe ff ff 48 8b 7c 24 20 e8 25 4d af ff e9 4e fe ff ff e8 1b 12 47 ff 90 0f 0b e8 13 12 47 ff 90 <0f> 0b 65 8b 1d 9d 73 6e 10 bf 07 00 00 00 89 de e8 3d 16 47 ff 83
> RSP: 0018:ffffc900054fdba0 EFLAGS: 00010293
> RAX: ffffffff827d2c8d RBX: 0000000000000023 RCX: ffff88801dfe8000
> RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
> RBP: ffffc900054fdce8 R08: ffffc900054fdc57 R09: 0000000000000000
> R10: ffffc900054fdc40 R11: fffff52000a9fb8b R12: 0000000000000030
> R13: dffffc0000000000 R14: 000000000000000f R15: ffff88807d100638
> FS:  00007efd221aa6c0(0000) GS:ffff888125866000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbc5c5e8600 CR3: 000000007569c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ext4_cache_extents fs/ext4/extents.c:544 [inline]
>  __read_extent_tree_block+0x4b4/0x840 fs/ext4/extents.c:591
>  ext4_find_extent+0x76b/0xcc0 fs/ext4/extents.c:944
>  ext4_ext_map_blocks+0x29d/0x6cd0 fs/ext4/extents.c:4239
>  ext4_map_create_blocks fs/ext4/inode.c:613 [inline]
>  ext4_map_blocks+0x8da/0x1830 fs/ext4/inode.c:816
>  _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:916
>  ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:949
>  ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1203
>  ext4_write_begin+0xb40/0x1870 fs/ext4/ext4_jbd2.h:-1
>  ext4_da_write_begin+0x355/0xd30 fs/ext4/inode.c:3130
>  generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
>  ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
>  ext4_file_write_iter+0x298/0x1c10 fs/ext4/file.c:-1
>  __kernel_write_iter+0x41e/0x880 fs/read_write.c:619
>  dump_emit_page fs/coredump.c:1298 [inline]
>  dump_user_range+0xb89/0x12d0 fs/coredump.c:1372
>  elf_core_dump+0x34c2/0x3ad0 fs/binfmt_elf.c:2111
>  coredump_write+0x1219/0x1950 fs/coredump.c:1049
>  do_coredump fs/coredump.c:1126 [inline]
>  vfs_coredump+0x369e/0x4270 fs/coredump.c:1200
>  get_signal+0x1107/0x1330 kernel/signal.c:3019
>  arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
>  irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
>  irqentry_exit+0x176/0x620 kernel/entry/common.c:196
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
> RIP: 0033:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 002b:0000200000000548 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: 00007efd21615fa0 RCX: 00007efd2139aeb9
> RDX: 0000000000000000 RSI: 0000200000000540 RDI: 0000000000000000
> RBP: 00007efd21408c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007efd21616038 R14: 00007efd21615fa0 R15: 00007ffc2b2553f8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_es_cache_extent+0x86e/0x990 fs/ext4/extents_status.c:1043
> Code: e1 07 80 c1 03 38 c1 0f 8c 5d fe ff ff 48 8b 7c 24 20 e8 25 4d af ff e9 4e fe ff ff e8 1b 12 47 ff 90 0f 0b e8 13 12 47 ff 90 <0f> 0b 65 8b 1d 9d 73 6e 10 bf 07 00 00 00 89 de e8 3d 16 47 ff 83
> RSP: 0018:ffffc900054fdba0 EFLAGS: 00010293
> RAX: ffffffff827d2c8d RBX: 0000000000000023 RCX: ffff88801dfe8000
> RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
> RBP: ffffc900054fdce8 R08: ffffc900054fdc57 R09: 0000000000000000
> R10: ffffc900054fdc40 R11: fffff52000a9fb8b R12: 0000000000000030
> R13: dffffc0000000000 R14: 000000000000000f R15: ffff88807d100638
> FS:  00007efd221aa6c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f82eec0f000 CR3: 000000007569c000 CR4: 00000000003526f0

Okay, so this is hitting even before the recent changes. I've made a
logging patch which might help narrow this down.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev

regards,
ojaswin

> 
> Tested on:
> 
> commit:         26f260ce ext4: remove unnecessary zero-initialization ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=12dcd78a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Note: no patches were applied.

--hc176XNAWwYAsIiG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ext4-add-logging-to-debug-issue.patch

From 3cbb86fa6f5d2c49fafb714e8ad3011eb17498b4 Mon Sep 17 00:00:00 2001
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date: Tue, 10 Feb 2026 17:59:17 +0530
Subject: [PATCH] ext4: add logging to debug issue

---
 fs/ext4/extents.c        | 21 +++++++++++++++++++++
 fs/ext4/extents_status.c | 17 +++++++++++++++++
 fs/ext4/mballoc.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3630b27e4fd7..e6df9833a279 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2006,6 +2006,22 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		goto errout;
 	}
 
+	ext4_warning_inode(
+		inode,
+		"%s: add newext [%d, %d, %lld, unwrit:%d] to extent tree.\n",
+		__func__, le32_to_cpu(newext->ee_block),
+		ext4_ext_get_actual_len(newext), ext4_ext_pblock(newext),
+		ext4_ext_is_unwritten(newext));
+
+	if (ex) {
+		ext4_warning_inode(
+			inode,
+			"%s: ext at current path: [%d, %d, %lld, unwrit:%d]\n",
+			__func__, le32_to_cpu(ex->ee_block),
+			ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
+			ext4_ext_is_unwritten(ex));
+	}
+
 	/* try to insert block into found extent and return */
 	if (ex && !(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE)) {
 
@@ -2832,6 +2848,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	int i = 0, err = 0;
 	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
 
+	ext4_warning_inode(
+		inode,
+		"%s: remove range [%d, %d] from extent tree\n",
+		__func__, start, end);
+
 	partial.pclu = 0;
 	partial.lblk = 0;
 	partial.state = initial;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index a1538bac51c6..0cfcf583bc37 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -847,6 +847,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 	struct rb_node *parent = NULL;
 	struct extent_status *es;
 
+	ext4_warning_inode(inode, "%s: add [%d, %d, %llu, 0x%x]\n", __func__,
+			   newes->es_lblk, newes->es_lblk + newes->es_len - 1, ext4_es_pblock(newes),
+			   ext4_es_status(newes));
+
 	while (*p) {
 		parent = *p;
 		es = rb_entry(parent, struct extent_status, rb_node);
@@ -921,6 +925,10 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
+	ext4_warning_inode(
+		inode,
+		"%s: add [%u, %u] %llu %x %d to extent status tree of inode %lu\n",
+		__func__, lblk, lblk + len - 1, pblk, status, delalloc_reserve_used, inode->i_ino);
 
 	if (!len)
 		return;
@@ -1493,6 +1501,11 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool count_reserved = true;
 	struct rsvd_count rc;
 
+	ext4_warning_inode(
+		inode,
+		"%s: remove [%u,%u] range from extent status tree of inode %lu\n",
+		__func__, lblk, end, inode->i_ino);
+
 	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
 		count_reserved = false;
 	if (status == 0)
@@ -1633,6 +1646,10 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
+	ext4_warning_inode(
+		inode,
+		"%s: remove [%u,%u] range from extent status tree of inode %lu\n",
+		__func__, lblk, end, inode->i_ino);
 
 	if (!len)
 		return;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dbc82b65f810..35331d35f630 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2004,6 +2004,18 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	int last = first + count - 1;
 	struct super_block *sb = e4b->bd_sb;
 
+	ext4_fsblk_t pblk =
+		ext4_group_first_block_no(e4b->bd_sb, e4b->bd_group) +
+		(first << EXT4_SB(e4b->bd_sb)->s_cluster_bits);
+
+	if (inode)
+		ext4_warning_inode(inode, "%s: trying to free blocks [%lld, %lld].\n",
+				__func__, pblk, pblk + count - 1);
+	else
+		ext4_warning(sb, "%s: trying to free blocks [%lld, %lld].\n",
+				__func__, pblk, pblk + count - 1);
+
+
 	if (WARN_ON(count == 0))
 		return;
 	BUG_ON(last >= (sb->s_blocksize << 3));
@@ -3101,6 +3113,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && ac->ac_first_err)
 		err = ac->ac_first_err;
 
+	ext4_warning_inode(
+		ac->ac_inode,
+		"%s: Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+		__func__, ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
+		ac->ac_flags, ac->ac_criteria, err);
+
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, ac->ac_criteria, err);
@@ -6251,6 +6269,10 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	sb = ar->inode->i_sb;
 	sbi = EXT4_SB(sb);
 
+	ext4_warning_inode(ar->inode,
+			   "%s: Allocation requested for: [%d, %d]\n",
+			   __func__, ar->logical, ar->logical + ar->len - 1);
+
 	trace_ext4_request_blocks(ar);
 	if (sbi->s_mount_state & EXT4_FC_REPLAY)
 		return ext4_mb_new_blocks_simple(ar, errp);
@@ -6334,6 +6356,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_mb_pa_put_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
+		ext4_warning_inode(
+			ar->inode,
+			"%s: Allocation found: [%d, %d], pblk:%lld len:%u\n",
+			__func__, ar->logical, ar->logical + ac->ac_b_ex.fe_len - 1,
+			ext4_grp_offs_to_block(sb, &ac->ac_b_ex), ac->ac_b_ex.fe_len);
 		*errp = ext4_mb_mark_diskspace_used(ac, handle);
 		if (*errp) {
 			ext4_discard_allocated_blocks(ac);
-- 
2.52.0


--hc176XNAWwYAsIiG--



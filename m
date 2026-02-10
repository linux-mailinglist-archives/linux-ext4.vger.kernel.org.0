Return-Path: <linux-ext4+bounces-13647-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pHdJKOXGimk+NwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13647-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 06:49:25 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFAF1172D9
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 06:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67FC030166D9
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382DE24679C;
	Tue, 10 Feb 2026 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L107Aa+c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0A2AD0C;
	Tue, 10 Feb 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702557; cv=none; b=YqRuvTjNjACklJSTNmzOhgWDizdUYnSMwXM97NfLhmPslEMRn6az9PUj9j+NH4+/en5z71O2APp2EkAqPTfGI7GH6/rTxyvcmwnH53iqq62a85tuqjL6kiUs7t8bHm73uU/e7vjQ628FK5P2oCn4BClhq+GWxQd4NObsEfHDYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702557; c=relaxed/simple;
	bh=bg6kLqxia5HiRi9nD9wgaCMGIhvLTtrLQx938tNDaXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjeI6Qr67p5ssXGuzFd00liIobR3ueWb5gzjF2dxmsDhCANHvPEP1XYj91HJVZmmCxTl3QTbALzOfQAXzbrECP/DdKr9VcGosNvJiJ/XAe6uhpyG+MyW2wtp9l+jJ9jv79sFAGrvSVWjK0Bjzjh0+xaI3rvAr4YE+i/rTFZ1ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L107Aa+c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619IOB3v1782847;
	Tue, 10 Feb 2026 05:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=F7ZFxGEJ8fgP3GfACTtNCPT1jBDbKc
	7rqdk0f4oTTwY=; b=L107Aa+ch84UJ6j0e76KDrpJLJJTEP021aWsc7CQvko3UT
	Sg1i78+RSkaXWvRBE4f52gVbzcCTqQGijeyH2+A+c+Coxi7KjdcaKhhRwPH7fXyo
	pkyC/GNCf0NiJG+0lI9yaM4Pqr4XrZ3uIyaGk+DfiUJluAoQ375a8uT1ZmzQviML
	O/CAkmwd0y5FfI7Dls5uWeHPYFZ8EJlPjUN/DAQnSbWEG1o1WXdlZ7qJzh2W2Aw4
	mFl+ZCIouI2xFHVU1Q7UhLGXQ/LS+pwhh7e3PO8ZcTkK0UajCk/uFLpXoqUH6zY6
	nzOP5o4UJC7hxxBm2teQAG1eklFXsXQnZcWQ0tiA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wruje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 05:49:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A5Cxll012623;
	Tue, 10 Feb 2026 05:49:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7k7y8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 05:49:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61A5nAan15925628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 05:49:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC9F920043;
	Tue, 10 Feb 2026 05:49:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 812B120040;
	Tue, 10 Feb 2026 05:49:09 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Feb 2026 05:49:09 +0000 (GMT)
Date: Tue, 10 Feb 2026 11:19:07 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
Message-ID: <aYrG032GU9Nesjsz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYoz6l_q2t-Wa5TP@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <698a388b.050a0220.1ad825.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698a388b.050a0220.1ad825.0030.GAE@google.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698ac6d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=edf1wS77AAAA:8 a=RN5uDl9G3LakndbvACMA:9 a=CjuIK1q_8ugA:10
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: l8Wh0AqN3LsC0zosnfi6digyI8lrqbrF
X-Proofpoint-ORIG-GUID: l8Wh0AqN3LsC0zosnfi6digyI8lrqbrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA0NiBTYWx0ZWRfXzywQ8eS22hyZ
 emggyNqscA945fKWFzw4jfDGnBjllr5CVTfBtvz/pnrEWP+5EBvSv9OSg7OEqu8/fLj1zGinIuG
 T/YxvhVySb/Wla2pVXYWzwtx7hYrWMVzuLyvF1VGysLl0673eCPp1SvDc+2WlsFEYvNjp8GT1nc
 b6kv5yuuMXg9X6WLU1GJ4MLeZsR2DyHfJaBcqz9m5RuYRTI/UXb0KpGT1rKbgzIY1v4cDdVAqBW
 6iucdsJaMPU8kfyCVYOvMu33Ia52fgvcU9g2xW7uHSshi5MdoCZ7y2ENRGay0EBNCzN+/WNMI/J
 FqUQYaA/b7UIv57PiQIACKMX7ueyeFaw993b8qClzcyYg6JIrIs8cutP5u2PxeyaljLfNAxtg2G
 lU6nvn6yJ0PC7RVpZ//84F5zvhXM/WFyTSGwXBJPC0hn/gEQ48gbLDjc+ypMWhESxmN3yES0yol
 EzS2ea5eZxBKUA7CSNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13647-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4,ccf1421545dbe5caa20c];
	RCPT_COUNT_FIVE(0.00)[6];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: ECFAF1172D9
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:42:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> kernel BUG in ext4_ext_insert_extent
> 
> inode 15: block 305:freeing already freed block (bit 19); block bitmap corrupt.
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/extents.c:2158!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 7267 Comm: syz.8.85 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> RIP: 0010:ext4_ext_insert_extent+0x4b19/0x4b50 fs/ext4/extents.c:2158
> Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 98 e7 ff ff 48 89 df e8 4a 96 b1 ff e9 8b e7 ff ff e8 70 5b 49 ff 90 0f 0b e8 68 5b 49 ff 90 <0f> 0b e8 60 5b 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
> RSP: 0018:ffffc90004d8ec20 EFLAGS: 00010293
> RAX: ffffffff827ae338 RBX: 0000000000000021 RCX: ffff8880269d1e80
> RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
> RBP: ffffc90004d8edd0 R08: ffff88805b34b747 R09: 1ffff1100b6696e8
> R10: dffffc0000000000 R11: ffffed100b6696e9 R12: 0000000000000021
> R13: dffffc0000000000 R14: ffff88807090c43c R15: ffff88804dea8700
> FS:  00007f7f021716c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdd8b3e1198 CR3: 000000005af88000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ext4_ext_map_blocks+0x168a/0x5760 fs/ext4/extents.c:4459
>  ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
>  ext4_map_blocks+0x7cd/0x11d0 fs/ext4/inode.c:809
>  _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:909
>  ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:942
>  ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1196
>  ext4_write_begin+0xb40/0x1870 fs/ext4/ext4_jbd2.h:-1
>  ext4_da_write_begin+0x355/0xd30 fs/ext4/inode.c:3123
>  generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
>  ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
>  ext4_file_write_iter+0x298/0x1bf0 fs/ext4/file.c:-1
>  do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
>  vfs_writev+0x33c/0x990 fs/read_write.c:1057
>  do_pwritev fs/read_write.c:1153 [inline]
>  __do_sys_pwritev2 fs/read_write.c:1211 [inline]
>  __se_sys_pwritev2+0x184/0x2a0 fs/read_write.c:1202
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7f0139aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7f02171028 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
> RAX: ffffffffffffffda RBX: 00007f7f01615fa0 RCX: 00007f7f0139aeb9
> RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
> RBP: 00007f7f01408c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f7f01616038 R14: 00007f7f01615fa0 R15: 00007ffd34928518
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_ext_insert_extent+0x4b19/0x4b50 fs/ext4/extents.c:2158
> Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 98 e7 ff ff 48 89 df e8 4a 96 b1 ff e9 8b e7 ff ff e8 70 5b 49 ff 90 0f 0b e8 68 5b 49 ff 90 <0f> 0b e8 60 5b 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
> RSP: 0018:ffffc90004d8ec20 EFLAGS: 00010293
> RAX: ffffffff827ae338 RBX: 0000000000000021 RCX: ffff8880269d1e80
> RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
> RBP: ffffc90004d8edd0 R08: ffff88805b34b747 R09: 1ffff1100b6696e8
> R10: dffffc0000000000 R11: ffffed100b6696e9 R12: 0000000000000021
> R13: dffffc0000000000 R14: ffff88807090c43c R15: ffff88804dea8700
> FS:  00007f7f021716c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdd8b1e8600 CR3: 000000005af88000 CR4: 00000000003526f0

Okay, so this time we tripped while adding an extent whose ee_block
already existed, which should ideally have never happened. We should
have just returned the extent in ext4_map_query_blocks().

I'll prepare a patch with debug logs, in the meantime lets see if the
issue exists before recent extent codepath changes.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git 26f260ce5828fc7897a

regards,
ojaswin

> 
> 
> Tested on:
> 
> commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> console output: https://syzkaller.appspot.com/x/log.txt?x=15091b22580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Note: no patches were applied.


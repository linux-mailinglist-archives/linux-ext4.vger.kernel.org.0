Return-Path: <linux-ext4+bounces-13665-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPu6DpqOi2mhWAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13665-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 21:01:30 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2411ED78
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 21:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88908301776B
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58A3321B1;
	Tue, 10 Feb 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E2YH+W9E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128A3314AC;
	Tue, 10 Feb 2026 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753613; cv=none; b=U6/7DdE6rmEtZsqKdgxhDiY5yM0w3DZuovlfQIDbMmcKAWC8xYGdJg+A1re+33BBom1UZ1ynUrQxVly/x5RI74D2HQAIb7PntE7mCuuKpOsBvfMj7NAOKmAMa7gg/YqhAQJ5q+UroerpRY+jM9qkQ63KY24sbrpGqTpWffIAnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753613; c=relaxed/simple;
	bh=IkTzGqPaAGmSxiiizBoN3bNm9vMqB9Rew7Web5jh4Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEf9W64/MGW7WvQxaP2Lco9e/eTPsXEtWVhsA2dRx/ppxDu9luI6h7BN/+aqwAccgHctKMi2IelxUrRK3Z6n6t7Mj1ctKgmk/Z/uJnnujIsTbhSMM9wPdHekDku7dJnf9Hf8aBFjnQ+5J67g7l1riYlzlpdh5jERrRHtTihiv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E2YH+W9E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A93VXW397449;
	Tue, 10 Feb 2026 20:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GMoNbK2WELKXh4fNAo7n88gYPBRKJo
	lyjovffOoEPWE=; b=E2YH+W9E+ucNJ2DyFfQ1268Y8Wk8L/YPIz21nwB/t1L2Qf
	JRLUdseRdJF38Qo3iXslIudKZ2Pa8S7gNF7jIYvP+VsWh07WOdugDrRHCa9+gdan
	fSA2JfnLQFU7eDRUYvoyyH/FF44ehTuTQCFl2Uw5z05VRHfCMxS12eBci64po2ij
	xqRljrz9MSLKM3Wo1VBReSa+3RbIL38s+PVPmJw9lvllFYvRsfiabogbyvH2WHcu
	8J1vhRHltJQYsy9SeXu7T68/A5kIEWDa3UtrmjBkDKz9n7AzkEKm/RafZpnqIWyl
	wSG5auKXsQUWNZ6tNjaO4z3i0caCZhArHpZEvO3g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w6444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 20:00:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AIvJgR019274;
	Tue, 10 Feb 2026 20:00:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk2rjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 20:00:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61AK023k43712960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 20:00:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6997D2004E;
	Tue, 10 Feb 2026 20:00:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B8C120043;
	Tue, 10 Feb 2026 20:00:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.155])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Feb 2026 20:00:00 +0000 (GMT)
Date: Wed, 11 Feb 2026 01:29:58 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
Message-ID: <aYuOGWks1hXSx-Uk@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYsltA41z7B23GVN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <698b4d93.a70a0220.2c38d7.0075.GAE@google.com>
 <aYtzvbT74Ba3dA_2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="684Fio5O5oMZSGwX"
Content-Disposition: inline
In-Reply-To: <aYtzvbT74Ba3dA_2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698b8e45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=VnNF1IyMAAAA:8
 a=Meogot6HX-65wpieH40A:9 a=CjuIK1q_8ugA:10 a=ODdyehY1IsyT0BtBtVMA:9
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: B8D7vqhO0FSwhTUF9bntPLK4MxNmVVJl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2NCBTYWx0ZWRfXz4zvx/regZp+
 cMqLG2dhR9ACUzkdq41bmEfgLWy4w015AZZT7S/Pccu9trz+X1Rwskt/+EMAxS++STG4HDKRjke
 Ahe0yjOww0RHboleN2/hNGHyV3yrhesflmAhC4exokGBaQQYBIRPJCM5Sbe09H/uTn2j3z11nCx
 NFfzzjdMH21irUZTs8fMlQvHktX3sUVAhnMOIluBDc5COrbNAVURqBqWe/I0OwHTzD3txe2TCiV
 Q6m9IUoQo4PamH/VlvZl0aBx3/QdYEGkQPOiLkr5PZfMNVOaF1659mSvKQMm54hjfgRJdBVUQKI
 239LVXwf29I2Rrsdx/BiWig0VmgYuDeXN5yD2Qa1h76fac4er0gAvFkHf8Sbpri7MFLYCT8OW5i
 CvaN5JEsRIJLbEqw1av0qIXKkObGkhCde6vstFbt5TJpOBp9WcsISc2q+B3ssOEQQ0daX3Z0GrZ
 WBOdeKqVsakmnyJ3Iwg==
X-Proofpoint-ORIG-GUID: B8D7vqhO0FSwhTUF9bntPLK4MxNmVVJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13665-lists,linux-ext4=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	TAGGED_RCPT(0.00)[linux-ext4,ccf1421545dbe5caa20c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4CC2411ED78
X-Rspamd-Action: no action


--684Fio5O5oMZSGwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2026 at 11:36:53PM +0530, Ojaswin Mujoo wrote:
> On Tue, Feb 10, 2026 at 07:24:03AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > kernel BUG in ext4_ext_insert_extent
> 

Forgot to add the tag:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev

> Okay, so I see these logs:
> 
> [  131.589929][ T6747] EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
> ...
> [  131.684962][ T6747] EXT4-fs warning (device loop0): __es_insert_extent:852: inode #15: comm syz.0.17: __es_insert_extent: add [0, -2, 576460752303423487, 0x8]
> ...
> [  131.771155][ T6747] EXT4-fs warning (device loop0): ext4_mb_new_blocks:6274: inode #15: comm syz.0.17: ext4_mb_new_blocks: Allocation requested for: [0, 0]
> [  131.966256][ T6747] EXT4-fs warning (device loop0): ext4_mb_new_blocks:6363: inode #15: comm syz.0.17: ext4_mb_new_blocks: Allocation found: [0, 0], pblk:113 len:1
> 
> Seems like we are trying to cache an extent that is of length -2. This
> seems like some sort of corruption with the disk but at the same time,
> this inode (#15) is actually an inline inode as pointed by debugfs:
> 
> stat file1
>   Inode: 15   Type: regular    Mode:  0755   Flags: 0x10000000
>   Generation: 1710885023    Version: 0x00000000:00000001
>   User:     0   Group:     0   Project:     0   Size: 10
>   File ACL: 0
>   Links: 1   Blockcount: 0
>   Fragment:  Address: 0    Number: 0    Size: 0
>    ctime: 0x637cf1f3:929ce9b8 -- Tue Nov 22 21:29:47 2022
>    atime: 0x698af58d:e97a2a00 -- Tue Feb 10 14:38:29 2026
>    mtime: 0x637cf1f3:929ce9b8 -- Tue Nov 22 21:29:47 2022
>   crtime: 0x637cf1f3:929ce9b8 -- Tue Nov 22 21:29:47 2022
>   Size of extra inode fields: 32
>   Extended attributes:
>     system.data (0)
>     user.xattr1 (6) = "xattr1"
>     user.xattr2 (6) = "xattr2"
>   Size of inline data: 60
> 
> ex file1
>   file1: does not uses extent block maps
> 
> And the logs also don't show any other operation between this and the
> mount. Seems like there is a disk corruption but somehow I'm unable to
> see it in debugfs, maybe I'm missing the case. Adding some more logging
> and fixing a few log cases to confirm this.
> 
> Regards,
> ojaswin
> 
> > 
> > inode 15: block 305:freeing already freed block (bit 19); block bitmap corrupt.
> > ------------[ cut here ]------------
> > kernel BUG at fs/ext4/extents.c:2174!
> > Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> > CPU: 0 UID: 0 PID: 6747 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> > RIP: 0010:ext4_ext_insert_extent+0x5248/0x5280 fs/ext4/extents.c:2174
> > Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 75 e4 ff ff 48 89 df e8 1b 8f b1 ff e9 68 e4 ff ff e8 41 54 49 ff 90 0f 0b e8 39 54 49 ff 90 <0f> 0b e8 31 54 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
> > RSP: 0018:ffffc9000426ebe0 EFLAGS: 00010293
> > RAX: ffffffff827aea67 RBX: 0000000000000021 RCX: ffff88802fe9db80
> > RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
> > RBP: ffffc9000426edd0 R08: ffff888076d2d0ef R09: 1ffff1100eda5a1d
> > R10: dffffc0000000000 R11: ffffed100eda5a1e R12: ffff888063f4b43c
> > R13: ffff888143ff8500 R14: ffff888063f4b400 R15: 0000000000000021
> > FS:  00007efc4003a6c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000003000 CR3: 0000000028bcc000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  ext4_ext_map_blocks+0x168a/0x5760 fs/ext4/extents.c:4480
> >  ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
> >  ext4_map_blocks+0x7cd/0x11d0 fs/ext4/inode.c:809
> >  _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:909
> >  ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:942
> >  ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1196
> >  ext4_write_begin+0xb40/0x1870 fs/ext4/ext4_jbd2.h:-1
> >  ext4_da_write_begin+0x355/0xd30 fs/ext4/inode.c:3123
> >  generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
> >  ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
> >  ext4_file_write_iter+0x298/0x1bf0 fs/ext4/file.c:-1
> >  do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
> >  vfs_writev+0x33c/0x990 fs/read_write.c:1057
> >  do_pwritev fs/read_write.c:1153 [inline]
> >  __do_sys_pwritev2 fs/read_write.c:1211 [inline]
> >  __se_sys_pwritev2+0x184/0x2a0 fs/read_write.c:1202
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7efc3f19aeb9
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007efc4003a028 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
> > RAX: ffffffffffffffda RBX: 00007efc3f415fa0 RCX: 00007efc3f19aeb9
> > RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
> > RBP: 00007efc3f208c1f R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007efc3f416038 R14: 00007efc3f415fa0 R15: 00007ffefdbddaa8
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:ext4_ext_insert_extent+0x5248/0x5280 fs/ext4/extents.c:2174
> > Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 75 e4 ff ff 48 89 df e8 1b 8f b1 ff e9 68 e4 ff ff e8 41 54 49 ff 90 0f 0b e8 39 54 49 ff 90 <0f> 0b e8 31 54 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
> > RSP: 0018:ffffc9000426ebe0 EFLAGS: 00010293
> > RAX: ffffffff827aea67 RBX: 0000000000000021 RCX: ffff88802fe9db80
> > RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
> > RBP: ffffc9000426edd0 R08: ffff888076d2d0ef R09: 1ffff1100eda5a1d
> > R10: dffffc0000000000 R11: ffffed100eda5a1e R12: ffff888063f4b43c
> > R13: ffff888143ff8500 R14: ffff888063f4b400 R15: 0000000000000021
> > FS:  00007efc4003a6c0(0000) GS:ffff888125866000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fc4a9f45000 CR3: 0000000028bcc000 CR4: 00000000003526f0
> > 
> > 
> > Tested on:
> > 
> > commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1081d33a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c15194580000
> > 

> From 4e793c55c63757a604934dd4e14318cd66e9b900 Mon Sep 17 00:00:00 2001
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Date: Tue, 10 Feb 2026 17:59:17 +0530
> Subject: [PATCH] ext4: add logging to debug issue
> 
> ---
>  fs/ext4/extents.c        | 24 ++++++++++++++++++++++++
>  fs/ext4/extents_status.c | 22 ++++++++++++++++++++++
>  fs/ext4/mballoc.c        | 27 +++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3630b27e4fd7..95a3eadcee67 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -529,6 +529,9 @@ static void ext4_cache_extents(struct inode *inode,
>  	int i;
>  
>  	KUNIT_STATIC_STUB_REDIRECT(ext4_cache_extents, inode, eh);
> +	ext4_warning_inode(inode, "%s: caching extents\n", __func__);
> +	if (strncmp(inode->i_sb->s_id, "loop", 4))
> +		dump_stack();
>  
>  	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
>  		unsigned int status = EXTENT_STATUS_WRITTEN;
> @@ -2006,6 +2009,22 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  		goto errout;
>  	}
>  
> +	ext4_warning_inode(
> +		inode,
> +		"%s: add newext [%d, %d, %lld, unwrit:%d] to extent tree.\n",
> +		__func__, le32_to_cpu(newext->ee_block),
> +		ext4_ext_get_actual_len(newext), ext4_ext_pblock(newext),
> +		ext4_ext_is_unwritten(newext));
> +
> +	if (ex) {
> +		ext4_warning_inode(
> +			inode,
> +			"%s: ext at current path: [%d, %d, %lld, unwrit:%d]\n",
> +			__func__, le32_to_cpu(ex->ee_block),
> +			ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
> +			ext4_ext_is_unwritten(ex));
> +	}
> +
>  	/* try to insert block into found extent and return */
>  	if (ex && !(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE)) {
>  
> @@ -2832,6 +2851,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  	int i = 0, err = 0;
>  	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
>  
> +	ext4_warning_inode(
> +		inode,
> +		"%s: remove range [%d, %d] from extent tree\n",
> +		__func__, start, end);
> +
>  	partial.pclu = 0;
>  	partial.lblk = 0;
>  	partial.state = initial;
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index a1538bac51c6..285acca9a6de 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -847,6 +847,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
>  	struct rb_node *parent = NULL;
>  	struct extent_status *es;
>  
> +	ext4_warning_inode(inode, "%s: add [%d, %d, %llu, 0x%x]\n", __func__,
> +			   newes->es_lblk, newes->es_lblk + newes->es_len - 1, ext4_es_pblock(newes),
> +			   ext4_es_status(newes));
> +
>  	while (*p) {
>  		parent = *p;
>  		es = rb_entry(parent, struct extent_status, rb_node);
> @@ -921,6 +925,10 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
>  		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
> +	ext4_warning_inode(
> +		inode,
> +		"%s: add [%u, %u] %llu %x %d to extent status tree of inode %lu\n",
> +		__func__, lblk, lblk + len - 1, pblk, status, delalloc_reserve_used, inode->i_ino);
>  
>  	if (!len)
>  		return;
> @@ -1031,6 +1039,11 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  	bool conflict = false;
>  	int err;
>  
> +	ext4_warning_inode(
> +		inode,
> +		"%s: cache extent lblk:%d len:%d pblk:%lld status:0x%x\n",
> +		__func__, lblk, len, pblk, status);
> +
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> @@ -1493,6 +1506,11 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	bool count_reserved = true;
>  	struct rsvd_count rc;
>  
> +	ext4_warning_inode(
> +		inode,
> +		"%s: remove [%u,%u] range from extent status tree of inode %lu\n",
> +		__func__, lblk, end, inode->i_ino);
> +
>  	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
>  		count_reserved = false;
>  	if (status == 0)
> @@ -1633,6 +1651,10 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
>  		 lblk, len, inode->i_ino);
> +	ext4_warning_inode(
> +		inode,
> +		"%s: remove [%d,%lld] range from extent status tree of inode %lu\n",
> +		__func__, lblk, (loff_t)lblk + len -1, inode->i_ino);
>  
>  	if (!len)
>  		return;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index dbc82b65f810..35331d35f630 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2004,6 +2004,18 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  	int last = first + count - 1;
>  	struct super_block *sb = e4b->bd_sb;
>  
> +	ext4_fsblk_t pblk =
> +		ext4_group_first_block_no(e4b->bd_sb, e4b->bd_group) +
> +		(first << EXT4_SB(e4b->bd_sb)->s_cluster_bits);
> +
> +	if (inode)
> +		ext4_warning_inode(inode, "%s: trying to free blocks [%lld, %lld].\n",
> +				__func__, pblk, pblk + count - 1);
> +	else
> +		ext4_warning(sb, "%s: trying to free blocks [%lld, %lld].\n",
> +				__func__, pblk, pblk + count - 1);
> +
> +
>  	if (WARN_ON(count == 0))
>  		return;
>  	BUG_ON(last >= (sb->s_blocksize << 3));
> @@ -3101,6 +3113,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  	if (!err && ac->ac_status != AC_STATUS_FOUND && ac->ac_first_err)
>  		err = ac->ac_first_err;
>  
> +	ext4_warning_inode(
> +		ac->ac_inode,
> +		"%s: Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
> +		__func__, ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
> +		ac->ac_flags, ac->ac_criteria, err);
> +
>  	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
>  		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
>  		 ac->ac_flags, ac->ac_criteria, err);
> @@ -6251,6 +6269,10 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  	sb = ar->inode->i_sb;
>  	sbi = EXT4_SB(sb);
>  
> +	ext4_warning_inode(ar->inode,
> +			   "%s: Allocation requested for: [%d, %d]\n",
> +			   __func__, ar->logical, ar->logical + ar->len - 1);
> +
>  	trace_ext4_request_blocks(ar);
>  	if (sbi->s_mount_state & EXT4_FC_REPLAY)
>  		return ext4_mb_new_blocks_simple(ar, errp);
> @@ -6334,6 +6356,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  			ext4_mb_pa_put_free(ac);
>  	}
>  	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
> +		ext4_warning_inode(
> +			ar->inode,
> +			"%s: Allocation found: [%d, %d], pblk:%lld len:%u\n",
> +			__func__, ar->logical, ar->logical + ac->ac_b_ex.fe_len - 1,
> +			ext4_grp_offs_to_block(sb, &ac->ac_b_ex), ac->ac_b_ex.fe_len);
>  		*errp = ext4_mb_mark_diskspace_used(ac, handle);
>  		if (*errp) {
>  			ext4_discard_allocated_blocks(ac);
> -- 
> 2.52.0
> 


--684Fio5O5oMZSGwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ext4-add-logging-to-debug-issue.patch

From 4e793c55c63757a604934dd4e14318cd66e9b900 Mon Sep 17 00:00:00 2001
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date: Tue, 10 Feb 2026 17:59:17 +0530
Subject: [PATCH] ext4: add logging to debug issue

---
 fs/ext4/extents.c        | 24 ++++++++++++++++++++++++
 fs/ext4/extents_status.c | 22 ++++++++++++++++++++++
 fs/ext4/mballoc.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3630b27e4fd7..95a3eadcee67 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -529,6 +529,9 @@ static void ext4_cache_extents(struct inode *inode,
 	int i;
 
 	KUNIT_STATIC_STUB_REDIRECT(ext4_cache_extents, inode, eh);
+	ext4_warning_inode(inode, "%s: caching extents\n", __func__);
+	if (strncmp(inode->i_sb->s_id, "loop", 4))
+		dump_stack();
 
 	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
 		unsigned int status = EXTENT_STATUS_WRITTEN;
@@ -2006,6 +2009,22 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
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
 
@@ -2832,6 +2851,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
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
index a1538bac51c6..285acca9a6de 100644
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
@@ -1031,6 +1039,11 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool conflict = false;
 	int err;
 
+	ext4_warning_inode(
+		inode,
+		"%s: cache extent lblk:%d len:%d pblk:%lld status:0x%x\n",
+		__func__, lblk, len, pblk, status);
+
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
@@ -1493,6 +1506,11 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1633,6 +1651,10 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
+	ext4_warning_inode(
+		inode,
+		"%s: remove [%d,%lld] range from extent status tree of inode %lu\n",
+		__func__, lblk, (loff_t)lblk + len -1, inode->i_ino);
 
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


--684Fio5O5oMZSGwX--



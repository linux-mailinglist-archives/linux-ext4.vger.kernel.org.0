Return-Path: <linux-ext4+bounces-13296-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAV8Js35dWmwKAEAu9opvQ
	(envelope-from <linux-ext4+bounces-13296-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 12:09:01 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBB80285
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA43C3007898
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E5319864;
	Sun, 25 Jan 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gt+LUgvC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B323BB5A;
	Sun, 25 Jan 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769339333; cv=none; b=miQwaBW0lNaD5qmkNMhoHYAAb0rJGRtFs3Jg4scRw1dAYF3TnndaT6IDWsL3FD02/pT4h6FZ70XwgEa5eRfwIlL2lX4zoYmOhXPJzismk0+wVfQ8K4z2p553woqVtY3YaM8yFYS/SO/d1K1Qcuq0qvsOI1z62ShHKa+UGEszE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769339333; c=relaxed/simple;
	bh=7vgMf4Pm8y75tOeGF9fxXJ4PU9bh5ZeGlg5V5+5rrMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT7NvE04arnJiJduhuTlIXh7RPafPkXBZRdKVx+O2jmNLg/oHaMPuRZlxJOBEfpLwBEid8WjHXA94mtThkpzSWmohgKhrzIdTDR4iWlL3WhcVYSzl0q/RZz1Pp9RrD3MCwU/sSlMukLGClQKSlGJe+3vPu/qpRskqA/Nfa3++DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gt+LUgvC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60P4RhoJ027449;
	Sun, 25 Jan 2026 11:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EvO3I+tSo36TNEqhEWvLwlQqtrpQJ1
	gYKjiw+ehHOiM=; b=Gt+LUgvCh6ZDo2EtVqDHlhjAilIh/U/gWUVZpcAb8lEc2w
	E7aXM2MCe4ADE87Uk2kbL52oRwPeu8EcEXMNSFFLZN8tz0+hjSZjNbAjIwYrf6Eg
	FYL7BaQQxsd0Cly4doc0Pb3HFx6FzQoA4KQ+feEculyi9Z8X6ZSsJwDZxMRDMRG1
	K65Ddt+VQsgMf3sKExzYrJz6CNu9urlfVEGenkhm/S+xEU2meZBgRurEXnef9HS9
	/jsVOP+0OI4vmC1MBlai6PJtARtFR45AHoL1GFLxw+72Y1Sf8zSZNUV2nsN5h/Iq
	HlDr1fjQCrra4aGuft5ijjuQJO3LeCLyU97XrqSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7c7g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Jan 2026 11:08:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60P7X79b031067;
	Sun, 25 Jan 2026 11:08:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8ds98a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Jan 2026 11:08:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60PB8jCt28377418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 11:08:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1E520040;
	Sun, 25 Jan 2026 11:08:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9916320043;
	Sun, 25 Jan 2026 11:08:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.25.236])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 25 Jan 2026 11:08:43 +0000 (GMT)
Date: Sun, 25 Jan 2026 16:38:38 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+e625b79bfdd66c067432@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in ext4_split_convert_extents
Message-ID: <aXX5tl7lvc-SdUKN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <69741ffa.050a0220.1a75db.0328.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69741ffa.050a0220.1a75db.0328.GAE@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EoND1-3UKybti6Iwq7_fP0gIgyXl9Q4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDA4OSBTYWx0ZWRfXwb172yPU/ZH0
 /K/Ml/U+sX7ipy7Smssys9jRW1J2AsfveJeYwYSyqt+zymWShungsmUkDjwLuHQcxv5tZQMEIin
 QrxKhq3eci85nBHbjKOk0TkDSIv8NsxKfL7ZWzrgVEAe/J2nETJJB7CbG3NyGMVZ1NIOOJaJLMe
 MwmVvLx4CAyxX+n1QgB2Vkv68UqP1wfm5ed3AaEYuT3tNOdLGwWlAmwRWiCHvJeHZw0R/of2pkP
 0hRXHMWT3uA0W/GftTqYn3feyooFgNx8HGV3wBHfxtZs8tRw6ZW9kfYwuOmkb5LdMYS2J+eKJJH
 78o1n48N0QLvUJYMMCW9h3yf3HC+3AadmSZtlezLgvbYjIKxOu8eA/8bN3/IZclNW4Nfbn11DbC
 P8JzPfYxmrOZ1O7QcaNWz8Rttu549x+IAqJOm0Pd6kN1meACB1K0xgqAbRmLQAfGbn6UdmpQsv/
 VHaFM0pCzdrS9dSfMGQ==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6975f9bf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8
 a=4RBUngkUAAAA:8 a=WOFrN-lx4AvMTsbw6dQA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22
 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-ORIG-GUID: EoND1-3UKybti6Iwq7_fP0gIgyXl9Q4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601250089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ee3bfbe9e319ed0c];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13296-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-ext4,e625b79bfdd66c067432];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: DECBB80285
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:27:22PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d08c85ac8894 Add linux-next specific files for 20260119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=171a1852580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ee3bfbe9e319ed0c
> dashboard link: https://syzkaller.appspot.com/bug?extid=e625b79bfdd66c067432
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121533fa580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bc7b9a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/94cfdbd8a0c9/disk-d08c85ac.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f7ec0695ac29/vmlinux-d08c85ac.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ddc8307e03e3/bzImage-d08c85ac.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/6ddc9a8efbb6/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14f96bfc580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e625b79bfdd66c067432@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: fs/ext4/extents.c:3486 at ext4_split_extent fs/ext4/extents.c:3485 [inline], CPU#1: kworker/u8:4/58
> WARNING: fs/ext4/extents.c:3486 at ext4_split_convert_extents+0x13c2/0x1a10 fs/ext4/extents.c:3839, CPU#1: kworker/u8:4/58
> Modules linked in:
> CPU: 1 UID: 0 PID: 58 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
> RIP: 0010:ext4_split_extent fs/ext4/extents.c:3485 [inline]
> RIP: 0010:ext4_split_convert_extents+0x13c2/0x1a10 fs/ext4/extents.c:3839
> Code: 4c 8b 44 24 38 e8 be 85 fe ff 40 b5 01 4c 8b 64 24 18 49 81 fc 00 f0 ff ff 0f 87 19 ff ff ff e9 4e f0 ff ff e8 3f 8f 4a ff 90 <0f> 0b 90 49 bf 00 00 00 00 00 fc ff df 44 8b 6c 24 04 4c 8b 64 24
> RSP: 0018:ffffc900015f7328 EFLAGS: 00010293
> RAX: ffffffff82768aa1 RBX: dffffc0000000001 RCX: ffff88801cb99e40
> RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000008
> RBP: 0000000000000008 R08: ffff88802ba1269f R09: 0000000000000000
> R10: ffff88802ba12690 R11: ffffed10057424d4 R12: 0000000000000010
> R13: ffff888073634d01 R14: 0000000000000010 R15: 0000000000000100
> FS:  0000000000000000(0000) GS:ffff888125cf2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000080 CR3: 000000000df3e000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ext4_convert_unwritten_extents_endio fs/ext4/extents.c:3915 [inline]
>  ext4_ext_handle_unwritten_extents fs/ext4/extents.c:3999 [inline]
>  ext4_ext_map_blocks+0xde4/0x5560 fs/ext4/extents.c:4336
>  ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
>  ext4_map_blocks+0x759/0x1170 fs/ext4/inode.c:809
>  ext4_convert_unwritten_extents+0x2a8/0x5d0 fs/ext4/extents.c:5038
>  ext4_convert_unwritten_io_end_vec+0xff/0x170 fs/ext4/extents.c:5078
>  ext4_end_io_end+0xc7/0x410 fs/ext4/page-io.c:200
>  ext4_do_flush_completed_IO fs/ext4/page-io.c:291 [inline]
>  ext4_end_io_rsv_work+0x262/0x330 fs/ext4/page-io.c:306
>  process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
>  process_scheduled_works kernel/workqueue.c:3362 [inline]
>  worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
>  kthread+0x389/0x480 kernel/kthread.c:467
>  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

Okay so I looked into this report. I see that it is not hitting in
lastest linux-next but only in commit d08c85ac8894 in linux-next.
Looking at the code, this commit has an older v2 of the patches which
had an issue where we were not updating orig_* variables in
ext4_split_extent() causing this WARN. This has been fixed in v3
onwards, which seems to be the version that the lastest linux-next has
hence we don't hit this anymore.

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


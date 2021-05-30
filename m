Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4764439527A
	for <lists+linux-ext4@lfdr.de>; Sun, 30 May 2021 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE3SaQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 14:30:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhE3SaQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 30 May 2021 14:30:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14UIElDU008804;
        Sun, 30 May 2021 14:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=IoFXVK2OhLkZU53V5T2um2Z4kemzqJATCsKITSQbrIQ=;
 b=nMyhSPjD+qXQ4THBKLalOOUveZugXP3xOEbuVM60NDRraOO9c2zpCNAFFtIGvariPoXS
 ecfFI3f9/EJ7GuBJS2WaZjZpMVuv18l8IjnWsejcPbjuiEkgrKLVpAkPjUgZajt4UG4T
 NITeKKxr0odDEFaTok4YIHmz8OMemKPlzHgZnc36bWfbhFXfHWMoFJVuNQ/DVt93xQDL
 pZvyg0b8L6pHjhSkOY//p2EFKY/9GzpozAYWwpkkSVvzEU10xGp8FD27BSvMaj6aV+O9
 MaAMgxL1BUpJymRLWLq0s0gDak+dPiDGE8om7ACCebGPKpmIagCGIkkwh3l5i6rJGP6H OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38vftg859m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 14:28:36 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14UIHcJS028255;
        Sun, 30 May 2021 14:28:36 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38vftg859b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 14:28:36 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14UISXSx013860;
        Sun, 30 May 2021 18:28:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 38ud888ag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 18:28:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14UISVPM13435336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 May 2021 18:28:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D35B11C050;
        Sun, 30 May 2021 18:28:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 090FF11C04A;
        Sun, 30 May 2021 18:28:31 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 May 2021 18:28:30 +0000 (GMT)
Date:   Sun, 30 May 2021 23:58:30 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: generic/475 failure/BUG on 5.13-rc3 running adv test case
Message-ID: <20210530182830.q2fz6gffkz6ljagg@riteshh-domain>
References: <20210527192418.GA2633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527192418.GA2633@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xK-77V8gH4eLCqvqNp7g3PkYmqS3Li5L
X-Proofpoint-GUID: MeBzWKkU0yuLYNE5QOzl4bvg5v9uYW_W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-30_09:2021-05-27,2021-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105300142
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/05/27 03:24PM, Eric Whitney wrote:
> As mentioned in today's concall I've seen generic/475 fail when a BUG was
> triggered in ext4_write_inline_data() while running the adv test case on
> a 5.13-rc3 kernel using kvm-xfstests.  This is not a regression in 5.13.
> I had a similar failure in 5.11-rc2, but did not recognize it as a panic
> at the time.
>
> More commonly, generic/475 can also fail with a report of an inconsistent file
> system and without a panic when run in the adv test case.  The failure
> frequency in that case is around 10%, while the frequency for the panic is
> 5% or less.
>
> I've included the tail end of the log output for a test failure including
> the panic below.
>
> Eric
>
>
> [ 1278.314136] EXT4-fs (dm-0): I/O error while writing superblock
> [ 1278.317088] Buffer I/O error on device dm-0, logical block 1282347
> [ 1278.317103] Buffer I/O error on device dm-0, logical block 1282348
> [ 1278.317112] Buffer I/O error on device dm-0, logical block 1282349
> [ 1278.347706] EXT4-fs error (device dm-0): ext4_journal_check_start:83: comm kworker/u4:3: Detected aborted journal
> [ 1278.360776] EXT4-fs error (device dm-0): ext4_journal_check_start:83: comm fsstress: Detected aborted journal
> [ 1278.370282] EXT4-fs error (device dm-0) in ext4_cross_rename:4241: Journal has aborted
> [ 1278.378709] EXT4-fs error (device dm-0): ext4_journal_check_start:83: comm fsstress: Detected aborted journal
> [ 1278.396981] EXT4-fs (dm-0): I/O error while writing superblock
> [ 1278.397037] EXT4-fs (dm-0): previous I/O error to superblock detected
> [ 1278.400830] EXT4-fs (dm-0): I/O error while writing superblock
> [ 1278.408834] EXT4-fs (dm-0): Remounting filesystem read-only
> [ 1278.413307] EXT4-fs (dm-0): I/O error while writing superblock
> [ 1278.413631] EXT4-fs (dm-0): I/O error while writing superblock
> [ 1278.418293] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:216: comm fsstress: Error while async write back metadata
> [ 1278.422415] EXT4-fs (dm-0): ext4_writepages: jbd2_start: 2048 pages, ino 6750; err -30
> [ 1278.432080] ------------[ cut here ]------------
> [ 1278.441356] kernel BUG at fs/ext4/inline.c:221!

From the initial looks of it, it looks to be a error not handeled properly in
ext4_restore_inline_data().

So
ext4_restore_inline_data()
	-> ext4_create_inline_data()
			-> ext4_journal_get_write_access() this may return an error since
			journal is aborted. (-30 EROFS).
	-> ext4_write_inline_data()
			-> BUG_ON(!EXT4_I(inode)->i_inline_off); we hit this.

I guess one of the problem is that we never check for return value from
ext4_create_inline_data() before calling ext4_write_inline_data() and hence
hit the BUG_ON(). But I will have to look deeper into this path to understand,
if we aren't missing anything else.

As for the regression, this issue seems to be present at the base patch itself.
So doesn't look like a regression.

-ritesh


> [ 1278.444944] invalid opcode: 0000 [#1] SMP
> [ 1278.448312] CPU: 1 PID: 29573 Comm: fsstress Not tainted 5.13.0-rc3 #1
> [ 1278.453230] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 1278.458065] RIP: 0010:ext4_write_inline_data+0xe4/0xf0
> [ 1278.462708] Code: 02 48 44 89 e2 48 01 df 5b 5d 4c 01 ef 41 5c 41 5d 41 5e 41 5f e9 fc 71 62 00 41 be 3c 00 00 00 45 8d 64 18 c4 41 29 de eb 93 <0f> 0b 0f 0b c3 0f 1f 80 00 00 00 00 0f 0b 66 66 2e 0f 1f 84 00 00
> [ 1278.487953] RSP: 0018:ffffc90006097c80 EFLAGS: 00010246
> [ 1278.492630] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
> [ 1278.498757] RDX: ffff88800477a980 RSI: ffffc90006097d30 RDI: ffff8880053673b8
> [ 1278.502877] RBP: ffff8880053673b8 R08: 0000000000000080 R09: 0000000000000001
> [ 1278.507664] R10: 0000000000000001 R11: 0000000000009923 R12: 0000000000000080
> [ 1278.512372] R13: 0000000000000080 R14: ffff8880053673b8 R15: 00000000ffffffe2
> [ 1278.516188] FS:  00007f67de588740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> [ 1278.521909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1278.531919] CR2: 00007fc369d9d000 CR3: 0000000009452006 CR4: 0000000000370ee0
> [ 1278.542735] Call Trace:
> [ 1278.545379]  ext4_convert_inline_data_nolock+0x14d/0x470
> [ 1278.549916]  ext4_try_add_inline_entry+0x18a/0x280
> [ 1278.553248]  ext4_add_entry+0xd6/0x4c0
> [ 1278.555691]  ext4_add_nondir+0x2b/0xc0
> [ 1278.558644]  ext4_symlink+0x363/0x3d0
> [ 1278.561931]  vfs_symlink+0x113/0x1b0
> [ 1278.564528]  do_symlinkat+0xe9/0x100
> [ 1278.566882]  do_syscall_64+0x3c/0x80
> [ 1278.569255]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1278.572835] RIP: 0033:0x7f67de676f07
> [ 1278.575582] Code: f0 ff ff 73 01 c3 48 8b 0d 86 ef 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 ef 0c 00 f7 d8 64 89 01 48
> [ 1278.587693] RSP: 002b:00007ffe259c92a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
> [ 1278.593152] RAX: ffffffffffffffda RBX: 0000000000000bbc RCX: 00007f67de676f07
> [ 1278.597826] RDX: 0000000000000064 RSI: 0000558fe5501530 RDI: 0000558fe5581380
> [ 1278.601987] RBP: 0000558fe5581380 R08: 0000000000000000 R09: 0000558fe5581f40
> [ 1278.606045] R10: 0000558fe5500010 R11: 0000000000000206 R12: 0000558fe5501530
> [ 1278.610155] R13: 00007ffe259c9410 R14: 0000558fe5581380 R15: 0000558fe4102430
> [ 1278.614037] Modules linked in:
> [ 1278.615599] ---[ end trace 800a8a9ba6a92f53 ]---
> [ 1278.618318] RIP: 0010:ext4_write_inline_data+0xe4/0xf0
> [ 1278.622018] Code: 02 48 44 89 e2 48 01 df 5b 5d 4c 01 ef 41 5c 41 5d 41 5e 41 5f e9 fc 71 62 00 41 be 3c 00 00 00 45 8d 64 18 c4 41 29 de eb 93 <0f> 0b 0f 0b c3 0f 1f 80 00 00 00 00 0f 0b 66 66 2e 0f 1f 84 00 00
> [ 1278.635759] RSP: 0018:ffffc90006097c80 EFLAGS: 00010246
> [ 1278.640398] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
> [ 1278.652894] RDX: ffff88800477a980 RSI: ffffc90006097d30 RDI: ffff8880053673b8
> [ 1278.663327] RBP: ffff8880053673b8 R08: 0000000000000080 R09: 0000000000000001
> [ 1278.670265] R10: 0000000000000001 R11: 0000000000009923 R12: 0000000000000080
> [ 1278.676285] R13: 0000000000000080 R14: ffff8880053673b8 R15: 00000000ffffffe2
> [ 1278.681777] FS:  00007f67de588740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> [ 1278.687522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1278.690965] CR2: 00007fc369d9d000 CR3: 0000000009452006 CR4: 0000000000370ee0
> [ 1278.695776] EXT4-fs (dm-0): I/O error while writing superblock
> [failed, exit status 1] [16:55:27]- output mismatch (see /results/ext4/results-adv/generic/475.out.bad)
>     --- tests/generic/475.out	2021-04-13 03:49:18.000000000 +0000
>     +++ /results/ext4/results-adv/generic/475.out.bad	2021-05-27 16:55:27.152702989 +0000
>     @@ -1,2 +1,6 @@
>      QA output created by 475
>      Silence is golden.
>     +umount: /vdc: target is busy.
>     +unmount failed
>     +(see /results/ext4/results-adv/generic/475.full for details)
>     +umount: /vdc: target is busy.
>

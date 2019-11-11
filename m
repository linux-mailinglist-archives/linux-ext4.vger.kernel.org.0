Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A58F6DBD
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 06:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKFMp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Nov 2019 00:12:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfKKFMp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Nov 2019 00:12:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB57Mxc122687
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2019 00:12:44 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w6v2v8r47-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2019 00:12:43 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 11 Nov 2019 05:12:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Nov 2019 05:12:38 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAB5CbY441091232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:12:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9211311C04C;
        Mon, 11 Nov 2019 05:12:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2717D11C05B;
        Mon, 11 Nov 2019 05:12:36 +0000 (GMT)
Received: from [9.199.159.197] (unknown [9.199.159.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 05:12:35 +0000 (GMT)
Subject: Re: general protection fault in ext4_writepages
To:     syzbot <syzbot+9567fda428fba259deba@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, Jan Kara <jack@suse.cz>
References: <00000000000073d3a70597069799@google.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 11 Nov 2019 10:42:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <00000000000073d3a70597069799@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111105-4275-0000-0000-0000037C9E12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111105-4276-0000-0000-0000388FF600
Message-Id: <20191111051236.2717D11C05B@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110049
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ted,

This issue seems to be coming via fault injection failure in slab
allocation. This should be fixed via below patch on your latest ext4
branch.

https://marc.info/?l=linux-ext4&m=804&w=2

Please let me know if anything else is needed.

-ritesh

On 11/11/19 5:14 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    dcd34bd2 Add linux-next specific files for 20191106
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a0a4fce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=9567fda428fba259deba
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1645c42ce00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1108a23ae00000
> 
> The bug was bisected to:
> 
> commit c8cc88163f40df39e50cda63ac361631864b453e
> Author: Ritesh Harjani <riteshh@linux.ibm.com>
> Date:   Wed Oct 16 07:37:10 2019 +0000
> 
>      ext4: Add support for blocksize < pagesize in dioread_nolock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1044c6b4e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1244c6b4e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1444c6b4e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9567fda428fba259deba@syzkaller.appspotmail.com
> Fixes: c8cc88163f40 ("ext4: Add support for blocksize < pagesize in 
> dioread_nolock")
> 
> RDX: 0000000000000000 RSI: 0000000100000003 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 00007fffd7a50033
> R10: 0000000028120001 R11: 0000000000000246 R12: 0000000000401ef0
> R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8639 Comm: syz-executor031 Not tainted 
> 5.4.0-rc6-next-20191106 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
> Google 01/01/2011
> RIP: 0010:mpage_map_and_submit_extent fs/ext4/inode.c:2557 [inline]
> RIP: 0010:ext4_writepages+0x17b4/0x2e80 fs/ext4/inode.c:2911
> Code: ff ff e8 1f cf b0 ff 48 8b 85 30 fe ff ff 48 8b 8d 00 fe ff ff 48 
> 8d 78 10 48 89 fa 48 c1 ea 03 0f b6 89 c2 00 00 00 48 d3 e3 <42> 80 3c 
> 2a 00 0f 85 03 16 00 00 48 89 58 10 48 c7 c0 08 ad c4 89
> RSP: 0018:ffff88808bf77890 EFLAGS: 00010206
> RAX: fffffffffffffff4 RBX: 00000000007ff000 RCX: 000000000000000c
> RDX: 0000000000000000 RSI: ffffffff820534cd RDI: 0000000000000004
> RBP: ffff88808bf77ac0 R08: 0000000000000000 R09: ffffed1015d06b7d
> R10: ffffed1015d06b7c R11: ffff8880ae835be3 R12: 0000000000000000
> R13: dffffc0000000000 R14: 00000000000007ff R15: ffff888086499488
> FS:  0000000001162880(0000) GS:ffff8880ae800000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000009366b000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   ? 0xffffffff81000000
>   do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
>   __filemap_fdatawrite_range+0x2bc/0x3b0 mm/filemap.c:421
>   filemap_write_and_wait_range mm/filemap.c:681 [inline]
>   filemap_write_and_wait_range+0xfc/0x1d0 mm/filemap.c:675
>   ext4_punch_hole+0x27d/0x1320 fs/ext4/inode.c:4314
>   ext4_fallocate+0x419/0x2470 fs/ext4/extents.c:4889
>   vfs_fallocate+0x4aa/0xa50 fs/open.c:309
>   ksys_fallocate+0x58/0xa0 fs/open.c:332
>   __do_sys_fallocate fs/open.c:340 [inline]
>   __se_sys_fallocate fs/open.c:338 [inline]
>   __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
>   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440609
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
> f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fffd7a50c58 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> RAX: ffffffffffffffda RBX: 00007fffd7a50c60 RCX: 0000000000440609
> RDX: 0000000000000000 RSI: 0000000100000003 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 00007fffd7a50033
> R10: 0000000028120001 R11: 0000000000000246 R12: 0000000000401ef0
> R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 0ee46d2ea32148f5 ]---
> RIP: 0010:mpage_map_and_submit_extent fs/ext4/inode.c:2557 [inline]
> RIP: 0010:ext4_writepages+0x17b4/0x2e80 fs/ext4/inode.c:2911
> Code: ff ff e8 1f cf b0 ff 48 8b 85 30 fe ff ff 48 8b 8d 00 fe ff ff 48 
> 8d 78 10 48 89 fa 48 c1 ea 03 0f b6 89 c2 00 00 00 48 d3 e3 <42> 80 3c 
> 2a 00 0f 85 03 16 00 00 48 89 58 10 48 c7 c0 08 ad c4 89
> RSP: 0018:ffff88808bf77890 EFLAGS: 00010206
> RAX: fffffffffffffff4 RBX: 00000000007ff000 RCX: 000000000000000c
> RDX: 0000000000000000 RSI: ffffffff820534cd RDI: 0000000000000004
> RBP: ffff88808bf77ac0 R08: 0000000000000000 R09: ffffed1015d06b7d
> R10: ffffed1015d06b7c R11: ffff8880ae835be3 R12: 0000000000000000
> R13: dffffc0000000000 R14: 00000000000007ff R15: ffff888086499488
> FS:  0000000001162880(0000) GS:ffff8880ae800000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000009366b000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches


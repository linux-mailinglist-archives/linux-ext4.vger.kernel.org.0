Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D108425584F
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgH1KIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 06:08:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgH1KH6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 06:07:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FEA4AC5E;
        Fri, 28 Aug 2020 10:08:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 050C21E12C0; Fri, 28 Aug 2020 12:07:56 +0200 (CEST)
Date:   Fri, 28 Aug 2020 12:07:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, linux-mm@kvack.org
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
Message-ID: <20200828100755.GG7072@quack2.suse.cz>
References: <000000000000d3a33205add2f7b2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d3a33205add2f7b2@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-08-20 19:48:16, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f83cb6900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3622cea378100f45d59f
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287ac96900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c7ac46900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inode.c:2598!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 27612 Comm: syz-executor879 Not tainted 5.9.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:mpage_prepare_extent_to_map+0xd34/0xd40 fs/ext4/inode.c:2598

Doh, so this is:

                        wait_on_page_writeback(page);
>>>                     BUG_ON(PageWriteback(page));

in mpage_prepare_extent_to_map(). So we have PageWriteback() page after we
have called wait_on_page_writeback() on a locked page. Not sure how this
could ever happen even less how ext4 could cause this...

Anyway, syzbot has found a reproducer so I'll try if it reproduces in my
KVM...

								Honza


> Code: 89 e8 a0 74 9f ff 0f 0b e8 59 81 70 ff 4c 89 e7 48 c7 c6 da a3 07 89 e8 8a 74 9f ff 0f 0b e8 43 81 70 ff 0f 0b e8 3c 81 70 ff <0f> 0b e8 c5 b3 25 06 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53
> RSP: 0018:ffffc9000a0974d8 EFLAGS: 00010293
> RAX: ffffffff820476e4 RBX: 00fffe000000a01f RCX: ffff88808ea5c340
> RDX: 0000000000000000 RSI: 000000000000a01f RDI: 000000000000ffff
> RBP: ffffea00020d4f80 R08: ffffffff820471e4 R09: fffff9400041a9f1
> R10: fffff9400041a9f1 R11: 0000000000000000 R12: ffffea00020d4f80
> R13: ffffc9000a0977b0 R14: 1ffffd400041a9f1 R15: dffffc0000000000
> FS:  00007f5055f25700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004ae4b0 CR3: 00000000a2d7f000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ext4_writepages+0xa98/0x3750 fs/ext4/inode.c:2735
>  do_writepages+0xda/0x1f0 mm/page-writeback.c:2352
>  __filemap_fdatawrite_range+0x2a5/0x350 mm/filemap.c:422
>  filemap_write_and_wait_range+0xca/0x160 mm/filemap.c:655
>  iomap_dio_rw+0x5a7/0xeb0 fs/iomap/direct-io.c:478
>  ext4_dio_read_iter fs/ext4/file.c:77 [inline]
>  ext4_file_read_iter+0x544/0x6d0 fs/ext4/file.c:129
>  call_read_iter include/linux/fs.h:1876 [inline]
>  generic_file_splice_read+0x3c5/0x640 fs/splice.c:312
>  do_splice_to fs/splice.c:870 [inline]
>  splice_direct_to_actor+0x3bd/0xb60 fs/splice.c:950
>  do_splice_direct+0x201/0x340 fs/splice.c:1059
>  do_sendfile+0x86d/0x1210 fs/read_write.c:1540
>  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
>  __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1587
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x448bc9
> Code: e8 1c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f5055f24ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00000000006e4a28 RCX: 0000000000448bc9
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
> RBP: 00000000006e4a20 R08: 0000000000000000 R09: 0000000000000000
> R10: 00008400fffffffb R11: 0000000000000246 R12: 00000000006e4a2c
> R13: 00007ffdc73a76df R14: 00007f5055f259c0 R15: 20c49ba5e353f7cf
> Modules linked in:
> ---[ end trace aba5fca59eda2183 ]---
> RIP: 0010:mpage_prepare_extent_to_map+0xd34/0xd40 fs/ext4/inode.c:2598
> Code: 89 e8 a0 74 9f ff 0f 0b e8 59 81 70 ff 4c 89 e7 48 c7 c6 da a3 07 89 e8 8a 74 9f ff 0f 0b e8 43 81 70 ff 0f 0b e8 3c 81 70 ff <0f> 0b e8 c5 b3 25 06 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53
> RSP: 0018:ffffc9000a0974d8 EFLAGS: 00010293
> RAX: ffffffff820476e4 RBX: 00fffe000000a01f RCX: ffff88808ea5c340
> RDX: 0000000000000000 RSI: 000000000000a01f RDI: 000000000000ffff
> RBP: ffffea00020d4f80 R08: ffffffff820471e4 R09: fffff9400041a9f1
> R10: fffff9400041a9f1 R11: 0000000000000000 R12: ffffea00020d4f80
> R13: ffffc9000a0977b0 R14: 1ffffd400041a9f1 R15: dffffc0000000000
> FS:  00007f5055f25700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004ae4b0 CR3: 00000000a2d7f000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

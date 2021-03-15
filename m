Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42C233C350
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhCORGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:06:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:55704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234218AbhCORGE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 15 Mar 2021 13:06:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88768AED6;
        Mon, 15 Mar 2021 17:06:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 433B71F2BC9; Mon, 15 Mar 2021 18:06:01 +0100 (CET)
Date:   Mon, 15 Mar 2021 18:06:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+628472a2aac693ab0fcd@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] WARNING: ODEBUG bug in ext4_fill_super (3)
Message-ID: <20210315170601.GF3227@quack2.suse.cz>
References: <000000000000477fa305bd774858@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000477fa305bd774858@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 13-03-21 20:08:14, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    28806e4d Merge tag 'media/v5.12-2' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136d1bbcd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6bcf96204c1b8e77
> dashboard link: https://syzkaller.appspot.com/bug?extid=628472a2aac693ab0fcd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1133abfad00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1191aab2d00000
> 
> The issue was bisected to:
> 
> commit 2d01ddc86606564fb08c56e3bc93a0693895f710
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Dec 16 10:18:40 2020 +0000
> 
>     ext4: save error info to sb through journal if available

After some head scratching I think [1] should fix the problem.

[1] https://lore.kernel.org/linux-ext4/20210315165906.2175-1-jack@suse.cz

								Honza

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152b9d56d00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=172b9d56d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=132b9d56d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+628472a2aac693ab0fcd@syzkaller.appspotmail.com
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> 
> ODEBUG: free active (active state 0) object type: timer_list hint: print_daily_error_info+0x0/0x1f0 fs/ext4/super.c:1334
> WARNING: CPU: 1 PID: 12723 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
> Modules linked in:
> CPU: 0 PID: 12723 Comm: syz-executor932 Not tainted 5.12.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
> Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd a0 06 c2 89 4c 89 ee 48 c7 c7 a0 fa c1 89 e8 fc 41 f8 04 <0f> 0b 83 05 05 7e fb 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffffc9000e6ef980 EFLAGS: 00010286
> 
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> RDX: ffff88801d5e9bc0 RSI: ffffffff815c0d25 RDI: fffff52001cddf22
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815b9abe R11: 0000000000000000 R12: ffffffff896d7da0
> R13: ffffffff89c200e0 R14: ffffffff81629d00 R15: dffffc0000000000
> FS:  0000000000f93300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcda3ec0000 CR3: 00000000155a1000 CR4: 0000000000350ef0
> Call Trace:
>  __debug_check_no_obj_freed lib/debugobjects.c:987 [inline]
>  debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1018
>  slab_free_hook mm/slub.c:1554 [inline]
>  slab_free_freelist_hook+0x147/0x210 mm/slub.c:1600
>  slab_free mm/slub.c:3161 [inline]
>  kfree+0xe5/0x7f0 mm/slub.c:4213
>  ext4_fill_super+0x84f/0xded0 fs/ext4/super.c:5182
>  mount_bdev+0x34d/0x410 fs/super.c:1367
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:2903 [inline]
>  path_mount+0x132a/0x1f90 fs/namespace.c:3233
>  do_mount fs/namespace.c:3246 [inline]
>  __do_sys_mount fs/namespace.c:3454 [inline]
>  __se_sys_mount fs/namespace.c:3431 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x445c0a
> Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe8bf4c3b8 EFLAGS: 00000202
>  ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffe8bf4c410 RCX: 0000000000445c0a
> RDX: 0000000020000040 RSI: 0000000020000100 RDI: 00007ffe8bf4c3d0
> RBP: 00007ffe8bf4c3d0 R08: 00007ffe8bf4c410 R09: 0000000000000000
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

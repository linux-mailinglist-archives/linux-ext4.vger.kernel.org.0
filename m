Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092192E09CB
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgLVLfW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 06:35:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:47948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgLVLfV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Dec 2020 06:35:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17CD8ACF1;
        Tue, 22 Dec 2020 11:34:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E2B51E1364; Tue, 22 Dec 2020 12:28:53 +0100 (CET)
Date:   Tue, 22 Dec 2020 12:28:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+9043030c040ce1849a60@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: general protection fault in ext4_commit_super
Message-ID: <20201222112853.GF13601@quack2.suse.cz>
References: <0000000000001faff305b709b8ad@google.com>
 <20201222100908.1782-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20201222100908.1782-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 22-12-20 18:09:08, Hillf Danton wrote:
> Tue, 22 Dec 2020 00:54:15 -0800
> > syzbot found the following issue on:
> > 
> > HEAD commit:    0d52778b Add linux-next specific files for 20201218
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b4aecb500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c81cc44aa25b5b3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9043030c040ce1849a60
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17983487500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c02937500000
> > 
> > The issue was bisected to:
> > 
> > commit e810c942a325cf749e859d7aa3a43dc219cea299
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Dec 16 10:18:40 2020 +0000
> > 
> >     ext4: save error info to sb through journal if available
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1282f137500000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1182f137500000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1682f137500000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9043030c040ce1849a60@syzkaller.appspotmail.com
> > Fixes: e810c942a325 ("ext4: save error info to sb through journal if available")
> > 
> > general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
> > CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.10.0-next-20201218-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events flush_stashed_error_work
> > RIP: 0010:ext4_commit_super+0x52/0x510 fs/ext4/super.c:5548
> > Code: 48 c1 ea 03 80 3c 02 00 0f 85 21 04 00 00 48 8b 9d 78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f1 03 00 00 48 8b 5b 60 48 85 db 0f 84 13 01 00
> > RSP: 0018:ffffc90000cc7cb8 EFLAGS: 00010206
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 000000000000000c RSI: ffffffff8217a0db RDI: 0000000000000060
> > RBP: ffff88802441c000 R08: 0000000000000000 R09: 0000000000000000
> > R10: ffffffff8217a7fa R11: 0000000000000000 R12: ffff88802441c000
> > R13: ffff88802441c678 R14: ffff8880109a5a00 R15: ffff8880b9c34440
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000400200 CR3: 0000000014038000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  flush_stashed_error_work+0x1c9/0x2a0 fs/ext4/super.c:727
> >  process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
> >  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
> >  kthread+0x3b1/0x4a0 kernel/kthread.c:292
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Fix e810c942a325 ("ext4: save error info to sb through journal if available")
> by flushing work as part of rollback.

Thanks for having a look. I don't think the fix is quite correct though. The
flush_work() should be at failed_mount3: label. So something like attached
fixup. Ted, can you please fold it into the buggy commit?

								Honza

> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5171,6 +5171,7 @@ out_fail:
>  	sb->s_fs_info = NULL;
>  	kfree(sbi->s_blockgroup_lock);
>  out_free_base:
> +	flush_work(&sbi->s_error_work);
>  	kfree(sbi);
>  	kfree(orig_data);
>  	fs_put_dax(dax_dev);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--XMCwj5IQnwKtuyBG
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fixup-error-handling-on-sb-load.patch"

From b3f87141c5944d4dba8e462e1c9ce0c723434fbb Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 22 Dec 2020 12:26:26 +0100
Subject: [PATCH] Fixup error handling on sb load

Reported-by: syzbot+9043030c040ce1849a60@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 502ae491d07d..c2311978f9b0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5142,6 +5142,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_es_unregister_shrinker(sbi);
 failed_mount3:
 	del_timer_sync(&sbi->s_err_report);
+	flush_work(&sbi->s_error_work);
 	if (sbi->s_mmp_tsk)
 		kthread_stop(sbi->s_mmp_tsk);
 failed_mount2:
-- 
2.16.4


--XMCwj5IQnwKtuyBG--

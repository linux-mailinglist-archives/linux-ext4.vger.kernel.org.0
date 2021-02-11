Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26214318A27
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 13:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhBKMNS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 07:13:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:33404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhBKMLJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 07:11:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C65DAAD29;
        Thu, 11 Feb 2021 12:10:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 795A31E14B2; Thu, 11 Feb 2021 13:10:20 +0100 (CET)
Date:   Thu, 11 Feb 2021 13:10:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.cz>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <20210211121020.GO19070@quack2.suse.cz>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
 <CACT4Y+b5gSAAtX3DUf-H3aRxbir44MTO6BCC3XYvN=6DniT+jw@mail.gmail.com>
 <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 12:28:48, Dmitry Vyukov wrote:
> On Thu, Feb 11, 2021 at 12:22 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Feb 11, 2021 at 11:49 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello,
> > >
> > > added mm guys to CC.
> > >
> > > On Wed 10-02-21 05:35:18, syzbot wrote:
> > > > HEAD commit:    1e0d27fc Merge branch 'akpm' (patches from Andrew)
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15cbce90d00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=bd1f72220b2e57eb
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=bfdded10ab7dcd7507ae
> > > > userspace arch: i386
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com
> > > >
> > > > ======================================================
> > > > WARNING: possible circular locking dependency detected
> > > > 5.11.0-rc6-syzkaller #0 Not tainted
> > > > ------------------------------------------------------
> > > > kswapd0/2246 is trying to acquire lock:
> > > > ffff888041a988e0 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf81/0x1380 fs/jbd2/transaction.c:444
> > > >
> > > > but task is already holding lock:
> > > > ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
> > > >
> > > > which lock already depends on the new lock.
> > > >
> > > > the existing dependency chain (in reverse order) is:
> > > >
> > > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > > >        __fs_reclaim_acquire mm/page_alloc.c:4326 [inline]
> > > >        fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
> > > >        might_alloc include/linux/sched/mm.h:193 [inline]
> > > >        slab_pre_alloc_hook mm/slab.h:493 [inline]
> > > >        slab_alloc_node mm/slub.c:2817 [inline]
> > > >        __kmalloc_node+0x5f/0x430 mm/slub.c:4015
> > > >        kmalloc_node include/linux/slab.h:575 [inline]
> > > >        kvmalloc_node+0x61/0xf0 mm/util.c:587
> > > >        kvmalloc include/linux/mm.h:781 [inline]
> > > >        ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
> > > >        ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
> > > >        ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
> > > >        ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
> > > >        ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
> > > >        ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
> > > >        ext4_xattr_user_set+0xbc/0x100 fs/ext4/xattr_user.c:40
> > > >        __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
> > > >        __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
> > > >        __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
> > > >        vfs_setxattr+0x135/0x320 fs/xattr.c:291
> > > >        setxattr+0x1ff/0x290 fs/xattr.c:553
> > > >        path_setxattr+0x170/0x190 fs/xattr.c:572
> > > >        __do_sys_setxattr fs/xattr.c:587 [inline]
> > > >        __se_sys_setxattr fs/xattr.c:583 [inline]
> > > >        __ia32_sys_setxattr+0xbc/0x150 fs/xattr.c:583
> > > >        do_syscall_32_irqs_on arch/x86/entry/common.c:77 [inline]
> > > >        __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:139
> > > >        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:164
> > > >        entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > >
> > > This stacktrace should never happen. ext4_xattr_set() starts a transaction.
> > > That internally goes through start_this_handle() which calls:
> > >
> > >         handle->saved_alloc_context = memalloc_nofs_save();
> > >
> > > and we restore the allocation context only in stop_this_handle() when
> > > stopping the handle. And with this fs_reclaim_acquire() should remove
> > > __GFP_FS from the mask and not call __fs_reclaim_acquire().
> > >
> > > Now I have no idea why something here didn't work out. Given we don't have
> > > a reproducer it will be probably difficult to debug this. I'd note that
> > > about year and half ago similar report happened (got autoclosed) so it may
> > > be something real somewhere but it may also be just some HW glitch or
> > > something like that.
> >
> > HW glitch is theoretically possible. But if we are considering such
> > causes, I would say a kernel memory corruption is way more likely, we
> > have hundreds of known memory-corruption-capable bugs open. In most
> > cases they are caught by KASAN before doing silent damage. But KASAN
> > can miss some cases.
> >
> > I see at least 4 existing bugs with similar stack:
> > https://syzkaller.appspot.com/bug?extid=bfdded10ab7dcd7507ae
> > https://syzkaller.appspot.com/bug?extid=a7ab8df042baaf42ae3c
> > https://syzkaller.appspot.com/bug?id=c814a55a728493959328551c769ede4c8ff72aab
> > https://syzkaller.appspot.com/bug?id=426ad9adca053dafcd698f3a48ad5406dccc972b
> >
> > All in all, I would not assume it's a memory corruption. When we had
> > bugs that actually caused silent memory corruption, that caused a
> > spike of random one-time crashes all over the kernel. This does not
> > look like it.
> 
> I wonder if memalloc_nofs_save (or any other manipulation of
> current->flags) could have been invoked from interrupt context? I
> think it could cause the failure mode we observe (extremely rare
> disappearing flags). It may be useful to add a check for task context
> there.

That's an interesting idea. I'm not sure if anything does manipulate
current->flags from inside an interrupt (definitely memalloc_nofs_save()
doesn't seem to be) but I'd think that in fully preemtible kernel,
scheduler could preempt the task inside memalloc_nofs_save() and the
current->flags manipulation could also clash with a manipulation of these
flags by the scheduler if there's any?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9CD31BB12
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Feb 2021 15:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBOOaU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Feb 2021 09:30:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:42140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBOOaS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 15 Feb 2021 09:30:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4E2BB1AC;
        Mon, 15 Feb 2021 14:29:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8D22C1E6305; Mon, 15 Feb 2021 15:29:35 +0100 (CET)
Date:   Mon, 15 Feb 2021 15:29:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, mhocko@suse.cz, linux-mm@kvack.org,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <20210215142935.GB22417@quack2.suse.cz>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
 <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
 <20210215124519.GA22417@quack2.suse.cz>
 <aaee5d61-f988-84c3-4d16-f8b7987f3a83@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaee5d61-f988-84c3-4d16-f8b7987f3a83@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 15-02-21 23:06:15, Tetsuo Handa wrote:
> On 2021/02/15 21:45, Jan Kara wrote:
> > On Sat 13-02-21 23:26:37, Tetsuo Handa wrote:
> >> Excuse me, but it seems to me that nothing prevents
> >> ext4_xattr_set_handle() from reaching ext4_xattr_inode_lookup_create()
> >> without memalloc_nofs_save() when hitting ext4_get_nojournal() path.
> >> Will you explain when ext4_get_nojournal() path is executed?
> > 
> > That's a good question but sadly I don't think that's it.
> > ext4_get_nojournal() is called when the filesystem is created without a
> > journal. In that case we also don't acquire jbd2_handle lockdep map. In the
> > syzbot report we can see:
> 
> Since syzbot can test filesystem images, syzbot might have tested a filesystem
> image created both with and without journal within this boot.

a) I think that syzbot reboots the VM between executing different tests to
get reproducible conditions. But in theory I agree the test may have
contained one image with and one image without a journal.

*but*

b) as I wrote in the email you are replying to, the jbd2_handle key is
private per filesystem. Thus for lockdep to complain about
jbd2_handle->fs_reclaim->jbd2_handle deadlock, those jbd2_handle lockdep
maps must come from the same filesystem.

*and*

c) filesystem without journal doesn't use jbd2_handle lockdep map at all so
for such filesystems lockdep creates no dependency for jbd2_handle map.

								Honza

> 
> > 
> > kswapd0/2246 is trying to acquire lock:
> > ffff888041a988e0 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf81/0x1380 fs/jbd2/transaction.c:444
> > 
> > but task is already holding lock:
> > ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
> > 
> > So this filesystem has very clearly been created with a journal. Also the
> > journal lockdep tracking machinery uses:
> 
> While locks held by kswapd0/2246 are fs_reclaim, shrinker_rwsem, &type->s_umount_key#38
> and jbd2_handle, isn't the dependency lockdep considers problematic is
> 
>   Chain exists of:
>     jbd2_handle --> &ei->xattr_sem --> fs_reclaim
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(fs_reclaim);
>                                  lock(&ei->xattr_sem);
>                                  lock(fs_reclaim);
>     lock(jbd2_handle);
> 
> where CPU0 is kswapd/2246 and CPU1 is the case of ext4_get_nojournal() path?
> If someone has taken jbd2_handle and &ei->xattr_sem in this order, isn't this
> dependency true?
> 
> > 
> > rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
> > 
> > so a lockdep key is per-filesystem. Thus it is not possible that lockdep
> > would combine lock dependencies from two different filesystems.
> > 
> > But I guess we could narrow the search for this problem by adding WARN_ONs
> > to ext4_xattr_set_handle() and ext4_xattr_inode_lookup_create() like:
> > 
> > WARN_ON(ext4_handle_valid(handle) && !(current->flags & PF_MEMALLOC_NOFS));
> > 
> > It would narrow down a place in which PF_MEMALLOC_NOFS flag isn't set
> > properly... At least that seems like the most plausible way forward to me.
> 
> You can use CONFIG_DEBUG_AID_FOR_SYZBOT for adding such WARN_ONs on linux-next.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

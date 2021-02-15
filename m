Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD68431B995
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Feb 2021 13:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBOMqG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Feb 2021 07:46:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:41286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhBOMqC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 15 Feb 2021 07:46:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7449CAC32;
        Mon, 15 Feb 2021 12:45:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ECF951E6305; Mon, 15 Feb 2021 13:45:19 +0100 (CET)
Date:   Mon, 15 Feb 2021 13:45:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, mhocko@suse.cz, linux-mm@kvack.org,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <20210215124519.GA22417@quack2.suse.cz>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
 <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 13-02-21 23:26:37, Tetsuo Handa wrote:
> On 2021/02/11 19:49, Jan Kara wrote:
> > This stacktrace should never happen. ext4_xattr_set() starts a transaction.
> > That internally goes through start_this_handle() which calls:
> > 
> > 	handle->saved_alloc_context = memalloc_nofs_save();
> > 
> > and we restore the allocation context only in stop_this_handle() when
> > stopping the handle. And with this fs_reclaim_acquire() should remove
> > __GFP_FS from the mask and not call __fs_reclaim_acquire().
> 
> Excuse me, but it seems to me that nothing prevents
> ext4_xattr_set_handle() from reaching ext4_xattr_inode_lookup_create()
> without memalloc_nofs_save() when hitting ext4_get_nojournal() path.
> Will you explain when ext4_get_nojournal() path is executed?

That's a good question but sadly I don't think that's it.
ext4_get_nojournal() is called when the filesystem is created without a
journal. In that case we also don't acquire jbd2_handle lockdep map. In the
syzbot report we can see:

kswapd0/2246 is trying to acquire lock:
ffff888041a988e0 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf81/0x1380 fs/jbd2/transaction.c:444

but task is already holding lock:
ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195

So this filesystem has very clearly been created with a journal. Also the
journal lockdep tracking machinery uses:

rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);

so a lockdep key is per-filesystem. Thus it is not possible that lockdep
would combine lock dependencies from two different filesystems.

But I guess we could narrow the search for this problem by adding WARN_ONs
to ext4_xattr_set_handle() and ext4_xattr_inode_lookup_create() like:

WARN_ON(ext4_handle_valid(handle) && !(current->flags & PF_MEMALLOC_NOFS));

It would narrow down a place in which PF_MEMALLOC_NOFS flag isn't set
properly... At least that seems like the most plausible way forward to me.

								Honza

> 
> ext4_xattr_set() {
>   handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits) == __ext4_journal_start() {
>       return __ext4_journal_start_sb() {
>         journal = EXT4_SB(sb)->s_journal;
>         if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
>           return ext4_get_nojournal(); // Never calls memalloc_nofs_save() despite returning !IS_ERR() value.
>         return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds, GFP_NOFS, type, line); // Calls memalloc_nofs_save() when start_this_handle() returns 0.
>       }
>     }
>   }
>   error = ext4_xattr_set_handle(handle, inode, name_index, name, value, value_len, flags); {
>     ext4_write_lock_xattr(inode, &no_expand); // Grabs &ei->xattr_sem
>     error = ext4_xattr_ibody_set(handle, inode, &i, &is) {
>       error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */) {
>         ret = ext4_xattr_inode_lookup_create(handle, inode, i->value, i->value_len, &new_ea_inode); // Using GFP_KERNEL based on assumption that ext4_journal_start() called memalloc_nofs_save().
>       }
>     }
>   }
> }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

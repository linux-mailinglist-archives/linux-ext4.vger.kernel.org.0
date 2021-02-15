Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EED31BABA
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Feb 2021 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBOOIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Feb 2021 09:08:07 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64712 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhBOOIG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Feb 2021 09:08:06 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11FE6HGh009237;
        Mon, 15 Feb 2021 23:06:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Mon, 15 Feb 2021 23:06:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11FE6HwJ009225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Feb 2021 23:06:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in start_this_handle (2)
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, mhocko@suse.cz, linux-mm@kvack.org,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
 <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
 <20210215124519.GA22417@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <aaee5d61-f988-84c3-4d16-f8b7987f3a83@i-love.sakura.ne.jp>
Date:   Mon, 15 Feb 2021 23:06:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215124519.GA22417@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/02/15 21:45, Jan Kara wrote:
> On Sat 13-02-21 23:26:37, Tetsuo Handa wrote:
>> Excuse me, but it seems to me that nothing prevents
>> ext4_xattr_set_handle() from reaching ext4_xattr_inode_lookup_create()
>> without memalloc_nofs_save() when hitting ext4_get_nojournal() path.
>> Will you explain when ext4_get_nojournal() path is executed?
> 
> That's a good question but sadly I don't think that's it.
> ext4_get_nojournal() is called when the filesystem is created without a
> journal. In that case we also don't acquire jbd2_handle lockdep map. In the
> syzbot report we can see:

Since syzbot can test filesystem images, syzbot might have tested a filesystem
image created both with and without journal within this boot.

> 
> kswapd0/2246 is trying to acquire lock:
> ffff888041a988e0 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf81/0x1380 fs/jbd2/transaction.c:444
> 
> but task is already holding lock:
> ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
> 
> So this filesystem has very clearly been created with a journal. Also the
> journal lockdep tracking machinery uses:

While locks held by kswapd0/2246 are fs_reclaim, shrinker_rwsem, &type->s_umount_key#38
and jbd2_handle, isn't the dependency lockdep considers problematic is

  Chain exists of:
    jbd2_handle --> &ei->xattr_sem --> fs_reclaim

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(fs_reclaim);
                                 lock(&ei->xattr_sem);
                                 lock(fs_reclaim);
    lock(jbd2_handle);

where CPU0 is kswapd/2246 and CPU1 is the case of ext4_get_nojournal() path?
If someone has taken jbd2_handle and &ei->xattr_sem in this order, isn't this
dependency true?

> 
> rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
> 
> so a lockdep key is per-filesystem. Thus it is not possible that lockdep
> would combine lock dependencies from two different filesystems.
> 
> But I guess we could narrow the search for this problem by adding WARN_ONs
> to ext4_xattr_set_handle() and ext4_xattr_inode_lookup_create() like:
> 
> WARN_ON(ext4_handle_valid(handle) && !(current->flags & PF_MEMALLOC_NOFS));
> 
> It would narrow down a place in which PF_MEMALLOC_NOFS flag isn't set
> properly... At least that seems like the most plausible way forward to me.

You can use CONFIG_DEBUG_AID_FOR_SYZBOT for adding such WARN_ONs on linux-next.


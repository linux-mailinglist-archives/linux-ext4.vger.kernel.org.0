Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4324231AC44
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Feb 2021 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhBMO3d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Feb 2021 09:29:33 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53214 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhBMO3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Feb 2021 09:29:32 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11DEQeXB006750;
        Sat, 13 Feb 2021 23:26:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Sat, 13 Feb 2021 23:26:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11DEQeQ5006747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 Feb 2021 23:26:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in start_this_handle (2)
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, mhocko@suse.cz, linux-mm@kvack.org,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
Date:   Sat, 13 Feb 2021 23:26:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211104947.GL19070@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/02/11 19:49, Jan Kara wrote:
> This stacktrace should never happen. ext4_xattr_set() starts a transaction.
> That internally goes through start_this_handle() which calls:
> 
> 	handle->saved_alloc_context = memalloc_nofs_save();
> 
> and we restore the allocation context only in stop_this_handle() when
> stopping the handle. And with this fs_reclaim_acquire() should remove
> __GFP_FS from the mask and not call __fs_reclaim_acquire().

Excuse me, but it seems to me that nothing prevents ext4_xattr_set_handle() from reaching
ext4_xattr_inode_lookup_create() without memalloc_nofs_save() when hitting ext4_get_nojournal() path.
Will you explain when ext4_get_nojournal() path is executed?

ext4_xattr_set() {
  handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits) == __ext4_journal_start() {
      return __ext4_journal_start_sb() {
        journal = EXT4_SB(sb)->s_journal;
        if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
          return ext4_get_nojournal(); // Never calls memalloc_nofs_save() despite returning !IS_ERR() value.
        return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds, GFP_NOFS, type, line); // Calls memalloc_nofs_save() when start_this_handle() returns 0.
      }
    }
  }
  error = ext4_xattr_set_handle(handle, inode, name_index, name, value, value_len, flags); {
    ext4_write_lock_xattr(inode, &no_expand); // Grabs &ei->xattr_sem
    error = ext4_xattr_ibody_set(handle, inode, &i, &is) {
      error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */) {
        ret = ext4_xattr_inode_lookup_create(handle, inode, i->value, i->value_len, &new_ea_inode); // Using GFP_KERNEL based on assumption that ext4_journal_start() called memalloc_nofs_save().
      }
    }
  }
}


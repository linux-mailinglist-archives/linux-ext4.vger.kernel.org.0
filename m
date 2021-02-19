Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AAE31F73C
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBSKTC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 05:19:02 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62027 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhBSKTB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 05:19:01 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11JAFWId022465;
        Fri, 19 Feb 2021 19:15:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Fri, 19 Feb 2021 19:15:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11JAFVNb022462
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Feb 2021 19:15:31 +0900 (JST)
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
 <aaee5d61-f988-84c3-4d16-f8b7987f3a83@i-love.sakura.ne.jp>
 <20210215142935.GB22417@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <34341830-f74f-57fa-2d21-c141f239b017@i-love.sakura.ne.jp>
Date:   Fri, 19 Feb 2021 19:15:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210215142935.GB22417@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/02/15 23:29, Jan Kara wrote:
> On Mon 15-02-21 23:06:15, Tetsuo Handa wrote:
>> On 2021/02/15 21:45, Jan Kara wrote:
>>> On Sat 13-02-21 23:26:37, Tetsuo Handa wrote:
>>>> Excuse me, but it seems to me that nothing prevents
>>>> ext4_xattr_set_handle() from reaching ext4_xattr_inode_lookup_create()
>>>> without memalloc_nofs_save() when hitting ext4_get_nojournal() path.
>>>> Will you explain when ext4_get_nojournal() path is executed?
>>>
>>> That's a good question but sadly I don't think that's it.
>>> ext4_get_nojournal() is called when the filesystem is created without a
>>> journal. In that case we also don't acquire jbd2_handle lockdep map. In the
>>> syzbot report we can see:
>>
>> Since syzbot can test filesystem images, syzbot might have tested a filesystem
>> image created both with and without journal within this boot.
> 
> a) I think that syzbot reboots the VM between executing different tests to
> get reproducible conditions. But in theory I agree the test may have
> contained one image with and one image without a journal.

syzkaller reboots the VM upon a crash.
syzkaller can test multiple filesystem images within one boot.

https://storage.googleapis.com/syzkaller/cover/ci-qemu-upstream-386.html (this
statistic snapshot is volatile) reports that ext4_get_nojournal() is partially covered
( https://github.com/google/syzkaller/blob/master/docs/coverage.md ) by syzkaller.

      /* Just increment the non-pointer handle value */
      static handle_t *ext4_get_nojournal(void)
      {
   86         handle_t *handle = current->journal_info;
              unsigned long ref_cnt = (unsigned long)handle;
      
              BUG_ON(ref_cnt >= EXT4_NOJOURNAL_MAX_REF_COUNT);
      
   86         ref_cnt++;
              handle = (handle_t *)ref_cnt;
      
              current->journal_info = handle;
 2006         return handle;
      }
      
      
      /* Decrement the non-pointer handle value */
      static void ext4_put_nojournal(handle_t *handle)
      {
              unsigned long ref_cnt = (unsigned long)handle;
      
   85         BUG_ON(ref_cnt == 0);
      
   85         ref_cnt--;
              handle = (handle_t *)ref_cnt;
      
              current->journal_info = handle;
      }


      handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
                                        int type, int blocks, int rsv_blocks,
                                        int revoke_creds)
      {
              journal_t *journal;
              int err;
      
 2006         trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
 2006                                  _RET_IP_);
 2006         err = ext4_journal_check_start(sb);
              if (err < 0)
                      return ERR_PTR(err);
      
 2005         journal = EXT4_SB(sb)->s_journal;
 1969         if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 2006                 return ext4_get_nojournal();
 1969         return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
                                         GFP_NOFS, type, line);
      }

> 
> *but*
> 
> b) as I wrote in the email you are replying to, the jbd2_handle key is
> private per filesystem. Thus for lockdep to complain about
> jbd2_handle->fs_reclaim->jbd2_handle deadlock, those jbd2_handle lockdep
> maps must come from the same filesystem.
> 
> *and*
> 
> c) filesystem without journal doesn't use jbd2_handle lockdep map at all so
> for such filesystems lockdep creates no dependency for jbd2_handle map.
> 

What about "EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)" case?
Does this case happen on filesystem with journal, and can this case be executed
by fuzzing a crafted (a sort of erroneous) filesystem with journal, and are
the jbd2_handle for calling ext4_get_nojournal() case and the jbd2_handle for
calling jbd2__journal_start() case the same?

Also, I worry that jbd2__journal_restart() is problematic, for it calls
stop_this_handle() (which calls memalloc_nofs_restore()) and then calls
start_this_handle() (which fails to call memalloc_nofs_save() if an error
occurs). An error from start_this_handle() from journal restart operation
might need special handling (i.e. either remount-ro or panic) ?


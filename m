Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9023E8C0
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHGITw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHGITv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 04:19:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47488C061574;
        Fri,  7 Aug 2020 01:19:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so544458pgc.8;
        Fri, 07 Aug 2020 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P8F5LcSIu0sknMubEOmFSH2dP8dzpWv5MvZX7Z+EJVg=;
        b=N+1zHHUvtK7Km0tGgxYRjlAlWrwOPRPafV8HoW2Nujjpn05UGJ8PQ0vOAbj0rqCZEA
         gosKvi63ukWohCdN5s2lKMxJiG8HgNyfh8WnCWAmm8Cp0CA+KoACR4xekPwTj0XY6LVR
         tBDjsXPaD3HWjaXpQGyw1RpmTL0zect1uaOme+7ZKxqMMV57dugL9VfTyGRH3TQSQ50/
         T7xxYFx9cV0SHbecf1IP6i4r90jZLnJzzu0ZAV5tUQwyA5v94RO0IhA30DmX3P7XFSH8
         cEUL0f9NNermH0mcbcFKNS7pTnHEhQMHEMpTNsyVYuUXh9DGGWOnEavZ21VKVTq2hgQK
         TiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8F5LcSIu0sknMubEOmFSH2dP8dzpWv5MvZX7Z+EJVg=;
        b=FVt/xd1Zp9Z8f2buubPblvfk58JnP/2+vvShYiMS4gtgKZbvTqziFuaQi9SYSb8Fh6
         bRoddV4fBA3owga5dgZ/uOJW81GvOJRUO/zB13uqjQ92jfHZ+GSulU4RRg30ADYfn6fd
         mS7Lxgu5lflGPvKwnYRVfFV13DEtGC4kBOkovJoS/cSYnOiqQ8wY7IOqVUnF/cLOqQuf
         +y79ncoy6L2SXpU6aCZ6tTdSECusTg/Of8p1WOeadluejqNVMo4fo6g9J58oaaQz09H1
         GyaNXoAoKbtgAcMEVXZiVjT1bQbr4a7asvKj/uSHqFx/n4UcFXrvXdacm8mFftvArwF0
         cAAw==
X-Gm-Message-State: AOAM531GublM3dPVPwGYKIIiy8jknlFhZUvjK30yDAJzoBG06W63bBSk
        vINrxEpEsBLLx8G0JB46X6LYZFDEXNM=
X-Google-Smtp-Source: ABdhPJwNq0Y+NCztqrEFAlPY/pm8k1WbvzayCIGTBuN46UkHqzfLH2Grn3aSfgliJAho5ovHuBSCkg==
X-Received: by 2002:a63:e442:: with SMTP id i2mr10942970pgk.105.1596788390350;
        Fri, 07 Aug 2020 01:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id t25sm7949568pfe.51.2020.08.07.01.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 01:19:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] ext4: limit the length of per-inode prealloc list
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <bb8be35a-ba56-44f6-b492-c3244f667a30@gmail.com>
 <EEA00B35-CC71-4E81-B5DB-596EE3B0AB56@dilger.ca>
 <bc768e7e-d8c6-72a2-c984-79cae4bcb9c9@gmail.com>
 <CA+OwuSg_owOPMxsknBfB8H=Vw64Nh_QABgOCM4wY+SV--eoXEw@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <a625c0cb-e42c-ac3e-0c62-5a744679e81b@gmail.com>
Date:   Fri, 7 Aug 2020 16:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+OwuSg_owOPMxsknBfB8H=Vw64Nh_QABgOCM4wY+SV--eoXEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

That is a good suggestion, thanks.

thanks.

Andreas Dilger wrote on 2020/8/7 16:15:
> It would be good to include these performance results in the commit message, so that the results are available to the patch reviewers and in the future if this code is changed.
> 
> On Wed, Aug 5, 2020 at 3:16 AM brookxu <brookxu.cn@gmail.com <mailto:brookxu.cn@gmail.com>> wrote:
> 
>     Add more... , As we expected, the running time of the test process is
>     reduced significantly.
> 
>     Running time on unrepaired kernel：
>     [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>     real    0m2.051s
>     user    0m0.008s
>     sys    0m2.026s
> 
>     Running time on repaired kernel：
>     [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>     real    0m0.471s
>     user    0m0.004s
>     sys        0m0.395s
> 
>     Thanks.
> 
>     Andreas Dilger wrote on 2020/8/5 12:53:
>     > On Aug 4, 2020, at 7:02 PM, brookxu <brookxu.cn@gmail.com <mailto:brookxu.cn@gmail.com>> wrote:
>     >> In the scenario of writing sparse files, the Per-inode prealloc list may
>     >> be very long, resulting in high overhead for ext4_mb_use_preallocated().
>     >> To circumvent this problem, we limit the maximum length of per-inode
>     >> prealloc list to 512 and allow users to modify it.
>     >>
>     >> Signed-off-by: Chunguang Xu <brookxu@tencent.com <mailto:brookxu@tencent.com>>
>     > Do you have any kind of measurements that show the benefit of this patch?
>     > For example performance improvement, memory or CPU usage before and after?
>     > How long is "very long"?
>     >
>     > Cheers, Andreas
>     >
>     >> ---
>     >>  fs/ext4/ext4.h        |  3 ++-
>     >>  fs/ext4/extents.c     | 10 ++++-----
>     >>  fs/ext4/file.c        |  2 +-
>     >>  fs/ext4/indirect.c    |  2 +-
>     >>  fs/ext4/inode.c       |  6 +++---
>     >>  fs/ext4/ioctl.c       |  2 +-
>     >>  fs/ext4/mballoc.c     | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
>     >>  fs/ext4/mballoc.h     |  4 ++++
>     >>  fs/ext4/move_extent.c |  4 ++--
>     >>  fs/ext4/super.c       |  2 +-
>     >>  fs/ext4/sysfs.c       |  2 ++
>     >>  11 files changed, 75 insertions(+), 19 deletions(-)
>     >>
>     >> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>     >> index 42f5060..68e0ebe 100644
>     >> --- a/fs/ext4/ext4.h
>     >> +++ b/fs/ext4/ext4.h
>     >> @@ -1501,6 +1501,7 @@ struct ext4_sb_info {
>     >>      unsigned int s_mb_stats;
>     >>      unsigned int s_mb_order2_reqs;
>     >>      unsigned int s_mb_group_prealloc;
>     >> +    unsigned int s_mb_max_inode_prealloc;
>     >>      unsigned int s_max_dir_size_kb;
>     >>      /* where last allocation was done - for stream allocation */
>     >>      unsigned long s_mb_last_group;
>     >> @@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
>     >>  extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>     >>                  struct ext4_allocation_request *, int *);
>     >>  extern int ext4_mb_reserve_blocks(struct super_block *, int);
>     >> -extern void ext4_discard_preallocations(struct inode *);
>     >> +extern void ext4_discard_preallocations(struct inode *, unsigned int);
>     >>  extern int __init ext4_init_mballoc(void);
>     >>  extern void ext4_exit_mballoc(void);
>     >>  extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
>     >> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>     >> index 221f240..a40f928 100644
>     >> --- a/fs/ext4/extents.c
>     >> +++ b/fs/ext4/extents.c
>     >> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>     >>       * i_mutex. So we can safely drop the i_data_sem here.
>     >>       */
>     >>      BUG_ON(EXT4_JOURNAL(inode) == NULL);
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>      up_write(&EXT4_I(inode)->i_data_sem);
>     >>      *dropped = 1;
>     >>      return 0;
>     >> @@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>     >>               * not a good idea to call discard here directly,
>     >>               * but otherwise we'd need to call it every free().
>     >>               */
>     >> -            ext4_discard_preallocations(inode);
>     >> +            ext4_discard_preallocations(inode, 0);
>     >>              if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>     >>                  fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
>     >>              ext4_free_blocks(handle, inode, NULL, newblock,
>     >> @@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>     >>      }
>     >>
>     >>      down_write(&EXT4_I(inode)->i_data_sem);
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>
>     >>      ret = ext4_es_remove_extent(inode, punch_start,
>     >>                      EXT_MAX_BLOCKS - punch_start);
>     >> @@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>     >>          up_write(&EXT4_I(inode)->i_data_sem);
>     >>          goto out_stop;
>     >>      }
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>
>     >>      ret = ext4_ext_shift_extents(inode, handle, punch_stop,
>     >>                       punch_stop - punch_start, SHIFT_LEFT);
>     >> @@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>     >>          goto out_stop;
>     >>
>     >>      down_write(&EXT4_I(inode)->i_data_sem);
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>
>     >>      path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>     >>      if (IS_ERR(path)) {
>     >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>     >> index 2a01e31..e3ab8ea 100644
>     >> --- a/fs/ext4/file.c
>     >> +++ b/fs/ext4/file.c
>     >> @@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>     >>                  !EXT4_I(inode)->i_reserved_data_blocks)
>     >>      {
>     >>          down_write(&EXT4_I(inode)->i_data_sem);
>     >> -        ext4_discard_preallocations(inode);
>     >> +        ext4_discard_preallocations(inode, 0);
>     >>          up_write(&EXT4_I(inode)->i_data_sem);
>     >>      }
>     >>      if (is_dx(inode) && filp->private_data)
>     >> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>     >> index be2b66e..ec6b930 100644
>     >> --- a/fs/ext4/indirect.c
>     >> +++ b/fs/ext4/indirect.c
>     >> @@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
>     >>       * i_mutex. So we can safely drop the i_data_sem here.
>     >>       */
>     >>      BUG_ON(EXT4_JOURNAL(inode) == NULL);
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>      up_write(&EXT4_I(inode)->i_data_sem);
>     >>      *dropped = 1;
>     >>      return 0;
>     >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>     >> index 10dd470..bb9e1cd 100644
>     >> --- a/fs/ext4/inode.c
>     >> +++ b/fs/ext4/inode.c
>     >> @@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>     >>       */
>     >>      if ((ei->i_reserved_data_blocks == 0) &&
>     >>          !inode_is_open_for_write(inode))
>     >> -        ext4_discard_preallocations(inode);
>     >> +        ext4_discard_preallocations(inode, 0);
>     >>  }
>     >>
>     >>  static int __check_block_validity(struct inode *inode, const char *func,
>     >> @@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>     >>      if (stop_block > first_block) {
>     >>
>     >>          down_write(&EXT4_I(inode)->i_data_sem);
>     >> -        ext4_discard_preallocations(inode);
>     >> +        ext4_discard_preallocations(inode, 0);
>     >>
>     >>          ret = ext4_es_remove_extent(inode, first_block,
>     >>                          stop_block - first_block);
>     >> @@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
>     >>
>     >>      down_write(&EXT4_I(inode)->i_data_sem);
>     >>
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>
>     >>      if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>     >>          err = ext4_ext_truncate(handle, inode);
>     >> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>     >> index 999cf6a..a5fcc23 100644
>     >> --- a/fs/ext4/ioctl.c
>     >> +++ b/fs/ext4/ioctl.c
>     >> @@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>     >>      reset_inode_seed(inode);
>     >>      reset_inode_seed(inode_bl);
>     >>
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>
>     >>      err = ext4_mark_inode_dirty(handle, inode);
>     >>      if (err < 0) {
>     >> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>     >> index 4f21f34..28a139f 100644
>     >> --- a/fs/ext4/mballoc.c
>     >> +++ b/fs/ext4/mballoc.c
>     >> @@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
>     >>      sbi->s_mb_stats = MB_DEFAULT_STATS;
>     >>      sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
>     >>      sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
>     >> +    sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
>     >>      /*
>     >>       * The default group preallocation is 512, which for 4k block
>     >>       * sizes translates to 2 megabytes.  However for bigalloc file
>     >> @@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>     >>   *
>     >>   * FIXME!! Make sure it is valid at all the call sites
>     >>   */
>     >> -void ext4_discard_preallocations(struct inode *inode)
>     >> +void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>     >>  {
>     >>      struct ext4_inode_info *ei = EXT4_I(inode);
>     >>      struct super_block *sb = inode->i_sb;
>     >> @@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode *inode)
>     >>
>     >>      mb_debug(sb, "discard preallocation for inode %lu\n",
>     >>           inode->i_ino);
>     >> -    trace_ext4_discard_preallocations(inode);
>     >> +    trace_ext4_discard_preallocations(inode,  needed);
>     >>
>     >>      INIT_LIST_HEAD(&list);
>     >>
>     >> +    if (needed == 0)
>     >> +        needed = UINT_MAX;
>     >> +
>     >>  repeat:
>     >>      /* first, collect all pa's in the inode */
>     >>      spin_lock(&ei->i_prealloc_lock);
>     >> -    while (!list_empty(&ei->i_prealloc_list)) {
>     >> -        pa = list_entry(ei->i_prealloc_list.next,
>     >> +    while (!list_empty(&ei->i_prealloc_list) && needed) {
>     >> +        pa = list_entry(ei->i_prealloc_list.prev,
>     >>                  struct ext4_prealloc_space, pa_inode_list);
>     >>          BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
>     >>          spin_lock(&pa->pa_lock);
>     >> @@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode *inode)
>     >>              spin_unlock(&pa->pa_lock);
>     >>              list_del_rcu(&pa->pa_inode_list);
>     >>              list_add(&pa->u.pa_tmp_list, &list);
>     >> +            needed--;
>     >>              continue;
>     >>          }
>     >>
>     >> @@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>     >>  }
>     >>
>     >>  /*
>     >> + * if per-inode prealloc list is too long, trim some PA
>     >> + */
>     >> +static void
>     >> +ext4_mb_trim_inode_pa(struct inode *inode)
>     >> +{
>     >> +    struct ext4_inode_info *ei = EXT4_I(inode);
>     >> +    struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>     >> +    struct ext4_prealloc_space *pa;
>     >> +    int count = 0, delta;
>     >> +
>     >> +    rcu_read_lock();
>     >> +    list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
>     >> +        spin_lock(&pa->pa_lock);
>     >> +        if (pa->pa_deleted) {
>     >> +            spin_unlock(&pa->pa_lock);
>     >> +            continue;
>     >> +        }
>     >> +        count++;
>     >> +        spin_unlock(&pa->pa_lock);
>     >> +    }
>     >> +    rcu_read_unlock();
>     >> +
>     >> +    delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
>     >> +    if (count > sbi->s_mb_max_inode_prealloc + delta) {
>     >> +        count -= sbi->s_mb_max_inode_prealloc;
>     >> +        ext4_discard_preallocations(inode, count);
>     >> +    }
>     >> +}
>     >> +
>     >> +/*
>     >>   * release all resource we used in allocation
>     >>   */
>     >>  static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>     >>  {
>     >> +    struct inode *inode = ac->ac_inode;
>     >> +    struct ext4_inode_info *ei = EXT4_I(inode);
>     >>      struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>     >>      struct ext4_prealloc_space *pa = ac->ac_pa;
>     >>      if (pa) {
>     >> @@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>     >>                  ext4_mb_add_n_trim(ac);
>     >>              }
>     >>          }
>     >> +
>     >> +        if (pa->pa_type == MB_INODE_PA) {
>     >> +            /*
>     >> +             * treat per-inode prealloc list as a lru list, then try
>     >> +             * to trim the least recently used PA.
>     >> +             */
>     >> +            spin_lock(pa->pa_obj_lock);
>     >> +            list_move(&ei->i_prealloc_list, &pa->pa_inode_list);
>     >> +            spin_unlock(pa->pa_obj_lock);
>     >> +        }
>     >> +
>     >>          ext4_mb_put_pa(ac, ac->ac_sb, pa);
>     >>      }
>     >>      if (ac->ac_bitmap_page)
>     >> @@ -4587,6 +4635,7 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>     >>      if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
>     >>          mutex_unlock(&ac->ac_lg->lg_mutex);
>     >>      ext4_mb_collect_stats(ac);
>     >> +    ext4_mb_trim_inode_pa(inode);
>     >>      return 0;
>     >>  }
>     >>
>     >> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>     >> index 6b4d17c..e75b474 100644
>     >> --- a/fs/ext4/mballoc.h
>     >> +++ b/fs/ext4/mballoc.h
>     >> @@ -73,6 +73,10 @@
>     >>   */
>     >>  #define MB_DEFAULT_GROUP_PREALLOC    512
>     >>
>     >> +/*
>     >> + * maximum length of inode prealloc list
>     >> + */
>     >> +#define MB_DEFAULT_MAX_INODE_PREALLOC    512
>     >>
>     >>  struct ext4_free_data {
>     >>      /* this links the free block information from sb_info */
>     >> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
>     >> index 1ed86fb..0d601b8 100644
>     >> --- a/fs/ext4/move_extent.c
>     >> +++ b/fs/ext4/move_extent.c
>     >> @@ -686,8 +686,8 @@
>     >>
>     >>  out:
>     >>      if (*moved_len) {
>     >> -        ext4_discard_preallocations(orig_inode);
>     >> -        ext4_discard_preallocations(donor_inode);
>     >> +        ext4_discard_preallocations(orig_inode, 0);
>     >> +        ext4_discard_preallocations(donor_inode, 0);
>     >>      }
>     >>
>     >>      ext4_ext_drop_refs(path);
>     >> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>     >> index 330957e..8ce61f3 100644
>     >> --- a/fs/ext4/super.c
>     >> +++ b/fs/ext4/super.c
>     >> @@ -1216,7 +1216,7 @@ void ext4_clear_inode(struct inode *inode)
>     >>  {
>     >>      invalidate_inode_buffers(inode);
>     >>      clear_inode(inode);
>     >> -    ext4_discard_preallocations(inode);
>     >> +    ext4_discard_preallocations(inode, 0);
>     >>      ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>     >>      dquot_drop(inode);
>     >>      if (EXT4_I(inode)->jinode) {
>     >> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>     >> index 6c9fc9e..92f04e9 100644
>     >> --- a/fs/ext4/sysfs.c
>     >> +++ b/fs/ext4/sysfs.c
>     >> @@ -215,6 +215,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>     >>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>     >>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>     >>  EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
>     >> +EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
>     >>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>     >>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
>     >>  EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
>     >> @@ -257,6 +258,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>     >>      ATTR_LIST(mb_order2_req),
>     >>      ATTR_LIST(mb_stream_req),
>     >>      ATTR_LIST(mb_group_prealloc),
>     >> +    ATTR_LIST(mb_max_inode_prealloc),
>     >>      ATTR_LIST(max_writeback_mb_bump),
>     >>      ATTR_LIST(extent_max_zeroout_kb),
>     >>      ATTR_LIST(trigger_fs_error),
>     >>
>     >> --
>     >> 1.8.3.1
>     >>
>     >
>     > Cheers, Andreas
>     >
>     >
>     >
>     >
>     >
> 

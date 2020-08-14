Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C942444F6
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 08:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgHNGW5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Aug 2020 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgHNGW5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Aug 2020 02:22:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5CC061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 23:22:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so3909998pjb.2
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SRxrYwdvKQpRsA0A6mSeqhLwdP6ieIeHkrbsidQjEKY=;
        b=e7x2YTZjLMJcSesyssoZHV7pnNlUS4U742K2VSjcmfCaS5E05ue4u2hY1VhwH6gisu
         2y5GERjGEunpRxg7qvxhqb5oPpA/s8XZO+toIyr63sPZLpHsQtDCrUZrjpJ1fMR4sowQ
         wSF4IgI3ahWEBHcZeMj2JhQvIzboe/8jTgFCTNJ2JF4JPrmsAoR86inblH3XfE5k3S2O
         a0kgPIwg3rSO0ipf5qZqdFcKFJaVPlMqoVcAEnWzy0uVmf/NVRRkxvnl8dgQxHeFmnyb
         IzBeYwqyrYj2t8gKy5BlpvL+AhYfos3quULyn3fDwf468cVLijUKsVXvkWYebHPpRy5t
         GTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SRxrYwdvKQpRsA0A6mSeqhLwdP6ieIeHkrbsidQjEKY=;
        b=BsZaufZHHWMHMaE84Nd6rjp06mp+SzApAC0cwcgCXrGAdkGn1vIkBPcjB+YaetR3k5
         3ucqrb1glclOYYiOOtw5+ML2Qr+HF8oEZMnNJXCJzp5owK/Wss+rSe4bHgl1zqa5yyjZ
         IoXm29Gx6BtmQNlUt9IzxKh5QXnC7YmcqGrgvFBdx5fPRDECRnf3FMoUSzdosTr9VWj2
         1m89O0/JJfl7CllAJps0hgu1SI6tLgv6pTiI4G9O+fcspjEmiuDUK2l1uI/85HV7DLu9
         r2dYhQ+E7DoVkZprY/8p8KFTQ9dDK27AarrRECWAyC4aq6aw/UnJVt1s7+s41wFstWBp
         WgmA==
X-Gm-Message-State: AOAM5310BDtbjuy0lyEIzG4MhcupQKP6rvDi6joWjX7nO5WWNn0LB80q
        gSBeih5k+8vIxagX/v20gJv2dn8IPSs=
X-Google-Smtp-Source: ABdhPJxL8t1Dx03qTwpAWcsV+3dJ0PHBi8xeywImkCKAZflDxPPnE8mRkPjeiXduTbl49WYkFz/bag==
X-Received: by 2002:a17:90b:14d2:: with SMTP id jz18mr1053801pjb.136.1597386175805;
        Thu, 13 Aug 2020 23:22:55 -0700 (PDT)
Received: from localhost.localdomain ([124.123.81.166])
        by smtp.gmail.com with ESMTPSA id y128sm7905260pfy.74.2020.08.13.23.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 23:22:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] ext4: limit the length of per-inode prealloc list
To:     brookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
 <20200813135254.54102A4059@d06av23.portsmouth.uk.ibm.com>
 <6c2e1231-e7a7-bb22-7eed-0e418cf6056d@gmail.com>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <c5d5c940-3220-80c6-9553-37beaf4a9eb0@gmail.com>
Date:   Fri, 14 Aug 2020 11:52:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6c2e1231-e7a7-bb22-7eed-0e418cf6056d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/14/20 6:41 AM, brookxu wrote:
> Thanks for review this patch :)
> 
> Ritesh Harjani wrote on 2020/8/13 21:52:
>> Hi brookxu,
>>
>> Few queries
>>
>> On 8/7/20 2:14 PM, brookxu wrote:
>>> In the scenario of writing sparse files, the Per-inode prealloc list may
>>> be very long, resulting in high overhead for ext4_mb_use_preallocated().
>>> To circumvent this problem, we limit the maximum length of per-inode
>>> prealloc list to 512 and allow users to modify it.
>>>
>>> After patching, we observed that the sys ratio of cpu has dropped, and
>>> the system throughput has increased significantly. We created a process
>>> to write the sparse file, and the running time of the process on the
>>> fixed kernel was significantly reduced, as follows:
>>>
>>> Running time on unfixed kernel：
>>> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>>> real    0m2.051s
>>> user    0m0.008s
>>> sys     0m2.026s
>>>
>>> Running time on fixed kernel：
>>> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>>> real    0m0.471s
>>> user    0m0.004s
>>> sys     0m0.395s
>>
>>
>> Please use "--thread" option in your git-format-patch script. So that
>> your patch series comes in a threaded form. It is easier then to apply
>> the series.
>>
>> Somehow I am unable to get my head around how this patch is working.
>> Could you please help explain the theory of operation by answering below
>> queries.
>>
>>>
>>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>>> ---
>>>    fs/ext4/ext4.h              |  3 ++-
>>>    fs/ext4/extents.c           | 10 ++++----
>>>    fs/ext4/file.c              |  2 +-
>>>    fs/ext4/indirect.c          |  2 +-
>>>    fs/ext4/inode.c             |  6 ++---
>>>    fs/ext4/ioctl.c             |  2 +-
>>>    fs/ext4/mballoc.c           | 57 +++++++++++++++++++++++++++++++++++++++++----
>>>    fs/ext4/mballoc.h           |  4 ++++
>>>    fs/ext4/move_extent.c       |  4 ++--
>>>    fs/ext4/super.c             |  2 +-
>>>    fs/ext4/sysfs.c             |  2 ++
>>>    include/trace/events/ext4.h | 14 ++++++-----
>>>    12 files changed, 83 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>> index 42f5060..68e0ebe 100644
>>> --- a/fs/ext4/ext4.h
>>> +++ b/fs/ext4/ext4.h
>>> @@ -1501,6 +1501,7 @@ struct ext4_sb_info {
>>>        unsigned int s_mb_stats;
>>>        unsigned int s_mb_order2_reqs;
>>>        unsigned int s_mb_group_prealloc;
>>> +    unsigned int s_mb_max_inode_prealloc;
>>>        unsigned int s_max_dir_size_kb;
>>>        /* where last allocation was done - for stream allocation */
>>>        unsigned long s_mb_last_group;
>>> @@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
>>>    extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>>>                    struct ext4_allocation_request *, int *);
>>>    extern int ext4_mb_reserve_blocks(struct super_block *, int);
>>> -extern void ext4_discard_preallocations(struct inode *);
>>> +extern void ext4_discard_preallocations(struct inode *, unsigned int);
>>>    extern int __init ext4_init_mballoc(void);
>>>    extern void ext4_exit_mballoc(void);
>>>    extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>> index 221f240..a40f928 100644
>>> --- a/fs/ext4/extents.c
>>> +++ b/fs/ext4/extents.c
>>> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>>>         * i_mutex. So we can safely drop the i_data_sem here.
>>>         */
>>>        BUG_ON(EXT4_JOURNAL(inode) == NULL);
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>        up_write(&EXT4_I(inode)->i_data_sem);
>>>        *dropped = 1;
>>>        return 0;
>>> @@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>>>                 * not a good idea to call discard here directly,
>>>                 * but otherwise we'd need to call it every free().
>>>                 */
>>> -            ext4_discard_preallocations(inode);
>>> +            ext4_discard_preallocations(inode, 0);
>>>                if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>>>                    fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
>>>                ext4_free_blocks(handle, inode, NULL, newblock,
>>> @@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>>        }
>>>
>>>        down_write(&EXT4_I(inode)->i_data_sem);
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>
>>>        ret = ext4_es_remove_extent(inode, punch_start,
>>>                        EXT_MAX_BLOCKS - punch_start);
>>> @@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>>            up_write(&EXT4_I(inode)->i_data_sem);
>>>            goto out_stop;
>>>        }
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>
>>>        ret = ext4_ext_shift_extents(inode, handle, punch_stop,
>>>                         punch_stop - punch_start, SHIFT_LEFT);
>>> @@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>>            goto out_stop;
>>>
>>>        down_write(&EXT4_I(inode)->i_data_sem);
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>
>>>        path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>>>        if (IS_ERR(path)) {
>>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>>> index 2a01e31..e3ab8ea 100644
>>> --- a/fs/ext4/file.c
>>> +++ b/fs/ext4/file.c
>>> @@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>>>                    !EXT4_I(inode)->i_reserved_data_blocks)
>>>        {
>>>            down_write(&EXT4_I(inode)->i_data_sem);
>>> -        ext4_discard_preallocations(inode);
>>> +        ext4_discard_preallocations(inode, 0);
>>>            up_write(&EXT4_I(inode)->i_data_sem);
>>>        }
>>>        if (is_dx(inode) && filp->private_data)
>>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>>> index be2b66e..ec6b930 100644
>>> --- a/fs/ext4/indirect.c
>>> +++ b/fs/ext4/indirect.c
>>> @@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
>>>         * i_mutex. So we can safely drop the i_data_sem here.
>>>         */
>>>        BUG_ON(EXT4_JOURNAL(inode) == NULL);
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>        up_write(&EXT4_I(inode)->i_data_sem);
>>>        *dropped = 1;
>>>        return 0;
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index 10dd470..bb9e1cd 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>>>         */
>>>        if ((ei->i_reserved_data_blocks == 0) &&
>>>            !inode_is_open_for_write(inode))
>>> -        ext4_discard_preallocations(inode);
>>> +        ext4_discard_preallocations(inode, 0);
>>>    }
>>>
>>>    static int __check_block_validity(struct inode *inode, const char *func,
>>> @@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>>>        if (stop_block > first_block) {
>>>
>>>            down_write(&EXT4_I(inode)->i_data_sem);
>>> -        ext4_discard_preallocations(inode);
>>> +        ext4_discard_preallocations(inode, 0);
>>>
>>>            ret = ext4_es_remove_extent(inode, first_block,
>>>                            stop_block - first_block);
>>> @@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
>>>
>>>        down_write(&EXT4_I(inode)->i_data_sem);
>>>
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>
>>>        if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>>            err = ext4_ext_truncate(handle, inode);
>>> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>>> index 999cf6a..a5fcc23 100644
>>> --- a/fs/ext4/ioctl.c
>>> +++ b/fs/ext4/ioctl.c
>>> @@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>>>        reset_inode_seed(inode);
>>>        reset_inode_seed(inode_bl);
>>>
>>> -    ext4_discard_preallocations(inode);
>>> +    ext4_discard_preallocations(inode, 0);
>>>
>>>        err = ext4_mark_inode_dirty(handle, inode);
>>>        if (err < 0) {
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index 4f21f34..28a139f 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
>>>        sbi->s_mb_stats = MB_DEFAULT_STATS;
>>>        sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
>>>        sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
>>> +    sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
>>>        /*
>>>         * The default group preallocation is 512, which for 4k block
>>>         * sizes translates to 2 megabytes.  However for bigalloc file
>>> @@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>>>     *
>>>     * FIXME!! Make sure it is valid at all the call sites
>>>     */
>>> -void ext4_discard_preallocations(struct inode *inode)
>>> +void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>>>    {
>>>        struct ext4_inode_info *ei = EXT4_I(inode);
>>>        struct super_block *sb = inode->i_sb;
>>> @@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode *inode)
>>>
>>>        mb_debug(sb, "discard preallocation for inode %lu\n",
>>>             inode->i_ino);

Can we please also add "needed" argument in mb_debug() msg here.

With that feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


>>> -    trace_ext4_discard_preallocations(inode);
>>> +    trace_ext4_discard_preallocations(inode,  needed);
>>>
>>>        INIT_LIST_HEAD(&list);
>>>
>>> +    if (needed == 0)
>>> +        needed = UINT_MAX;
>>> +
>>>    repeat:
>>>        /* first, collect all pa's in the inode */
>>>        spin_lock(&ei->i_prealloc_lock);
>>> -    while (!list_empty(&ei->i_prealloc_list)) {
>>> -        pa = list_entry(ei->i_prealloc_list.next,
>>> +    while (!list_empty(&ei->i_prealloc_list) && needed) {
>>> +        pa = list_entry(ei->i_prealloc_list.prev,
>>>                    struct ext4_prealloc_space, pa_inode_list);
>>>            BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
>>>            spin_lock(&pa->pa_lock);
>>> @@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode *inode)
>>>                spin_unlock(&pa->pa_lock);
>>>                list_del_rcu(&pa->pa_inode_list);
>>>                list_add(&pa->u.pa_tmp_list, &list);
>>> +            needed--;
>>>                continue;
>>>            }
>>>
>>> @@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>>>    }
>>>
>>>    /*
>>> + * if per-inode prealloc list is too long, trim some PA
>>> + */
>>> +static void
>>> +ext4_mb_trim_inode_pa(struct inode *inode)
>>> +{
>>> +    struct ext4_inode_info *ei = EXT4_I(inode);
>>> +    struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>>> +    struct ext4_prealloc_space *pa;
>>> +    int count = 0, delta;
>>> +
>>> +    rcu_read_lock();
>>> +    list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
>>> +        spin_lock(&pa->pa_lock);
>>> +        if (pa->pa_deleted) {
>>> +            spin_unlock(&pa->pa_lock);
>>> +            continue;
>>> +        }
>>> +        count++;
>>> +        spin_unlock(&pa->pa_lock);
>>> +    }
>>> +    rcu_read_unlock();
>>> +
>>> +    delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
>>> +    if (count > sbi->s_mb_max_inode_prealloc + delta) {
>>> +        count -= sbi->s_mb_max_inode_prealloc;
>>> +        ext4_discard_preallocations(inode, count);
>>> +    }
>>> +}
>>> +
>>> +/*
>>>     * release all resource we used in allocation
>>>     */
>>>    static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>>>    {
>>> +    struct inode *inode = ac->ac_inode;
>>> +    struct ext4_inode_info *ei = EXT4_I(inode);
>>>        struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>>>        struct ext4_prealloc_space *pa = ac->ac_pa;
>>>        if (pa) {
>>> @@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>>>                    ext4_mb_add_n_trim(ac);
>>>                }
>>>            }
>>> +
>>> +        if (pa->pa_type == MB_INODE_PA) {
>>> +            /*
>>> +             * treat per-inode prealloc list as a lru list, then try
>>> +             * to trim the least recently used PA.
>>> +             */
>>> +            spin_lock(pa->pa_obj_lock);
>>> +            list_move(&ei->i_prealloc_list, &pa->pa_inode_list);
>>
>> So what you are doing here is essentially moving back ei->i_prealloc_list back into pa->pa_inode_lis
> 
> The operation here uses LRU to maintain the prealloc list, so we can trim the least recently used PA
> from the tail of the list. According to the principle of locality, this may reduce the impact on the
> program.
> 
>> Then in ext4_mb_trim_inode_pa(), it will traverse over i_prealloc_list
>> which is empty anyways no? (considering single threaded write here).
>> I am definitely missing something, could you help explain how is it
>> getting trimmed then?
> 

Sorry, I had got confused here with something else. This looks fine to 
me now :)

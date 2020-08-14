Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398CB2442A9
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHNBLt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 21:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNBLt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 21:11:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622DC061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 18:11:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so3740521pgb.2
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 18:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGzNfHsdBeelZXZ+9pdeOdRwxoep69m+sBveAvzb7jo=;
        b=iA2ZXnokvpFY6zvzWyCTv6RAo1qlQqVdmq2AlFyLr1YuXVOqnQ1MyKlzjRoJK8hAHk
         DcYsUlsMpzXGdjgmZdd3mcxeB7KAQh6X1tDSQq8K3i7SVcBnKrLDf3PD8jl8m0geGXHR
         j+CepnUGTCFkgBMIT+mSi4YEU9tfu/TAsMgnIABj9cp/zzc4rZDc3uOobke2Nr0zwJg8
         42gu8AroGImAEwath/1NPMVqoDFjnXNPEbNwXEiePCm+NMX5T5Cy/2c33hHVbgKxUDmc
         LAUrWyEf3cZPdlX0Hm1byvo+TklDSk8qVGPfl3c5Xv4nKzvK8J6sxhrAJRk/0FH5Cxvr
         nTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGzNfHsdBeelZXZ+9pdeOdRwxoep69m+sBveAvzb7jo=;
        b=f89T5osbaxifluIQOQjoUp+H4b0gFHq+ODLMXa+a4NSgrGZ2KeqJ2bIuoR5o8w5fV1
         FbGnHRUIwqXnkpwpgzg9vKa90IRUcbY+yLwh5/SLy7OgShl9DAyC74c21CbNerT4Ll2/
         Gs5g1x9NQ75pIQ5IP32QjH8/XVBvWgcx7q9s31WMnHL1We8DhgBUYvW8gBodRJfhPe6J
         E1/fOucoiQV2dm6Ef5Ry84wABkkJlu5Sl7jbAUuyTcnMdJA4EdbQxD4Ezwm26X2Kds5F
         damFRLe1wzuZrWZCMhI3O6I+m9IqP4vxGUZoYmHsio6VCzZWC3mZI8xqaVjA4D9G7x/Z
         nMdw==
X-Gm-Message-State: AOAM530Bc1LfvINdDkjBhPY3hv8GsKQHEgu2T1zfiKaKwTv1gxw6BjeW
        OtZXgfCjjbzxGFeh2pCL9iKlLz+3
X-Google-Smtp-Source: ABdhPJwobyKzNGWrubBfOT3FwA8kgdW/bXQnL7no+xBvgZIhVPGCMy9FLASiFxHbHxdjytaruw7sww==
X-Received: by 2002:a63:e1f:: with SMTP id d31mr201706pgl.262.1597367507874;
        Thu, 13 Aug 2020 18:11:47 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id i11sm4793281pjg.50.2020.08.13.18.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:11:47 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] ext4: limit the length of per-inode prealloc list
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
 <20200813135254.54102A4059@d06av23.portsmouth.uk.ibm.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <6c2e1231-e7a7-bb22-7eed-0e418cf6056d@gmail.com>
Date:   Fri, 14 Aug 2020 09:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813135254.54102A4059@d06av23.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for review this patch :)

Ritesh Harjani wrote on 2020/8/13 21:52:
> Hi brookxu,
> 
> Few queries
> 
> On 8/7/20 2:14 PM, brookxu wrote:
>> In the scenario of writing sparse files, the Per-inode prealloc list may
>> be very long, resulting in high overhead for ext4_mb_use_preallocated().
>> To circumvent this problem, we limit the maximum length of per-inode
>> prealloc list to 512 and allow users to modify it.
>>
>> After patching, we observed that the sys ratio of cpu has dropped, and
>> the system throughput has increased significantly. We created a process
>> to write the sparse file, and the running time of the process on the
>> fixed kernel was significantly reduced, as follows:
>>
>> Running time on unfixed kernel：
>> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>> real    0m2.051s
>> user    0m0.008s
>> sys     0m2.026s
>>
>> Running time on fixed kernel：
>> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>> real    0m0.471s
>> user    0m0.004s
>> sys     0m0.395s
> 
> 
> Please use "--thread" option in your git-format-patch script. So that
> your patch series comes in a threaded form. It is easier then to apply
> the series.
> 
> Somehow I am unable to get my head around how this patch is working.
> Could you please help explain the theory of operation by answering below
> queries.
> 
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>   fs/ext4/ext4.h              |  3 ++-
>>   fs/ext4/extents.c           | 10 ++++----
>>   fs/ext4/file.c              |  2 +-
>>   fs/ext4/indirect.c          |  2 +-
>>   fs/ext4/inode.c             |  6 ++---
>>   fs/ext4/ioctl.c             |  2 +-
>>   fs/ext4/mballoc.c           | 57 +++++++++++++++++++++++++++++++++++++++++----
>>   fs/ext4/mballoc.h           |  4 ++++
>>   fs/ext4/move_extent.c       |  4 ++--
>>   fs/ext4/super.c             |  2 +-
>>   fs/ext4/sysfs.c             |  2 ++
>>   include/trace/events/ext4.h | 14 ++++++-----
>>   12 files changed, 83 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 42f5060..68e0ebe 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1501,6 +1501,7 @@ struct ext4_sb_info {
>>       unsigned int s_mb_stats;
>>       unsigned int s_mb_order2_reqs;
>>       unsigned int s_mb_group_prealloc;
>> +    unsigned int s_mb_max_inode_prealloc;
>>       unsigned int s_max_dir_size_kb;
>>       /* where last allocation was done - for stream allocation */
>>       unsigned long s_mb_last_group;
>> @@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
>>   extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>>                   struct ext4_allocation_request *, int *);
>>   extern int ext4_mb_reserve_blocks(struct super_block *, int);
>> -extern void ext4_discard_preallocations(struct inode *);
>> +extern void ext4_discard_preallocations(struct inode *, unsigned int);
>>   extern int __init ext4_init_mballoc(void);
>>   extern void ext4_exit_mballoc(void);
>>   extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 221f240..a40f928 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>>        * i_mutex. So we can safely drop the i_data_sem here.
>>        */
>>       BUG_ON(EXT4_JOURNAL(inode) == NULL);
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>       up_write(&EXT4_I(inode)->i_data_sem);
>>       *dropped = 1;
>>       return 0;
>> @@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>>                * not a good idea to call discard here directly,
>>                * but otherwise we'd need to call it every free().
>>                */
>> -            ext4_discard_preallocations(inode);
>> +            ext4_discard_preallocations(inode, 0);
>>               if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>>                   fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
>>               ext4_free_blocks(handle, inode, NULL, newblock,
>> @@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>       }
>>
>>       down_write(&EXT4_I(inode)->i_data_sem);
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>
>>       ret = ext4_es_remove_extent(inode, punch_start,
>>                       EXT_MAX_BLOCKS - punch_start);
>> @@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>           up_write(&EXT4_I(inode)->i_data_sem);
>>           goto out_stop;
>>       }
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>
>>       ret = ext4_ext_shift_extents(inode, handle, punch_stop,
>>                        punch_stop - punch_start, SHIFT_LEFT);
>> @@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>           goto out_stop;
>>
>>       down_write(&EXT4_I(inode)->i_data_sem);
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>
>>       path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>>       if (IS_ERR(path)) {
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 2a01e31..e3ab8ea 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>>                   !EXT4_I(inode)->i_reserved_data_blocks)
>>       {
>>           down_write(&EXT4_I(inode)->i_data_sem);
>> -        ext4_discard_preallocations(inode);
>> +        ext4_discard_preallocations(inode, 0);
>>           up_write(&EXT4_I(inode)->i_data_sem);
>>       }
>>       if (is_dx(inode) && filp->private_data)
>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>> index be2b66e..ec6b930 100644
>> --- a/fs/ext4/indirect.c
>> +++ b/fs/ext4/indirect.c
>> @@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
>>        * i_mutex. So we can safely drop the i_data_sem here.
>>        */
>>       BUG_ON(EXT4_JOURNAL(inode) == NULL);
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>       up_write(&EXT4_I(inode)->i_data_sem);
>>       *dropped = 1;
>>       return 0;
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 10dd470..bb9e1cd 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>>        */
>>       if ((ei->i_reserved_data_blocks == 0) &&
>>           !inode_is_open_for_write(inode))
>> -        ext4_discard_preallocations(inode);
>> +        ext4_discard_preallocations(inode, 0);
>>   }
>>
>>   static int __check_block_validity(struct inode *inode, const char *func,
>> @@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>>       if (stop_block > first_block) {
>>
>>           down_write(&EXT4_I(inode)->i_data_sem);
>> -        ext4_discard_preallocations(inode);
>> +        ext4_discard_preallocations(inode, 0);
>>
>>           ret = ext4_es_remove_extent(inode, first_block,
>>                           stop_block - first_block);
>> @@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
>>
>>       down_write(&EXT4_I(inode)->i_data_sem);
>>
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>
>>       if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>           err = ext4_ext_truncate(handle, inode);
>> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>> index 999cf6a..a5fcc23 100644
>> --- a/fs/ext4/ioctl.c
>> +++ b/fs/ext4/ioctl.c
>> @@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>>       reset_inode_seed(inode);
>>       reset_inode_seed(inode_bl);
>>
>> -    ext4_discard_preallocations(inode);
>> +    ext4_discard_preallocations(inode, 0);
>>
>>       err = ext4_mark_inode_dirty(handle, inode);
>>       if (err < 0) {
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 4f21f34..28a139f 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
>>       sbi->s_mb_stats = MB_DEFAULT_STATS;
>>       sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
>>       sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
>> +    sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
>>       /*
>>        * The default group preallocation is 512, which for 4k block
>>        * sizes translates to 2 megabytes.  However for bigalloc file
>> @@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>>    *
>>    * FIXME!! Make sure it is valid at all the call sites
>>    */
>> -void ext4_discard_preallocations(struct inode *inode)
>> +void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>>   {
>>       struct ext4_inode_info *ei = EXT4_I(inode);
>>       struct super_block *sb = inode->i_sb;
>> @@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode *inode)
>>
>>       mb_debug(sb, "discard preallocation for inode %lu\n",
>>            inode->i_ino);
>> -    trace_ext4_discard_preallocations(inode);
>> +    trace_ext4_discard_preallocations(inode,  needed);
>>
>>       INIT_LIST_HEAD(&list);
>>
>> +    if (needed == 0)
>> +        needed = UINT_MAX;
>> +
>>   repeat:
>>       /* first, collect all pa's in the inode */
>>       spin_lock(&ei->i_prealloc_lock);
>> -    while (!list_empty(&ei->i_prealloc_list)) {
>> -        pa = list_entry(ei->i_prealloc_list.next,
>> +    while (!list_empty(&ei->i_prealloc_list) && needed) {
>> +        pa = list_entry(ei->i_prealloc_list.prev,
>>                   struct ext4_prealloc_space, pa_inode_list);
>>           BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
>>           spin_lock(&pa->pa_lock);
>> @@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode *inode)
>>               spin_unlock(&pa->pa_lock);
>>               list_del_rcu(&pa->pa_inode_list);
>>               list_add(&pa->u.pa_tmp_list, &list);
>> +            needed--;
>>               continue;
>>           }
>>
>> @@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>>   }
>>
>>   /*
>> + * if per-inode prealloc list is too long, trim some PA
>> + */
>> +static void
>> +ext4_mb_trim_inode_pa(struct inode *inode)
>> +{
>> +    struct ext4_inode_info *ei = EXT4_I(inode);
>> +    struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> +    struct ext4_prealloc_space *pa;
>> +    int count = 0, delta;
>> +
>> +    rcu_read_lock();
>> +    list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
>> +        spin_lock(&pa->pa_lock);
>> +        if (pa->pa_deleted) {
>> +            spin_unlock(&pa->pa_lock);
>> +            continue;
>> +        }
>> +        count++;
>> +        spin_unlock(&pa->pa_lock);
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
>> +    if (count > sbi->s_mb_max_inode_prealloc + delta) {
>> +        count -= sbi->s_mb_max_inode_prealloc;
>> +        ext4_discard_preallocations(inode, count);
>> +    }
>> +}
>> +
>> +/*
>>    * release all resource we used in allocation
>>    */
>>   static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>>   {
>> +    struct inode *inode = ac->ac_inode;
>> +    struct ext4_inode_info *ei = EXT4_I(inode);
>>       struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>>       struct ext4_prealloc_space *pa = ac->ac_pa;
>>       if (pa) {
>> @@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>>                   ext4_mb_add_n_trim(ac);
>>               }
>>           }
>> +
>> +        if (pa->pa_type == MB_INODE_PA) {
>> +            /*
>> +             * treat per-inode prealloc list as a lru list, then try
>> +             * to trim the least recently used PA.
>> +             */
>> +            spin_lock(pa->pa_obj_lock);
>> +            list_move(&ei->i_prealloc_list, &pa->pa_inode_list);
> 
> So what you are doing here is essentially moving back ei->i_prealloc_list back into pa->pa_inode_lis

The operation here uses LRU to maintain the prealloc list, so we can trim the least recently used PA
from the tail of the list. According to the principle of locality, this may reduce the impact on the
program.

> Then in ext4_mb_trim_inode_pa(), it will traverse over i_prealloc_list
> which is empty anyways no? (considering single threaded write here).
> I am definitely missing something, could you help explain how is it
> getting trimmed then?

In our scenario, format an ext3 file system(no da), and then creat a daemon to write data to a sparse
file. Due to the large offset(10M) of each writing position, the system will create a large number of PAs.
In general, the inode prealloc list is released on truncate, puch hole, release file, da, abnormal
block allocation path, etc. But in this scene, none of the above paths have been reached, which causes
the length of the prealloc list to get out of control. This phenomenon may be similar in both single-task
and multi-task scenarios.

> and how are you adding it back to ext4_inode_info->i_prealloc_list
> which is traversed to check if we can use pe-existing preallocation> of an inode in ext4_mb_use_preallocated(ac)

When block allocation is needed, the system will try to search inode prealloc list first, and small files
may try to continue searching percpu locality group prealloc list. If this fails, the system will request
the mb allocator, which will normalize the request, so we may get extra space, but this strategy is good.
After the request is processed, the system will create a new PA and add it to the prealloc list. The trim
here may theoretically lead to increased fragmentation or increased mb consumption. Since the default
length is 512 and we give priority to trim the least recently used PA, the actual test did not find any
relevant effects. In our actual business tests, we found that the system sys overhead has been reduced,
and the throughput of the whole machine has also increased significantly.
 
> 
>> +            spin_unlock(pa->pa_obj_lock);
>> +        }
>> +
>>           ext4_mb_put_pa(ac, ac->ac_sb, pa);
>>       }
>>       if (ac->ac_bitmap_page)
>> @@ -4587,6 +4635,7 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>>       if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
>>           mutex_unlock(&ac->ac_lg->lg_mutex);
>>       ext4_mb_collect_stats(ac);
>> +    ext4_mb_trim_inode_pa(inode);
>>       return 0;
>>   }
>>

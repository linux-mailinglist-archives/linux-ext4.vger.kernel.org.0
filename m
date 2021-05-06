Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52437532E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhEFLsP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 07:48:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18357 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhEFLsO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 07:48:14 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FbWwN17Dkzlc5w;
        Thu,  6 May 2021 19:45:08 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 19:47:11 +0800
Subject: Re: [PATCH v3] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
To:     Jan Kara <jack@suse.cz>
References: <20210428085158.3728201-1-yebin10@huawei.com>
 <20210430125853.GB5315@quack2.suse.cz> <60921135.3030900@huawei.com>
 <20210505104105.GA29867@quack2.suse.cz> <6093A830.3000704@huawei.com>
 <20210506101915.GA22189@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <6093D73F.70909@huawei.com>
Date:   Thu, 6 May 2021 19:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20210506101915.GA22189@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/5/6 18:19, Jan Kara wrote:
> On Thu 06-05-21 16:26:24, yebin wrote:
>> Thanks for your suggesttion. If you have no objection to following
>> modification, i will send it as V4.
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 77c84d6f1af6..f9cbd11e1eae 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3206,7 +3206,10 @@ static int ext4_split_extent_at(handle_t *handle,
>>                  ext4_ext_mark_unwritten(ex2);
>>
>>          err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
>> -       if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
>> +       if (err != -ENOSPC && err != -EDQUOT)
>> +                goto out;
>> +
>> +       if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> You need:
>
> if (err && (EXT4_EXT_MAY_ZEROOUT & split_flag))
>
> there, don't you? You don't want to zero-out if there's no error.

If (err != -ENOSPC && err != -EDQUOT) already goto out, so there is needn't
judge "err" again.

>
>> @@ -3232,22 +3235,23 @@ static int ext4_split_extent_at(handle_t *handle,
>> ext4_ext_pblock(&orig_ex));
>>                  }
>>
>> -               if (err)
>> -                       goto fix_extent_len;
>> -               /* update the extent length and mark as initialized */
>> -               ex->ee_len = cpu_to_le16(ee_len);
>> -               ext4_ext_try_to_merge(handle, inode, path, ex);
>> -               err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>> -               if (err)
>> -                       goto fix_extent_len;
>> -
>> -               /* update extent status tree */
>> -               err = ext4_zeroout_es(inode, &zero_ex);
>> -
>> -               goto out;
>> -       } else if (err)
>> -               goto fix_extent_len;
>> -
>> +               if (!err) {
>> +                       /* update the extent length and mark as initialized
>> */
>> +                        ex->ee_len = cpu_to_le16(ee_len);
>> +                        ext4_ext_try_to_merge(handle, inode, path, ex);
>> +                        err = ext4_ext_dirty(handle, inode, path +
>> path->p_depth);
>> +                        if (!err)
>> +                               /* update extent status tree */
>> +                                err = ext4_zeroout_es(inode, &zero_ex);
>> +                        /* At here, ext4_ext_try_to_merge maybe already
>> merge
>> +                         * extent, if fix origin extent length may lead to
>> +                         * overwritten.
>> +                         */
> I'd rephrase the comment as:
>
> /*
>   * If we failed at this point, we don't know in which state the extent tree
>   * exactly is so don't try to fix length of the original extent as it may do
>   * even more damage.
>   */
I will replace it with your comment.
>
>> +                        goto out;
>> +                }
>> +       }
>> +        if (err)
>> +                goto fix_extent_len;
> And you can move this if (err) before if (!err) above to make code easier
> to read and save one indentation level.
if (EXT4_EXT_MAY_ZEROOUT & split_flag) do zero-out,  if  failed, we 
don't need fix extent length.
But if (!EXT4_EXT_MAY_ZEROOUT & split_flag) we need to fix extent 
length.  Maybe i can move
label "out"  behind  label "fix_extent_len", then this judement can be 
removed.
Did i misunderstand what you meant earlier?
>>   out:
>>          ext4_ext_show_leaf(inode, path);
>>          return err;
>>
>>
> 								Honza
The diff as following:
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 77c84d6f1af6..cbf37b2cf871 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3206,7 +3206,10 @@ static int ext4_split_extent_at(handle_t *handle,
                 ext4_ext_mark_unwritten(ex2);

         err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-       if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
+       if (err != -ENOSPC && err != -EDQUOT)
+               goto out;
+
+       if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
                 if (split_flag & 
(EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
                         if (split_flag & EXT4_EXT_DATA_VALID1) {
                                 err = ext4_ext_zeroout(inode, ex2);
@@ -3232,25 +3235,22 @@ static int ext4_split_extent_at(handle_t *handle,
ext4_ext_pblock(&orig_ex));
                 }

-               if (err)
-                       goto fix_extent_len;
-               /* update the extent length and mark as initialized */
-               ex->ee_len = cpu_to_le16(ee_len);
-               ext4_ext_try_to_merge(handle, inode, path, ex);
-               err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-               if (err)
-                       goto fix_extent_len;
-
-               /* update extent status tree */
-               err = ext4_zeroout_es(inode, &zero_ex);
-
-               goto out;
-       } else if (err)
-               goto fix_extent_len;
-
-out:
-       ext4_ext_show_leaf(inode, path);
-       return err;
+               if (!err) {
+                       /* update the extent length and mark as 
initialized */
+                       ex->ee_len = cpu_to_le16(ee_len);
+                       ext4_ext_try_to_merge(handle, inode, path, ex);
+                       err = ext4_ext_dirty(handle, inode, path + 
path->p_depth);
+                       if (!err)
+                               /* update extent status tree */
+                               err = ext4_zeroout_es(inode, &zero_ex);
+                       /* If we failed at this point, we don't know in 
which
+                        * state the extent tree exactly is so don't try 
to fix
+                        * length of the original extent as it may do 
even more
+                        * damage.
+                        */
+                       goto out;
+               }
+       }

  fix_extent_len:
         ex->ee_len = orig_ex.ee_len;
@@ -3260,6 +3260,9 @@ static int ext4_split_extent_at(handle_t *handle,
          */
         ext4_ext_dirty(handle, inode, path + path->p_depth);
         return err;
+out:
+       ext4_ext_show_leaf(inode, path);
+       return err;
  }

The whole code as folowing:
ext4_split_extent_at:
.......
3208         err = ext4_ext_insert_extent(handle, inode, ppath, &newex, 
flags);
3209         if (err != -ENOSPC && err != -EDQUOT)
3210                 goto out;
3211
3212         if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
3213                 if (split_flag & 
(EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
3214                         if (split_flag & EXT4_EXT_DATA_VALID1) {
3215                                 err = ext4_ext_zeroout(inode, ex2);
3216                                 zero_ex.ee_block = ex2->ee_block;
3217                                 zero_ex.ee_len = cpu_to_le16(
3218 ext4_ext_get_actual_len(ex2));
3219 ext4_ext_store_pblock(&zero_ex,
3220 ext4_ext_pblock(ex2));
3221                         } else {
3222                                 err = ext4_ext_zeroout(inode, ex);
3223                                 zero_ex.ee_block = ex->ee_block;
3224                                 zero_ex.ee_len = cpu_to_le16(
3225 ext4_ext_get_actual_len(ex));
3226 ext4_ext_store_pblock(&zero_ex,
3227 ext4_ext_pblock(ex));
3228                         }
3229                 } else {
3230                         err = ext4_ext_zeroout(inode, &orig_ex);
3231                         zero_ex.ee_block = orig_ex.ee_block;
3232                         zero_ex.ee_len = cpu_to_le16(
3233 ext4_ext_get_actual_len(&orig_ex));
3234                         ext4_ext_store_pblock(&zero_ex,
3235 ext4_ext_pblock(&orig_ex));
3236                 }
3237
3238                 if (!err) {
3239                         /* update the extent length and mark as 
initialized */
3240                         ex->ee_len = cpu_to_le16(ee_len);
3241                         ext4_ext_try_to_merge(handle, inode, path, ex);
3242                         err = ext4_ext_dirty(handle, inode, path + 
path->p_depth);
3243                         if (!err)
3244                                 /* update extent status tree */
3245                                 err = ext4_zeroout_es(inode, &zero_ex);
3246                         /* If we failed at this point, we don't 
know in which
3247                          * state the extent tree exactly is so 
don't try to fix
3248                          * length of the original extent as it may 
do even more
3249                          * damage.
3250                          */
3251                         goto out;
3252                 }
3253         }
3254
3255 fix_extent_len:
3256         ex->ee_len = orig_ex.ee_len;
3257         /*
3258          * Ignore ext4_ext_dirty return value since we are already 
in error path
3259          * and err is a non-zero error code.
3260          */
3261         ext4_ext_dirty(handle, inode, path + path->p_depth);
3262         return err;
3263 out:
3264         ext4_ext_show_leaf(inode, path);
3265         return err;
3266 }



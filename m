Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26A3750AE
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhEFI1a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 04:27:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18004 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhEFI11 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 04:27:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbRRM54v7zQjdF;
        Thu,  6 May 2021 16:23:11 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 16:26:24 +0800
Subject: Re: [PATCH v3] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
To:     Jan Kara <jack@suse.cz>
References: <20210428085158.3728201-1-yebin10@huawei.com>
 <20210430125853.GB5315@quack2.suse.cz> <60921135.3030900@huawei.com>
 <20210505104105.GA29867@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <6093A830.3000704@huawei.com>
Date:   Thu, 6 May 2021 16:26:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20210505104105.GA29867@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/5/5 18:41, Jan Kara wrote:
> On Wed 05-05-21 11:29:57, yebin wrote:
>>
>> On 2021/4/30 20:58, Jan Kara wrote:
>>> On Wed 28-04-21 16:51:58, Ye Bin wrote:
>>>> We got follow bug_on when run fsstress with injecting IO fault:
>>>> [130747.323114] kernel BUG at fs/ext4/extents_status.c:762!
>>>> [130747.323117] Internal error: Oops - BUG: 0 [#1] SMP
>>>> ......
>>>> [130747.334329] Call trace:
>>>> [130747.334553]  ext4_es_cache_extent+0x150/0x168 [ext4]
>>>> [130747.334975]  ext4_cache_extents+0x64/0xe8 [ext4]
>>>> [130747.335368]  ext4_find_extent+0x300/0x330 [ext4]
>>>> [130747.335759]  ext4_ext_map_blocks+0x74/0x1178 [ext4]
>>>> [130747.336179]  ext4_map_blocks+0x2f4/0x5f0 [ext4]
>>>> [130747.336567]  ext4_mpage_readpages+0x4a8/0x7a8 [ext4]
>>>> [130747.336995]  ext4_readpage+0x54/0x100 [ext4]
>>>> [130747.337359]  generic_file_buffered_read+0x410/0xae8
>>>> [130747.337767]  generic_file_read_iter+0x114/0x190
>>>> [130747.338152]  ext4_file_read_iter+0x5c/0x140 [ext4]
>>>> [130747.338556]  __vfs_read+0x11c/0x188
>>>> [130747.338851]  vfs_read+0x94/0x150
>>>> [130747.339110]  ksys_read+0x74/0xf0
>>>>
>>>> If call ext4_ext_insert_extent failed but new extent already inserted, we just
>>>> update "ex->ee_len = orig_ex.ee_len", this will lead to extent overlap, then
>>>> cause bug on when cache extent.
>>> Thanks for the patch but I'm still not quite sure, how overlapping extents
>>> in the extent tree can lead to triggering BUG_ON(lblk + len - 1 < lblk) in
>>> ext4_es_cache_extent().  Can you ellaborate a bit more how this happens?
>> Assume that there is  extent  [10, 100] (ee_block=10 ee_len=91), call
>> ext4_split_extent_at  split at  50,
>> we get two  extent [10, 49] and [50, 100], then call ext4_ext_insert_extent
>> to insert  new  extent [50, 100],
>> if insert extent  successed, but call ext4_ext_dirty  failed(return -EROFS)
>> as JBD maybe abort as io error.
>> Then fix  old extent  length with  old  value, so we get two extent   [10,
>> 100] (ee_block=10 ee_len=91) and
>> [50, 100](ee_block=50 ee_len=51).
>> If call ext4_cache_extent to cache above extents as follow:
>> prev = 0 lblk = 10 len = 91 --> cache  [10, 100] ---> prev = lblk + len =
>> 101
>> prev = 101  lblk = 50 len = 51 --> prev != 0 && prev != lblk --> cache [prev
>> = 101, lblk - prev = 50 - 101 = -51]
>> Obvious if call ext4_es_cache_extent cache  extent[101, -51] wil trigger
>> "BUG_ON(end < lblk)" .
> Thanks for great explanation! Now I understand.
>
>>>> If call ext4_ext_insert_extent failed don't update ex->ee_len with old value.
>>>> Maybe there will lead to block leak, but it can be fixed by fsck later.
>>>>
>>>> After we fixed above issue with v2 patch, but we got the same issue.
>>>> ext4_split_extent_at:
>>>> {
>>>>           ......
>>>>           err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
>>>>           if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
>>>>               ......
>>>>               ext4_ext_try_to_merge(handle, inode, path, ex); ->step(1)
>>>>               err = ext4_ext_dirty(handle, inode, path + path->p_depth); ->step(2)
>>>>               if (err)
>>>>                   goto fix_extent_len;
>>>>           ......
>>>>           }
>>>>           ......
>>>> fix_extent_len:
>>>>           ex->ee_len = orig_ex.ee_len; ->step(3)
>>>>           ......
>>>> }
>>>> If step(1) have been merged, but step(2) dirty extent failed, then go to
>>>> fix_extent_len label to fix ex->ee_len with orig_ex.ee_len. But "ex" may not be
>>>> old one, will cause overwritten. Then will trigger the same issue as previous.
>>>> If step(2) failed, just return error, don't fix ex->ee_len with old value.
>>>>
>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>>> ---
>>>>    fs/ext4/extents.c | 13 +++++--------
>>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>> index 77c84d6f1af6..d4aa24a09d8b 100644
>>>> --- a/fs/ext4/extents.c
>>>> +++ b/fs/ext4/extents.c
>>>> @@ -3238,15 +3238,12 @@ static int ext4_split_extent_at(handle_t *handle,
>>>>    		ex->ee_len = cpu_to_le16(ee_len);
>>>>    		ext4_ext_try_to_merge(handle, inode, path, ex);
>>>>    		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>>>> -		if (err)
>>>> -			goto fix_extent_len;
>>>> -
>>>> -		/* update extent status tree */
>>>> -		err = ext4_zeroout_es(inode, &zero_ex);
>>>> -
>>>> -		goto out;
>>>> -	} else if (err)
>>>> +		if (!err)
>>>> +		        /* update extent status tree */
>>>> +		        err = ext4_zeroout_es(inode, &zero_ex);
>>>> +	} else if (err && err != -EROFS) {
>>> I fail to see why EROFS is special here. Can you explain a bit please?
>>   V1 patch Ted suggest me  to fix length  only  when "err != -EROSFS". As if
>> we don't
>> fix origin extent with old extent length, it will lead to block leak.
>> Ted said as follow:
>>
>> If you don't want to do that, then a "do no harm" fix would be
>> something like this:
>>
>> 	...
>> 	} else if (err == -EROFS) {
>> 		return err;
>> 	} else if (err)
>> 		goto fix_extent_len;
>>
>> So in the journal abort case, when err is set to EROFS, we don't try
>> to reset the length, since in theory the file system is read-only
>> already anyway.  However, in the ENOSPC case, we won't end up silently
>> leaking blocks that will be lost until the user somehow decides to run
>> fsck.
> I see. Now I understand your patch. Honestly, seeing how fragile is trying
> to fix extent tree after split has failed in the middle, I would probably
> go even further and make sure we fix the tree properly in case of ENOSPC
> and EDQUOT (those are easily user triggerable).  Anything else indicates a
> HW problem or fs corruption so I'd rather leave the extent tree as is and
> don't try to fix it (which also means we will not create overlapping
> extents). So something like:
>
>
>          err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -       if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
> +       if (err == -ENOSPC || err == -EDQUOT) {
> +		if (EXT4_EXT_MAY_ZEROOUT & split_flag)
> +			err = handle zeroing...
> 		if (err) {
> 			fix extent len
> 			goto out;
> 		}
> ...
> 	}
>
> and in all other cases just 'goto out' in case of error. What do you think?
>
> 								Honza
Thanks for your suggesttion. If you have no objection to following 
modification, i will send it as V4.

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 77c84d6f1af6..f9cbd11e1eae 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3206,7 +3206,10 @@ static int ext4_split_extent_at(handle_t *handle,
                 ext4_ext_mark_unwritten(ex2);

         err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-       if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
+       if (err != -ENOSPC && err != -EDQUOT)
+                goto out;
+
+       if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
                 if (split_flag & 
(EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
                         if (split_flag & EXT4_EXT_DATA_VALID1) {
                                 err = ext4_ext_zeroout(inode, ex2);
@@ -3232,22 +3235,23 @@ static int ext4_split_extent_at(handle_t *handle,
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
+               if (!err) {
+                       /* update the extent length and mark as 
initialized */
+                        ex->ee_len = cpu_to_le16(ee_len);
+                        ext4_ext_try_to_merge(handle, inode, path, ex);
+                        err = ext4_ext_dirty(handle, inode, path + 
path->p_depth);
+                        if (!err)
+                               /* update extent status tree */
+                                err = ext4_zeroout_es(inode, &zero_ex);
+                        /* At here, ext4_ext_try_to_merge maybe already 
merge
+                         * extent, if fix origin extent length may lead to
+                         * overwritten.
+                         */
+                        goto out;
+                }
+       }
+        if (err)
+                goto fix_extent_len;
  out:
         ext4_ext_show_leaf(inode, path);
         return err;



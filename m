Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5C45BB25
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 13:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbhKXMQ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Nov 2021 07:16:56 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28104 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbhKXMO4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Nov 2021 07:14:56 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hzftw35YNz1DJdd;
        Wed, 24 Nov 2021 20:09:12 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 20:11:44 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 20:11:44 +0800
Subject: Re: [PATCH] ext4: if zeroout fails fall back to splitting the extent
 node
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <YRaNKc2PvM+Eyzmp@mit.edu> <20210813212701.366447-1-tytso@mit.edu>
 <715f636e-ff1b-301f-38a9-602437fdd95a@huawei.com>
 <20211123092741.GA8583@quack2.suse.cz>
 <d5346e36-3331-0d0d-e36d-83f543986ccb@huawei.com>
 <20211124103737.GI8583@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <9e47b349-0360-3426-dfa3-cc77f444fac3@huawei.com>
Date:   Wed, 24 Nov 2021 20:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20211124103737.GI8583@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/11/24 18:37, Jan Kara wrote:
> On Wed 24-11-21 17:01:12, yangerkun wrote:
>> On 2021/11/23 17:27, Jan Kara wrote:
>>> Hello,
>>>
>>> On Sun 26-09-21 19:35:01, yangerkun wrote:
>>>> Rethink about this problem. Should we consider other place which call
>>>> ext4_issue_zeroout? Maybe it can trigger the problem too(in theory, not
>>>> really happened)...
>>>>
>>>> How about include follow patch which not only transfer ENOSPC to EIO. But
>>>> also stop to overwrite the error return by ext4_ext_insert_extent in
>>>> ext4_split_extent_at.
>>>>
>>>> Besides, 308c57ccf431 ("ext4: if zeroout fails fall back to splitting the
>>>> extent node") can work together with this patch.
>>>
>>> I've got back to this. The ext4_ext_zeroout() calls in
>>> ext4_split_extent_at() seem to be there as fallback when insertion of a new
>>> extent fails due to ENOSPC / EDQUOT. If even ext4_ext_zeroout(), then I
>>> think returning an error as the code does now is correct and we don't have
>>> much other option. Also we are really running out of disk space so I think
>>> returning ENOSPC is fine. What exact scenario are you afraid of?
>>
>> I am afraid about the EDQUOT from ext4_ext_insert_extent may be overwrite by
>> ext4_ext_zeroout with ENOSPC. And this may lead to dead loop since
>> ext4_writepages will retry once get ENOSPC? Maybe I am wrong...
> 
> OK, so passing back original error instead of the error from
> ext4_ext_zeroout() makes sense. But I don't think doing much more is needed
> - firstly, ENOSPC or EDQUOT should not happen in ext4_split_extent_at()
> called from ext4_writepages() because we should have reserved enough
> space for extent splits when writing data. So hitting that is already

ext4_da_write_begin
   ext4_da_get_block_prep
     ext4_insert_delayed_block
       ext4_da_reserve_space

It seems we will only reserve space for data, no for metadata...


> unexpected. Committing transaction holding blocks that are expected to be
> free is the most likely reason for us seeing ENOSPC and returning EIO in
> that case would be bug. 

Agree. EIO from ext4_ext_zeroout that overwrite the ENOSPC from
ext4_ext_insert_extent seems buggy too. Maybe we should ignore the error
from ext4_ext_zeroout and return the error from ext4_ext_insert_extent
once ext4_ext_zeroout in ext4_split_extent_at got a error. Something
like this:

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0ecf819bf189..56cc00ee42a1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3185,6 +3185,7 @@ static int ext4_split_extent_at(handle_t *handle,
         struct ext4_extent *ex2 = NULL;
         unsigned int ee_len, depth;
         int err = 0;
+       int err1;

         BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | 
EXT4_EXT_DATA_VALID2)) ==
                (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
@@ -3255,7 +3256,7 @@ static int ext4_split_extent_at(handle_t *handle,
         if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
                 if (split_flag & 
(EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
                         if (split_flag & EXT4_EXT_DATA_VALID1) {
-                               err = ext4_ext_zeroout(inode, ex2);
+                               err1 = ext4_ext_zeroout(inode, ex2);
                                 zero_ex.ee_block = ex2->ee_block;
                                 zero_ex.ee_len = cpu_to_le16(
 
ext4_ext_get_actual_len(ex2));
@@ -3270,7 +3271,7 @@ static int ext4_split_extent_at(handle_t *handle,
                                                       ext4_ext_pblock(ex));
                         }
                 } else {
-                       err = ext4_ext_zeroout(inode, &orig_ex);
+                       err1 = ext4_ext_zeroout(inode, &orig_ex);
                         zero_ex.ee_block = orig_ex.ee_block;
                         zero_ex.ee_len = cpu_to_le16(
 
ext4_ext_get_actual_len(&orig_ex));
@@ -3278,7 +3279,7 @@ static int ext4_split_extent_at(handle_t *handle,
                                               ext4_ext_pblock(&orig_ex));
                 }

-               if (!err) {
+               if (!err1) {
                         /* update the extent length and mark as 
initialized */
                         ex->ee_len = cpu_to_le16(ee_len);
                         ext4_ext_try_to_merge(handle, inode, path, ex);



> Secondly, returning EIO instead of ENOSPC is IMO a
> bit confusing for upper layers and makes it harder to analyze where the
> real problem is...
> 
> 								Honza
> 

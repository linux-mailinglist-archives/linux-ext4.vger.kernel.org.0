Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00FE6AA735
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Mar 2023 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCDBSE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 20:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCDBSD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 20:18:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D3D1351F;
        Fri,  3 Mar 2023 17:17:30 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PT6Kx0rZwz16Nxb;
        Sat,  4 Mar 2023 09:13:41 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 09:16:23 +0800
Subject: Re: [PATCH v2 1/2] ext4: introduce 'update_only' parameter for
 ext4_find_inline_data_nolock()
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20230303082158.4012809-1-yebin@huaweicloud.com>
 <20230303082158.4012809-2-yebin@huaweicloud.com>
 <20230303095536.7h7hlpf5v54tjpbj@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <64029BE6.6060003@huawei.com>
Date:   Sat, 4 Mar 2023 09:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230303095536.7h7hlpf5v54tjpbj@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/3/3 17:55, Jan Kara wrote:
> On Fri 03-03-23 16:21:57, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Introduce 'update_only' parameter for ext4_find_inline_data_nolock() to
>> use this function to update 'inline_off' only.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Now looking at the patch maybe we could do better? The call in
> ext4_write_inline_data_end() is there also only to update i_inline_off and
> setting EXT4_STATE_MAY_INLINE_DATA from that call is not strictly
> problematic (we are just writing new inline data so we cannot be converting
> them) but not necessary either. So maybe we should instead move setting of
> EXT4_STATE_MAY_INLINE_DATA into ext4_iget_extra_inode() and remove it from
> ext4_find_inline_data_nolock()? Then we won't need the 'update_only'
> argument...
>
> 								Honza
Thank you for your suggestion. It really seems to be a good idea. I will 
send new patches.
>> ---
>>   fs/ext4/ext4.h   | 2 +-
>>   fs/ext4/inline.c | 7 ++++---
>>   fs/ext4/inode.c  | 2 +-
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 4eeb02d456a9..b073976f4bf2 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3545,7 +3545,7 @@ extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
>>   
>>   /* inline.c */
>>   extern int ext4_get_max_inline_size(struct inode *inode);
>> -extern int ext4_find_inline_data_nolock(struct inode *inode);
>> +extern int ext4_find_inline_data_nolock(struct inode *inode, bool update_only);
>>   extern int ext4_init_inline_data(handle_t *handle, struct inode *inode,
>>   				 unsigned int len);
>>   extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>> index 2b42ececa46d..0fa8f41de3de 100644
>> --- a/fs/ext4/inline.c
>> +++ b/fs/ext4/inline.c
>> @@ -126,7 +126,7 @@ int ext4_get_max_inline_size(struct inode *inode)
>>    * currently only used in a code path coming form ext4_iget, before
>>    * the new inode has been unlocked
>>    */
>> -int ext4_find_inline_data_nolock(struct inode *inode)
>> +int ext4_find_inline_data_nolock(struct inode *inode, bool update_only)
>>   {
>>   	struct ext4_xattr_ibody_find is = {
>>   		.s = { .not_found = -ENODATA, },
>> @@ -159,7 +159,8 @@ int ext4_find_inline_data_nolock(struct inode *inode)
>>   					(void *)ext4_raw_inode(&is.iloc));
>>   		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
>>   				le32_to_cpu(is.s.here->e_value_size);
>> -		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>> +		if (!update_only)
>> +			ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>>   	}
>>   out:
>>   	brelse(is.iloc.bh);
>> @@ -761,7 +762,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>>   		 * ext4_write_begin() called
>>   		 * ext4_try_to_write_inline_data()
>>   		 */
>> -		(void) ext4_find_inline_data_nolock(inode);
>> +		(void) ext4_find_inline_data_nolock(inode, false);
>>   
>>   		kaddr = kmap_atomic(page);
>>   		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d251d705c276..6ecaa1bef9bb 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4798,7 +4798,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>>   	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
>>   	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>>   		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
>> -		return ext4_find_inline_data_nolock(inode);
>> +		return ext4_find_inline_data_nolock(inode, false);
>>   	} else
>>   		EXT4_I(inode)->i_inline_off = 0;
>>   	return 0;
>> -- 
>> 2.31.1
>>


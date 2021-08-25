Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB73F6D2B
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 03:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhHYBix (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 21:38:53 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37399 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhHYBiw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Aug 2021 21:38:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UlfSc9z_1629855485;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UlfSc9z_1629855485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Aug 2021 09:38:06 +0800
Subject: Re: [PATCH v2] ext4: fix reserved space counter leakage
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        hsiangkao@linux.alibaba.com
References: <20210823061358.84473-1-jefflexu@linux.alibaba.com>
 <20210823203009.GA10429@localhost.localdomain>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <77ac5ffe-9769-bcb4-0600-f72ddf0aa59a@linux.alibaba.com>
Date:   Wed, 25 Aug 2021 09:38:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210823203009.GA10429@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/24/21 4:30 AM, Eric Whitney wrote:
> * Jeffle Xu <jefflexu@linux.alibaba.com>:
>> When ext4_insert_delayed block receives and recovers from an error from
>> ext4_es_insert_delayed_block(), e.g., ENOMEM, it does not release the
>> space it has reserved for that block insertion as it should. One effect
>> of this bug is that s_dirtyclusters_counter is not decremented and
>> remains incorrectly elevated until the file system has been unmounted.
>> This can result in premature ENOSPC returns and apparent loss of free
>> space.
>>
>> Another effect of this bug is that
>> /sys/fs/ext4/<dev>/delayed_allocation_blocks can remain non-zero even
>> after syncfs has been executed on the filesystem.
>>
>> Besides, add check for s_dirtyclusters_counter when inode is going to be
>> evicted and freed. s_dirtyclusters_counter can still keep non-zero until
>> inode is written back in .evict_inode(), and thus the check is delayed
>> to .destroy_inode().
>>
>> Fixes: 51865fda28e5 ("ext4: let ext4 maintain extent status tree")
>> Cc: <stable@vger.kernel.org>
>> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>> changes since v1:
>> - improve commit log suggested by Eric Whitney
>> - update "Suggested-by" title for Gao Xian, who actually found this bug
>>   code
>> - add check for s_dirtyclusters_counter in .destroy_inode()
>> ---
>>  fs/ext4/inode.c | 5 +++++
>>  fs/ext4/super.c | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d8de607849df..73daf9443e5e 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1640,6 +1640,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>>  	int ret;
>>  	bool allocated = false;
>> +	bool reserved = false;
>>  
>>  	/*
>>  	 * If the cluster containing lblk is shared with a delayed,
>> @@ -1656,6 +1657,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>>  		ret = ext4_da_reserve_space(inode);
>>  		if (ret != 0)   /* ENOSPC */
>>  			goto errout;
>> +		reserved = true;
>>  	} else {   /* bigalloc */
>>  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>>  			if (!ext4_es_scan_clu(inode,
>> @@ -1668,6 +1670,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>>  					ret = ext4_da_reserve_space(inode);
>>  					if (ret != 0)   /* ENOSPC */
>>  						goto errout;
>> +					reserved = true;
>>  				} else {
>>  					allocated = true;
>>  				}
>> @@ -1678,6 +1681,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>>  	}
>>  
>>  	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
>> +	if (ret && reserved)
>> +		ext4_da_release_space(inode, 1);
>>  
>>  errout:
>>  	return ret;
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index dfa09a277b56..61bf52b58fca 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1351,6 +1351,12 @@ static void ext4_destroy_inode(struct inode *inode)
>>  				true);
>>  		dump_stack();
>>  	}
>> +
>> +	if (EXT4_I(inode)->i_reserved_data_blocks)
>> +		ext4_msg(inode->i_sb, KERN_ERR,
>> +			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>> +			 inode->i_ino, EXT4_I(inode),
>> +			 EXT4_I(inode)->i_reserved_data_blocks);
>>  }
>>  
>>  static void init_once(void *foo)
>> -- 
>> 2.27.0
>>
> 
> Looks good, passed 4k xfstests-bld regression.  Feel free to add:
> 
> Reviewed-by: Eric Whitney <enwlinux@gmail.com>


Hi tytso, it's a bug fix and it would be great if it could be merged to
5.15.

-- 
Thanks,
Jeffle

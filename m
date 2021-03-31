Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA68834F740
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Mar 2021 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhCaDNQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 23:13:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14649 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhCaDNG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Mar 2021 23:13:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9BC46NcGzmc1x;
        Wed, 31 Mar 2021 11:10:24 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 11:12:59 +0800
Subject: Re: [PATCH] ext4: fix check to prevent false positive report of
 incorrect used inodes
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
References: <20210329061955.2437573-1-yi.zhang@huawei.com>
 <20210329142631.GC4283@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <5d6e4215-4d42-6621-1004-517caf3d3ebf@huawei.com>
Date:   Wed, 31 Mar 2021 11:12:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210329142631.GC4283@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/3/29 22:26, Jan Kara wrote:
> On Mon 29-03-21 14:19:55, Zhang Yi wrote:
>> Commit <50122847007> ("ext4: fix check to prevent initializing reserved
>> inodes") check the block group zero and prevent initializing reserved
>> inodes. But in some special cases, the reserved inode may not all belong
>> to the group zero, it may exist into the second group if we format
>> filesystem below.
>>
>>   mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
>>
>> So, it will end up triggering a false positive report of a corrupted
>> file system. This patch fix it by avoid check reserved inodes if no free
>> inode blocks will be zeroed.
>>
>> Fixes: 50122847007 ("ext4: fix check to prevent initializing reserved inodes")
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks! The patch looks correct but maybe the code can be made more
> comprehensible like I suggest below?
> 
>> @@ -1543,22 +1544,25 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
>>  	 * used inodes so we need to skip blocks with used inodes in
>>  	 * inode table.
>>  	 */
>> -	if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)))
>> -		used_blks = DIV_ROUND_UP((EXT4_INODES_PER_GROUP(sb) -
>> -			    ext4_itable_unused_count(sb, gdp)),
>> -			    sbi->s_inodes_per_block);
>> -
>> -	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
>> -	    ((group == 0) && ((EXT4_INODES_PER_GROUP(sb) -
>> -			       ext4_itable_unused_count(sb, gdp)) <
>> -			      EXT4_FIRST_INO(sb)))) {
>> -		ext4_error(sb, "Something is wrong with group %u: "
>> -			   "used itable blocks: %d; "
>> -			   "itable unused count: %u",
>> -			   group, used_blks,
>> -			   ext4_itable_unused_count(sb, gdp));
>> -		ret = 1;
>> -		goto err_out;
>> +	if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT))) {
>> +		used_inos = EXT4_INODES_PER_GROUP(sb) -
>> +			    ext4_itable_unused_count(sb, gdp);
>> +		used_blks = DIV_ROUND_UP(used_inos, sbi->s_inodes_per_block);
>> +
>> +		if (used_blks >= 0 && used_blks <= sbi->s_itb_per_group)
>> +			used_inos += group * EXT4_INODES_PER_GROUP(sb);
> 
> Maybe if would be more comprehensible like:
> 
> 		/* Bogus inode unused count? */
> 		if (used_blks < 0 || used_blks > sbi->s_itb_per_group) {
> 			ext4_error(...);
> 			ret = 1;
> 			goto err_out;
> 		}
> 
> 		used_inos += EXT4_INODES_PER_GROUP(sb);
> 		/*
> 		 * Are there some uninitialized inodes in the inode table
> 		 * before the first normal inode?
> 		 */
> 		if (used_blks != sbi->s_itb_per_group &&
> 		    used_inos < EXT4_FIRST_INO(sb)) {
> 			ext4_error(...);
> 			ret = 1;
> 			goto err_out;
> 		}

Yes, it looks more comprehensible, I will send v2 as you suggested.

Thanks,
Yi.

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96037EC9B
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 08:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfHBG2W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 02:28:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732494AbfHBG2W (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 02:28:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 97EF2BC928EEF673CD80;
        Fri,  2 Aug 2019 14:28:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 14:28:08 +0800
Subject: Re: [PATCH] ext4: fix potential use after free in system zone via
 remount with noblock_validity
To:     Jan Kara <jack@suse.cz>
References: <1563970268-33688-1-git-send-email-yi.zhang@huawei.com>
 <20190731140821.GF15806@quack2.suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <54c1c269-c874-1ff8-8ca8-a87e65227957@huawei.com>
Date:   Fri, 2 Aug 2019 14:28:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190731140821.GF15806@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your suggestions, I will look at the RCU method to solve this problem.

Thanks,
Yi.

On 2019/7/31 22:08, Jan Kara Wrote:
> On Wed 24-07-19 20:11:08, zhangyi (F) wrote:
>> Remount process will release system zone which was allocated before if
>> "noblock_validity" is specified. If we mount an ext4 file system to two
>> mountpoints whit default mount options, and then remount one of them
>> with "noblock_validity", it may trigger a use after free problem when
>> someone accessing the other one.
>>
>>  # mount /dev/sda foo
>>  # mount /dev/sda bar
>>
>> User access mountpoint "foo"   |   Remount mountpoint "bar"
>>                                |
>> ext4_map_blocks()              |   ext4_remount()
>> check_block_validity()         |   ext4_setup_system_zone()
>> ext4_data_block_valid()        |   ext4_release_system_zone()
>>                                |   free system_blks rb nodes
>> access system_blks rb nodes    |
>> trigger use after free         |
>>
>> This patch lock the system zone when accessing it to prevent it being
>> released when doing a remount with "noblock_validity" mount option.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> Cc: stable@vger.kernel.org
> 
> Thanks for the patch. It is a good catch. Some small comments below.
> 
>> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
>> index 8e83741..d9c4792 100644
>> --- a/fs/ext4/block_validity.c
>> +++ b/fs/ext4/block_validity.c
>> @@ -191,7 +191,7 @@ int ext4_setup_system_zone(struct super_block *sb)
>>  
>>  	if (!test_opt(sb, BLOCK_VALIDITY)) {
>>  		if (sbi->system_blks.rb_node)
>> -			ext4_release_system_zone(sb);
>> +			ext4_release_system_zone_lock(sb);
>>  		return 0;
>>  	}
>>  	if (sbi->system_blks.rb_node)
>> @@ -239,6 +239,14 @@ void ext4_release_system_zone(struct super_block *sb)
>>  	EXT4_SB(sb)->system_blks = RB_ROOT;
>>  }
>>  
>> +/* Called when (re)mounting the filesystem without BLOCK_VALIDITY */
>> +void ext4_release_system_zone_lock(struct super_block *sb)
>> +{
>> +	spin_lock(&EXT4_SB(sb)->system_blks_lock);
>> +	ext4_release_system_zone(sb);
>> +	spin_unlock(&EXT4_SB(sb)->system_blks_lock);
>> +}
> 
> Is there any reason why ext4_release_system_zone() should not always take
> the system_blks_lock lock? I understand it may not be necessary in all the
> cases but it won't hurt either...
> 
> Also ext4_setup_system_zone() should IMO use system_blks_lock to protect
> modifications of the rbtree. It can get called during remount as well so
> there can be racing ext4_data_block_valid() reading the rbtree at the same
> time.
> 
>> @@ -256,6 +264,13 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
>>  		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
>>  		return 0;
>>  	}
>> +
>> +	/*
>> +	 * Lock the system zone to prevent it being released concurrently
>> +	 * when doing a remount with "noblock_validity" mount option.
>> +	 */
>> +	spin_lock(&sbi->system_blks_lock);
>> +	n = sbi->system_blks.rb_node;
>>  	while (n) {
>>  		entry = rb_entry(n, struct ext4_system_zone, node);
>>  		if (start_blk + count - 1 < entry->start_blk)
>> @@ -264,9 +279,11 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
>>  			n = n->rb_right;
>>  		else {
>>  			sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
>> +			spin_unlock(&sbi->system_blks_lock);
>>  			return 0;
>>  		}
>>  	}
>> +	spin_unlock(&sbi->system_blks_lock);
>>  	return 1;
>>  }
> 
> So this will not only serialize ext4_data_block_valid() against remounts
> but also against each other. So I suspect that a read-heavy workload on
> fast storage could contend on your new fs-wide spinlock. So I think it
> would be better to have some other synchronization scheme to avoid the
> race.
> 
> If nothing else, rwlock_t would allow concurrent ext4_data_block_valid()
> calls. It is still not ideal as the calls would be still bouncing around
> the cacheline when updating the lock itself but better than nothing.
> 
> Ideal (performance-wise) would be to use RCU scheme for this -
> ext4_data_block_valid() would be RCU protected when reading the RB-tree,
> teardown of the block validity information would clear
> sbi->system_blks.rb_node and then defer actual freeing of the tree nodes to
> RCU callback. Setup would first construct the rbtree and then just set
> sbi->system_blks.rb_node to the root of the constructed tree.
> 
> That being said I'm not *sure* this is going to be a performance issue
> since ext4_map_blocks() are not that frequent and the lock hold times will
> be very short (needs testing). So maybe rwlock_t is a reasonable compromise
> between complexity and performance.
> 
> 								Honza
> 


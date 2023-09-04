Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2D791039
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 05:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjIDDAd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 23:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIDDAa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 23:00:30 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4879310A;
        Sun,  3 Sep 2023 20:00:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfD055dVqz4f3kk3;
        Mon,  4 Sep 2023 11:00:21 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgDH5LxFSPVkbLS0CA--.44142S2;
        Mon, 04 Sep 2023 11:00:22 +0800 (CST)
Subject: Re: [PATCH v6 05/11] ext4: Separate block bitmap and buddy bitmap
 freeing in ext4_mb_clear_bb()
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <878r9q8cf9.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <656f0cf0-1092-84eb-e934-534102c2fa54@huaweicloud.com>
Date:   Mon, 4 Sep 2023 11:00:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <878r9q8cf9.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgDH5LxFSPVkbLS0CA--.44142S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF47Zr1xtr13Gr4UAw47urg_yoW7GF4fpr
        9Fk3WUCrnxGFnF9r1xu34jq3WxKw48WF4UGrW3u34rCFy2qF93KF97KFy3A3ZFyFs7X3Wv
        qw4Y9rWkCrs2va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/1/2023 5:34 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> This patch separates block bitmap and buddy bitmap freeing in order to
>> udpate block bitmap with ext4_mb_mark_context in following patch.
> ^^^ update.
> 
>>
>> Separated freeing is safe with concurrent allocation as long as:
>> 1. Firstly allocate block in buddy bitmap, and then in block bitmap.
>> 2. Firstly free block in block bitmap, and then buddy bitmap.
>> Then freed block will only be available to allocation when both buddy
>> bitmap and block bitmap are updated by freeing.
>> Allocation obeys rule 1 already, just do sperated freeing with rule 2.
> 
> So we also don't need ext4_load_buddy_gfp() before freeing on-disk
> bitmap right. Continue below...
> 
>>
>> Separated freeing has no race with generate_buddy as:
>> Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
>> buddy page can be found in sbi->s_buddy_cache and no more buddy
>> initialization of the buddy page will be executed concurrently until
>> buddy page is unloaded. As we always do free in "load buddy, free,
>> unload buddy" sequence, separated freeing has no race with generate_buddy.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index e650eac22237..01ad36a1cc96 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6519,6 +6519,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  	if (err)
>>  		goto error_return;
> 
> 
> Let me add the a piece of code before the added changes and continue...
> 
> 	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
> 				     GFP_NOFS|__GFP_NOFAIL);
> 	if (err)
> 		goto error_return;
>>  
>> +	ext4_lock_group(sb, block_group);
>> +	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>> +	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>> +	ext4_free_group_clusters_set(sb, gdp, ret);
>> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> +	ext4_group_desc_csum_set(sb, block_group, gdp);
>> +	ext4_unlock_group(sb, block_group);
>> +
> 
> ...Is it required for ext4_mb_load_buddy_gfp() to be called before
> freeing on-disk bitmap blocks? Can you explain why please?
> At least it is not very clear to me that why do we need
> ext4_mb_load_buddy_gfp() before clearing of bitmap blocks. If it's not
> needed then I think we should separate out bitmap freeing logic and
> buddy freeing logic even further.
Yes, ext4_mb_load_buddy_gfp is no needed for clearing of bitmap, put
it before bit clearing for catching error and aborting mark early
to reduce functional change.
> 
> Thoughts?
> 
>>  	/*
>>  	 * We need to make sure we don't reuse the freed block until after the
>>  	 * transaction is committed. We make an exception if the inode is to be
>> @@ -6541,13 +6549,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  		new_entry->efd_tid = handle->h_transaction->t_tid;
>>  
>>  		ext4_lock_group(sb, block_group);
>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
>>  	} else {
>> -		/* need to update group_info->bb_free and bitmap
>> -		 * with group lock held. generate_buddy look at
>> -		 * them with group lock_held
>> -		 */
>>  		if (test_opt(sb, DISCARD)) {
>>  			err = ext4_issue_discard(sb, block_group, bit,
>>  						 count_clusters, NULL);
>> @@ -6560,14 +6563,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>  
>>  		ext4_lock_group(sb, block_group);
>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
>>  	}
>>  
>> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>> -	ext4_free_group_clusters_set(sb, gdp, ret);
>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> -	ext4_group_desc_csum_set(sb, block_group, gdp);
>>  	ext4_unlock_group(sb, block_group);
>>  
>>  	if (sbi->s_log_groups_per_flex) {
> 
> 
> Adding piece of code here...
> 
> 	if (sbi->s_log_groups_per_flex) {
> 		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
> 		atomic64_add(count_clusters,
> 			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> 						  flex_group)->free_clusters);
> 	}
> 
> <...>
> 
> 	/* We dirtied the bitmap block */
> 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
> 	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> 	/* And the group descriptor block */
> 	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
> 	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
> 	if (!err)
> 		err = ret;
> 
> I was thinking even this can go around bitmap freeing logic above. So
> the next patch becomes very clear that all of the bitmap freeing logic
> is just simply moved into ext4_mb_mark_context() function.
> 
> -ritesh
> 


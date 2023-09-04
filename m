Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A279102E
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 04:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351104AbjIDCv2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 22:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbjIDCv1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 22:51:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C52210A;
        Sun,  3 Sep 2023 19:51:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfCnh0R4tz4f3lVv;
        Mon,  4 Sep 2023 10:51:20 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgD3ErspRvVkHDq0CA--.42671S2;
        Mon, 04 Sep 2023 10:51:21 +0800 (CST)
Subject: Re: [PATCH v6 02/11] ext4: call ext4_mb_mark_context in
 ext4_free_blocks_simple
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87jztb8f1k.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <fda8fc5b-f205-1557-4456-027ba6e02b1d@huaweicloud.com>
Date:   Mon, 4 Sep 2023 10:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87jztb8f1k.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgD3ErspRvVkHDq0CA--.42671S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1kCF45AF47GrW7Jw1fZwb_yoW5Gw1xpr
        ZxAF17Cr4rJF1Dur47Zw1jq3W0gw18W3WUGrW3W34rCFnFyr93KF4xKF1F9F9IkFZrWFn3
        ZF1Y9Fs7Cw13WrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
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



on 8/31/2023 10:25 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> call ext4_mb_mark_context in ext4_free_blocks_simple to:
>> 1. remove repeat code
>> 2. pair update of free_clusters in ext4_mb_new_blocks_simple.
>> 3. add missing ext4_lock_group/ext4_unlock_group protection.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 35 +++--------------------------------
>>  1 file changed, 3 insertions(+), 32 deletions(-)
> 
> Looks good to me. Please feel free to add - 
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> (One small comment below for previous patch)
> 
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index e2be572deb75..c803f74aaf63 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6414,43 +6414,14 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>>  static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>>  					unsigned long count)
>>  {
>> -	struct buffer_head *bitmap_bh;
>> +	struct ext4_mark_context mc;
>>  	struct super_block *sb = inode->i_sb;
>> -	struct ext4_group_desc *gdp;
>> -	struct buffer_head *gdp_bh;
>>  	ext4_group_t group;
>>  	ext4_grpblk_t blkoff;
>> -	int already_freed = 0, err, i;
>>  
>> +	ext4_mb_prepare_mark_context(&mc, sb, 0);
> 
> It looks like we always use 0 or 1 as the state for struct
> ext4_mark_context. In that case we can keep state member of this struct
> as bool instead of int. 
Get it. Thanks for pointing it out!
> 
> 
>>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
>> -	bitmap_bh = ext4_read_block_bitmap(sb, group);
>> -	if (IS_ERR(bitmap_bh)) {
>> -		pr_warn("Failed to read block bitmap\n");
>> -		return;
>> -	}
>> -	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
>> -	if (!gdp)
>> -		goto err_out;
>> -
>> -	for (i = 0; i < count; i++) {
>> -		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data))
>> -			already_freed++;
>> -	}
>> -	mb_clear_bits(bitmap_bh->b_data, blkoff, count);
>> -	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
>> -	if (err)
>> -		goto err_out;
>> -	ext4_free_group_clusters_set(
>> -		sb, gdp, ext4_free_group_clusters(sb, gdp) +
>> -		count - already_freed);
>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> -	ext4_group_desc_csum_set(sb, group, gdp);
>> -	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>> -	sync_dirty_buffer(bitmap_bh);
>> -	sync_dirty_buffer(gdp_bh);
>> -
>> -err_out:
>> -	brelse(bitmap_bh);
>> +	ext4_mb_mark_context(&mc, group, blkoff, count);
>>  }
>>  
>>  /**
>> -- 
>> 2.30.0
> 


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7967B1133
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 05:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjI1Dbd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 23:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjI1Dbc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 23:31:32 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6399;
        Wed, 27 Sep 2023 20:31:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RwzXn1ZZHz4f3jJH;
        Thu, 28 Sep 2023 11:31:21 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgCHjQKJ8xRlsnY+Bg--.12055S2;
        Thu, 28 Sep 2023 11:31:22 +0800 (CST)
Subject: Re: [PATCH v7 02/12] ext4: factor out codes to update block bitmap
 and group descriptor on disk from ext4_mb_mark_bb
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87zg18f1bm.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <309d082f-45b9-9dac-9921-6c3d44de17a7@huaweicloud.com>
Date:   Thu, 28 Sep 2023 11:31:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87zg18f1bm.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCHjQKJ8xRlsnY+Bg--.12055S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary8KF1ktF1fKF4xuF1ftFb_yoW7WFyrpr
        nIyF1DGF13Jrnrur47Zw1UX3WfJw409F18GryfW34rWFZFyr95JFn7GFyFkas0kFsrXFnF
        vF45Zrs7ur48GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/27/2023 4:49 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> There are several reasons to add a general function ext4_mb_mark_context
>> to update block bitmap and group descriptor on disk:
>> 1. pair behavior of alloc/free bits. For example,
>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>> 2. remove repeat code to read from disk, update and write back to disk.
>> 3. reduce future unit test mocks to catch real IO to update structure
>> on disk.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 147 ++++++++++++++++++++++++----------------------
>>  1 file changed, 77 insertions(+), 70 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index cf09adfbaf11..e1320eea46e9 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3953,6 +3953,80 @@ void ext4_exit_mballoc(void)
>>  	ext4_groupinfo_destroy_slabs();
>>  }
>>  
>> +static int
>> +ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
>> +		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
> 
> 
> ext4_grpblk_t is defined as int.
>     /* data type for block offset of block group */
>     typedef int ext4_grpblk_t;
> 
> I think len should be unsigned int (u32) here. 
> 
Hi Ritesh, thanks for reply and a lot suggestions to this patch and other
patches in this series.
I define len as ext4_grpblk_t as I think ext4_grpblk_t is supposed to fit
block or cluster number of single group.

Here are some examples save block number of group to ext4_grpblk_t:
static ext4_fsblk_t ext4_valid_block_bitmap(...)
{
        ...
        ext4_grpblk_t max_bit = EXT4_CLUSTERS_PER_GROUP(sb);
        ...
}

static ext4_fsblk_t ext4_mb_new_blocks_simple(...)
{
        ...
        ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
        ...
}

/* len could be group block number if group has only one fragment */
static int mb_avg_fragment_size_order(..., ext4_grpblk_t len)

As ext4_grpblk_t is data type for block offset of block group, so
ext4_grpblk_t fits "block number of group" - 1. If we support block
number of group > INT_MAX + 1, ext4_grpblk_t should be unsigned int anyway.
IMO, it's more simple just make ext4_grpblk_t data type for block number
in a single group and make it unsigned int if block number of group is
possible to >= INT_MAX + 1. Does this makes to you.

>> +{
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	struct buffer_head *bitmap_bh = NULL;
>> +	struct ext4_group_desc *gdp;
>> +	struct buffer_head *gdp_bh;
>> +	int err;
>> +	unsigned int i, already, changed;
>> +
>> +	bitmap_bh = ext4_read_block_bitmap(sb, group);
>> +	if (IS_ERR(bitmap_bh))
>> +		return PTR_ERR(bitmap_bh);
>> +
>> +	err = -EIO;
>> +	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
>> +	if (!gdp)
>> +		goto out_err;
>> +
>> +	ext4_lock_group(sb, group);
>> +	if (ext4_has_group_desc_csum(sb) &&
>> +	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
>> +		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
>> +		ext4_free_group_clusters_set(sb, gdp,
>> +			ext4_free_clusters_after_init(sb, group, gdp));
>> +	}
>> +
>> +	already = 0;
>> +	for (i = 0; i < len; i++)
>> +		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
>> +				state)
>> +			already++;
>> +	changed = len - already;
>> +
>> +	if (state) {
>> +		mb_set_bits(bitmap_bh->b_data, blkoff, len);
>> +		ext4_free_group_clusters_set(sb, gdp,
>> +			ext4_free_group_clusters(sb, gdp) - changed);
>> +	} else {
>> +		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
>> +		ext4_free_group_clusters_set(sb, gdp,
>> +			ext4_free_group_clusters(sb, gdp) + changed);
>> +	}
>> +
>> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> +	ext4_group_desc_csum_set(sb, group, gdp);
>> +	ext4_unlock_group(sb, group);
>> +
>> +	if (sbi->s_log_groups_per_flex) {
>> +		ext4_group_t flex_group = ext4_flex_group(sbi, group);
>> +		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
>> +					   s_flex_groups, flex_group);
>> +
>> +		if (state)
>> +			atomic64_sub(changed, &fg->free_clusters);
>> +		else
>> +			atomic64_add(changed, &fg->free_clusters);
>> +	}
>> +
>> +	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
>> +	if (err)
>> +		goto out_err;
>> +	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>> +	if (err)
>> +		goto out_err;
>> +
>> +	sync_dirty_buffer(bitmap_bh);
>> +	sync_dirty_buffer(gdp_bh);
>> +
>> +out_err:
>> +	brelse(bitmap_bh);
>> +	return err;
>> +}
>>  
>>  /*
>>   * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
>> @@ -4079,15 +4153,11 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>>  		     int len, bool state)
> 
> Even ext4_mb_mark_bb should take len as unsigned int IMO.
> For e.g. ext4_fc_replay_add_range() passes map.m_len which is also
> unsigned int.
If we agree ext4_grpblk_t to be data type for block number in group,
I think it's more reasonable to take len as ext4_grpblk_t too.

Look forward to you reply. Thanks!
> 
> 
> Otherwise the patch looks good to me. Feel free to add - 
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> -ritesh
> 


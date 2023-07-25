Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B37606C9
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 05:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGYDlJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 23:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGYDlH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 23:41:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A81725;
        Mon, 24 Jul 2023 20:41:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R92qt4hBBz4f3jMv;
        Tue, 25 Jul 2023 11:40:58 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgDn3x1LRL9kdyzYNg--.32665S2;
        Tue, 25 Jul 2023 11:41:01 +0800 (CST)
Subject: Re: [PATCH v5 1/8] ext4: factor out codes to update block bitmap and
 group descriptor on disk from ext4_mb_mark_bb
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87jzusjwf7.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <2692ff1c-4c4c-f10b-17ca-83a94281c491@huaweicloud.com>
Date:   Tue, 25 Jul 2023 11:40:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87jzusjwf7.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgDn3x1LRL9kdyzYNg--.32665S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3JryrGF43GrW7Wr1UGFg_yoWrXw1rpr
        nxA3WSkr1rJr9rCFsru34IqryfKw4rGF1UGryfGr1F9rZ3Jr97uF4ktF1FvF90grWDJF1a
        qF42qry3uw4rC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 7/22/2023 2:24 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> There are several reasons to add a general function to update block
>> bitmap and group descriptor on disk:
>> 1. pair behavior of alloc/free bits. For example,
>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>> 2. remove repeat code to read from disk, update and write back to disk.
>> 3. reduce future unit test mocks to catch real IO to update structure
>> on disk.
> 
> Thanks for the cleanup and sorry that I am starting to review this
> series only now. However I do have some review comments to understand a
> bit more on the patch series. 
> 
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> ---
>>  fs/ext4/mballoc.c | 157 +++++++++++++++++++++++++---------------------
>>  1 file changed, 87 insertions(+), 70 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index a2475b8c9fb5..58864a9116c0 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3948,6 +3948,86 @@ void ext4_exit_mballoc(void)
>>  	ext4_groupinfo_destroy_slabs();
>>  }
>>  
>> +struct ext4_mark_context {
>> +	struct super_block *sb;
>> +	int state;
>> +};
> 
> It's not totally clear the intention behind this structure from above
> since it lacking any comments.
> 
> Can you please help me understand why do we need this.
> I still don't know whether we require this structure and what is it's
> purpose. Is it only for reducing the number of variable passing?
Exactly. It's only for reducing the number of variable passing.
> Let me do more reading... 
> 
> ...On more reading, I was previous considering to rename it to something
> like ext4_mb_mark_context, but then I realized the naming of this is
> something similar to ext4_allocation_context. So we may keep the naming
> as is.
Exactly again. The ext4_mark_context is based on ext4_allocation_context.
> So since this structure, presumably, is used for marking blk bits for
> mballoc. Why don't we pass useful information which is relevant for
> this operation like - 
> 
>     ext4_mark_context {
>         ext4_group_t mc_group;          /* block group */
>         ext4_grpblk_t mc_clblk;	    /* block in cluster units */
>         ext4_grpblk_t mc_cllen;	    /* len in cluster units */
>         ext4_grpblk_t mc_clupdates;     /* number of clusters marked/unmarked */
>         unsigned int mc_flags;          /* flags ... */
>         bool mc_state;                  /* to set or unset state */
>     };
> 
> Maybe, super_block and handle we can pass as an argument as those doesn't
> define the ext4_mark_context for mballoc.
Actually, I try to put stable arguments need by bit mark into
ext4_mark_context then ext4_mark_context could be initialized once and used
multiple times. For example, if there is function to mark multiple bit
fragments, it will use ext4_allocation_context as:
 struct ext4_mark_context mc = {
   /* initialization */
 }
 /* mark fragment1 */
 ext4_mb_mark_group_bb(&mc, group1, blkoff1, len1);
 /* mark fragment2 */
 ext4_mb_mark_group_bb(&mc, group2, blkoff2, len2);
And I thinks these stable arguments match "context" meaning which bit
mark needed to work around :).

Put bit mark relevant information into ext4_mark_context is absolutely
a great choice. I will arrange ext4_mark_context in this way if you
still prefer this.

> Since this structure is prepared not at the begining of any function, we
> may need a prepare function for it. e.g. 
> 
>    static void ext4_mb_prepare_mark_context(&mc, ...)
>    static int ext4_mb_mark_context(sb, handle, &mc);  (instead of ext4_mb_mark_group_bb())
> 
> Does this sounds better to you? Thoughts?
>
Yes, prepare function is a great idea. I will add this in next version.
> Otherwise I think having a common function for mb_mark_context looks
> like a nice cleanup.
> 
Thanks! this means a lot to me!


-- 
Best wishes
Kemeng Shi


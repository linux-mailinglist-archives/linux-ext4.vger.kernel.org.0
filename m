Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644BB780758
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358676AbjHRIm4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357775AbjHRImk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 04:42:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B963A94;
        Fri, 18 Aug 2023 01:42:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRwNm6f16z4f41Vb;
        Fri, 18 Aug 2023 16:42:32 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgAHK2_4Lt9kJOHxAw--.47387S2;
        Fri, 18 Aug 2023 16:42:33 +0800 (CST)
Subject: Re: [PATCH 12/13] ext4: remove unnecessary check for avoiding
 multiple update_backups in ext4_flex_group_add
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-13-shikemeng@huaweicloud.com>
 <20230816034730.GT2247938@mit.edu>
 <2a0c45d9-29f0-10a3-fc40-d48e101c8d91@huaweicloud.com>
 <20230817141112.GZ2247938@mit.edu>
 <cfad4b27-3174-1124-1516-a2ddb3843639@huaweicloud.com>
 <20230818050036.GG3464136@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <8f8dc5cf-cfd9-eb90-9f09-ee2dc89de537@huaweicloud.com>
Date:   Fri, 18 Aug 2023 16:42:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230818050036.GG3464136@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAHK2_4Lt9kJOHxAw--.47387S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4fZrykur18Cw45AF15twb_yoW7Xw1Upa
        1qka1DArn8GrZrZF1xJw10qFy0ka1xJF45Ary7uw1UuF9IqFn2qrn2yF1YyFyUXFZ29w1Y
        qr15A3srCr4vyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/18/2023 1:00 PM, Theodore Ts'o wrote:
> On Fri, Aug 18, 2023 at 11:16:35AM +0800, Kemeng Shi wrote:
>> Ah, I guess here is the thing I missed that make this confusing:
>> sbi->s_group_desc contains only primary block of each group. i.e.
>> sbi->s_group_desc['i'] is the primary gdb block of group 'i'.
> 
> Correct.  In fact, when we need to modify a block group descriptor for
> a group, we call ext4_get_group_desc(), and it references
> sbi->s_group_desc to find the appropriate buffer_head for the bg
> descriptor that we want to modify.
> 
> I'm not sure "only" is the right adjective to use here, since the
> whole *point* of s_group_desc[] is to keep the buffer_heads for the
> block group descriptor blocks in memory, so we can modify them when we
> allocate or free blocks, inodes, etc.  And we only modify the primary
> block group descriptors.
> 
> The secondary, or backup block group descriptors are only by used
> e2fsck when the primary block group descriptor has been overwritten,
> so we can find the inode table, allocation bitmaps, and so on.  So we
> do *not* modify them in the course of normal operations, and that's by
> design.  The only time the kernel will update those block group
> descriptors is when we are doing an online resize, and we need make
> sure the backup descriptors are updated, so that if the primary
> descriptors get completely smashed, we can still get critical
> information such as the location of that block group's inode table.
> >> From add_new_gdb and add_new_gdb_meta_bg, we can find that we always
>> add primary gdb block of new group to s_group_desc. To be more specific:
>> add_new_gdb
>> 	gdblock = EXT4_SB(sb)->s_sbh->b_blocknr + 1 + gdb_num;
>> 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
>> 	n_group_desc[gdb_num] = gdb_bh;
>>
>> add_new_gdb_meta_bg
>> 	gdblock = ext4_meta_bg_first_block_no(sb, group) +
>> 		  ext4_bg_has_super(sb, group);
>> 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
>> 	n_group_desc[gdb_num] = gdb_bh;
> 
> Put another way, there are EXT4_DESC_PER_BLOCK(sb) bg descriptors in a
> block.  For a file system with the 64-bit feature enabled, the size of
> the block group descriptor is 128.  If the block size is 4096, then we
> can fit 32 block group descriptors in a block.
> 
> When we add a new block group such that its block group descriptor
> will spill into a new block, then we need to expand s_group_desc[]
> array, and initialize the new block group descriptor block.  And
> that's the job of add_new_gdb() and add_new_gdb_meta_bg().
> 
Hi Ted, thanks for the explain. Here are more updates from what I found:
I find that descriptor_loc show layout of gdb blocks in s_group_desc[]
which is: block of s_group_desc[i] will be superblock + i + 1 for
non-meta_bg and 'first block of meta_bg' + has_super for meta_bg.
Although descriptor_loc is called to initialize s_group_desc[], the
expanded gdb block to s_group_desc from add_new_gdb obeys the same
layout.
Back to the original purpose of this patch which is to remove
unnecessary of equality check of s_group_desc[gdb_num - 1].b_blocknr and
s_group_desc[gdb_num].b_blocknr, we can see each s_group_desc has it's
own block from layout above and the check should be unnecessary.
But no insistant on this if you still have concern about it.
>>> More generally, this whole patch series is making it clear that the
>>> online resize code is hard to understand, because it's super
>>> complicated, leading to potential bugs, and very clearly code which is
>>> very hard to maintain.  So this may mean we need better comments to
>>> make it clear *when* the backup block groups are going to be
>>> accomplished, given the various different cases (e.g., no flex_bg or
>>> meta_bg, with flex_bg, or with meat_bg).
>>>
>> Yes, I agree with this. I wonder if a series to add comments of some
>> common rules is good to you. Like the information mentioned above
>> that s_group_desc contains primary gdb block of each group.
> 
> Well, the meaning of s_group_desc[] was obvious to me, but that's why
> it's useful to have somone with "new eyes" take a look at code, since
> what may be obvious to old hands might not be obvious to someone
> looking at the code for the first time --- and so yes, it's probably
Yes. this is just for anyone starting to read this code.
> worth documenting.  The question is where is the best place to put it,
> since the primary place where s_group_desc[] is *not* online resize.
> 
> s_group_desc[] is initialized in ext4_group_desc_init() in
> fs/ext4/super.c, and it is used in fs/ext4/balloc.c, and of course, it
> is defined in fs/ext4.h.  
I plan to add comment in fs/ext4.h as following:
struct ext4_sb_info {
	...
	struct buffer_head * __rcu *s_group_desc; /* Primary gdb blocks of online groups */
But I'm not sure it's proper now as you menthioned s_group_desc[] is to
keep the buffer_heads for the block group descriptor blocks in memory
and it contains primary gdb block is a coincidence that we only modify
primary block in kernel.

Besides, I plan to go through the resize code again in fulture and
add some comments to make it easy for anyone starting read this
or make it easy to maintain. Please let me if you disklike it.
> 
> 						- Ted
> 


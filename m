Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18E278044A
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 05:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357489AbjHRDQ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 23:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357498AbjHRDQm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 23:16:42 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C2530E6;
        Thu, 17 Aug 2023 20:16:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RRn8d53Brz4f3v7M;
        Fri, 18 Aug 2023 11:16:33 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgBnisKT4t5kYbSsAw--.38013S2;
        Fri, 18 Aug 2023 11:16:36 +0800 (CST)
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
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <cfad4b27-3174-1124-1516-a2ddb3843639@huaweicloud.com>
Date:   Fri, 18 Aug 2023 11:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230817141112.GZ2247938@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBnisKT4t5kYbSsAw--.38013S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF47Jw4fur1rCr15uw4kWFg_yoW5Xw17pa
        9xCF1Utr1DGw4DZF1vy3y2qFyFkw4xtFW5Jry7Ka15ur90gFySgFn7trsYkFyUtFsYywnF
        vFy5A3y7Aa1DZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/17/2023 10:11 PM, Theodore Ts'o wrote:
> On Thu, Aug 17, 2023 at 11:53:52AM +0800, Kemeng Shi wrote:
>>
>>
>> on 8/16/2023 11:47 AM, Theodore Ts'o wrote:
>>> On Thu, Jun 29, 2023 at 08:00:43PM +0800, Kemeng Shi wrote:
>>>> Commit 0acdb8876fead ("ext4: don't call update_backups() multiple times
>>>> for the same bg") add check in ext4_flex_group_add to avoid call
>>>> update_backups multiple times for block group descriptors in the same
>>>> group descriptor block. However, we have already call update_backups in
>>>> block step, so the added check is unnecessary.
>>>
>>> I'm having trouble understaind this comit.  What do you mean by the
>>> "block step" in the last paragraph?
>>>
>> Sorry for the confusing stuff. I mean we foreach in group descriptor block
>> step instead of foreach in group descriptor step to update backup.
>> So there is no chance to call update_backups for different descriptors
>> in the same bg.
> 
> I'm still confused.  This commit is not so much removing an
> unnecessary check as much as forcing update_backups() to be called for
> every single block group.  Right?
> 
Ah, I guess here is the thing I missed that make this confusing:
sbi->s_group_desc contains only primary block of each group. i.e.
sbi->s_group_desc['i'] is the primary gdb block of group 'i'. It's clear
that primary gdb blocks of different groups will not be the same. Then
all blocks in s_group_desc[*] should be different and the removed check
is unnecessary.
From add_new_gdb and add_new_gdb_meta_bg, we can find that we always
add primary gdb block of new group to s_group_desc. To be more specific:
add_new_gdb
	gdblock = EXT4_SB(sb)->s_sbh->b_blocknr + 1 + gdb_num;
	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
	n_group_desc[gdb_num] = gdb_bh;

add_new_gdb_meta_bg
	gdblock = ext4_meta_bg_first_block_no(sb, group) +
		  ext4_bg_has_super(sb, group);
	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
	n_group_desc[gdb_num] = gdb_bh;
	
> So either we're doing extra work, or (b) we're fixing a problem
> because we actually *need* to call update_backups() for every single
> block group.
> 
> More generally, this whole patch series is making it clear that the
> online resize code is hard to understand, because it's super
> complicated, leading to potential bugs, and very clearly code which is
> very hard to maintain.  So this may mean we need better comments to
> make it clear *when* the backup block groups are going to be
> accomplished, given the various different cases (e.g., no flex_bg or
> meta_bg, with flex_bg, or with meat_bg).
> 
Yes, I agree with this. I wonder if a series to add comments of some
common rules is good to you. Like the information mentioned above
that s_group_desc contains primary gdb block of each group.

> 							- Ted
> 


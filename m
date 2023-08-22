Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE187837DC
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Aug 2023 04:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHVCVr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Aug 2023 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjHVCVr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Aug 2023 22:21:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4EFD;
        Mon, 21 Aug 2023 19:21:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVClT4hZqz4f3k6k;
        Tue, 22 Aug 2023 10:21:41 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDndqm0G+Rk4JQlBQ--.39660S2;
        Tue, 22 Aug 2023 10:21:42 +0800 (CST)
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
 <8f8dc5cf-cfd9-eb90-9f09-ee2dc89de537@huaweicloud.com>
 <20230818160038.GA3515079@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7dafe2b7-d78e-ec99-18f9-2830d614d01b@huaweicloud.com>
Date:   Tue, 22 Aug 2023 10:21:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230818160038.GA3515079@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDndqm0G+Rk4JQlBQ--.39660S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DGF47KryUtw48ZFW3GFg_yoW5KryUp3
        98Aa90krn8Gr4fZ3W8J340va4Fkws7AFs8Jry3Xw15G39xKr4Iqr9rKr1YyFWqqFs7uw1j
        vF10yry3Cw4q9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/19/2023 12:00 AM, Theodore Ts'o wrote:
> On Fri, Aug 18, 2023 at 04:42:31PM +0800, Kemeng Shi wrote:
>>> s_group_desc[] is initialized in ext4_group_desc_init() in
>>> fs/ext4/super.c, and it is used in fs/ext4/balloc.c, and of course, it
>>> is defined in fs/ext4.h.  
>> I plan to add comment in fs/ext4.h as following:
>> struct ext4_sb_info {
>> 	...
>> 	struct buffer_head * __rcu *s_group_desc; /* Primary gdb blocks of online groups */
>> But I'm not sure it's proper now as you menthioned s_group_desc[] is to
>> keep the buffer_heads for the block group descriptor blocks in memory
>> and it contains primary gdb block is a coincidence that we only modify
>> primary block in kernel.
> 
> In general, the terminology that ext4 developers have used is "block
> group descriptors" and "backup block group descriptors".  The kernel
> never *uses* the backup block group users; and with the sparse_super2
> feature, the "backup superblocks" and "backup block group descriptors"
> are optional.
> 
Sure.
> They are used by e2fsck if we need to recover a trashed superblock and
> block group descriptors, which is why code that is resizing the file
> system, or updating the label or the UUID need to update the backup
> superblocks and/or backup block group descriptors so that we can
> better recover disaster.
OK, kernel updates backup blocks and userspace tool recovers from backup
in case that blocks used by kernel is corrupted.
> 
> So I'd just suggest changing the comment above to "array of bh's for
> the block group descriptors".
> 
Sure, I will do this in next version.

Besides, what about the check this patch tries to remove. Would you
prefer to keep it or remove it with better git description. Both
ways are acceptable to me. Thanks.

> Cheers,
> 
> 							- Ted
> 
>> Besides, I plan to go through the resize code again in fulture and
>> add some comments to make it easy for anyone starting read this
>> or make it easy to maintain. Please let me if you disklike it.
> 
> P.S.
> 
> BTW, a useful test program to add is one that checks to make sure that
> the "static" parts of the superblock and block group descriptors
> (i.e., the parts that don't get changed under normal operation while
> the file system is mounted when the kernel *isn't* trying to do a
> resize or change the label, UUID, or in the future, the new ioctl's to
> update the parts of the superblock that can get modified by tune2fs),
> and to make sure that all of the backup superblock and block group
> descriptors have gotten updated>
> Some of the bugs that you found may have resulted in some of the
> backup bg descriptors not getting updataed, which we wouldn't
> necessarily notice unless we had a test program that explicitly
> checked for them.
> 
> And truth to tell, the only backup superblock and block group
> descriptor that actually gets used to recover the file system is the
> first one, since that's the one e2fsck will fall back to
> automatically.  An expert might try to use one of the other backup
> block groups as a desperate measure, and there might be some automated
> programs that might be smart enough to use the backup block groups
> when trying to recover the location of the partition table when the
> file system and partition table is very badly damaged --- so that's
> one of the reasons why with sparse_super2, the number of backup block
> group descriptors can be limited to (for example) one located in the
> first block group, and one located in the very last block group.
> 
> Thanks for let me know and I do have no knowldge about how backup is used
in usersapce.


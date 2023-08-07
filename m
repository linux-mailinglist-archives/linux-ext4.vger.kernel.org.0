Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CED771EE2
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHGKxa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHGKx3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 06:53:29 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D22B10FA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 03:53:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RKCpn5nCbz4f403k
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 18:53:21 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgBH16kVzdBkZvGTAA--.56258S3;
        Mon, 07 Aug 2023 18:53:24 +0800 (CST)
Subject: Re: [PATCH 07/12] jbd2: add fast_commit space check
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-8-yi.zhang@huaweicloud.com>
 <20230803143825.f364hmpsgqbzvjwo@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d23c42ce-32d1-79c3-63b2-0bfbc3af924c@huaweicloud.com>
Date:   Mon, 7 Aug 2023 18:53:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230803143825.f364hmpsgqbzvjwo@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH16kVzdBkZvGTAA--.56258S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur48JFyrGF4kCFy3Gw17KFg_yoWrJr4fpF
        W8JFySkrWkZrWUA3WxtF4DJFWFva4qyFWUGrn2k3savw15trn3Kw4vqF13JF1DAw1q93y8
        XFnrt347Cw10ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/8/3 22:38, Jan Kara wrote:
> On Tue 04-07-23 21:42:28, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> If JBD2_FEATURE_INCOMPAT_FAST_COMMIT bit is set, it means the journal
>> have fast commit records need to recover, so the fast commit size
>> should not be zero, and also the leftover normal journal size should
>> never less than JBD2_MIN_JOURNAL_BLOCKS. Add a check into the
>> journal_check_superblock() and drop the pointless branch when
>> initializing in-memory fastcommit parameters.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Some comments below.
> 
> 
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index efdb8db3c06e..210b532a3673 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -1392,6 +1392,18 @@ static int journal_check_superblock(journal_t *journal)
>>  		return err;
>>  	}
>>  
>> +	if (jbd2_has_feature_fast_commit(journal)) {
>> +		int num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
>> +
>> +		if (!num_fc_blks ||
>> +		    (be32_to_cpu(sb->s_maxlen) - num_fc_blks <
>> +		     JBD2_MIN_JOURNAL_BLOCKS)) {
>> +			printk(KERN_ERR "JBD2: Invalid fast commit size %d\n",
>> +			       num_fc_blks);
>> +			return err;
>> +		}
> 
> This is wrong sb->s_num_fc_blks == 0 means that the fast-commit area should
> have the default size of 256 blocks. At least that's how it behaves
> currently and we should not change the behavior.

Thanks for the review and correcting me. I missed the fc_debug_force
mount option, this option enable fast commit feature without init
sb->s_num_fc_blks to disk, so it could left over an unclean image with
fast_commit feature but sb->s_num_fc_blks is still zero. And the mke2fs
could also set sb->s_num_fc_blks to 0.

> 
> Similarly if the number of fastcommit blocks was too big (i.e. there was
> not enough space left for ordinary journal), we effectively silently
> disable fastcommit and you break this behavior in this patch.
> 

If the fastcommit is too big, jbd2_journal_initialize_fast_commit()
will detect this corruption and refuse to mount.

[ 1213.810719] JBD2: Cannot enable fast commits.
[ 1213.812282] EXT4-fs (pmem1): Failed to set fast commit journal feature

It only silently disable fastcommit while recovering the journal, but it
doesn't seem to make much sense, because the journal->j_last is likely to
be wrong (not point to the correct end of normal journal range) and will
probably lead to incorrect recovery. It seems better to report the error
and exit as early as possible. So I suppose we could keep this "too big"
check in journal_check_superblock(). How does that sound ?

Thanks,
Yi.

> 
>> +	}
>> +
>>  	if (jbd2_has_feature_csum2(journal) &&
>>  	    jbd2_has_feature_csum3(journal)) {
>>  		/* Can't have checksum v2 and v3 at the same time! */
>> @@ -1460,7 +1472,6 @@ static int journal_load_superblock(journal_t *journal)
>>  	int err;
>>  	struct buffer_head *bh;
>>  	journal_superblock_t *sb;
>> -	int num_fc_blocks;
>>  
>>  	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
>>  			      journal->j_blocksize);
>> @@ -1498,9 +1509,8 @@ static int journal_load_superblock(journal_t *journal)
>>  
>>  	if (jbd2_has_feature_fast_commit(journal)) {
>>  		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
>> -		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
>> -		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
>> -			journal->j_last = journal->j_fc_last - num_fc_blocks;
>> +		journal->j_last = journal->j_fc_last -
>> +				  be32_to_cpu(sb->s_num_fc_blks);
>>  		journal->j_fc_first = journal->j_last + 1;
>>  		journal->j_fc_off = 0;
>>  	}
>> -- 
>> 2.39.2
>>


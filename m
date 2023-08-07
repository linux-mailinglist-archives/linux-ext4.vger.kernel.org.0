Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6B77231C
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHGLy0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 07:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjHGLyZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 07:54:25 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B310B92
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 04:54:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RKDmt2z3pz4f47RP
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 19:36:46 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6lN19BkslWWAA--.57095S3;
        Mon, 07 Aug 2023 19:36:46 +0800 (CST)
Subject: Re: [PATCH 11/12] ext4: cleanup ext4_get_dev_journal() and
 ext4_get_journal()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-12-yi.zhang@huaweicloud.com>
 <20230803161446.6ac3ffhvfihmpyr6@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1dcada9b-77ba-504e-b2dd-b0437afa9962@huaweicloud.com>
Date:   Mon, 7 Aug 2023 19:36:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230803161446.6ac3ffhvfihmpyr6@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHl6lN19BkslWWAA--.57095S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUCFyDGw1xCr4xCr47twb_yoW5tw18pF
        4UAFy7uFWUuF1Uua1IqanrXFy29w40yay8GrZru3ZYyayDtrn3CF9xGF4UJa4jyrW7G397
        XF4jqF9Fkw1xKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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

On 2023/8/4 0:14, Jan Kara wrote:
> On Tue 04-07-23 21:42:32, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Factor out a new helper form ext4_get_dev_journal() to get external
>> journal bdev and check validation of this device, drop ext4_blkdev_get()
>> helper, and also remove duplicate check of journal feature. It makes
>> ext4_get_dev_journal() more clear than before.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> One comment below:
> 
>> @@ -5838,25 +5815,25 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>>  	return journal;
>>  }
>>  
>> -static journal_t *ext4_get_dev_journal(struct super_block *sb,
>> -				       dev_t j_dev)
>> +static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>> +					dev_t j_dev, ext4_fsblk_t *j_start,
>> +					ext4_fsblk_t *j_len)
>>  {
>>  	struct buffer_head *bh;
>> -	journal_t *journal;
>> -	ext4_fsblk_t start;
>> -	ext4_fsblk_t len;
>> +	struct block_device *bdev;
>>  	int hblock, blocksize;
>>  	ext4_fsblk_t sb_block;
>>  	unsigned long offset;
>>  	struct ext4_super_block *es;
>> -	struct block_device *bdev;
>>  
>> -	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
>> -		return NULL;
>> -
>> -	bdev = ext4_blkdev_get(j_dev, sb);
>> -	if (bdev == NULL)
>> +	bdev = blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
>> +				 &ext4_holder_ops);
>> +	if (IS_ERR(bdev)) {
>> +		ext4_msg(sb, KERN_ERR,
>> +			 "failed to open journal device unknown-block(%u,%u) %ld",
>> +			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
>>  		return NULL;
>> +	}
>>  
>>  	blocksize = sb->s_blocksize;
>>  	hblock = bdev_logical_block_size(bdev);
>> @@ -5869,7 +5846,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>>  	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
>>  	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
>>  	set_blocksize(bdev, blocksize);
>> -	if (!(bh = __bread(bdev, sb_block, blocksize))) {
>> +	bh = __bread(bdev, sb_block, blocksize);
>> +	if (!bh) {
>>  		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
>>  		       "external journal");
>>  		goto out_bdev;
>> @@ -5879,56 +5857,67 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>>  	if ((le16_to_cpu(es->s_magic) != EXT4_SUPER_MAGIC) ||
>>  	    !(le32_to_cpu(es->s_feature_incompat) &
>>  	      EXT4_FEATURE_INCOMPAT_JOURNAL_DEV)) {
>> -		ext4_msg(sb, KERN_ERR, "external journal has "
>> -					"bad superblock");
>> -		brelse(bh);
>> -		goto out_bdev;
>> +		ext4_msg(sb, KERN_ERR, "external journal has bad superblock");
>> +		goto out_bh;
>>  	}
>>  
>>  	if ((le32_to_cpu(es->s_feature_ro_compat) &
>>  	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
>>  	    es->s_checksum != ext4_superblock_csum(sb, es)) {
>> -		ext4_msg(sb, KERN_ERR, "external journal has "
>> -				       "corrupt superblock");
>> -		brelse(bh);
>> -		goto out_bdev;
>> +		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
>> +		goto out_bh;
>>  	}
>>  
>>  	if (memcmp(EXT4_SB(sb)->s_es->s_journal_uuid, es->s_uuid, 16)) {
>>  		ext4_msg(sb, KERN_ERR, "journal UUID does not match");
>> -		brelse(bh);
>> -		goto out_bdev;
>> +		goto out_bh;
>>  	}
>>  
>> -	len = ext4_blocks_count(es);
>> -	start = sb_block + 1;
>> -	brelse(bh);	/* we're done with the superblock */
>> +	brelse(bh);
>> +	*j_start = sb_block + 1;
>> +	*j_len = ext4_blocks_count(es);
> 
> Here the ext4_blocks_count() is a use-after-free since you've released the
> bh a few lines above.
> 

Indeed, will move it before the brelse(bh).

Thanks,
Yi.


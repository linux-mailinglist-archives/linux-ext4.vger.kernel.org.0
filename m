Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75D4C535E
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Feb 2022 03:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiBZCbJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 21:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiBZCbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 21:31:08 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F119414E
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 18:30:34 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K59VZ3Dvpz1FDfw;
        Sat, 26 Feb 2022 10:25:58 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Feb 2022 10:30:32 +0800
Subject: Re: [PATCH v2] ext4: fix underflow in ext4_max_bitmap_size()
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20220225102837.3048196-1-yi.zhang@huawei.com>
 <20220225123851.flahv2nlvpqq3d33@quack3.lan>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <3335eb5d-76c0-0b01-3dca-b2e2ccdf91c0@huawei.com>
Date:   Sat, 26 Feb 2022 10:30:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220225123851.flahv2nlvpqq3d33@quack3.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/2/25 20:38, Jan Kara wrote:
> On Fri 25-02-22 18:28:37, Zhang Yi wrote:
>> The same to commit 1c2d14212b15 ("ext2: Fix underflow in ext2_max_size()")
>> in ext2 filesystem, ext4 driver has the same issue with 64K block size
>> and ^huge_file, fix this issue the same as ext2. This patch also revert
>> commit 75ca6ad408f4 ("ext4: fix loff_t overflow in ext4_max_bitmap_size()")
>> because it's no longer needed.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks for the patch. I would not refer to ext2 patch in the changelog - it
> is better to have it self-contained. AFAIU the problem is that (meta_blocks
>> upper_limit) for 64k blocksize and ^huge_file and so upper_limit would
> underflow during the computations, am I right?

Thanks for the review. Yes, I will rewrite the change log.

> 
> Also two comments below:
> 
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index c5021ca0a28a..95608c2127e7 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -3468,8 +3468,9 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
>>   */
>>  static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
>>  {
>> -	unsigned long long upper_limit, res = EXT4_NDIR_BLOCKS;
>> +	loff_t upper_limit, res = EXT4_NDIR_BLOCKS;
>>  	int meta_blocks;
>> +	unsigned int ppb = 1 << (bits - 2);
>>  
>>  	/*
>>  	 * This is calculated to be the largest file size for a dense, block
>> @@ -3501,27 +3502,42 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
>>  
>>  	}
>>  
>> -	/* indirect blocks */
>> -	meta_blocks = 1;
>> -	/* double indirect blocks */
>> -	meta_blocks += 1 + (1LL << (bits-2));
>> -	/* tripple indirect blocks */
>> -	meta_blocks += 1 + (1LL << (bits-2)) + (1LL << (2*(bits-2)));
>> -
>> -	upper_limit -= meta_blocks;
>> -	upper_limit <<= bits;
>> -
>> +	/* Compute how many blocks we can address by block tree */
>>  	res += 1LL << (bits-2);
>>  	res += 1LL << (2*(bits-2));
>>  	res += 1LL << (3*(bits-2));
> 
> When you have the 'ppb' convenience variable, perhaps you can update this
> math to:
> 
> 	res = EXT4_NDIR_BLOCKS + ppb + ppb*ppb + ((long long)ppb)*ppb*ppb;
> 
> It is easier to understand and matches how you compute meta_blocks as well.
> 
>> +	/* Compute how many metadata blocks are needed */
>> +	meta_blocks = 1;
>> +	meta_blocks += 1 + ppb;
>> +	meta_blocks += 1 + ppb + ppb * ppb;
>> +	/* Does block tree limit file size? */
>> +	if (res + meta_blocks <= upper_limit)
>> +		goto check_lfs;
>> +
>> +	res = upper_limit;
>> +	/* How many metadata blocks are needed for addressing upper_limit? */
>> +	upper_limit -= EXT4_NDIR_BLOCKS;
>> +	/* indirect blocks */
>> +	meta_blocks = 1;
>> +	upper_limit -= ppb;
>> +	/* double indirect blocks */
>> +	if (upper_limit < ppb * ppb) {
>> +		meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb);
>> +		res -= meta_blocks;
>> +		goto check_lfs;
>> +	}
>> +	meta_blocks += 1 + ppb;
>> +	upper_limit -= ppb * ppb;
>> +	/* tripple indirect blocks for the rest */
>> +	meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb) +
>> +		DIV_ROUND_UP_ULL(upper_limit, ppb*ppb);
>> +	res -= meta_blocks;
>> +check_lfs:
>>  	res <<= bits;
> 
> Cannot this overflow loff_t again? I mean if upper_limit == (1 << 48) - 1
> and we have 64k blocksize, 'res' will be larger than (1 << 47) and thus 
> res << 16 will be greater than 1 << 63 => negative... Am I missing
> something?
> 

If upper_limit==(1 << 48) - 1, we could address the whole data blocks, the 'res'
is equal to EXT4_NDIR_BLOCKS + ppb + ppb*ppb + ((long long)ppb)*ppb*ppb, it's
smaller than (1 << 43) - 1, so res << 16 is still smaller 1 << 59, so it cannot
overflow loff_t again.

Thanks,
Yi.

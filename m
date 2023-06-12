Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D598F72B630
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjFLDrO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 23:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLDrN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 23:47:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9184FB3;
        Sun, 11 Jun 2023 20:47:11 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qfcv95dzQzqTtt;
        Mon, 12 Jun 2023 11:42:13 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 11:47:07 +0800
Message-ID: <9af2b8d7-8ad4-96bf-6a30-587ad23cff59@huawei.com>
Date:   Mon, 12 Jun 2023 11:47:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block() return
 void
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-11-libaokun1@huawei.com>
 <20230610190319.GB1436857@mit.edu> <20230612030405.GH1436857@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230612030405.GH1436857@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/12 11:04, Theodore Ts'o wrote:
> On Sat, Jun 10, 2023 at 03:03:19PM -0400, Theodore Ts'o wrote:
>> Unforuntately, the changes to ext4_insert_delayed_block() in this
>> patch were buggy, and were causing tests to hang when running
>> ext4/encrypt, ext4/bigalloc_4k, and ext4/bigalloc_1k test scenarios.
>> A bisect using "gce-xfstests -c ext4/bigalloc_4k -C 5 generic/579"
>> pinpointed the problem.
I'm very sorry, I didn't turn on encrypt or bigalloc when I tested it.
>>
>> The problem is that ext4_clu_mapped can return a positive value, and
>> so there are times when we do need to release the space even though
>> there are no errors.

Yes, ext4_clu_mapped may return a positive value,

but when it does, reserved is false and we never need to release the space.

>> So I've fixed up your commit with the following changes.  With this
>> change, the test regressions go away.
The previous reply was very confusing to me because the changes
in the previous reply have nothing to do with ext4_clu_mapped
and ret is always 0 when reserved is true, so we don't need
ext4_da_release_space to perform a rollback.
> It turns out my fix was not correct, because I misread the fundamental
> problem with the patch.  The issue was in the last patch hunk:
>   
> -	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> -	if (ret && reserved)
> -		ext4_da_release_space(inode, 1);
> -
> +	ext4_es_insert_delayed_block(inode, lblk, allocated);
>   errout:
>   	return ret;
>   }

Indeed, there is a behavioral change in ret here.

Before modification:

ext4_da_map_blocks             --> return 0
  ext4_insert_delayed_block     --> return 0
   ext4_clu_mapped              --> return 1
   ext4_es_insert_delayed_block --> return 0

After modification:

ext4_da_map_blocks             --> return 1
  ext4_insert_delayed_block     --> return 1
   ext4_clu_mapped              --> return 1
   ext4_es_insert_delayed_block --> void

>
> The problem is that entering this code hunk, ret could be non-zero.
> But when we made ext4_es_insert_delayed_block() to return void.  So
> the changes to fs/ext4/inode.c needed to be replaced by this:
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 129b9af53d62..7700db1782dd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1630,7 +1630,6 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	int ret;
>   	bool allocated = false;
> -	bool reserved = false;
>   
>   	/*
>   	 * If the cluster containing lblk is shared with a delayed,
> @@ -1646,8 +1645,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>   	if (sbi->s_cluster_ratio == 1) {
>   		ret = ext4_da_reserve_space(inode);
>   		if (ret != 0)   /* ENOSPC */
> -			goto errout;
> -		reserved = true;
> +			return ret;
>   	} else {   /* bigalloc */
>   		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>   			if (!ext4_es_scan_clu(inode,
> @@ -1655,12 +1653,11 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>   				ret = ext4_clu_mapped(inode,
>   						      EXT4_B2C(sbi, lblk));
>   				if (ret < 0)
> -					goto errout;
> +					return ret;
>   				if (ret == 0) {
>   					ret = ext4_da_reserve_space(inode);
>   					if (ret != 0)   /* ENOSPC */
> -						goto errout;
> -					reserved = true;
> +						return ret;
>   				} else {
>   					allocated = true;
>   				}
> @@ -1670,12 +1667,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>   		}
>   	}
>   
> -	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> -	if (ret && reserved)
> -		ext4_da_release_space(inode, 1);
> -
> -errout:
> -	return ret;
> +	ext4_es_insert_delayed_block(inode, lblk, allocated);
> +	return 0;
>   }
>   
>   /*
>
> 						- Ted
>
Yes, it looks very good！A million thanks for the fix!

I am very sorry for taking your time to locate and fix this issue!

I will do more checks later.

-- 
With Best Regards,
Baokun Li
.

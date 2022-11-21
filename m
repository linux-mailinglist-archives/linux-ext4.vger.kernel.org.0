Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992E63203D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 12:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKULTU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 06:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKULTA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 06:19:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D43BEB45;
        Mon, 21 Nov 2022 03:14:18 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NG4Sk4j0xzFqSS;
        Mon, 21 Nov 2022 19:11:02 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:14:16 +0800
Subject: Re: [PATCH 2/3] ext4: WANR_ON when detect abnormal
 'i_reserved_data_blocks'
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>
References: <20221117014246.610202-1-yebin@huaweicloud.com>
 <20221117014246.610202-3-yebin@huaweicloud.com>
 <20221121094715.gpha7rkijbwr5r47@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <637B5D87.4000806@huawei.com>
Date:   Mon, 21 Nov 2022 19:14:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20221121094715.gpha7rkijbwr5r47@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/11/21 17:47, Jan Kara wrote:
> On Thu 17-11-22 09:42:45, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> If 'i_reserved_data_blocks' is not cleared which mean something wrong
>> with code, so emit WARN_ON to capture this abnormal closer to the first
>> scene.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/super.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 63ef74eb8091..30885a6fe18b 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1385,11 +1385,14 @@ static void ext4_destroy_inode(struct inode *inode)
>>   		dump_stack();
>>   	}
>>   
>> -	if (EXT4_I(inode)->i_reserved_data_blocks)
>> -		ext4_msg(inode->i_sb, KERN_ERR,
>> -			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>> -			 inode->i_ino, EXT4_I(inode),
>> -			 EXT4_I(inode)->i_reserved_data_blocks);
>> +	if (EXT4_I(inode)->i_reserved_data_blocks) {
>> +		ext4_warning(inode->i_sb, "Inode %lu (%p): "
>> +			    "i_reserved_data_blocks (%u) not cleared!",
>> +			     inode->i_ino, EXT4_I(inode),
>> +			     EXT4_I(inode)->i_reserved_data_blocks);
>> +
>> +		WARN_ON(1);
>> +	}
> Hum, so I'd think that if this happens, the free space accounting is likely
> wrong so we might as well just force the filesystem to error mode with
> ext4_error() to force fsck?  I also gives a good chance to various test
> systems to detect there is some problem so we don't need the WARN_ON then?
> What do others think?
>
> 								Honza
Thanks for your advice, use ext4_error() maybe is suitable and also 
testable.


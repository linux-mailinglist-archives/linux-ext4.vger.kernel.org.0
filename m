Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0113F1A17
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhHSNMj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 09:12:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8047 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhHSNMj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 09:12:39 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gr4sf4jG6zYrSp;
        Thu, 19 Aug 2021 21:11:34 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 19 Aug 2021 21:11:59 +0800
Subject: Re: [PATCH v2 3/4] ext4: don't return error if huge_file feature
 mismatch
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210819065704.1248402-1-yi.zhang@huawei.com>
 <20210819065704.1248402-4-yi.zhang@huawei.com>
 <20210819102614.GA32435@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <3bccf3af-8408-4a57-74a0-5d9fca85cf1e@huawei.com>
Date:   Thu, 19 Aug 2021 21:11:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210819102614.GA32435@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/8/19 18:26, Jan Kara wrote:
> On Thu 19-08-21 14:57:03, Zhang Yi wrote:
>> In ext4_inode_blocks_set(), huge_file feature should exist when setting
>> i_blocks beyond a 32 bit variable could be represented, return EFBIG if
>> not. This error should never happen in theory since sb->s_maxbytes should
>> not have allowed this, and we have already init sb->s_maxbytes according
>> to this feature in ext4_fill_super(). So switch to use WARN_ON_ONCE
>> instead.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
> 
> One comment below:
> 
>> @@ -4918,10 +4918,15 @@ static int ext4_inode_blocks_set(handle_t *handle,
>>  		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
>>  		raw_inode->i_blocks_high = 0;
>>  		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
>> -		return 0;
>> +		return;
>>  	}
>> -	if (!ext4_has_feature_huge_file(sb))
>> -		return -EFBIG;
>> +
>> +	/*
>> +	 * This should never happen since sb->s_maxbytes should not have
>> +	 * allowed this, which was set according to the huge_file feature
>> +	 * in ext4_fill_super().
>> +	 */
>> +	WARN_ON_ONCE(!ext4_has_feature_huge_file(sb));
> 
> Thinking about this a bit more, this could also happen due to fs
> corruption. So we probably need to call ext4_error_inode() here instead of
> WARN_ON_ONCE(). Also it will result in properly marking fs as having
> errors. But since we hold i_raw_lock at this call site we need to
> keep the error bail out from ext4_inode_blocks_set() and in
> ext4_do_update_inode() finish updating inode and then call
> ext4_error_inode() after dropping i_raw_lock.
> 
Yes, make sense, ext4_error_inode() is more reasonable.

Thanks,
Yi.

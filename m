Return-Path: <linux-ext4+bounces-1259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E942858DC4
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 08:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EF81F223D2
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DE1CD19;
	Sat, 17 Feb 2024 07:45:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9931CD07;
	Sat, 17 Feb 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155918; cv=none; b=lSO3iVF1VWe2qNr/j8OGhmvkp7NPoRxtWPYgV9v4nn2ihEVW+ZKveWvazyprAxGYvJyHlC6hXHNdFniTHwUClpyOMc0/XyDp0XZ6sR3Ub4Y0KO+1XQGCCLHWf3YAsoAG8c45Hhuoxq4KzbFUydXX3Q7OA/FGIxZc/rQ816Z+YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155918; c=relaxed/simple;
	bh=kOFa+40cClPoausTzw1T0175OF2d0Y2d43JTpoBOkqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u4DE4UVXFmhyTSvMnirI2DYAOmPYAass2aF40qwx6zc6xE41yVqmt+Gm7Tr9cnkGbgET/JCqA2Yk4lca80kOSvKJqt5YLVYw6WpmG4NPgxPS6c2ADDJgIuEvYHs7FJAuFk1Nz8d758HOA0ONvjQHMN4SQdjALgk+ixhMOqFimF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcLPn3TPWz1gylJ;
	Sat, 17 Feb 2024 15:43:09 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 8304C140485;
	Sat, 17 Feb 2024 15:45:14 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 15:45:13 +0800
Message-ID: <e867978a-f64f-fe32-2671-aeaa34e75b0e@huawei.com>
Date: Sat, 17 Feb 2024 15:45:13 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 7/7] ext4: set the type of max_zeroout to unsigned int to
 avoid overflow
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-8-libaokun1@huawei.com>
 <20240213163807.lodqvvw24namiu7g@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240213163807.lodqvvw24namiu7g@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/14 0:38, Jan Kara wrote:
> On Fri 26-01-24 16:57:16, Baokun Li wrote:
>> The max_zeroout is of type int and the s_extent_max_zeroout_kb is of
>> type uint, and the s_extent_max_zeroout_kb can be freely modified via
>> the sysfs interface. When the block size is 1024, max_zeroout may
>> overflow, so declare it as unsigned int to avoid overflow.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/extents.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 01299b55a567..8653b13e8248 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3425,10 +3425,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>>   	struct ext4_extent zero_ex1, zero_ex2;
>>   	struct ext4_extent *ex, *abut_ex;
>>   	ext4_lblk_t ee_block, eof_block;
>> -	unsigned int ee_len, depth, map_len = map->m_len;
>> -	int allocated = 0, max_zeroout = 0;
>> -	int err = 0;
>> -	int split_flag = EXT4_EXT_DATA_VALID2;
>> +	unsigned int ee_len, depth, map_len = map->m_len, max_zeroout = 0;
>> +	int err = 0, allocated = 0, split_flag = EXT4_EXT_DATA_VALID2;
> Honestly, I prefer if we keep unrelated variables on different lines,
> especially when they have initializers. I find the code more readable that
> way. So in this case:
>
> 	int err = 0;
> 	int split_flag = EXT4_EXT_DATA_VALID2;
> 	int allocated = 0;
> 	unsigned int max_zeroout = 0;
>
> But otherwise the fix looks good!
>
> 								Honza
Totally agree! I will replace it in the next version.

Thanks!
-- 
With Best Regards,
Baokun Li
.


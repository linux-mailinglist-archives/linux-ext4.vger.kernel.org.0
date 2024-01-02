Return-Path: <linux-ext4+bounces-593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BC821BB1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DA11C21547
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A5F510;
	Tue,  2 Jan 2024 12:34:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D13F4F7
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T4C1D1k2QzvTpd;
	Tue,  2 Jan 2024 20:32:48 +0800 (CST)
Received: from kwepemd200008.china.huawei.com (unknown [7.221.188.40])
	by mail.maildlp.com (Postfix) with ESMTPS id C3C6E18006E;
	Tue,  2 Jan 2024 20:33:56 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemd200008.china.huawei.com (7.221.188.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 2 Jan 2024 20:33:56 +0800
Message-ID: <f18ffc07-aa98-4e7c-8631-88e3a62a786c@huawei.com>
Date: Tue, 2 Jan 2024 20:33:55 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ext4: return 0 when ext4_get_group_info failed in
 __mb_check_buddy
To: Kemeng Shi <shikemeng@huaweicloud.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>
References: <20240102112012.672260-1-yangerkun@huawei.com>
 <48ec32eb-145d-d6fd-e2d3-bd4a4087627b@huaweicloud.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <48ec32eb-145d-d6fd-e2d3-bd4a4087627b@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200008.china.huawei.com (7.221.188.40)



在 2024/1/2 20:17, Kemeng Shi 写道:
> 
> 
> on 1/2/2024 7:20 PM, yangerkun wrote:
>> The return value for __mb_check_buddy should be a integer. Found this by
>> code review.
>>
> Hi yangerkun,
> I think the return value of __mb_check_buddy is actually not used and can
> be removed. See [1] for details :). Thanks!

Hi Kemeng,

Yeah, the return value nowdays help nothing, it's a good choice to 
remove them all.

Thanks.

> 
> [1] https://lore.kernel.org/lkml/20231125161143.3945726-2-shikemeng@huaweicloud.com/
> 
>> Fixes: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index d72b5e3c92ec..55c70a1b445a 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -758,7 +758,7 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>>   
>>   	grp = ext4_get_group_info(sb, e4b->bd_group);
>>   	if (!grp)
>> -		return NULL;
>> +		return 0;
>>   	list_for_each(cur, &grp->bb_prealloc_list) {
>>   		ext4_group_t groupnr;
>>   		struct ext4_prealloc_space *pa;
>>
> 


Return-Path: <linux-ext4+bounces-5844-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0C9FBD30
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A01162219
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C711B653E;
	Tue, 24 Dec 2024 12:16:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38813DDC5;
	Tue, 24 Dec 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042589; cv=none; b=JmF/S0QjKu9K4zlYB30SGymFQFNPqo8E/gGO+sQJUFbvqohTwgKYcD0ULUemrQWh64ogNtTB2mgcdWXY5JhAJt3J0Qml09MtNOJ6pdrjTHOmoapLr9EcngZ3m3ifROHe5XuEd2HiZjbPiQZY60DgKl5tMe29q2CW0YeOBSkHMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042589; c=relaxed/simple;
	bh=bXZj8G/0f61eauI6VJbdwCiuZskp5UaIW8S8uv1E4hI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lfehy72AVZ6GLaRcU12yKpEb/oBdb2w7h7cvVRp1J/9yyDms6bdOA8WNc9Vlz/DyQHpNHjFDCPyDteE5dojfYJYdVhDr0tjvhkxL37NFKv772AyuRi6qqdgnaJrQ1e08AWqfBdUkJ9HckQ3r6uyu4ga/FHlHqAvpKXpAGqX4kMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHYlG22Scz4f3jtN;
	Tue, 24 Dec 2024 20:16:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC73E1A0568;
	Tue, 24 Dec 2024 20:16:24 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCXcoYYpmpnWRgGFg--.28598S2;
	Tue, 24 Dec 2024 20:16:24 +0800 (CST)
Subject: Re: [PATCH 4/6] ext4: remove unneeded check in get_dx_countlimit
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-5-shikemeng@huaweicloud.com>
 <a002a2bd-f8ff-4bf2-bb4d-e686cfeea6ac@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <42f841c7-ce17-42a6-4393-25fba58b2575@huaweicloud.com>
Date: Tue, 24 Dec 2024 20:16:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a002a2bd-f8ff-4bf2-bb4d-e686cfeea6ac@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXcoYYpmpnWRgGFg--.28598S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4rWw1fCry8Xry5WFy7GFg_yoWfZFc_Xa
	1vvrn7CF4rXr1xWF15C39xJFZxK3Z5Ar1rJr95try2vr95trZY9asrJrySya45GF4xJrWa
	kas5ZFy3tFyxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjiID7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/21/2024 3:44 PM, Zhang Yi wrote:
> On 2024/12/19 19:00, Kemeng Shi wrote:
>> The "offset" is always non-NULL, remove unneeded NULL check of "offset".
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> I agree with Ojaswin, the check strengthens the function, and I'd
> suggest that we'd better to keep it for now.
Sure, will drop this in next version.

Thanks,
Kemeng
> 
> Thanks,
> Yi.
> 
>> ---
>>  fs/ext4/namei.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index 33670cebdedc..07a1bb570deb 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -434,8 +434,7 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>>  	} else
>>  		return NULL;
>>  
>> -	if (offset)
>> -		*offset = count_offset;
>> +	*offset = count_offset;
>>  	return (struct dx_countlimit *)(((void *)dirent) + count_offset);
>>  }
>>  
> 



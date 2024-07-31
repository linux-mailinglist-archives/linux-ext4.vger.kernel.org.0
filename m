Return-Path: <linux-ext4+bounces-3556-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E860942949
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB62284747
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83D18B480;
	Wed, 31 Jul 2024 08:37:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33621A8BE3;
	Wed, 31 Jul 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415043; cv=none; b=MIAK9larkR/Wv9NrD5lsC7u4SAfHmH2QW4HcthSoZ8b3Sg4kxb4o9ugs0fNoNj86WF9+Iy216x65kYcjZR+0a2JtcPATCjbdFjlSgor6uyTEWrHMt7yxKSJSfufFNMrxsTTQvReJKh8nqk1wXxwBLmPTiR/Xkv7YHoGCVMcx2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415043; c=relaxed/simple;
	bh=kx+WXr+aG/XOA88K5RCoIIY+kKBJctVEAjfLgYDBvLQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y+Jt2aGGytXF4Jv+EAX5L19Yu6Ndbtif3ski4v/HBoeVn40RN1q+fJ9coQLpOYGI2ceny4qy11t9EI5djJOE8/pQpcqrvtySXl6YGfEwdk9TNj6M7Vkp7jm4it5JBh9Gk07mnFEJMBDrsw6JEWyNnoytZ+eUBQyOzTHS+Hn0Qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYlnw1lMmz4f3jqM;
	Wed, 31 Jul 2024 16:37:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E11B21A15AC;
	Wed, 31 Jul 2024 16:37:16 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoS796lmxQZxAQ--.38747S2;
	Wed, 31 Jul 2024 16:37:16 +0800 (CST)
Subject: Re: [PATCH 7/7] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-8-shikemeng@huaweicloud.com>
 <a5da8406-ed52-b71f-4766-a16e8d175496@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7c6b48fa-0734-df56-eb6b-3df427bce59d@huaweicloud.com>
Date: Wed, 31 Jul 2024 16:37:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a5da8406-ed52-b71f-4766-a16e8d175496@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3XoS796lmxQZxAQ--.38747S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtr4rAw1kJF1rZFyftw4ruFg_yoW8Jr1kpr
	yrGFyYyFWFvrW7WF1IqFs5GrWjv3yvkFyUCr90kw1vkw47Jrn7J3s8Gw1rWa90kr1S93Wx
	Zr17ZayDG3yYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 7/31/2024 2:17 PM, Zhang Yi wrote:
> On 2024/7/30 19:33, Kemeng Shi wrote:
>> Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
>> ret.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/jbd2/journal.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index dc18b9f7c999..6f90f7b8e9e5 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -842,12 +842,8 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
>>  		fc_off = journal->j_fc_off;
>>  		blocknr = journal->j_fc_first + fc_off;
>>  		journal->j_fc_off++;
>> -	} else {
>> -		ret = -EINVAL;
>> -	}
>> -
>> -	if (ret)
>> -		return ret;
>> +	} else
>> +		return -EINVAL;
>>  
> 
> I'd like this style, just a suggestion.
> 
> 	if (journal->j_fc_off + journal->j_fc_first >= journal->j_fc_last)
> 		return -EINVAL;
> 
> 	fc_off = journal->j_fc_off;
> 	blocknr = journal->j_fc_first + fc_off;
> 	journal->j_fc_off++;
> 
> 	...
> 
Sorry, I miss this. I also think code looks better in this way. I will do
it in next version. Thanks.
> Thanks,
> Yi.
> 
> 
>>  	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
>>  	if (ret)
>>
> 



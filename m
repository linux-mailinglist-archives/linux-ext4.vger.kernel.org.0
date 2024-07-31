Return-Path: <linux-ext4+bounces-3540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D001894242B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 03:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327E0284E5D
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08648C2ED;
	Wed, 31 Jul 2024 01:35:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6EB1AA3C3;
	Wed, 31 Jul 2024 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389716; cv=none; b=VNrA/Vr63EFOgVugtSb5o6ZkUE+v6xjyizax4kjWP+5F7Zcv43YWV73wREBKpLxOaaDSqi8/QOXSZErwiyQpVGR45BrjZ97eavgYK7Tcfy3T2HUCJVRz5ePOnvc9Ld5uiMgq4wSqNWpaOjXipHOJ13pwovVCUFhArDOX0rWW0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389716; c=relaxed/simple;
	bh=i7McqhjslTEUgJNczjwLHkbohcNeCfBcxZU9Cyupdi4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ALyxqBdb0WE9BK0R/tASIUbchGJH4UkotO8NdQ7m7PoWWhGvdKSR3bm7mfOF2N2UZlBZU0fuhu54V8cFsS9B7euPzBq0hZqfJMZGxNxVyCDUFs9m7p2z8B7axDb6HGR+prL51CZXFaH3nYJvdihH6MeMhiGpGImv2jfkYfibm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYZQt0c56z4f3jjx;
	Wed, 31 Jul 2024 09:35:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B55E91A0359;
	Wed, 31 Jul 2024 09:35:10 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgB3f1G6lKlmF8ZJAQ--.37087S2;
	Wed, 31 Jul 2024 09:35:10 +0800 (CST)
Subject: Re: [PATCH 5/7] jbd2: remove unneeded done_copy_out variable in
 jbd2_journal_write_metadata_buffer
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-6-shikemeng@huaweicloud.com>
 <20240730134943.ircjz6l5ix6zmmwe@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <0f83f5e5-97d1-fc63-f611-21cd08e9e70b@huaweicloud.com>
Date: Wed, 31 Jul 2024 09:34:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730134943.ircjz6l5ix6zmmwe@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3f1G6lKlmF8ZJAQ--.37087S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF18tr18ZFyDJrWUZr1fWFg_yoW8tFWDpF
	WrKrWkKFykJry2yr1DWw4UZryUKrWDWr17Kr47Ca43Aa9Ig3sI9F1YyFW0g3WjyrZ3AF48
	ZF17XFyxWwsIya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 7/30/2024 9:49 PM, Jan Kara wrote:
> On Tue 30-07-24 19:33:33, Kemeng Shi wrote:
>> It's more intuitive to use jh_in->b_frozen_data directly instead of
>> done_copy_out variable. Simply remove unneeded done_copy_out variable
>> and use b_frozen_data instead.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
>> @@ -357,17 +355,15 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  		new_folio = bh_in->b_folio;
>>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>>  		mapped_data = kmap_local_folio(new_folio, new_offset);
>> -	}
>> -
>> -	/*
>> -	 * Fire data frozen trigger if data already wasn't frozen.  Do this
>> -	 * before checking for escaping, as the trigger may modify the magic
>> -	 * offset.  If a copy-out happens afterwards, it will have the correct
>> -	 * data in the buffer.
>> -	 */
>> -	if (!done_copy_out)
>> +		/*
>> +		 * Fire data frozen trigger if data already wasn't frozen. Do
>> +		 * this before checking for escaping, as the trigger may modify
>> +		 * the magic offset.  If a copy-out happens afterwards, it will
>> +		 * have the correct data in the buffer.
>> +		 */
>>  		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>>  					   jh_in->b_triggers);
>> +	}
> 
> I like how you've got rid of the conditional. But I'd go further and also
> move the escaping check and thus unmap & possible frozen buffer creation
> into the branch. Like:
> 
> 		do_escape = jbd2_data_needs_escaping(mapped_data);
> 			- create this trivial helper
> 		kunmap_local(mapped_data);
> 		if (do_escape) {
> 			handle b_frozen_data creation
> 		}
Thanks Jan. It does look better this way, I will do it in next version.

Kemeng.
> 
> 								Honza
> 
>>  
>>  	/*
>>  	 * Check for escaping
>> @@ -380,7 +376,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  	/*
>>  	 * Do we need to do a data copy?
>>  	 */
>> -	if (do_escape && !done_copy_out) {
>> +	if (do_escape && !jh_in->b_frozen_data) {
>>  		char *tmp;
>>  
>>  		spin_unlock(&jh_in->b_state_lock);
>> @@ -408,7 +404,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  copy_done:
>>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>> -		done_copy_out = 1;
>>  	}
>>  
>>  	/*
>> -- 
>> 2.30.0
>>



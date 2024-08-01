Return-Path: <linux-ext4+bounces-3579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7009440A6
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858AD1F2269F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43E1A0720;
	Thu,  1 Aug 2024 01:24:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45013AA2D;
	Thu,  1 Aug 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475476; cv=none; b=SK3OChJDuuGeUS3e5IbooEktrpzDKeURgJQVxjaPbtetFIha4oos1k3vOe83ltoG1+Ts33PbZzEf1rDvZnOvxTNAezH++dnYLe7qa863CWO4VhaoczE4d3p9dg3oXCzUXUlmYia/5nHBMPnBwSybDxfYGpr8kZY5LEDbNw/CobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475476; c=relaxed/simple;
	bh=szTeyMQLDM3wAMn9EegK2Gei3FbTHD59zf+v7vtmfII=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ONjNk7Dl1QyJGNZOTrZA3v18595kn+fkBt7HIjVHEbP56S01JgyS1E8g0rVrDREjcUyr62dOfxus3VY5dssoOsbvGepcBay+Z/J312xFYaNnelxznl9b11eHtA95IVSZn33aT0xbZk9QFqjldP6/Enmn9tgthzpI5vPVtC8yVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WZB801gdkz4f3jHk;
	Thu,  1 Aug 2024 09:24:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 307991A06D7;
	Thu,  1 Aug 2024 09:24:29 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCnzYPL46pmPwO0AQ--.21094S2;
	Thu, 01 Aug 2024 09:24:29 +0800 (CST)
Subject: Re: [PATCH v3 6/8] ext4: move escape handle to futher improve
 jbd2_journal_write_metadata_buffer
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-7-shikemeng@huaweicloud.com>
 <a3fe84d8-62b6-fa5e-a088-15b34fab6063@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a4c6f818-ec38-67a2-35b4-c27726ae0734@huaweicloud.com>
Date: Thu, 1 Aug 2024 09:24:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a3fe84d8-62b6-fa5e-a088-15b34fab6063@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnzYPL46pmPwO0AQ--.21094S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF13AF18AFykKr45Cr1kAFb_yoW5Kw13pr
	93KF1fKFWvqr9Fyrn7Ww4DZryYgrWkWr17K3W3Gas3tFZY9wn2gF4jvryrGa4jyrWvka18
	XFyjqFyxuwnIkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjuHq7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 7/31/2024 8:17 PM, Zhang Yi wrote:
> The title: "ext4: move escape handle..." should be "jbd2: move escape handle..."
> 
Sorry for this, will fix it in next version. Thanks!
> Thanks,
> Yi.
> 
> On 2024/7/31 17:29, Kemeng Shi wrote:
>> Move escape handle to futher improve code readability and remove some
>> repeat check.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/jbd2/journal.c | 49 +++++++++++++++++++++++------------------------
>>  1 file changed, 24 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index f17d05bc61df..85273fb1accb 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -281,6 +281,16 @@ static void journal_kill_thread(journal_t *journal)
>>  	write_unlock(&journal->j_state_lock);
>>  }
>>  
>> +static inline bool jbd2_data_needs_escaping(char *data)
>> +{
>> +	return *((__be32 *)data) == cpu_to_be32(JBD2_MAGIC_NUMBER);
>> +}
>> +
>> +static inline void jbd2_data_do_escape(char *data)
>> +{
>> +	*((unsigned int *)data) = 0;
>> +}
>> +
>>  /*
>>   * jbd2_journal_write_metadata_buffer: write a metadata buffer to the journal.
>>   *
>> @@ -319,7 +329,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  				  sector_t blocknr)
>>  {
>>  	int do_escape = 0;
>> -	char *mapped_data;
>>  	struct buffer_head *new_bh;
>>  	struct folio *new_folio;
>>  	unsigned int new_offset;
>> @@ -350,8 +359,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  	if (jh_in->b_frozen_data) {
>>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>> -		mapped_data = jh_in->b_frozen_data;
>> +		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
>> +		if (do_escape)
>> +			jbd2_data_do_escape(jh_in->b_frozen_data);
>>  	} else {
>> +		char *tmp;
>> +		char *mapped_data;
>> +
>>  		new_folio = bh_in->b_folio;
>>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>>  		mapped_data = kmap_local_folio(new_folio, new_offset);
>> @@ -363,21 +377,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  		 */
>>  		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>>  					   jh_in->b_triggers);
>> -	}
>> -
>> -	/*
>> -	 * Check for escaping
>> -	 */
>> -	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
>> -		do_escape = 1;
>> -	if (!jh_in->b_frozen_data)
>> +		do_escape = jbd2_data_needs_escaping(mapped_data);
>>  		kunmap_local(mapped_data);
>> -
>> -	/*
>> -	 * Do we need to do a data copy?
>> -	 */
>> -	if (do_escape && !jh_in->b_frozen_data) {
>> -		char *tmp;
>> +		/*
>> +		 * Do we need to do a data copy?
>> +		 */
>> +		if (!do_escape)
>> +			goto escape_done;
>>  
>>  		spin_unlock(&jh_in->b_state_lock);
>>  		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
>> @@ -404,17 +410,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  copy_done:
>>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>> +		jbd2_data_do_escape(jh_in->b_frozen_data);
>>  	}
>>  
>> -	/*
>> -	 * Did we need to do an escaping?  Now we've done all the
>> -	 * copying, we can finally do so.
>> -	 * b_frozen_data is from jbd2_alloc() which always provides an
>> -	 * address from the direct kernels mapping.
>> -	 */
>> -	if (do_escape)
>> -		*((unsigned int *)jh_in->b_frozen_data) = 0;
>> -
>> +escape_done:
>>  	folio_set_bh(new_bh, new_folio, new_offset);
>>  	new_bh->b_size = bh_in->b_size;
>>  	new_bh->b_bdev = journal->j_dev;
>>
> 
> 



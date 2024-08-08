Return-Path: <linux-ext4+bounces-3669-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6594B648
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 07:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492711F21301
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AAB13BACE;
	Thu,  8 Aug 2024 05:31:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488D7E1;
	Thu,  8 Aug 2024 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095073; cv=none; b=VQrAiNmfB3vYF6aqL0aDOOCboGAZ8HsqZh0ilLCaiub7c6MtD+Uq588evE9yeghzrfDfPQ6PgbdS0wKZP9OoQeMSjw7uzWSEORSCel9AJo6WlpVWkyS3/Imw0HZEz98Qzzu9EEcuPbq3aJMT54DZmClBfDPbNX74wnJRTKfyDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095073; c=relaxed/simple;
	bh=mEqa4IkpK4JJIL78XPPwu/dN09TjXlEr0XzBqsNe6E0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lGkNVy4vPyTPe/rQcx2YYUVoASw+BarQ+HQkLJ/16Oc0AAYsoF3WDYoCX/dW8bKVh6Tuy8m+dpw2pLko/7Epq2mDnnVxmqf+m/8OzHmCROGEmgeHamHLDxHTiYBgRQFWqx1q5rkUeixU8UYMZ7xIA3HJOyIGAKG8U3q30gl1Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WfbHB2kmVz4f3kvf;
	Thu,  8 Aug 2024 13:30:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB18C1A111E;
	Thu,  8 Aug 2024 13:31:00 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCH_IITWLRm4A9dBA--.39061S2;
	Thu, 08 Aug 2024 13:31:00 +0800 (CST)
Subject: Re: [PATCH v3 6/8] ext4: move escape handle to futher improve
 jbd2_journal_write_metadata_buffer
To: "wangjianjian (C)" <wangjianjian3@huawei.com>, tytso@mit.edu,
 jack@suse.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-7-shikemeng@huaweicloud.com>
 <2eb72bf1-8c15-40f7-98fe-156c91ab9191@huawei.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7ba5654e-96d4-8dea-c82d-952bd11fe825@huaweicloud.com>
Date: Thu, 8 Aug 2024 13:30:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2eb72bf1-8c15-40f7-98fe-156c91ab9191@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH_IITWLRm4A9dBA--.39061S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UXr45uryfCF1UCFWktFb_yoWruFy5pr
	95Kry5Jry0qrn7tr18Wr1UAryUKrWUX3WUtr18WFy7JrWUCr1qgr4UZr1vgr1UArWkJr48
	Xr1UXr9ruFnxtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUU
	UUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/7/2024 3:41 PM, wangjianjian (C) wrote:
> On 2024/7/31 17:29, Kemeng Shi wrote:
>> Move escape handle to futher improve code readability and remove some
>> repeat check.
> Should subject prefix "ext4" be "jbd2" ?
Hello, I have updated this in v4 series. Thanks!
Kemeng
> 
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   fs/jbd2/journal.c | 49 +++++++++++++++++++++++------------------------
>>   1 file changed, 24 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index f17d05bc61df..85273fb1accb 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -281,6 +281,16 @@ static void journal_kill_thread(journal_t *journal)
>>       write_unlock(&journal->j_state_lock);
>>   }
>>   +static inline bool jbd2_data_needs_escaping(char *data)
>> +{
>> +    return *((__be32 *)data) == cpu_to_be32(JBD2_MAGIC_NUMBER);
>> +}
>> +
>> +static inline void jbd2_data_do_escape(char *data)
>> +{
>> +    *((unsigned int *)data) = 0;
>> +}
>> +
>>   /*
>>    * jbd2_journal_write_metadata_buffer: write a metadata buffer to the journal.
>>    *
>> @@ -319,7 +329,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>                     sector_t blocknr)
>>   {
>>       int do_escape = 0;
>> -    char *mapped_data;
>>       struct buffer_head *new_bh;
>>       struct folio *new_folio;
>>       unsigned int new_offset;
>> @@ -350,8 +359,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>       if (jh_in->b_frozen_data) {
>>           new_folio = virt_to_folio(jh_in->b_frozen_data);
>>           new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>> -        mapped_data = jh_in->b_frozen_data;
>> +        do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
>> +        if (do_escape)
>> +            jbd2_data_do_escape(jh_in->b_frozen_data);
>>       } else {
>> +        char *tmp;
>> +        char *mapped_data;
>> +
>>           new_folio = bh_in->b_folio;
>>           new_offset = offset_in_folio(new_folio, bh_in->b_data);
>>           mapped_data = kmap_local_folio(new_folio, new_offset);
>> @@ -363,21 +377,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>            */
>>           jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>>                          jh_in->b_triggers);
>> -    }
>> -
>> -    /*
>> -     * Check for escaping
>> -     */
>> -    if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
>> -        do_escape = 1;
>> -    if (!jh_in->b_frozen_data)
>> +        do_escape = jbd2_data_needs_escaping(mapped_data);
>>           kunmap_local(mapped_data);
>> -
>> -    /*
>> -     * Do we need to do a data copy?
>> -     */
>> -    if (do_escape && !jh_in->b_frozen_data) {
>> -        char *tmp;
>> +        /*
>> +         * Do we need to do a data copy?
>> +         */
>> +        if (!do_escape)
>> +            goto escape_done;
>>             spin_unlock(&jh_in->b_state_lock);
>>           tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
>> @@ -404,17 +410,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>   copy_done:
>>           new_folio = virt_to_folio(jh_in->b_frozen_data);
>>           new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>> +        jbd2_data_do_escape(jh_in->b_frozen_data);
>>       }
>>   -    /*
>> -     * Did we need to do an escaping?  Now we've done all the
>> -     * copying, we can finally do so.
>> -     * b_frozen_data is from jbd2_alloc() which always provides an
>> -     * address from the direct kernels mapping.
>> -     */
>> -    if (do_escape)
>> -        *((unsigned int *)jh_in->b_frozen_data) = 0;
>> -
>> +escape_done:
>>       folio_set_bh(new_bh, new_folio, new_offset);
>>       new_bh->b_size = bh_in->b_size;
>>       new_bh->b_bdev = journal->j_dev;



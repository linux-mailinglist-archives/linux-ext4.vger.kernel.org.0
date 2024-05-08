Return-Path: <linux-ext4+bounces-2354-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25BD8BF439
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 03:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F34BB21BD2
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83A9441;
	Wed,  8 May 2024 01:46:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C8C13B;
	Wed,  8 May 2024 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132766; cv=none; b=RpzwjnP9A+iaLRvdsrc+NRFarkan4Hvaq46L8g8KIOW60YJu8EfAe4B+FQoIRNzaMn69iw5i1cACCpNiE2/F9D+N5sjz2KjoTlVKBISjkaR3GJ9DRzQuaujC3R7Ty2DxbDhcBUY/Cazd9yFcW4GzIRPgYDFZOZ31p1jFc13PShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132766; c=relaxed/simple;
	bh=W7ybjPe0BkA14FFGDTX7fq0I5oQUbMY6QkKas4Geh64=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n3nGnN0BYDhnHqKTcxgxN/D7sz4JnMFJ8x1qvqU8rRfqDriwnZHVE/NBxi1m5RDY7Km5WfIBtB50egn/oBoyBgMeJkI/dhtjtnSZjQdjhufYrEuijGA0jflLePJCJllJkKwN/GaNE1lehus7CKZVl3hisnDwAbivfIVktnq29hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYyf63Rlgz4f3mHq;
	Wed,  8 May 2024 09:45:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4B7DE1A0179;
	Wed,  8 May 2024 09:46:00 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAHCpJX2TpmvRKDLw--.36309S2;
	Wed, 08 May 2024 09:46:00 +0800 (CST)
Subject: Re: [PATCH 4/9] jbd2: move repeat tag around to remove a repeat check
 of b_frozen_data
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-5-shikemeng@huaweicloud.com>
 <b2fa97c7-3f1c-321d-038e-7fb46420d24b@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <76da9920-caa1-5f80-549f-ae07ada34fa9@huaweicloud.com>
Date: Wed, 8 May 2024 09:45:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b2fa97c7-3f1c-321d-038e-7fb46420d24b@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHCpJX2TpmvRKDLw--.36309S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13Zw47XFyfAw1DAr17Awb_yoW8Gryxpr
	95KF1jkFWvq3srAFn7Wa1DZrWjvw4vgFy8KFs8Cr13Aay7Xr1IgFyjqw4UKw1jyrZ7G3y8
	Zr1q93yxW3ZIvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUU
	UU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 5/7/2024 8:41 PM, Zhang Yi wrote:
> On 2024/5/6 22:17, Kemeng Shi wrote:
>> We make sure b_frozen_data is not NULL before jump to "repeat" tag, move
>> "repeat" tag around to remove repeat check of b_frozen_data.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/jbd2/journal.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 9a35d0c5b38c..77fcdc76fdfd 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -353,12 +353,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  	atomic_set(&new_bh->b_count, 1);
>>  
>>  	spin_lock(&jh_in->b_state_lock);
>> -repeat:
>>  	/*
>>  	 * If a new transaction has already done a buffer copy-out, then
>>  	 * we use that version of the data for the commit.
>>  	 */
>>  	if (jh_in->b_frozen_data) {
>> +repeat:
>>  		done_copy_out = 1;
>>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>>
> 
> I suppose we could drop the repeat tag entirely, just set the new_folio and
> new_offset, and then goto handle do_escape. We don't need to call
> jbd2_buffer_frozen_trigger() and check for escaping again, is that right?
Sure, sounds reasonable to me. Will do it in next version. Thanks
> 
> Thanks,
> Yi.
> 



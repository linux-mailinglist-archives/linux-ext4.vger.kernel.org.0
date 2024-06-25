Return-Path: <linux-ext4+bounces-2948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6A9166D2
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 14:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E848CB22180
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6A14D296;
	Tue, 25 Jun 2024 12:03:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271F146A83;
	Tue, 25 Jun 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316983; cv=none; b=Nzv04kqqy5I1fGxf++uC24PBdpLqIWy2S9EiIWQ7DJ+f8XATiUBMctqzAOwTnkGagoitMbjqqIQ8TJ7koIMV3X7OkWmSnN1C/1McYzWs4eGeUXBp/jaWKJWdaf0UzzpZMrrI8ArU3mPhdNfYm69E9zx/QVmIHACubkcN5OupcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316983; c=relaxed/simple;
	bh=mS+rZUtb5K+RjeS3jy24SMFLmKYC19yORuviinahatI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Qb80ggWQ6mFkSF2SwNz8lbfvuYYatf51Z1Jy0D2dR57TtV58Apw+KVsk+Vh0rkRJwOJ07Y2FcBe5V7nShk9+N+BPvXHBoeO4i/5HV+BzptMdMCwy2Bhr2QsOKvmevboBTnDvr0iLhnmFh6lHG3EP6KrMXqgOsS0Fq9S7B31WnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W7k3p0LLcz4f3jMH;
	Tue, 25 Jun 2024 20:02:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C7CD61A0572;
	Tue, 25 Jun 2024 20:02:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDHO3jvsXpmFbssAQ--.45075S2;
	Tue, 25 Jun 2024 20:02:56 +0800 (CST)
Subject: Re: [PATCH v2 2/4] jbd2: Precompute number of transaction descriptor
 blocks
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Alexander Coffin <alex.coffin@maticrobots.com>, stable@vger.kernel.org
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-2-jack@suse.cz>
 <483983e0-8827-9801-5268-abfd97865d94@huaweicloud.com>
 <20240625110726.wny5vmig7v2ugdbh@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <17f3006d-4601-9f34-0ab0-fec6e9f55ffa@huaweicloud.com>
Date: Tue, 25 Jun 2024 20:02:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240625110726.wny5vmig7v2ugdbh@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHO3jvsXpmFbssAQ--.45075S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4DAFyDZF18Gw13CFyfZwb_yoW5GFykp3
	yFkaySkr98Zry7Z3Z3Xa18W3yFgayIyFyUWrnrurs3KayDtwn3tr9rtr1Yga40yr97uw1j
	qF4UJasrGa90kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/25/2024 7:07 PM, Jan Kara wrote:
> On Tue 25-06-24 17:31:15, Kemeng Shi wrote:
>> on 6/25/2024 1:01 AM, Jan Kara wrote:
>>> Instead of computing the number of descriptor blocks a transaction can
>>> have each time we need it (which is currently when starting each
>>> transaction but will become more frequent later) precompute the number
>>> once during journal initialization together with maximum transaction
>>> size. We perform the precomputation whenever journal feature set is
>>> updated similarly as for computation of
>>> journal->j_revoke_records_per_block.
>>>
>>> CC: stable@vger.kernel.org
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>>  fs/jbd2/journal.c     | 61 ++++++++++++++++++++++++++++++++-----------
>>>  fs/jbd2/transaction.c | 24 +----------------
>>>  include/linux/jbd2.h  |  7 +++++
>>>  3 files changed, 54 insertions(+), 38 deletions(-)
>>>
>>> +static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
>>> +{
>>> +	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
>>> +	int tags_per_block;
>>> +
>>> +	/* Subtract UUID */
>>> +	tag_space -= 16;
>>> +	if (jbd2_journal_has_csum_v2or3(journal))
>>> +		tag_space -= sizeof(struct jbd2_journal_block_tail);
>>> +	/* Commit code leaves a slack space of 16 bytes at the end of block */
>>> +	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
>>> +	/*
>>> +	 * Revoke descriptors are accounted separately so we need to reserve
>>> +	 * space for commit block and normal transaction descriptor blocks.
>>> +	 */
>>> +	return 1 + DIV_ROUND_UP(jbd2_journal_get_max_txn_bufs(journal),
>>> +				tags_per_block);
>>> +}
>> The change looks good to me. I wonder if the original calculation of
>> number of JBD2_DESCRIPTOR_BLOCK blocks is correct.
>> In my opinion, it should be:
>> DIV_ROUND_UP(jbd2_journal_get_max_txn_bufs(journal), tags_per_block *+ 1*)
>> Assume max_txn_bufs is 6, tags_per_block is 1, then we have one tag block
>> after each JBD2_DESCRIPTOR_BLOCK block. Then we could get 3
>> JBD2_DESCRIPTOR_BLOCK block at most rather than 6.
>> Please let me konw if I miss something, this confused me for sometime...
> 
> So you are correct that the expression is overestimating the number of
> descriptor blocks required, essentially because we don't need descriptor
> blocks for descriptor blocks. But given tags_per_block is at least over 60,
> in common configurations over 250, this imprecision is not really
> substantial and I prefer a simple to argue about upper estimate...
Right, I agree with this. Thanks for explanation.
> 
> 								Honza
> 



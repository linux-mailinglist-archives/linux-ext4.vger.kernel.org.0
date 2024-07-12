Return-Path: <linux-ext4+bounces-3234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736A92F8F7
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 12:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA702825CE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79260158A1E;
	Fri, 12 Jul 2024 10:28:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2E155382;
	Fri, 12 Jul 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780114; cv=none; b=lUqNwZHSGU/KXdGa/0H9YnT3kLeG9nmCjnwcN0Zdq5yezKuIroCRrC77SU0fMH1huG+u7/ziw8pX9KLkkc7si+FPfMrvKDKmubBN8BbU5NxIigdDyzrfhWbbN8PJxFm+73FoMEl3gFxjac84ODygH32H76KDf3fllKZ8vuaUb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780114; c=relaxed/simple;
	bh=/jwj4ZcFwoDhSg1cZkyLmP80Tipw6rXbgR83cx9X0p4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=BtfUXgFcKpDzjd6WSnbGwxGIbNCik/G0BQ6hi9S0UxvP2A6tO69mvntBWZhHSwExit6EZNDH0XUXN6Pa5dYtbaKNLzWnjGcqbuVHu9mnhV20CVtUX2I1jnxcfh2pYOMzKPAys5/xEIspUQo/qpFQG3xX2U3w+DtqmIre8Jbbrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WL74F6lLSz1X4jC;
	Fri, 12 Jul 2024 18:24:13 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 76B5F1A016C;
	Fri, 12 Jul 2024 18:28:28 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jul 2024 18:28:27 +0800
Message-ID: <2c8ba685-403e-4694-81ad-751c40895fa4@huawei.com>
Date: Fri, 12 Jul 2024 18:28:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] jbd2: make '0' an invalid transaction sequence
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
To: Luis Henriques <luis.henriques@linux.dev>, Andreas Dilger
	<adilger@dilger.ca>
CC: Wang Jianjian <wangjianjian0@foxmail.com>, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240711083520.6751-1-luis.henriques@linux.dev>
 <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
 <878qy8nem5.fsf@brahms.olymp>
 <tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
 <A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca> <87ed7znf8n.fsf@linux.dev>
 <87wmlrkkch.fsf_-_@linux.dev>
 <20b9015d-80ed-4864-811a-ff4b0e3774dd@huawei.com>
Content-Language: en-US
In-Reply-To: <20b9015d-80ed-4864-811a-ff4b0e3774dd@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/7/12 18:04, wangjianjian (C) wrote:
> On 2024/7/12 17:53, Luis Henriques wrote:
>> Since there's code (in fast-commit) that already handles a '0' tid as a
>> special case, it's better to ensure that jbd2 never sets it to that value
>> when journal->j_transaction_sequence increment wraps.
>>
>> Suggested-by: Andreas Dilger <adilger@dilger.ca>
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>>   fs/jbd2/transaction.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index 66513c18ca29..4dbdd37349c3 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -84,6 +84,8 @@ static void jbd2_get_transaction(journal_t *journal,
>>       transaction->t_state = T_RUNNING;
>>       transaction->t_start_time = ktime_get();
>>       transaction->t_tid = journal->j_transaction_sequence++;
>> +    if (unlikely(transaction->t_tid == 0))
>> +        transaction->t_tid = journal->j_transaction_sequence++;
> Do we need add j_transaction_sequence again here? if tansanction->t_tid 
> == 0, then journal->j_trnasaction_sequence must be 1
still need add 1. Sorry for confuse.
> 
>>       transaction->t_expires = jiffies + journal->j_commit_interval;
>>       atomic_set(&transaction->t_updates, 0);
>>       atomic_set(&transaction->t_outstanding_credits,
-- 
Regards



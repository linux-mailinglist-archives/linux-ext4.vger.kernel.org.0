Return-Path: <linux-ext4+bounces-3233-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1892F8AE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 12:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41AD1C208CA
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740015251C;
	Fri, 12 Jul 2024 10:05:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7910F7;
	Fri, 12 Jul 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778745; cv=none; b=sHMq5/OaZZRw6xZ6oZljGcMwo+kY1t9jf/nt+vYudTjxvzVo9DY6riCH8o8Q5CAzYnpccBXGj/90gzpulh4DDs2x3zU9x++PoQbNcyJZOqWoaqwec1AwF8LoLmHWHPSvN4qAKL6/kcYmLpGx0Pj08xYBRf8PAJ8ICeH/2iZT3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778745; c=relaxed/simple;
	bh=eNpOohRTg3sL6MiRjtOVbuLFKyzUozLlvJcudOSO/xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MH4tNTxLi+14tYUQBiApFrFf52JskKr5WTYaZNOuzkiG1/vbzal4012kxzSsYhCGP9YA3A7SstifTWLxmKlrK6evHiCOtru3KS1qX28TYFLD3Avn4ZvbUegzQKOTVgcs06kO3eUaCan7CZUk47Js3TVUEEAPpd4PMnNjbpYKwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WL6YP4rH4zQlTd;
	Fri, 12 Jul 2024 18:00:57 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id A224D14097F;
	Fri, 12 Jul 2024 18:04:55 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jul 2024 18:04:54 +0800
Message-ID: <20b9015d-80ed-4864-811a-ff4b0e3774dd@huawei.com>
Date: Fri, 12 Jul 2024 18:04:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] jbd2: make '0' an invalid transaction sequence
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
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <87wmlrkkch.fsf_-_@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/7/12 17:53, Luis Henriques wrote:
> Since there's code (in fast-commit) that already handles a '0' tid as a
> special case, it's better to ensure that jbd2 never sets it to that value
> when journal->j_transaction_sequence increment wraps.
> 
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
>   fs/jbd2/transaction.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 66513c18ca29..4dbdd37349c3 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -84,6 +84,8 @@ static void jbd2_get_transaction(journal_t *journal,
>   	transaction->t_state = T_RUNNING;
>   	transaction->t_start_time = ktime_get();
>   	transaction->t_tid = journal->j_transaction_sequence++;
> +	if (unlikely(transaction->t_tid == 0))
> +		transaction->t_tid = journal->j_transaction_sequence++;
Do we need add j_transaction_sequence again here? if tansanction->t_tid 
== 0, then journal->j_trnasaction_sequence must be 1

>   	transaction->t_expires = jiffies + journal->j_commit_interval;
>   	atomic_set(&transaction->t_updates, 0);
>   	atomic_set(&transaction->t_outstanding_credits,
-- 
Regards



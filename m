Return-Path: <linux-ext4+bounces-3653-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72794A1E9
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4242835D6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1B1C57AA;
	Wed,  7 Aug 2024 07:41:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26B8F77;
	Wed,  7 Aug 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016481; cv=none; b=na7fM3cAx/yxikuh9zD0flVb2FZG5/+/oF+P8cJimpCTEN+kS99PIyXNYKm6hiaTxVf9LKfIzxpg0nPo05nBIkplU3UPgOpFUOrElfVtWQM1zC3QCQUoCY+UK4+6UFKO+TWsxAFNI5x0r5Pt4eOPtwY9lahRA1igVgcAYHwJHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016481; c=relaxed/simple;
	bh=KLMCQjIQt1MmwyFO5vJjT+qxHO3XCKdeXZAoeKf6b7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cVqcRFk1E14/eryF3GXPGxYeGr1ISAQbZP6hjcvp4+B8+qHANLs4GDObdMCnL9CkcbKsfL4vy9WQpOF4ONI4NgqVUTeaRy9KK5W77Jvj/qBZ4OsOKxY/FxUK7SKjyXgq1oXjZzVpEcraBV3dEQmWa1AkHei9O24lks94cOynFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wf2Bq740lzpT2b;
	Wed,  7 Aug 2024 15:40:03 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id DDFD71400D1;
	Wed,  7 Aug 2024 15:41:13 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 15:41:13 +0800
Message-ID: <2eb72bf1-8c15-40f7-98fe-156c91ab9191@huawei.com>
Date: Wed, 7 Aug 2024 15:41:12 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] ext4: move escape handle to futher improve
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>, <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-7-shikemeng@huaweicloud.com>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20240731092910.2383048-7-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/7/31 17:29, Kemeng Shi wrote:
> Move escape handle to futher improve code readability and remove some
> repeat check.
Should subject prefix "ext4" be "jbd2" ?

> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   fs/jbd2/journal.c | 49 +++++++++++++++++++++++------------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index f17d05bc61df..85273fb1accb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -281,6 +281,16 @@ static void journal_kill_thread(journal_t *journal)
>   	write_unlock(&journal->j_state_lock);
>   }
>   
> +static inline bool jbd2_data_needs_escaping(char *data)
> +{
> +	return *((__be32 *)data) == cpu_to_be32(JBD2_MAGIC_NUMBER);
> +}
> +
> +static inline void jbd2_data_do_escape(char *data)
> +{
> +	*((unsigned int *)data) = 0;
> +}
> +
>   /*
>    * jbd2_journal_write_metadata_buffer: write a metadata buffer to the journal.
>    *
> @@ -319,7 +329,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>   				  sector_t blocknr)
>   {
>   	int do_escape = 0;
> -	char *mapped_data;
>   	struct buffer_head *new_bh;
>   	struct folio *new_folio;
>   	unsigned int new_offset;
> @@ -350,8 +359,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>   	if (jh_in->b_frozen_data) {
>   		new_folio = virt_to_folio(jh_in->b_frozen_data);
>   		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> -		mapped_data = jh_in->b_frozen_data;
> +		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
> +		if (do_escape)
> +			jbd2_data_do_escape(jh_in->b_frozen_data);
>   	} else {
> +		char *tmp;
> +		char *mapped_data;
> +
>   		new_folio = bh_in->b_folio;
>   		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>   		mapped_data = kmap_local_folio(new_folio, new_offset);
> @@ -363,21 +377,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>   		 */
>   		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>   					   jh_in->b_triggers);
> -	}
> -
> -	/*
> -	 * Check for escaping
> -	 */
> -	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
> -		do_escape = 1;
> -	if (!jh_in->b_frozen_data)
> +		do_escape = jbd2_data_needs_escaping(mapped_data);
>   		kunmap_local(mapped_data);
> -
> -	/*
> -	 * Do we need to do a data copy?
> -	 */
> -	if (do_escape && !jh_in->b_frozen_data) {
> -		char *tmp;
> +		/*
> +		 * Do we need to do a data copy?
> +		 */
> +		if (!do_escape)
> +			goto escape_done;
>   
>   		spin_unlock(&jh_in->b_state_lock);
>   		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
> @@ -404,17 +410,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>   copy_done:
>   		new_folio = virt_to_folio(jh_in->b_frozen_data);
>   		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		jbd2_data_do_escape(jh_in->b_frozen_data);
>   	}
>   
> -	/*
> -	 * Did we need to do an escaping?  Now we've done all the
> -	 * copying, we can finally do so.
> -	 * b_frozen_data is from jbd2_alloc() which always provides an
> -	 * address from the direct kernels mapping.
> -	 */
> -	if (do_escape)
> -		*((unsigned int *)jh_in->b_frozen_data) = 0;
> -
> +escape_done:
>   	folio_set_bh(new_bh, new_folio, new_offset);
>   	new_bh->b_size = bh_in->b_size;
>   	new_bh->b_bdev = journal->j_dev;
-- 
Regards



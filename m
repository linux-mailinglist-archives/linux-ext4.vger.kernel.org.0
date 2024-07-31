Return-Path: <linux-ext4+bounces-3573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BED942DC3
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 14:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388212869FD
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D71AE84D;
	Wed, 31 Jul 2024 12:07:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1471AD9F3;
	Wed, 31 Jul 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427658; cv=none; b=oGufXHn6It9awJUXZ92a7hL9HsDdT2beXy2UsDUFdAonHNG9WAtdVn50srrjCd39Ycfoec+w6pRaL9jIRsh9XbEoR+/ztIaE0Hmn9Gc7rOz87gpioXK5mo4sSfl0y29Qw3jTAc+uqFVULi9wn7vAcLOe4v1RxyNN6agbyX418Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427658; c=relaxed/simple;
	bh=qCl+X1kNEHc5kmRVhEEUvfQGAgRO2R8PBtzr9oKbYo4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BfKOhmF7lmdBeJaIbYkKXOcXmaRMQyillrVsTQBAwYYHOVVzcuTJQ0eTSHXRl/Q5azMXIaWh2NHS80wDpYMebqFYmOJEL2/bDoB249KOSun2EHNUh3pAhiIFTUcJLhOgvgJ4s7F1FyP7PnO4S5xAEfAdWdQB7r9OBmQS3H0g/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYrSP2TPVz4f3lVh;
	Wed, 31 Jul 2024 20:07:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C0B51A08DC;
	Wed, 31 Jul 2024 20:07:31 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4UBKapmw_F+AQ--.55380S3;
	Wed, 31 Jul 2024 20:07:31 +0800 (CST)
Subject: Re: [PATCH v3 6/8] ext4: move escape handle to futher improve
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-7-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <6054a2db-fea6-f43d-e9ba-bd3c0449717f@huaweicloud.com>
Date: Wed, 31 Jul 2024 20:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240731092910.2383048-7-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4UBKapmw_F+AQ--.55380S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UGF1UuFW3Aw4xKFW8tFb_yoW5tr15pr
	93Kr1ftFyvqrn2yrn7Ww4DZryFgrWkWry7K3W7Gas3tFW3uwnFgF4jv34rG34jyrWkKa18
	XFyjqFW8uwnxK3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBmhwUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/7/31 17:29, Kemeng Shi wrote:
> Move escape handle to futher improve code readability and remove some
> repeat check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

It's do deserve a cleanup, looks cleaner now.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 49 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index f17d05bc61df..85273fb1accb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -281,6 +281,16 @@ static void journal_kill_thread(journal_t *journal)
>  	write_unlock(&journal->j_state_lock);
>  }
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
>  /*
>   * jbd2_journal_write_metadata_buffer: write a metadata buffer to the journal.
>   *
> @@ -319,7 +329,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  				  sector_t blocknr)
>  {
>  	int do_escape = 0;
> -	char *mapped_data;
>  	struct buffer_head *new_bh;
>  	struct folio *new_folio;
>  	unsigned int new_offset;
> @@ -350,8 +359,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	if (jh_in->b_frozen_data) {
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> -		mapped_data = jh_in->b_frozen_data;
> +		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
> +		if (do_escape)
> +			jbd2_data_do_escape(jh_in->b_frozen_data);
>  	} else {
> +		char *tmp;
> +		char *mapped_data;
> +
>  		new_folio = bh_in->b_folio;
>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>  		mapped_data = kmap_local_folio(new_folio, new_offset);
> @@ -363,21 +377,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		 */
>  		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>  					   jh_in->b_triggers);
> -	}
> -
> -	/*
> -	 * Check for escaping
> -	 */
> -	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
> -		do_escape = 1;
> -	if (!jh_in->b_frozen_data)
> +		do_escape = jbd2_data_needs_escaping(mapped_data);
>  		kunmap_local(mapped_data);
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
>  		spin_unlock(&jh_in->b_state_lock);
>  		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
> @@ -404,17 +410,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  copy_done:
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		jbd2_data_do_escape(jh_in->b_frozen_data);
>  	}
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
>  	folio_set_bh(new_bh, new_folio, new_offset);
>  	new_bh->b_size = bh_in->b_size;
>  	new_bh->b_bdev = journal->j_dev;
> 



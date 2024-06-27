Return-Path: <linux-ext4+bounces-2990-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A04691A000
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 09:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D1D1F2A0F8
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D3047A6A;
	Thu, 27 Jun 2024 07:07:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEA4CE05;
	Thu, 27 Jun 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472024; cv=none; b=AcC+K8Qdpn5PI91Il28iamy/TJ3dOcuGQehsLgQaeLFEob/Wigmn6MXRfJ5ziR6Epiiy/nv3bOp3cpEjNUb4wj4lFxQW/bImsMqMskWPKBK9z6+hZYUixWPnXVWwOP1zblndf+6ej9XD5JYLKyoxbu+SRz0EveiGTa2GT2FRYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472024; c=relaxed/simple;
	bh=GHSvMALue0NCQy32KokzZg385UVQn0uoTu3jkqhiIIM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L+MuopvYI776E8QqNACRSHNxRgPtroObBz5eT2PeB5tgJXKtaOAXSBb1MbnvMVGyCo4IhZ6VZ5697lBvBP8Z0XSAW2Xy2jnFE9rBHnymB3D8RS8Br+yB3xRo+o2zgLACzcIqueotFfZDeTRjMfuSfRnpXHcrSLKPCdBn/S+c140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W8qPJ2k8Yz4f3ktx;
	Thu, 27 Jun 2024 15:06:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8EABE1A0572;
	Thu, 27 Jun 2024 15:06:56 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgB34YaOD31m1djiAQ--.15220S3;
	Thu, 27 Jun 2024 15:06:56 +0800 (CST)
Subject: Re: [PATCH v2 2/4] jbd2: Precompute number of transaction descriptor
 blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Alexander Coffin
 <alex.coffin@maticrobots.com>, stable@vger.kernel.org,
 Ted Tso <tytso@mit.edu>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-2-jack@suse.cz>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <7c42a1a8-edde-d89c-e5f2-0857e4005016@huaweicloud.com>
Date: Thu, 27 Jun 2024 15:06:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624170127.3253-2-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB34YaOD31m1djiAQ--.15220S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw48CrW7KF48Xw13Zw17GFg_yoW3WF4fp3
	yUC343CrWjvrWUZwn7Xr48JrWFqFy0yFyUWr1q93Z3Ka15Kwn2v34ktr17KFyqyryagw18
	XF1UC34DGw4jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/6/25 1:01, Jan Kara wrote:
> Instead of computing the number of descriptor blocks a transaction can
> have each time we need it (which is currently when starting each
> transaction but will become more frequent later) precompute the number
> once during journal initialization together with maximum transaction
> size. We perform the precomputation whenever journal feature set is
> updated similarly as for computation of
> journal->j_revoke_records_per_block.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c     | 61 ++++++++++++++++++++++++++++++++-----------
>  fs/jbd2/transaction.c | 24 +----------------
>  include/linux/jbd2.h  |  7 +++++
>  3 files changed, 54 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1bb73750d307..ae5b544ed0cc 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1451,6 +1451,48 @@ static int journal_revoke_records_per_block(journal_t *journal)
>  	return space / record_size;
>  }
>  
> +static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
> +{
> +	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
> +}
> +
> +/*
> + * Base amount of descriptor blocks we reserve for each transaction.
> + */
> +static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
> +{
> +	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
> +	int tags_per_block;
> +
> +	/* Subtract UUID */
> +	tag_space -= 16;
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		tag_space -= sizeof(struct jbd2_journal_block_tail);
> +	/* Commit code leaves a slack space of 16 bytes at the end of block */
> +	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
> +	/*
> +	 * Revoke descriptors are accounted separately so we need to reserve
> +	 * space for commit block and normal transaction descriptor blocks.
> +	 */
> +	return 1 + DIV_ROUND_UP(jbd2_journal_get_max_txn_bufs(journal),
> +				tags_per_block);
> +}
> +
> +/*
> + * Initialize number of blocks each transaction reserves for its bookkeeping
> + * and maximum number of blocks a transaction can use. This needs to be called
> + * after the journal size and the fastcommit area size are initialized.
> + */
> +static void jbd2_journal_init_transaction_limits(journal_t *journal)
> +{
> +	journal->j_revoke_records_per_block =
> +				journal_revoke_records_per_block(journal);
> +	journal->j_transaction_overhead_buffers =
> +				jbd2_descriptor_blocks_per_trans(journal);
> +	journal->j_max_transaction_buffers =
> +				jbd2_journal_get_max_txn_bufs(journal);
> +}
> +
>  /*
>   * Load the on-disk journal superblock and read the key fields into the
>   * journal_t.
> @@ -1492,8 +1534,8 @@ static int journal_load_superblock(journal_t *journal)
>  	if (jbd2_journal_has_csum_v2or3(journal))
>  		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
>  						   sizeof(sb->s_uuid));
> -	journal->j_revoke_records_per_block =
> -				journal_revoke_records_per_block(journal);
> +	/* After journal features are set, we can compute transaction limits */
> +	jbd2_journal_init_transaction_limits(journal);
>  
>  	if (jbd2_has_feature_fast_commit(journal)) {
>  		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> @@ -1698,11 +1740,6 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  	return journal;
>  }
>  
> -static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
> -{
> -	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
> -}
> -
>  /*
>   * Given a journal_t structure, initialise the various fields for
>   * startup of a new journaling session.  We use this both when creating
> @@ -1748,8 +1785,6 @@ static int journal_reset(journal_t *journal)
>  	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
>  	journal->j_commit_request = journal->j_commit_sequence;
>  
> -	journal->j_max_transaction_buffers = jbd2_journal_get_max_txn_bufs(journal);
> -
>  	/*
>  	 * Now that journal recovery is done, turn fast commits off here. This
>  	 * way, if fast commit was enabled before the crash but if now FS has
> @@ -2290,8 +2325,6 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
>  	journal->j_fc_first = journal->j_last + 1;
>  	journal->j_fc_off = 0;
>  	journal->j_free = journal->j_last - journal->j_first;
> -	journal->j_max_transaction_buffers =
> -		jbd2_journal_get_max_txn_bufs(journal);
>  
>  	return 0;
>  }
> @@ -2379,8 +2412,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
>  	unlock_buffer(journal->j_sb_buffer);
> -	journal->j_revoke_records_per_block =
> -				journal_revoke_records_per_block(journal);
> +	jbd2_journal_init_transaction_limits(journal);
>  
>  	return 1;
>  #undef COMPAT_FEATURE_ON
> @@ -2411,8 +2443,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
> -	journal->j_revoke_records_per_block =
> -				journal_revoke_records_per_block(journal);
> +	jbd2_journal_init_transaction_limits(journal);
>  }
>  EXPORT_SYMBOL(jbd2_journal_clear_features);
>  
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index cb0b8d6fc0c6..a095f1a3114b 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -62,28 +62,6 @@ void jbd2_journal_free_transaction(transaction_t *transaction)
>  	kmem_cache_free(transaction_cache, transaction);
>  }
>  
> -/*
> - * Base amount of descriptor blocks we reserve for each transaction.
> - */
> -static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
> -{
> -	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
> -	int tags_per_block;
> -
> -	/* Subtract UUID */
> -	tag_space -= 16;
> -	if (jbd2_journal_has_csum_v2or3(journal))
> -		tag_space -= sizeof(struct jbd2_journal_block_tail);
> -	/* Commit code leaves a slack space of 16 bytes at the end of block */
> -	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
> -	/*
> -	 * Revoke descriptors are accounted separately so we need to reserve
> -	 * space for commit block and normal transaction descriptor blocks.
> -	 */
> -	return 1 + DIV_ROUND_UP(journal->j_max_transaction_buffers,
> -				tags_per_block);
> -}
> -
>  /*
>   * jbd2_get_transaction: obtain a new transaction_t object.
>   *
> @@ -109,7 +87,7 @@ static void jbd2_get_transaction(journal_t *journal,
>  	transaction->t_expires = jiffies + journal->j_commit_interval;
>  	atomic_set(&transaction->t_updates, 0);
>  	atomic_set(&transaction->t_outstanding_credits,
> -		   jbd2_descriptor_blocks_per_trans(journal) +
> +		   journal->j_transaction_overhead_buffers +
>  		   atomic_read(&journal->j_reserved_credits));
>  	atomic_set(&transaction->t_outstanding_revokes, 0);
>  	atomic_set(&transaction->t_handle_count, 0);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f91b930abe20..b900c642210c 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1085,6 +1085,13 @@ struct journal_s
>  	 */
>  	int			j_revoke_records_per_block;
>  
> +	/**
> +	 * @j_transaction_overhead:
> +	 *
> +	 * Number of blocks each transaction needs for its own bookkeeping
> +	 */
> +	int			j_transaction_overhead_buffers;
> +
>  	/**
>  	 * @j_commit_interval:
>  	 *
> 



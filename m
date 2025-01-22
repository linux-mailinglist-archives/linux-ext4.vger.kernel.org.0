Return-Path: <linux-ext4+bounces-6190-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3FA189B0
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816151883F85
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6131E502;
	Wed, 22 Jan 2025 01:48:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47971196
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737510484; cv=none; b=LE5LIz3iMVQfgBAHiWvgsXYlXBG0CUC6VsoYhRWnbyILNKhLWmWxq/j/kBnhy8zowDEvMfbas9s0ZBqvQBaVCyVlLassyoJzlzcK+IKBvcXVX/0TSdEIl9YZZ9xGQMDLCDmwZ+DFiPuINhb4NNj7A2781i1Utjxu+NVM+naHwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737510484; c=relaxed/simple;
	bh=qy9mGlHGMvcrWl1fgldsGcmeUgBlXA51XFKMbixYXQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dFbnzaQu3jcCgTk2AtViOycA4pZT9rt2F/HJLsC9ohBP7xvNJ2bGkp/CtL7/bJDMe5CQehGDzGlAad/tV/IFEH4EEXnSkWMhfUmfGZp0mopQsdIsIVLa1rBCkvnt56eBy97TX7CgmrDyvTMSVfqc2SWeRP/n4Ep9Zvf4oCPsWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yd6N96sfCzRlmg;
	Wed, 22 Jan 2025 09:45:29 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id E3027140159;
	Wed, 22 Jan 2025 09:47:59 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jan 2025 09:47:59 +0800
Message-ID: <70363ae9-7432-4a43-b7da-e52720dad4cc@huawei.com>
Date: Wed, 22 Jan 2025 09:47:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] jbd2: Avoid long replay times due to high number or
 revoke blocks
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, Alexey Zhuravlev <azhuravlev@ddn.com>,
	Andreas Dilger <adilger@dilger.ca>
References: <20250121140925.17231-2-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250121140925.17231-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/1/21 22:09, Jan Kara wrote:
> Some users are reporting journal replay takes a long time when there is
> excessive number of revoke blocks in the journal. Reported times are
> like:
> 
> 1048576 records - 95 seconds
> 2097152 records - 580 seconds
> 
> The problem is that hash chains in the revoke table gets excessively
> long in these cases. Fix the problem by sizing the revoke table
> appropriately before the revoke pass.
> 
> Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the
> patch with large numbers of revoke blocks [1].
> 
> [1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks for the update, this looks good to me. Feel free to add:

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c   | 58 ++++++++++++++++++++++++++++++++++++--------
>  fs/jbd2/revoke.c     |  8 +++---
>  include/linux/jbd2.h |  2 ++
>  3 files changed, 54 insertions(+), 14 deletions(-)
> 
> Changes since v1:
> * rebased on 6.13
> * move check in do_one_pass()
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 9192be7c19d8..7c23a8be673f 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -39,7 +39,7 @@ struct recovery_info
>  
>  static int do_one_pass(journal_t *journal,
>  				struct recovery_info *info, enum passtype pass);
> -static int scan_revoke_records(journal_t *, struct buffer_head *,
> +static int scan_revoke_records(journal_t *, enum passtype, struct buffer_head *,
>  				tid_t, struct recovery_info *);
>  
>  #ifdef __KERNEL__
> @@ -327,6 +327,12 @@ int jbd2_journal_recover(journal_t *journal)
>  		  journal->j_transaction_sequence, journal->j_head);
>  
>  	jbd2_journal_clear_revoke(journal);
> +	/* Free revoke table allocated for replay */
> +	if (journal->j_revoke != journal->j_revoke_table[0] &&
> +	    journal->j_revoke != journal->j_revoke_table[1]) {
> +		jbd2_journal_destroy_revoke_table(journal->j_revoke);
> +		journal->j_revoke = journal->j_revoke_table[1];
> +	}
>  	err2 = sync_blockdev(journal->j_fs_dev);
>  	if (!err)
>  		err = err2;
> @@ -612,6 +618,31 @@ static int do_one_pass(journal_t *journal,
>  	first_commit_ID = next_commit_ID;
>  	if (pass == PASS_SCAN)
>  		info->start_transaction = first_commit_ID;
> +	else if (pass == PASS_REVOKE) {
> +		/*
> +		 * Would the default revoke table have too long hash chains
> +		 * during replay?
> +		 */
> +		if (info->nr_revokes > JOURNAL_REVOKE_DEFAULT_HASH * 16) {
> +			unsigned int hash_size;
> +
> +			/*
> +			 * Aim for average chain length of 8, limit at 1M
> +			 * entries to avoid problems with malicious
> +			 * filesystems.
> +			 */
> +			hash_size = min(roundup_pow_of_two(info->nr_revokes / 8),
> +					1U << 20);
> +			journal->j_revoke =
> +				jbd2_journal_init_revoke_table(hash_size);
> +			if (!journal->j_revoke) {
> +				printk(KERN_ERR
> +				       "JBD2: failed to allocate revoke table for replay with %u entries. "
> +				       "Journal replay may be slow.\n", hash_size);
> +				journal->j_revoke = journal->j_revoke_table[1];
> +			}
> +		}
> +	}
>  
>  	jbd2_debug(1, "Starting recovery pass %d\n", pass);
>  
> @@ -851,6 +882,13 @@ static int do_one_pass(journal_t *journal,
>  			continue;
>  
>  		case JBD2_REVOKE_BLOCK:
> +			/*
> +			 * If we aren't in the SCAN or REVOKE pass, then we can
> +			 * just skip over this block.
> +			 */
> +			if (pass != PASS_REVOKE && pass != PASS_SCAN)
> +				continue;
> +
>  			/*
>  			 * Check revoke block crc in pass_scan, if csum verify
>  			 * failed, check commit block time later.
> @@ -863,12 +901,7 @@ static int do_one_pass(journal_t *journal,
>  				need_check_commit_time = true;
>  			}
>  
> -			/* If we aren't in the REVOKE pass, then we can
> -			 * just skip over this block. */
> -			if (pass != PASS_REVOKE)
> -				continue;
> -
> -			err = scan_revoke_records(journal, bh,
> +			err = scan_revoke_records(journal, pass, bh,
>  						  next_commit_ID, info);
>  			if (err)
>  				goto failed;
> @@ -922,8 +955,9 @@ static int do_one_pass(journal_t *journal,
>  
>  /* Scan a revoke record, marking all blocks mentioned as revoked. */
>  
> -static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
> -			       tid_t sequence, struct recovery_info *info)
> +static int scan_revoke_records(journal_t *journal, enum passtype pass,
> +			       struct buffer_head *bh, tid_t sequence,
> +			       struct recovery_info *info)
>  {
>  	jbd2_journal_revoke_header_t *header;
>  	int offset, max;
> @@ -944,6 +978,11 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
>  	if (jbd2_has_feature_64bit(journal))
>  		record_len = 8;
>  
> +	if (pass == PASS_SCAN) {
> +		info->nr_revokes += (max - offset) / record_len;
> +		return 0;
> +	}
> +
>  	while (offset + record_len <= max) {
>  		unsigned long long blocknr;
>  		int err;
> @@ -956,7 +995,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
>  		err = jbd2_journal_set_revoke(journal, blocknr, sequence);
>  		if (err)
>  			return err;
> -		++info->nr_revokes;
>  	}
>  	return 0;
>  }
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..f4ac308e84c5 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -215,7 +215,7 @@ int __init jbd2_journal_init_revoke_table_cache(void)
>  	return 0;
>  }
>  
> -static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
> +struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
>  {
>  	int shift = 0;
>  	int tmp = hash_size;
> @@ -231,7 +231,7 @@ static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
>  	table->hash_size = hash_size;
>  	table->hash_shift = shift;
>  	table->hash_table =
> -		kmalloc_array(hash_size, sizeof(struct list_head), GFP_KERNEL);
> +		kvmalloc_array(hash_size, sizeof(struct list_head), GFP_KERNEL);
>  	if (!table->hash_table) {
>  		kmem_cache_free(jbd2_revoke_table_cache, table);
>  		table = NULL;
> @@ -245,7 +245,7 @@ static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
>  	return table;
>  }
>  
> -static void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
> +void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
>  {
>  	int i;
>  	struct list_head *hash_list;
> @@ -255,7 +255,7 @@ static void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
>  		J_ASSERT(list_empty(hash_list));
>  	}
>  
> -	kfree(table->hash_table);
> +	kvfree(table->hash_table);
>  	kmem_cache_free(jbd2_revoke_table_cache, table);
>  }
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 50f7ea8714bf..610841635204 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1634,6 +1634,8 @@ extern void	   jbd2_journal_destroy_revoke_record_cache(void);
>  extern void	   jbd2_journal_destroy_revoke_table_cache(void);
>  extern int __init jbd2_journal_init_revoke_record_cache(void);
>  extern int __init jbd2_journal_init_revoke_table_cache(void);
> +struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size);
> +void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table);
>  
>  extern void	   jbd2_journal_destroy_revoke(journal_t *);
>  extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);



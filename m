Return-Path: <linux-ext4+bounces-6141-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C226CA14860
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 03:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C126516976A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 02:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB231F560D;
	Fri, 17 Jan 2025 02:58:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A371747
	for <linux-ext4@vger.kernel.org>; Fri, 17 Jan 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737082730; cv=none; b=CvkEltl8uQT+lxrMFnz5TMGwP0KrbkqSNmV7ZNIrWfYaaFD0UFWE0lZoXbKd5pq9Rd6yqc4Nb8ehTHndJ1r7yW5FIRL6w7ILU9dz/pHdBJVUezeB3dX8j6Fv8y42mrkXyJ7AD1ox5dn8mhVo3Ny4bqXpgHQn5hIFmV3Is4nYoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737082730; c=relaxed/simple;
	bh=yCEzfuZc1smypvtchMaDztCHdUlo+kkbhlqu6ZEROAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F7hekFGF2EJl42Uc4r7SeprwTAfFBRMYPUTTpboXKx5RKbkU7+eIyjOu45Z6M4XBH+vtTblcY3Iy4N4uXgGfNBt40dfMRThbhER37EnuyP1lEEtgHZmrdufUnDx08UYnWoY2kQ47TgCUPiV/zffrg9BP+8VfJEGfjZio8Xj4HGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YZ4BC2B2Tz22lPr;
	Fri, 17 Jan 2025 10:56:19 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id B1F3D1A0188;
	Fri, 17 Jan 2025 10:58:43 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 10:58:43 +0800
Message-ID: <6c9ce6fe-9d6f-49cf-b274-3355bb1ea8af@huawei.com>
Date: Fri, 17 Jan 2025 10:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Avoid long replay times due to high number or
 revoke blocks
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Andreas Dilger <adilger@dilger.ca>, Alexey
 Zhuravlev <azhuravlev@ddn.com>, Ted Tso <tytso@mit.edu>
References: <20250116180223.18564-2-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250116180223.18564-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/1/17 2:02, Jan Kara wrote:
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
> Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the patch with
> large numbers of revoke blocks [1].
> 
> [1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Hi, Jan,

This overall patch looks good to me; however, it appears to be not
based on the latested version of the upstream kernel, and I have one
minor suggestion below.

> ---
>  fs/jbd2/recovery.c   | 54 +++++++++++++++++++++++++++++++++++++-------
>  fs/jbd2/revoke.c     |  8 +++----
>  include/linux/jbd2.h |  2 ++
>  3 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 667f67342c52..9845f72e456a 100644
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
> @@ -517,6 +523,31 @@ static int do_one_pass(journal_t *journal,
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
> @@ -874,14 +905,16 @@ static int do_one_pass(journal_t *journal,
>  				need_check_commit_time = true;
>  			}
>  
> -			/* If we aren't in the REVOKE pass, then we can
> -			 * just skip over this block. */
> -			if (pass != PASS_REVOKE) {
> +			/*
> +			 * If we aren't in the SCAN or REVOKE pass, then we can
> +			 * just skip over this block.
> +			 */
> +			if (pass != PASS_REVOKE && pass != PASS_SCAN) {
>  				brelse(bh);
>  				continue;
>  			}

How about move this code snippets to the beginning of the
JBD2_REVOKE_BLOCK branch case?

Thanks,
Yi.


>  
>  extern void	   jbd2_journal_destroy_revoke(journal_t *);
>  extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);



Return-Path: <linux-ext4+bounces-7762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C4AAF13C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 04:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7941B60094
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 02:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E31D416E;
	Thu,  8 May 2025 02:48:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46EA1BDCF
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672532; cv=none; b=Q3AGl3yXV4qxr6eWbBTrEH4EU83GuE59U1s62wSSYpH6CH/b+AUMYZNXuWalO2vsMSCEQFnvpLXUbgmj4GL8nn+kaN1RGAqPwyrYXrntO5A3bNy4ObvsxI1yfw1+xX2nVVQ0oMtq4Eya8C9lrv3CdE5NnZW3JWqLdOvScUqBLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672532; c=relaxed/simple;
	bh=/q9HaymT9dPE+6LCpn3459WjXZPx4h1B24jC9Ls9/vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7fgCbfszoJCZdCfSvhcsQkVkt7vWrOS5amTrGmTBjI41rmzTuB1LG02bWEvok/sIuykpMAFZgxvycvsvK498UCP/aW+N7t8VZMziiDxFZYM95BTZHWSQM3WfekfL/NC24QeW9nQaH8IdpF/IL74f/aO2vAI3279RIDvpV9/RVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZtGll5mLLz4f3kvq
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 10:48:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CF3331A0359
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 10:48:45 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB32l6MGxxowGUNLw--.55231S3;
	Thu, 08 May 2025 10:48:45 +0800 (CST)
Message-ID: <f35c4ecd-48ca-4f41-8457-4b5bfc1e83b8@huaweicloud.com>
Date: Thu, 8 May 2025 10:48:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: use writeback_iter in
 ext4_journalled_submit_inode_data_buffers
To: Christoph Hellwig <hch@lst.de>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, tytso@mit.edu
References: <20250505091604.3449879-1-hch@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250505091604.3449879-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB32l6MGxxowGUNLw--.55231S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43CFW5JF48CFW8Kr48Zwb_yoW5ArW7pF
	W3C3ZrAr4jvFy7urn7Wa1qvF4Yga4SyFW2yFy7Kan3X3Z8G3sFkFyktw1F9FWUtrW8Ww4r
	XF4jkr17WwnFq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/5 17:16, Christoph Hellwig wrote:
> Use writeback_iter directly instead of write_cache_pages for a nicer
> code structure and less indirect calls.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It looks clearer now.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/super.c | 46 ++++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 181934499624..6a0a3493ee43 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -508,21 +508,9 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
>  	ext4_maybe_update_superblock(sb);
>  }
>  
> -/*
> - * This writepage callback for write_cache_pages()
> - * takes care of a few cases after page cleaning.
> - *
> - * write_cache_pages() already checks for dirty pages
> - * and calls clear_page_dirty_for_io(), which we want,
> - * to write protect the pages.
> - *
> - * However, we may have to redirty a page (see below.)
> - */
> -static int ext4_journalled_writepage_callback(struct folio *folio,
> -					      struct writeback_control *wbc,
> -					      void *data)
> +static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
> +		struct folio *folio)
>  {
> -	transaction_t *transaction = (transaction_t *) data;
>  	struct buffer_head *bh, *head;
>  	struct journal_head *jh;
>  
> @@ -543,15 +531,12 @@ static int ext4_journalled_writepage_callback(struct folio *folio,
>  		 */
>  		jh = bh2jh(bh);
>  		if (buffer_dirty(bh) ||
> -		    (jh && (jh->b_transaction != transaction ||
> -			    jh->b_next_transaction))) {
> -			folio_redirty_for_writepage(wbc, folio);
> -			goto out;
> -		}
> +		    (jh && (jh->b_transaction != jinode->i_transaction ||
> +			    jh->b_next_transaction)))
> +			return true;
>  	} while ((bh = bh->b_this_page) != head);
>  
> -out:
> -	return AOP_WRITEPAGE_ACTIVATE;
> +	return false;
>  }
>  
>  static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
> @@ -563,10 +548,23 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  		.range_start = jinode->i_dirty_start,
>  		.range_end = jinode->i_dirty_end,
>          };
> +	struct folio *folio = NULL;
> +	int error;
>  
> -	return write_cache_pages(mapping, &wbc,
> -				 ext4_journalled_writepage_callback,
> -				 jinode->i_transaction);
> +	/*
> +	 * writeback_iter() already checks for dirty pages and calls
> +	 * folio_clear_dirty_for_io(), which we want to write protect the
> +	 * folios.
> +	 *
> +	 * However, we may have to redirty a folio sometimes.
> +	 */
> +	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
> +		if (ext4_journalled_writepage_needs_redirty(jinode, folio))
> +			folio_redirty_for_writepage(&wbc, folio);
> +		folio_unlock(folio);
> +	}
> +
> +	return error;
>  }
>  
>  static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)



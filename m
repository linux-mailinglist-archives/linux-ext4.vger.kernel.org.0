Return-Path: <linux-ext4+bounces-5725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471439F5D85
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 04:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC98118906A8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 03:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EA5146A6F;
	Wed, 18 Dec 2024 03:41:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FFA126F1E;
	Wed, 18 Dec 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493273; cv=none; b=lfXvBW3E0wY4xcbkVhQFWDVHmMbIrv+gftryYcqmiU/SPkmGw+WJjC6NwiKlZ90R7/dASRrECwdEabK8RmHJ+gYKsiG1bQQHRdWrRXXx8h2QIL30IJWjYZYwPC7uyazLIdf4+JByhG8JMZKE7YKowsgZKUXlCAcyKoWMQd668z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493273; c=relaxed/simple;
	bh=WdR45KsXzNl6YY3rKlJ39dAozDytbMvjTFxO+gbrcbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qz+lqfKuwrGTWGC/tcGG5+clt3LefWHlz86dEs7sc2XckoPUjCplctLITyzY6+1OHmXlLP4g7E3tTzzr8V64lObdNZYVf/Nnw2xRP5qBy1gan2FQn0Hd+BmxUjlHIm7Zb0H87O4DT3XOQCIS6l2jNteI2QZF7GUIzt/kW8iiPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCfbS167Wz4f3jqq;
	Wed, 18 Dec 2024 11:40:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 954161A018D;
	Wed, 18 Dec 2024 11:41:06 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dGRGJn19yrEw--.32009S3;
	Wed, 18 Dec 2024 11:41:06 +0800 (CST)
Message-ID: <24ea83c0-597c-4b45-9372-105f07c476a2@huaweicloud.com>
Date: Wed, 18 Dec 2024 11:40:54 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ext4: remove unused ext4 journal callback
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.com
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-2-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241217120356.1399443-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXc4dGRGJn19yrEw--.32009S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWUuFyUXF43ZF4DGF1ftFb_yoW7GF4Upr
	yfuw17Cry8Zr1UuF4xWr48GFW29w4FkFy5GryxCF9Yk3yj9wn7tFykt3W0yayDJFWru3Z8
	X3Wj9rnrGw4vk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUTnQUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/17 20:03, Kemeng Shi wrote:
> Remove unused ext4 journal callback.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4_jbd2.h | 84 ---------------------------------------------
>  fs/ext4/super.c     | 14 --------
>  2 files changed, 98 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 0c77697d5e90..3f2596c9e5f2 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -122,90 +122,6 @@
>  #define EXT4_HT_EXT_CONVERT     11
>  #define EXT4_HT_MAX             12
>  
> -/**
> - *   struct ext4_journal_cb_entry - Base structure for callback information.
> - *
> - *   This struct is a 'seed' structure for a using with your own callback
> - *   structs. If you are using callbacks you must allocate one of these
> - *   or another struct of your own definition which has this struct
> - *   as it's first element and pass it to ext4_journal_callback_add().
> - */
> -struct ext4_journal_cb_entry {
> -	/* list information for other callbacks attached to the same handle */
> -	struct list_head jce_list;
> -
> -	/*  Function to call with this callback structure */
> -	void (*jce_func)(struct super_block *sb,
> -			 struct ext4_journal_cb_entry *jce, int error);
> -
> -	/* user data goes here */
> -};
> -
> -/**
> - * ext4_journal_callback_add: add a function to call after transaction commit
> - * @handle: active journal transaction handle to register callback on
> - * @func: callback function to call after the transaction has committed:
> - *        @sb: superblock of current filesystem for transaction
> - *        @jce: returned journal callback data
> - *        @rc: journal state at commit (0 = transaction committed properly)
> - * @jce: journal callback data (internal and function private data struct)
> - *
> - * The registered function will be called in the context of the journal thread
> - * after the transaction for which the handle was created has completed.
> - *
> - * No locks are held when the callback function is called, so it is safe to
> - * call blocking functions from within the callback, but the callback should
> - * not block or run for too long, or the filesystem will be blocked waiting for
> - * the next transaction to commit. No journaling functions can be used, or
> - * there is a risk of deadlock.
> - *
> - * There is no guaranteed calling order of multiple registered callbacks on
> - * the same transaction.
> - */
> -static inline void _ext4_journal_callback_add(handle_t *handle,
> -			struct ext4_journal_cb_entry *jce)
> -{
> -	/* Add the jce to transaction's private list */
> -	list_add_tail(&jce->jce_list, &handle->h_transaction->t_private_list);
> -}
> -
> -static inline void ext4_journal_callback_add(handle_t *handle,
> -			void (*func)(struct super_block *sb,
> -				     struct ext4_journal_cb_entry *jce,
> -				     int rc),
> -			struct ext4_journal_cb_entry *jce)
> -{
> -	struct ext4_sb_info *sbi =
> -			EXT4_SB(handle->h_transaction->t_journal->j_private);
> -
> -	/* Add the jce to transaction's private list */
> -	jce->jce_func = func;
> -	spin_lock(&sbi->s_md_lock);
> -	_ext4_journal_callback_add(handle, jce);
> -	spin_unlock(&sbi->s_md_lock);
> -}
> -
> -
> -/**
> - * ext4_journal_callback_del: delete a registered callback
> - * @handle: active journal transaction handle on which callback was registered
> - * @jce: registered journal callback entry to unregister
> - * Return true if object was successfully removed
> - */
> -static inline bool ext4_journal_callback_try_del(handle_t *handle,
> -					     struct ext4_journal_cb_entry *jce)
> -{
> -	bool deleted;
> -	struct ext4_sb_info *sbi =
> -			EXT4_SB(handle->h_transaction->t_journal->j_private);
> -
> -	spin_lock(&sbi->s_md_lock);
> -	deleted = !list_empty(&jce->jce_list);
> -	list_del_init(&jce->jce_list);
> -	spin_unlock(&sbi->s_md_lock);
> -	return deleted;
> -}
> -
>  int
>  ext4_mark_iloc_dirty(handle_t *handle,
>  		     struct inode *inode,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a09f4621b10d..8dfda41dabaa 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -502,25 +502,11 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>  static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
>  {
>  	struct super_block		*sb = journal->j_private;
> -	struct ext4_sb_info		*sbi = EXT4_SB(sb);
> -	int				error = is_journal_aborted(journal);
> -	struct ext4_journal_cb_entry	*jce;
>  
>  	BUG_ON(txn->t_state == T_FINISHED);
>  
>  	ext4_process_freed_data(sb, txn->t_tid);
>  	ext4_maybe_update_superblock(sb);
> -
> -	spin_lock(&sbi->s_md_lock);
> -	while (!list_empty(&txn->t_private_list)) {
> -		jce = list_entry(txn->t_private_list.next,
> -				 struct ext4_journal_cb_entry, jce_list);
> -		list_del_init(&jce->jce_list);
> -		spin_unlock(&sbi->s_md_lock);
> -		jce->jce_func(sb, jce, error);
> -		spin_lock(&sbi->s_md_lock);
> -	}
> -	spin_unlock(&sbi->s_md_lock);
>  }
>  
>  /*



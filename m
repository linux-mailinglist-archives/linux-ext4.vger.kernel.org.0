Return-Path: <linux-ext4+bounces-3570-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252A942D9E
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 13:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B8B28292B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB81AE870;
	Wed, 31 Jul 2024 11:57:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF621AE846;
	Wed, 31 Jul 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427045; cv=none; b=K0DfKI4sc4d9ncVbU+LYgYlmVYxoxOR8jyKjIhGHPVJE5DvleX71fGPPZGcg6gavT913Oz88r5B4qPm6gnsjkyigIsOBzLePWNn90eI0Wy0bEIXITTJ4yG8FY8U5VjWSsVEmgDDkz+fvjLl3Bt0nhg+2mJvWTxil9YJDM6Bvzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427045; c=relaxed/simple;
	bh=bPG5ie4o6eFHk5P0SKST3hcdakVW4lNHJZL4wIMuuMY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MA5DPOZt3S+DunrOw7tuTiqSu8U1GFcPWaAzhws7g+IMK876RmSkWTmg8f40MlouMgA4tecZwbZF1ynHJEVTExIyLshZenpl60N1iO5g1pJFIRQZxLuQ5PInzoMfzodd2kYo0XGADBO/3/+gd0hZEXSTGsJGbxya6Uni8snZwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYrDj6TlGz4f3k6d;
	Wed, 31 Jul 2024 19:57:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 913271A018D;
	Wed, 31 Jul 2024 19:57:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WdJqpmGUR+AQ--.55088S3;
	Wed, 31 Jul 2024 19:57:18 +0800 (CST)
Subject: Re: [PATCH v3 5/8] jbd2: remove unneeded done_copy_out variable in
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-6-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <01115725-c0ca-6bca-c6e2-5f75e1a5c13a@huaweicloud.com>
Date: Wed, 31 Jul 2024 19:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240731092910.2383048-6-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4WdJqpmGUR+AQ--.55088S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1kWF4rWr4DAr1UurykZrb_yoW5Xr48pF
	9akr9rtryvqry2yr1kWw4UZrW0grWDWrW2krsrCa43Aayag3sF9F1qyr1rK3WjyrZ7Ja18
	XryUuFZ7WwnIyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjuHq7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/7/31 17:29, Kemeng Shi wrote:
> It's more intuitive to use jh_in->b_frozen_data directly instead of
> done_copy_out variable. Simply remove unneeded done_copy_out variable
> and use b_frozen_data instead.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 9c1ffb0dc740..f17d05bc61df 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -318,7 +318,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  				  struct buffer_head **bh_out,
>  				  sector_t blocknr)
>  {
> -	int done_copy_out = 0;
>  	int do_escape = 0;
>  	char *mapped_data;
>  	struct buffer_head *new_bh;
> @@ -349,7 +348,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 * we use that version of the data for the commit.
>  	 */
>  	if (jh_in->b_frozen_data) {
> -		done_copy_out = 1;
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>  		mapped_data = jh_in->b_frozen_data;
> @@ -357,17 +355,15 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		new_folio = bh_in->b_folio;
>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>  		mapped_data = kmap_local_folio(new_folio, new_offset);
> -	}
> -
> -	/*
> -	 * Fire data frozen trigger if data already wasn't frozen.  Do this
> -	 * before checking for escaping, as the trigger may modify the magic
> -	 * offset.  If a copy-out happens afterwards, it will have the correct
> -	 * data in the buffer.
> -	 */
> -	if (!done_copy_out)
> +		/*
> +		 * Fire data frozen trigger if data already wasn't frozen. Do
> +		 * this before checking for escaping, as the trigger may modify
> +		 * the magic offset.  If a copy-out happens afterwards, it will
> +		 * have the correct data in the buffer.
> +		 */
>  		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>  					   jh_in->b_triggers);
> +	}
>  
>  	/*
>  	 * Check for escaping
> @@ -380,7 +376,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	/*
>  	 * Do we need to do a data copy?
>  	 */
> -	if (do_escape && !done_copy_out) {
> +	if (do_escape && !jh_in->b_frozen_data) {
>  		char *tmp;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> @@ -408,7 +404,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  copy_done:
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> -		done_copy_out = 1;
>  	}
>  
>  	/*
> 



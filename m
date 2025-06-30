Return-Path: <linux-ext4+bounces-8709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E186AEDFDB
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 16:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBB8189B806
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43DA28C849;
	Mon, 30 Jun 2025 13:59:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927828B7F9;
	Mon, 30 Jun 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291943; cv=none; b=LIbIL33UnsqVxAyq+EId+JQpnsjux4TWG+wuteP+PwWr9htpDNq1S07vsujBYE5JFK9F+jKzd1Y78O/IbE8iLpit6K3ZdQ8Kw7EI8TTU83LJi5EfRlVBJ37qD3REX/zDW68GUIkdXd9FMyO3UOE+QKeBABUV0gwRaAE6MuWXStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291943; c=relaxed/simple;
	bh=lnuCtoZ25M8XX5pqOcDT82hZ0f7dTMbUDFp1u5jiT1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJF21ic0iSN8Ca8JYuHRosHUM2ddHvbZQNh7LHUWsvREKwi5ST5UTy1+rNzcJbqZ43/3mJNpSRKPg+BZYRZKXQdDqU1XoAyNHEIvCPVjoJfxXd8618WXXfcHvMnBfIzZPkRy5oPeTELXFIuesE0Ii5o16mVoX76M907pP7tFrAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bW7755qtczYQvGC;
	Mon, 30 Jun 2025 21:58:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A9B9D1A1447;
	Mon, 30 Jun 2025 21:58:56 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCUdmGJooO7dAA--.62190S3;
	Mon, 30 Jun 2025 21:58:54 +0800 (CST)
Message-ID: <0d7b0731-88c3-4114-a401-e6aa8a085c5f@huaweicloud.com>
Date: Mon, 30 Jun 2025 21:58:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix JBD2 credit overflow with large folios
To: Sasha Levin <sashal@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tytso@mit.edu
References: <20250630131324.1253313-1-sashal@kernel.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250630131324.1253313-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXeCUdmGJooO7dAA--.62190S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1DArWUGFyDGF47CF15Jwb_yoW7GryfpF
	W7CFsxCr98Za4fu3WSkw4UZF1Fg348CF4UGF1fKrn2va98Wr1xKFn8tw15KFyjkr4xGwnY
	qF15ur9rW3Z0yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/30 21:13, Sasha Levin wrote:
> When large folios are enabled, the blocks-per-folio calculation in
> ext4_da_writepages_trans_blocks() can overflow the journal transaction
> limits, causing the writeback path to fail with errors like:
> 
>   JBD2: kworker/u8:0 wants too many credits credits:416 rsv_credits:21 max:334
> 
> This occurs with small block sizes (1KB) and large folios (32MB), where
> the calculation results in 32768 blocks per folio. The transaction credit
> calculation then requests more credits than the journal can handle, leading
> to the following warning and writeback failure:
> 
>   WARNING: CPU: 1 PID: 43 at fs/jbd2/transaction.c:334 start_this_handle+0x4c0/0x4e0
>   EXT4-fs (loop0): ext4_do_writepages: jbd2_start: 9223372036854775807 pages, ino 14; err -28
> 
> Call trace leading to the issue:
>   ext4_do_writepages()
>     ext4_da_writepages_trans_blocks()
>       bpp = ext4_journal_blocks_per_folio() // Returns 32768 for 32MB folio with 1KB blocks
>       ext4_meta_trans_blocks(inode, MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp)
>         // With bpp=32768, lblocks=34815, pextents=32768
>         // Returns credits=415, but with overhead becomes 416 > max 334
>     ext4_journal_start_with_reserve()
>       jbd2_journal_start_reserved()
>         start_this_handle()
>           // Fails with warning when credits:416 > max:334
> 
> The issue was introduced by commit d6bf294773a47 ("ext4/jbd2: convert
> jbd2_journal_blocks_per_page() to support large folio"), which added
> support for large folios but didn't account for the journal credit limits.
> 
> Fix this by capping the blocks-per-folio value at 8192 in the writeback
> path. This is the value we'd get with 32MB folios and 4KB blocks, or 8MB
> folios with 1KB blocks, which is reasonable and safe for typical journal
> configurations.
> 
> Fixes: d6bf294773a4 ("ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi, Sasha!

Thank you for the fix. However, simply limiting the credits is not enough,
as this may result in a scenario where there are not enough credits
available to map a large, non-contiguous folio. I've been working on this
issue[1] and I'll release v3 tomorrow if my tests looks fine.

[1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

> ---
>  fs/ext4/inode.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index be9a4cba35fd5..860e59a176c97 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2070,6 +2070,14 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>   */
>  #define MAX_WRITEPAGES_EXTENT_LEN 2048
>  
> +/*
> + * Maximum blocks per folio to avoid JBD2 credit overflow.
> + * This is the value we'd get with 32MB folios and 4KB blocks,
> + * or 8MB folios with 1KB blocks, which is reasonable and safe
> + * for typical journal configurations.
> + */
> +#define MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK 8192
> +
>  /*
>   * mpage_add_bh_to_extent - try to add bh to extent of blocks to map
>   *
> @@ -2481,6 +2489,18 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
>  {
>  	int bpp = ext4_journal_blocks_per_folio(inode);
>  
> +	/*
> +	 * With large folios, blocks per folio can get excessively large,
> +	 * especially with small block sizes. For example, with 32MB folios
> +	 * (order 11) and 1KB blocks, we get 32768 blocks per folio. This
> +	 * leads to credit requests that overflow the journal's transaction
> +	 * limit.
> +	 *
> +	 * Limit the value to avoid excessive credit requests.
> +	 */
> +	if (bpp > MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK)
> +		bpp = MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK;
> +
>  	return ext4_meta_trans_blocks(inode,
>  				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
>  }
> @@ -2559,6 +2579,13 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	handle_t *handle = NULL;
>  	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
>  
> +	/*
> +	 * With large folios, blocks per folio can get excessively large,
> +	 * especially with small block sizes. Cap it to avoid credit overflow.
> +	 */
> +	if (bpp > MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK)
> +		bpp = MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK;
> +
>  	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
>  		tag = PAGECACHE_TAG_TOWRITE;
>  	else
> @@ -6179,6 +6206,13 @@ int ext4_writepage_trans_blocks(struct inode *inode)
>  	int bpp = ext4_journal_blocks_per_folio(inode);
>  	int ret;
>  
> +	/*
> +	 * With large folios, blocks per folio can get excessively large,
> +	 * especially with small block sizes. Cap it to avoid credit overflow.
> +	 */
> +	if (bpp > MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK)
> +		bpp = MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK;
> +
>  	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
>  
>  	/* Account for data blocks for journalled mode */



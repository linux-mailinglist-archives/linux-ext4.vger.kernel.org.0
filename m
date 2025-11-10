Return-Path: <linux-ext4+bounces-11722-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D0C46949
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 13:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABAC94E2BF5
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6953074A4;
	Mon, 10 Nov 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="DVVZXDAL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCF18626;
	Mon, 10 Nov 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777596; cv=none; b=ubBcJR9EbF4yDa1MhRkpyAJe38Ri15O9IGprVEss8LMHCo/5Fw+LQOnp/ji5boI5bhH238KZ8fuFG9hazWGfcq5CXIzHi1CggtzQ1LmsTrahJ4ATX6IqMHN5khl9d22ge2K8P8UZ1yq2dYN/IcaNWg0SLSisX4Q/hy0X5XOUQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777596; c=relaxed/simple;
	bh=L6naHV+R0hdfap4NIv1kJN6rQ8xwUu00wffuXt5IU48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdGf9kMwLZ0kvSjhRaVu7zCdeJgJRz20QD9Lbi/Mi9708DEDY1wIs0ovZAYLMbjRuAibhI/S0gH1i25mikQXJyFzCyHZc2i/zjvef4B3sdDqb5761w4hPQIHxtWz8XhCVZ+jDjSeIatQT46vK1yHBc5nC9M9bPj3GaxpO1w2Gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=DVVZXDAL; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d4pmv41h6z9tg2;
	Mon, 10 Nov 2025 13:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1762777583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxS3S4E3EDuqOd1N7IeIu20lm6MwawNUsDUFEyJ5EOA=;
	b=DVVZXDALmpZf7p5azYl1KM5JiBGgvL0SI3d3FNeL1QXGezr24cIfGHJrGn6NmiqGfFQ8m7
	U7hk0FbBGBSGxIM6FaV/rvlOEuSUOPV0PQSwvx/Ujit8hlpzx9hTXJSkkoAbIy2ly7/a8P
	CxSkvKI7M4agb9AR85nDccyjxLhnYUlgAy+kpvr90+Vm9yEdhMGsy0EH8ARGX0wVjdJnPj
	WNceECQSDhbxnL+z+jZC8+fD4L6HEXdfjw+FvviypgNwLRScd1BltMMvFH+anJkHpDRg5M
	W8C+TAvL0LMf4qVGfw5h+bDc9snZzMj0qgF7nJuJUDx5eA53JzXDuyuwIpckFQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <af30cb7e-a59d-4937-8fc5-1b9c68685939@pankajraghav.com>
Date: Mon, 10 Nov 2025 13:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 08/24] ext4: support large block size in ext4_readdir()
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, ebiggers@kernel.org,
 willy@infradead.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-9-libaokun@huaweicloud.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20251107144249.435029-9-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4d4pmv41h6z9tg2

On 11/7/25 15:42, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_readdir(), page_cache_sync_readahead() is used to readahead mapped
> physical blocks. With LBS support, this can lead to a negative right shift.
> 
> To fix this, the page index is now calculated by first converting the
> physical block number (pblk) to a file position (pos) before converting
> it to a page index. Also, the correct number of pages to readahead is now
> passed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
Minor general comments below.

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

>  fs/ext4/dir.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index d4164c507a90..256fe2c1d4c1 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -192,13 +192,13 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  			continue;
>  		}
>  		if (err > 0) {
> -			pgoff_t index = map.m_pblk >>
> -					(PAGE_SHIFT - inode->i_blkbits);
> +			pgoff_t index = map.m_pblk << inode->i_blkbits >>
> +					PAGE_SHIFT;

It will be nice to have some common helper for this operation. We do something
similar in filemap.c as well.

>  			if (!ra_has_index(&file->f_ra, index))
>  				page_cache_sync_readahead(
>  					sb->s_bdev->bd_mapping,
> -					&file->f_ra, file,
> -					index, 1);
> +					&file->f_ra, file, index,
> +					1 << EXT4_SB(sb)->s_min_folio_order);
Just a personal opinion but it would be nice to have some variable for this instead of doing it
inline? It could be defined along with index.

unsigned long min_nr_pages = 1UL << EXT4_SB(sb)->s_min_folio_order;


>  			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
>  			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
>  			if (IS_ERR(bh)) {



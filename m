Return-Path: <linux-ext4+bounces-11721-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C919C467C2
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 13:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 768943483A2
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43D3112C4;
	Mon, 10 Nov 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="KoKNy9GX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9031076A;
	Mon, 10 Nov 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776582; cv=none; b=EsP2qIppMokAehzjW93dafYO/9622vpVOd/GBF+XaH1NJ2Mn0t88gU+86ZhHKbhwsQ+MzQl8sPbRypE57IUV05D5TNvOOIBHw2ojMowAVDUeJRFKEDG/4X7wqYZ0Z/UfARkYntpGlIskRlarerYej0qnD/TYpOB7nXn2cCma6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776582; c=relaxed/simple;
	bh=21raMy9AqcuNpuodzWyV3qNti9get3yec5vrUZWy/FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHnfn9ZmRqF21lTvnI0KZ9lsjusCV68pBEcUQpZ3MnDg4HCpqq3S0ctDmHVPQY7RQ+L2HCLcj/g01oLqC+WAlaUyUOoaotxwu0O9HgG72R0QKy5/vB26F9fzrke/MVx7qYFrBsiNMPJDr7VxEwLGLdDAel4/lYhJnxNMkJt6pNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=KoKNy9GX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d4pPV3xBqz9t7s;
	Mon, 10 Nov 2025 13:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1762776574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnLclFpio7cquMiXUQ0a6w+ejZfEXZBGwwWiiDE/dmc=;
	b=KoKNy9GX/WVMFtDmlQc8y29033qX3S8n9uKOcOIGw82pElWyqRNIrXLT6WWzR0yn343MU0
	LimDTfDBmiof9aSRQv6ocLgUU3wS0VelNx9+qRAUB++odeN3JnrY9P5lgau4KceY76AiTl
	yUP9ogDItyOI3bsNZcPJJvtyeFpIktgzBO+/zQvGj0Jzd3oone+tv3U33wTKE51KixmMYF
	llAMbGGR4CGPaXIldoluyOfSERvWnUw1x5IOvyftv+h1jfVl69eMP3zshnfUjNwsb5/PPJ
	fVX0grJTUVyDGBM13bZexoFDfNl5P4njYHQAceuDcauakwdATeI5/Kw35JJnxQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <bdc8ea99-f967-4112-b418-f586736da993@pankajraghav.com>
Date: Mon, 10 Nov 2025 13:09:30 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/24] ext4: introduce s_min_folio_order for future BS
 > PS support
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, ebiggers@kernel.org,
 willy@infradead.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-7-libaokun@huaweicloud.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20251107144249.435029-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4d4pPV3xBqz9t7s

On 11/7/25 15:42, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This commit introduces the s_min_folio_order field to the ext4_sb_info
> structure. This field will store the minimum folio order required by the
> current filesystem, laying groundwork for future support of block sizes
> greater than PAGE_SIZE.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
Looks good,

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

>  fs/ext4/ext4.h  |  3 +++
>  fs/ext4/inode.c |  3 ++-
>  fs/ext4/super.c | 10 +++++-----
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3d18e6bf43cf..6fe8cc3bf9a5 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1688,6 +1688,9 @@ struct ext4_sb_info {
>  	/* record the last minlen when FITRIM is called. */
>  	unsigned long s_last_trim_minblks;
>  
> +	/* minimum folio order of a page cache allocation */
> +	unsigned int s_min_folio_order;
> +
>  	/* Precomputed FS UUID checksum for seeding other checksums */
>  	__u32 s_csum_seed;
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6fec3aa2268a..9faa0cf77075 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5181,7 +5181,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
>  	if (!ext4_should_enable_large_folio(inode))
>  		return;
>  
> -	mapping_set_folio_order_range(inode->i_mapping, 0,
> +	mapping_set_folio_order_range(inode->i_mapping,
> +				      EXT4_SB(inode->i_sb)->s_min_folio_order,
>  				      EXT4_MAX_PAGECACHE_ORDER(inode));
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a9fa824487f9..a6314a3de51d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5107,11 +5107,8 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  	 * If the default block size is not the same as the real block size,
>  	 * we need to reload it.
>  	 */
> -	if (sb->s_blocksize == blocksize) {
> -		*lsb = logical_sb_block;
> -		sbi->s_sbh = bh;
> -		return 0;
> -	}
> +	if (sb->s_blocksize == blocksize)
> +		goto success;
>  
>  	/*
>  	 * bh must be released before kill_bdev(), otherwise
> @@ -5142,6 +5139,9 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  		ext4_msg(sb, KERN_ERR, "Magic mismatch, very weird!");
>  		goto out;
>  	}
> +
> +success:
> +	sbi->s_min_folio_order = get_order(blocksize);
>  	*lsb = logical_sb_block;
>  	sbi->s_sbh = bh;
>  	return 0;



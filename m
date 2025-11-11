Return-Path: <linux-ext4+bounces-11790-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCAC4F5D2
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 19:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AA2189B009
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217D28725A;
	Tue, 11 Nov 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="FP4DPIrS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA627587D;
	Tue, 11 Nov 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884096; cv=none; b=QkUpYhjCG0y+uGoNczCg9gaxvpd9t3ksNE1jmsteo2ZAp/9VT9jchj4typ7nk9F9yqVX/GIQz663U0okH9L+45Wdec2MRJhH0Qe2IEq//G2xbnvZUDWQYjC7jm9aTuVkYZt7vl92sJudTvBaIdfHinvDVZpdaEYOf0kLg9JAUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884096; c=relaxed/simple;
	bh=uFWA3teT7TosQucoMFTr49PCOAPfaa0i4DqQX56vHt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDfZZkZ2BD3eLsIWlqLnw6w2/1qHGdgdat4darSgsvIBha5OQTfAXD6jFfLVbu3eOLDq84Hi+KdXjGymiXXd7FE51aKnSZv/cWECmApvNpAWex+2yAInqDlNFf2PfgwASp8O+lT0B+2SZXxOFwW+IjUnH/NC1shz18eqZkuK8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=FP4DPIrS; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d5Z924mmVz9ss7;
	Tue, 11 Nov 2025 19:01:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1762884086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWsd4vZTjWLUJaUc98A7GiceajcfWMWAR9nAKjmOjpA=;
	b=FP4DPIrSJvn+BI0/A1buudkDLRu2pDBGk+r/fpvwVDwYuugwBaIxXP5ETBjInp4t4yG1cm
	eFNfUH+RHufIpQ8jMQSC2X3mRzuClHwuKZoPQsGPYMB3+1v4b41OyB/325TfJiEzp+vrZn
	y7agp279myUCtu804rmL1mW3bgvDuMMscwLnQbWdRccHP3NWrJXwaL5u5BZ8nDYd5EHBG8
	+TcE/mAtaxKz15PGJRZjr6GlVkDobufnuGnY4yw4ICujJgjvvhmQeisGd5No+Cdzs+75mw
	vwDu/GvYK2IPc7r03tQ5fGPBCW8nRFr7oczXHZWjbuw+RQ8zPYTPnFngaREYpA==
Message-ID: <880280be-1cd0-41b6-bc89-9168f374a9b9@pankajraghav.com>
Date: Tue, 11 Nov 2025 19:01:20 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 24/24] ext4: enable block size larger than page size
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, ebiggers@kernel.org,
 willy@infradead.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-25-libaokun@huaweicloud.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20251111142634.3301616-25-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/11/25 15:26, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since block device (See commit 3c20917120ce ("block/bdev: enable large
> folio support for large logical block sizes")) and page cache (See commit
> ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
> cache")) has the ability to have a minimum order when allocating folio,
> and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
> large folio for regular file"), now add support for block_size > PAGE_SIZE
> in ext4.
> 
> set_blocksize() -> bdev_validate_blocksize() already validates the block
> size, so ext4_load_super() does not need to perform additional checks.
> Here we only need to add the FS_LBS bit to fs_flags.
> 
> In addition, block sizes larger than the page size are currently supported
> only when CONFIG_TRANSPARENT_HUGEPAGE is enabled. To make this explicit,
> a blocksize_gt_pagesize entry has been added under /sys/fs/ext4/feature/,
> indicating whether bs > ps is supported. This allows mke2fs to check the
> interface and determine whether a warning should be issued when formatting
> a filesystem with block size larger than the page size.
> 

If you are planning to send another revision, then it would be nice to include
the corresponding patch to mke2fs as well? I don't know how ext4 process works but
just a suggestion.
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

>  fs/ext4/super.c | 3 ++-
>  fs/ext4/sysfs.c | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f1aeba47b0e3..29bc8f5eb527 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7451,7 +7451,8 @@ static struct file_system_type ext4_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= ext4_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
> +				  FS_LBS,
>  };
>  MODULE_ALIAS_FS("ext4");
>  
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 987bd00f916a..0018e09b867e 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -332,6 +332,9 @@ EXT4_ATTR_FEATURE(fast_commit);
>  #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
>  EXT4_ATTR_FEATURE(encrypted_casefold);
>  #endif
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +EXT4_ATTR_FEATURE(blocksize_gt_pagesize);
> +#endif
>  
>  static struct attribute *ext4_feat_attrs[] = {
>  	ATTR_LIST(lazy_itable_init),
> @@ -351,6 +354,9 @@ static struct attribute *ext4_feat_attrs[] = {
>  	ATTR_LIST(fast_commit),
>  #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
>  	ATTR_LIST(encrypted_casefold),
> +#endif
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	ATTR_LIST(blocksize_gt_pagesize),
>  #endif
>  	NULL,
>  };



Return-Path: <linux-ext4+bounces-11696-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFBC425BE
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 04:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6114B188CC17
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477C2D23A5;
	Sat,  8 Nov 2025 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WYG3dmFb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B9253956;
	Sat,  8 Nov 2025 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572185; cv=none; b=ioDx3WaRq5WveBuifKjyIKY+JGpd6M4yi5Hqh6XSyfEhNIVoTpbxWxPkfXo2GxwDAn3qtTOXKSqqWIFEK/d5NQ7st11D0x9jp9oJIfmaFw8GsTFvmZbBWWr9uGBxQs45GtsvLmjS2nM3ylnPjWSeEs/N4mtt/K9mEpawzwLs6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572185; c=relaxed/simple;
	bh=3db6kDgcp6ZBaCWoMiT07aEdoBIn2fyq56Cj1ZzUUFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=htOrC64EhXw9vZNFVO5V4ujZZnZ+jgzFK87Ob8P09wrDd483LWE8Xcoynhc9NAGsSKH+TRPXmmSLe417TzT8l8GrBfXHyvYi/3ZLzNsBtqILitNi9ssyRHYsf4r34FRdqh0ENOAsmuj8OfOsPNAL8pm6eJQMslxcJJ/JCTuElco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WYG3dmFb; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qZpdxuNaZJ5yTrvmKWL9bmcWjXTZFnV3j45z8dY7gZo=;
	b=WYG3dmFbG8rzR/MN5MvXPHAcQZowG4JneABCdOdvePd0iFkkb4zAHegLxioAyhiAdD703l7Jn
	mxY8fVF2zjY3X8SV23ant75X/iLdJT9pAOguu6oKemTSKGqugFwfSPYtFRQj4tCq7m9CX2wxHTB
	XSugBg9Q17r3T1oGSAMVO1U=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d3Lmz0SyfzpStp;
	Sat,  8 Nov 2025 11:21:23 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 83D16180B69;
	Sat,  8 Nov 2025 11:22:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 11:22:57 +0800
Message-ID: <e564bcc0-c4ea-466c-b6a9-5bce5406c475@huawei.com>
Date: Sat, 8 Nov 2025 11:22:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: clear i_state_flags when alloc inode
Content-Language: en-GB
To: Haibo Chen <haibo.chen@nxp.com>
CC: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>
References: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-04 16:12, Haibo Chen wrote:
> i_state_flags used on 32-bit archs, need to clear this flag when
> alloc inode.
> Find this issue when umount ext4, sometimes track the inode as orphan
> accidently, cause ext4 mesg dump.
>
> Fixes: acf943e9768e ("ext4: fix checks for orphan inodes")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/ialloc.c | 1 -
>  fs/ext4/inode.c  | 1 -
>  fs/ext4/super.c  | 1 +
>  3 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index ba4fd9aba1c14de56b89ebbeb4597f7becf947ff..b20a1bf866abedf3a768ee8a147f108ea09ecb01 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1293,7 +1293,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		ei->i_csum_seed = ext4_chksum(csum, (__u8 *)&gen, sizeof(gen));
>  	}
>  
> -	ext4_clear_state_flags(ei); /* Only relevant on 32-bit archs */
>  	ext4_set_inode_state(inode, EXT4_STATE_NEW);
>  
>  	ei->i_extra_isize = sbi->s_want_extra_isize;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a163c087137314c541ec10c011488c5392fb7011..bf6786d373ff57c32d5a84cfd73ea8a33cb68b16 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5285,7 +5285,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	ei->i_projid = make_kprojid(&init_user_ns, i_projid);
>  	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
>  
> -	ext4_clear_state_flags(ei);	/* Only relevant on 32-bit archs */
>  	ei->i_inline_off = 0;
>  	ei->i_dir_start_lookup = 0;
>  	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529c357d291f40269863398753dc650..3dcc9410c09a55d5dce2dbff388a97bf4f133818 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1396,6 +1396,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  
>  	inode_set_iversion(&ei->vfs_inode, 1);
>  	ei->i_flags = 0;
> +	ext4_clear_state_flags(ei);	/* Only relevant on 32-bit archs */
>  	spin_lock_init(&ei->i_raw_lock);
>  	ei->i_prealloc_node = RB_ROOT;
>  	atomic_set(&ei->i_prealloc_active, 0);
>
> ---
> base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
> change-id: 20251104-ext4-3f9647dcedd0
>
> Best regards,




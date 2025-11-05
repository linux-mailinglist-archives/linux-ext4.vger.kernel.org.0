Return-Path: <linux-ext4+bounces-11463-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEAC33A7E
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 02:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2684608BF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 01:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05697243951;
	Wed,  5 Nov 2025 01:26:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DA22D4DC;
	Wed,  5 Nov 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305963; cv=none; b=EPrw1d1E84QAgPQJOPQ6lfqtM29d2aACEakX+oTUZT/+Y4Rs1yTQCB2IcHABQUZXz0qS9Jo/HXL4idcgVrKkh/vcTxv6Niyt0xr1xTL2K7d3AyeYK5HsNj57LjgkEm42VY2SRABfBjxcVgJ8gTBohJLQBTZcvcAtUtVESYsq40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305963; c=relaxed/simple;
	bh=d+WLItqrPtI3jZBXpw7c4Iikc6Ig5YbeZW9d5Rz+aZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vq05Yqss2RVk2Su78l9hcTm5yUgaF0OnDCJZe9ysErit0kbuCqPcQXONDvpVP+u7wjXke5l8WebLf4REGwRil4MgC6591o3lgQrEHHhSCqg9bNe5fAm3B6IR6iU9CaEEJYMStbIbZu53rYGsIeye8XqAaD7OXkq0G4g7O+5wEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1SLt3KC4zYQv8B;
	Wed,  5 Nov 2025 09:25:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5B4D51A0B86;
	Wed,  5 Nov 2025 09:25:58 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBXrESkpwppj0v3Cg--.2175S3;
	Wed, 05 Nov 2025 09:25:58 +0800 (CST)
Message-ID: <1e2aa259-50c5-4dbd-a699-de1a5976dfc4@huaweicloud.com>
Date: Wed, 5 Nov 2025 09:25:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: clear i_state_flags when alloc inode
To: Haibo Chen <haibo.chen@nxp.com>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXrESkpwppj0v3Cg--.2175S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDGw4fWF15uFyxtry7Jrb_yoW5Jr1UpF
	Z7Ca4fGFW7X34UWa1IgrnrXr1jqa45KFWUWFn09r1jvF93XFyrKFn2qr45AF4IvrZ5Ar4S
	q3WUCry7uw45Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/4/2025 4:12 PM, Haibo Chen wrote:
> i_state_flags used on 32-bit archs, need to clear this flag when
> alloc inode.
> Find this issue when umount ext4, sometimes track the inode as orphan
> accidently, cause ext4 mesg dump.
> 
> Fixes: acf943e9768e ("ext4: fix checks for orphan inodes")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

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



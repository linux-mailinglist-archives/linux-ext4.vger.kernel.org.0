Return-Path: <linux-ext4+bounces-11834-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC11AC53F92
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70A99349C6D
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196834A77D;
	Wed, 12 Nov 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK7YUeJ/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6E233128
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972570; cv=none; b=raa4FKJiAhyHrZmrhV/XreULgHNoS1U71MUUuJIbNDsuk8ORHaG77gqOcVvuagTeZNF+74ggcCRUoqudmDgwV7VhgJ4sshLDXOkVDTM/QTAqUWmESgfrCxsr3Qy+uqSb1mArq54AXAD+sQ7m8qSQEkfZft9xXg0YsPEqepmH0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972570; c=relaxed/simple;
	bh=T3cq49mIPcV95dXJh13yfA5wC/E5eXEfQxNQ+X71yxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqa1nZK/oES5a2trYrt1SY2pIicPoghXOk7TDk0yXVqBZtd1qJtuuIFS8F5H/00QgjwYeLZmlwQzq8DBeF/5BD3CN40HyPTI+L/ux38VXFbyjGzUQP497591yR374/4mojwSVRJmKDic8JbMeky77LW8E103Ao/z9MDhCLVNorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK7YUeJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F41C4CEF1;
	Wed, 12 Nov 2025 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972570;
	bh=T3cq49mIPcV95dXJh13yfA5wC/E5eXEfQxNQ+X71yxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YK7YUeJ/F6T59x8r4+kISdC01P3IKAnh9WhkeLA1bQ0TnBr61AmzGq8RLgi6JaVxc
	 +QQw9r6m0F1DP5wFb98+uO3JGb6+wqIs1BodK8f8bWOn1mM3DoH1Lf84ybd8XWAtN3
	 fTfaxS988/MpO8Bml98dC5qRpNZLeU3NpZhOs5E0gKZh1Z67elS5F4ScQpvQA1++Ed
	 kfieghRzTBLfAF1WRww11iVDOUgIuLN0DT/n5bAyBrZ4S65qvSNEz/w3Kqx9C2sln4
	 921p1Y+MgTTfIf2/8zNJqfCh/90Ywq0Tpe5An4Th9CpuqhxepVJRvm94Sg6HJgkWNt
	 bSiiBHHX56OCw==
Date: Wed, 12 Nov 2025 10:36:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH e2fsprogs] libext2fs: fix orphan file size > kernel limit
 with large blocksize
Message-ID: <20251112183609.GN196358@frogsfrogsfrogs>
References: <20251112122157.1990595-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112122157.1990595-1-libaokun@huaweicloud.com>

On Wed, Nov 12, 2025 at 08:21:57PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> limits the maximum supported orphan file size to 8 << 20.
> 
> However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
> blocks when creating a filesystem.
> 
> With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
> than the kernel allows, so mount prints an error and fails:
> 
>     EXT4-fs (vdb): orphan file too big: 8650752
>     EXT4-fs (vdb): mount failed
> 
> Therefore, synchronize the kernel change to e2fsprogs to avoid creating
> orphan files larger than the kernel limit.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  lib/ext2fs/ext2fs.h |  2 ++
>  lib/ext2fs/orphan.c | 12 +++++++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index bb2170b7..d9df007c 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1819,6 +1819,8 @@ errcode_t ext2fs_set_data_io(ext2_filsys fs, io_channel new_io);
>  errcode_t ext2fs_rewrite_to_io(ext2_filsys fs, io_channel new_io);
>  
>  /* orphan.c */
> +#define EXT4_MAX_ORPHAN_FILE_SIZE	8 << 20
> +#define EXT4_DEFAULT_ORPHAN_FILE_SIZE	2 << 20

These #defines ought to have parentheses guarding the expression for
good hygiene.  Also, if this is an artifact of the ondisk format, then
shouldn't it be in ext2_fs.h?  and fs/ext4/ext4.h?

>  extern errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks);
>  extern errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs);
>  extern e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs);
> diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
> index 14ac3569..40b1c5c7 100644
> --- a/lib/ext2fs/orphan.c
> +++ b/lib/ext2fs/orphan.c
> @@ -164,6 +164,8 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
>  	memset(zerobuf, 0, fs->blocksize);
>  	ob_tail = ext2fs_orphan_block_tail(fs, buf);
>  	ob_tail->ob_magic = ext2fs_cpu_to_le32(EXT4_ORPHAN_BLOCK_MAGIC);
> +	if (num_blocks * fs->blocksize > EXT4_MAX_ORPHAN_FILE_SIZE)
> +		num_blocks = EXT4_MAX_ORPHAN_FILE_SIZE / fs->blocksize;
>  	oi.num_blocks = num_blocks;
>  	oi.alloc_blocks = 0;
>  	oi.last_blk = 0;
> @@ -216,18 +218,18 @@ out:
>  
>  /*
>   * Find reasonable size for orphan file. We choose orphan file size to be
> - * between 32 and 512 filesystem blocks and not more than 1/4096 of the
> - * filesystem unless it is really small.
> + * between 32 filesystem blocks and EXT4_DEFAULT_ORPHAN_FILE_SIZE, and not
> + * more than 1/fs->blocksize of the filesystem unless it is really small.
>   */
>  e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs)
>  {
>  	__u64 num_blocks = ext2fs_blocks_count(fs->super);
> -	e2_blkcnt_t blks = 512;
> +	e2_blkcnt_t blks = EXT4_DEFAULT_ORPHAN_FILE_SIZE / fs->blocksize;
>  
>  	if (num_blocks < 128 * 1024)
>  		blks = 32;
> -	else if (num_blocks < 2 * 1024 * 1024)
> -		blks = num_blocks / 4096;
> +	else if (num_blocks < EXT4_DEFAULT_ORPHAN_FILE_SIZE)
> +		blks = num_blocks / fs->blocksize;

If the number of blocks in the filesystem is less than the default
orphan file size in bytes?  I don't understand that logic, particularly
because EXT4_DEFAULT_ORPHAN_FILE_SIZE == 2<<20 == 2097152 == 2 * 1024 *
1024.

--D

>  	return (blks + EXT2FS_CLUSTER_MASK(fs)) & ~EXT2FS_CLUSTER_MASK(fs);
>  }
>  
> -- 
> 2.46.1
> 
> 


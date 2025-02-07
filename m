Return-Path: <linux-ext4+bounces-6375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B03FA2BA13
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 05:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B067C166484
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFAD194A67;
	Fri,  7 Feb 2025 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJsV/vmX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC022417CA
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901790; cv=none; b=HGxzuCrqKr02IWyUkeAt70+DFEHxcxj8GHJuDcgMqQnJeeiiwWt0QRoAi+6+LviZ656VywCtp/XSJr6XzrEZ0p23hqgF79oyUGYubCP7pF1gt4IBeBEevGpKGCiFqM/Djp7swakHG1pD4JIaYbyuokZQ28D9VqHXBlk5MrIc6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901790; c=relaxed/simple;
	bh=tyYBArqkYSTqUixKrn6RK8NoGwYrrd8j+Z1IJvpPYFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr82jgtk3D3TklbW5N2MnI3B/wPtOnH4al/gSQdFMkJed4DEnNBmvXbtd65CsWGEfuinJQvO1fa315Niisu26ETmF19Lw2yS3qKaTZDiq2rkiCavS5+Q1o26ZkqlL7aOaTqs9cDevNPCKvMVCsjdnsC233kdX7nvCdUx6GesOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJsV/vmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91521C4CED1;
	Fri,  7 Feb 2025 04:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738901789;
	bh=tyYBArqkYSTqUixKrn6RK8NoGwYrrd8j+Z1IJvpPYFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJsV/vmXPuUqAVOpAoydNE6ZnLHOwCOKqlGIDyzoP3qb3NL2Xq8brJb64WnC+7qXR
	 cXR5cqA31CO3IQJuNmcHtKhxLSMlNa/LTwSGXKxr0l2AyBspaGXOnKpz0b8OzEa/Ve
	 E5HhnxQHCz2nXmvpqa2X3DvD9/kFutwT4DFgXd1t1oF9NKWZiTvtvmmZ4UXKICzxl4
	 V4ep5eHL2/oCAG0YPFOQol1Gtavy6QOwgzD0FAcweZODHUKHrG6dMdvflKCDNcy01R
	 D1L6Tfd2MaUJ04n+2+3R7LBrlsuavQqW/LO0NeKnAvC4Gbh45Xyo/uahAmqCXVUGmh
	 d2LfDnZnfZ0yQ==
Date: Thu, 6 Feb 2025 20:16:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz
Subject: Re: [RESEND PATCH 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Message-ID: <20250207041629.GE21787@frogsfrogsfrogs>
References: <20250207032743.882949-1-yebin@huaweicloud.com>
 <20250207032743.882949-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207032743.882949-3-yebin@huaweicloud.com>

On Fri, Feb 07, 2025 at 11:27:43AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
> Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172
> 
> CPU: 3 PID: 15172 Comm: syz-executor.0
> Call Trace:
>  __dump_stack lib/dump_stack.c:82 [inline]
>  dump_stack+0xbe/0xfd lib/dump_stack.c:123
>  print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
>  __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
>  kasan_report+0x3a/0x50 mm/kasan/report.c:585
>  ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
>  ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
>  ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
>  evict+0x39f/0x880 fs/inode.c:622
>  iput_final fs/inode.c:1746 [inline]
>  iput fs/inode.c:1772 [inline]
>  iput+0x525/0x6c0 fs/inode.c:1758
>  ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
>  ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
>  mount_bdev+0x355/0x410 fs/super.c:1446
>  legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
>  vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
>  do_new_mount fs/namespace.c:2983 [inline]
>  path_mount+0x119a/0x1ad0 fs/namespace.c:3316
>  do_mount+0xfc/0x110 fs/namespace.c:3329
>  __do_sys_mount fs/namespace.c:3540 [inline]
>  __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Memory state around the buggy address:
>  ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> Above issue happens as ext4_xattr_delete_inode() isn't check xattr
> is valid if xattr is in inode.
> To solve above issue call xattr_check_inode() check if xattr if valid
> in inode.
> 
> Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/xattr.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 0e4494863d15..cb724477f8da 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2922,7 +2922,6 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>  			    int extra_credits)
>  {
>  	struct buffer_head *bh = NULL;
> -	struct ext4_xattr_ibody_header *header;
>  	struct ext4_iloc iloc = { .bh = NULL };
>  	struct ext4_xattr_entry *entry;
>  	struct inode *ea_inode;
> @@ -2937,6 +2936,9 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>  
>  	if (ext4_has_feature_ea_inode(inode->i_sb) &&
>  	    ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> +		struct ext4_xattr_ibody_header *header;
> +		struct ext4_inode *raw_inode;
> +		void *end;
>  
>  		error = ext4_get_inode_loc(inode, &iloc);
>  		if (error) {
> @@ -2952,14 +2954,20 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>  			goto cleanup;
>  		}
>  
> -		header = IHDR(inode, ext4_raw_inode(&iloc));
> -		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC))
> +		raw_inode = ext4_raw_inode(&iloc);
> +		header = IHDR(inode, raw_inode);
> +		end = ITAIL(inode, raw_inode);
> +		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {

This needs to make sure that header + sizeof(h_magic) >= end before
checking the magic number in header::h_magic, right?

--D

> +			error = xattr_check_inode(inode, header, end);
> +			if (error)
> +				goto cleanup;
>  			ext4_xattr_inode_dec_ref_all(handle, inode, iloc.bh,
>  						     IFIRST(header),
>  						     false /* block_csum */,
>  						     ea_inode_array,
>  						     extra_credits,
>  						     false /* skip_quota */);
> +		}
>  	}
>  
>  	if (EXT4_I(inode)->i_file_acl) {
> -- 
> 2.34.1
> 
> 


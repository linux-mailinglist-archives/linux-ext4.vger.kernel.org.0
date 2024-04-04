Return-Path: <linux-ext4+bounces-1869-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0F898F8B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 22:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91271F23144
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087151369B7;
	Thu,  4 Apr 2024 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uOr1PId/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D643136660
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262219; cv=none; b=c+dAt0ia5YHrjyM6ZInmmu10OXvUfYO9+l8eT/ovZY2HmjQZyKXyqXjpUqcvgfLgTfBV26Jt46DbOdm+tkOdfLh1SgwzuXcEJYPEsOLa1mSuROEF5ssAIja5LD+NwZcI6G3k/W1XaDtGe5z5RrQQ0alXOn5ZbEsKPqWJXD2Oom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262219; c=relaxed/simple;
	bh=wgCJTs1VZslq2YYJP4ej/kJCEFbfmncKm6H0uv+8gho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nv+lRoeqfD3mqeM8dvi9fNPL3o/uZD9AXXav0U54jYicDZY9Rj+jA25Gr8OuXR6X2ketKaDuJaJwbo1wFrJ0h+mMD1T3TyyjNtiAOXoE5g2NUTCyuiSlmeceoO5MMuMIaC+PbIdd/bt/Q8iMkl4RBOeSbwZb6asP+oE6H180ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uOr1PId/; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712262215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7niUODCqFPVcYJvNoQY8v4Gr7dz4gQ/jPwc/4w0vbY=;
	b=uOr1PId/e5DSx/qbiUVuhAHR0A0Scs06rKFT+j9vtILOqR6blsOAvbYU6NRImr+C4qmHMS
	y9nN+Ae9inLfxh2OXnJc69C+VWUIhlLYcFx+TzW72A9jo+M2AR85x/gt3lBH9d1gmVGw90
	DeT6EQwyQ9v9CGZWB2pSAntx2NtAX3k=
From: Luis Henriques <luis.henriques@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,  linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/4] e2fsck: update quota when deallocating a bad inode
In-Reply-To: <04E748F4-0CE8-4376-B9E7-F1798EE84F67@dilger.ca> (Andreas
	Dilger's message of "Thu, 4 Apr 2024 11:25:32 -0600")
References: <20240404111032.10427-1-luis.henriques@linux.dev>
	<20240404111032.10427-3-luis.henriques@linux.dev>
	<04E748F4-0CE8-4376-B9E7-F1798EE84F67@dilger.ca>
Date: Thu, 04 Apr 2024 21:23:31 +0100
Message-ID: <87bk6o6fng.fsf@camandro.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04 2024, Andreas Dilger wrote:

> On Apr 4, 2024, at 5:10 AM, Luis Henriques (SUSE) <luis.henriques@linux.dev> wrote:
>> 
>> If a bad inode is found it will be deallocated.  However, if the filesystem has
>> quota enabled, the quota information isn't being updated accordingly.  This
>> issue was detected by running fstest ext4/019.
>> 
>> This patch fixes the issue by decreasing the inode count from the
>> quota and, if blocks are also being released, also subtract them as well.
>> 
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>> e2fsck/pass2.c | 33 +++++++++++++++++++++++----------
>> 1 file changed, 23 insertions(+), 10 deletions(-)
>> 
>> diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
>> index b91628567a7f..e16b488af643 100644
>> --- a/e2fsck/pass2.c
>> +++ b/e2fsck/pass2.c
>> @@ -1859,12 +1859,13 @@ static int deallocate_inode_block(ext2_filsys fs,
>
> I'd hoped you might include a better comment for this function, but the code
> itself looks OK.

Ouch!  I totally forgot about that, sorry.  I'll send out v3 tomorrow.
And thanks for you reviews and suggestions.

Cheers,
-- 
Luis

> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>
>> static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
>> {
>> 	ext2_filsys fs = ctx->fs;
>> -	struct ext2_inode	inode;
>> +	struct ext2_inode_large	inode;
>> 	struct problem_context	pctx;
>> 	__u32			count;
>> 	struct del_block	del_block;
>> 
>> -	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
>> +	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
>> +			       sizeof(inode), "deallocate_inode");
>> 	clear_problem_context(&pctx);
>> 	pctx.ino = ino;
>> 
>> @@ -1874,29 +1875,29 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
>> 	e2fsck_read_bitmaps(ctx);
>> 	ext2fs_inode_alloc_stats2(fs, ino, -1, LINUX_S_ISDIR(inode.i_mode));
>> 
>> -	if (ext2fs_file_acl_block(fs, &inode) &&
>> +	if (ext2fs_file_acl_block(fs, EXT2_INODE(&inode)) &&
>> 	    ext2fs_has_feature_xattr(fs->super)) {
>> 		pctx.errcode = ext2fs_adjust_ea_refcount3(fs,
>> -				ext2fs_file_acl_block(fs, &inode),
>> +				ext2fs_file_acl_block(fs, EXT2_INODE(&inode)),
>> 				block_buf, -1, &count, ino);
>> 		if (pctx.errcode == EXT2_ET_BAD_EA_BLOCK_NUM) {
>> 			pctx.errcode = 0;
>> 			count = 1;
>> 		}
>> 		if (pctx.errcode) {
>> -			pctx.blk = ext2fs_file_acl_block(fs, &inode);
>> +			pctx.blk = ext2fs_file_acl_block(fs, EXT2_INODE(&inode));
>> 			fix_problem(ctx, PR_2_ADJ_EA_REFCOUNT, &pctx);
>> 			ctx->flags |= E2F_FLAG_ABORT;
>> 			return;
>> 		}
>> 		if (count == 0) {
>> 			ext2fs_block_alloc_stats2(fs,
>> -				  ext2fs_file_acl_block(fs, &inode), -1);
>> +				  ext2fs_file_acl_block(fs, EXT2_INODE(&inode)), -1);
>> 		}
>> -		ext2fs_file_acl_block_set(fs, &inode, 0);
>> +		ext2fs_file_acl_block_set(fs, EXT2_INODE(&inode), 0);
>> 	}
>> 
>> -	if (!ext2fs_inode_has_valid_blocks2(fs, &inode))
>> +	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode)))
>> 		goto clear_inode;
>> 
>> 	/* Inline data inodes don't have blocks to iterate */
>> @@ -1921,10 +1922,22 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
>> 		ctx->flags |= E2F_FLAG_ABORT;
>> 		return;
>> 	}
>> +
>> +	if ((ino != quota_type2inum(PRJQUOTA, fs->super)) &&
>> +	    (ino != fs->super->s_orphan_file_inum) &&
>> +	    (ino == EXT2_ROOT_INO || ino >= EXT2_FIRST_INODE(ctx->fs->super)) &&
>> +	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
>> +		if (del_block.num > 0)
>> +			quota_data_sub(ctx->qctx, &inode, ino,
>> +				       del_block.num * EXT2_CLUSTER_SIZE(fs->super));
>> +		quota_data_inodes(ctx->qctx, (struct ext2_inode_large *)&inode,
>> +				  ino, -1);
>> +	}
>> +
>> clear_inode:
>> 	/* Inode may have changed by block_iterate, so reread it */
>> -	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
>> -	e2fsck_clear_inode(ctx, ino, &inode, 0, "deallocate_inode");
>> +	e2fsck_read_inode(ctx, ino, EXT2_INODE(&inode), "deallocate_inode");
>> +	e2fsck_clear_inode(ctx, ino, EXT2_INODE(&inode), 0, "deallocate_inode");
>> }
>> 
>> /*
>
>
> Cheers, Andreas


Return-Path: <linux-ext4+bounces-1763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A072888F0BB
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 22:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C50E29B265
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C353914EC60;
	Wed, 27 Mar 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9i9qrxS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515614EC4F
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574225; cv=none; b=BMchwzW3Gm9+MCXvTcSzBgeMZaNi0vs+/IgDFA3ZjfqQVVmTjphnIaAXFHWLr6gsSLO74twx9laHNJLXh5Z7h95xZ9w6qMIpzDOf3IArf3kUXAoZHITJHSYSX6O0gbRpREiANXZdJByA2ziqSwkqHUnjgfm+UH+srZ+G/Vfzpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574225; c=relaxed/simple;
	bh=3q+1AxvS+noSwgyk8pLBIxhLIV/mwhcVnRv0xi3D6PY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IULHjYN0t6fgzax2kCrA+1wWQRcP0t3yEnLyCKQ1lK/l/U3g67QIA3vNkw12ZsnKtEqB82h6mZI+LilpDbQ176rP/1BIcoeIk27JqcFOAiNUYAJYo1LYo1eKOSa1yfIPTgzqJgRfsEB0KIYFDx3N6dRIpjUgtwm4LRvmZPQ2kjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9i9qrxS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711574218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ygUT90NuxAIWFIMTQp5Z3Z9Tf2NUmn39bdIZGaN3Q8=;
	b=f9i9qrxS81rj9EryWcA9y8RlGJFbC0wguah5sVwodLN3TdweBRhUMqJZqB5r9yKtAKmcoo
	BdLVaM+xRfUVwoqAUepwF4ZUDkxP7auT0azXh5Dozme4YBxOg1Uv71n/Igdm7blUxO7+gU
	0gmPPWK8OLSBWzO767wBIo4ndObCKmQ=
From: Luis Henriques <luis.henriques@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,  Ext4 Developers List
 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH e2fsprogs] e2fsck: update quota accounting after
 directory optimization
In-Reply-To: <F7E15565-D316-4F02-93D4-CC081AB421C0@dilger.ca> (Andreas
	Dilger's message of "Wed, 27 Mar 2024 13:25:49 -0600")
References: <20240327154352.22648-1-luis.henriques@linux.dev>
	<F7E15565-D316-4F02-93D4-CC081AB421C0@dilger.ca>
Date: Wed, 27 Mar 2024 21:16:55 +0000
Message-ID: <87wmpn74u0.fsf@camandro.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Andreas Dilger <adilger@dilger.ca> writes:

> On Mar 27, 2024, at 9:43 AM, Luis Henriques (SUSE) <luis.henriques@linux.dev> wrote:
>> 
>> In "Pass 3A: Optimizing directories", a directory may have it's size reduced.
>> If that happens and quota is enabled in the filesystem, the quota information
>> will be incorrect because it doesn't take the rehash into account.
>> 
>> This patch simply updates the quota data accordingly, after the directory is
>> written and it's size has been updated.
>
> Hi Luis,
> thanks for the patch.  It looks reasonable, and might (partially) explain
> why quota accounting occasionally reports inconsistencies by a few blocks
> after running e2fsck.  You can add my Reviewed-by: to the patch.

Awesome, thank you for your review.  In the meantime, I have already a
similar fix for another case where quota inconsistencies occur in e2fsck.
I'm still running a few more tests, but I should be sending another patch
soon.

> Could you please include an e2fsck regression test for this, to confirm
> that it is working and continues to work in the future?  It should be
> possible to use something like the following to create a test case:
>
>     # cd tests
>     # make testnew
>     # tune2fs -O quota,project f_testnew/image
>     # mkdir /mnt/tmp
>     # mount -t ext4 -o loop f_testnew/image /mnt/tmp
>     # mkdir /mnt/tmp/subdir
>     # chattr -p 1000 -P /mnt/tmp/subdir
>     # touch /mnt/tmp/subdir/long-filenames-for-test-{1..1024}
>     # rm /mnt/tmp/subdir/long-filenames-for-test-{1..1024..2}
>     # umount /mnt/tmp
>     # echo "directory optimization updates quota" > f_testnew/name
>     # make testend
>     # mv f_testnew f_quota_shrinkdir
>
> and confirm in expect.[12] that the quota did not need to be repaired
> afterward by e2fsck (i.e. there shouldn't be any error messages about
> inconsistent quota).  Running this test with an unpatched e2fsck should
> report that the quotas had to be fixed and the test should fail.

Right, it makes sense to add a regression test, of course.  I'll need to
get familiar with the framework used but I'll have a look and see what I
can come up with.

> On a related note, it would be convenient if "make testnew" passed an
> environment variable (e.g. $TESTNEW_OPTS) to mke2fs so more options
> could be set at format time instead of using tune2fs afterward:
>
>     # TESTNEW_OPTS="-O quota,project" make testnew
>
> It isn't a big deal in this case, but might be useful in the future.

Hmm... Okay, as I said I'll need to get familiar with this but that seems
to make sense.

Cheers,
-- 
Luis

> Cheers, Andreas
>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218626
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>> e2fsck/rehash.c | 27 +++++++++++++++++++++------
>> 1 file changed, 21 insertions(+), 6 deletions(-)
>> 
>> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
>> index c1da7d52724e..4847d172e5fe 100644
>> --- a/e2fsck/rehash.c
>> +++ b/e2fsck/rehash.c
>> @@ -987,14 +987,18 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
>> {
>> 	ext2_filsys 		fs = ctx->fs;
>> 	errcode_t		retval;
>> -	struct ext2_inode 	inode;
>> +	struct ext2_inode_large	inode;
>> 	char			*dir_buf = 0;
>> 	struct fill_dir_struct	fd = { NULL, NULL, 0, 0, 0, NULL,
>> 				       0, 0, 0, 0, 0, 0 };
>> 	struct out_dir		outdir = { 0, 0, 0, 0 };
>> -	struct name_cmp_ctx name_cmp_ctx = {0, NULL};
>> +	struct name_cmp_ctx	name_cmp_ctx = {0, NULL};
>> +	__u64			osize;
>> 
>> -	e2fsck_read_inode(ctx, ino, &inode, "rehash_dir");
>> +	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
>> +			       sizeof(inode), "rehash_dir");
>> +
>> +	osize = EXT2_I_SIZE(&inode);
>> 
>> 	if (ext2fs_has_feature_inline_data(fs->super) &&
>> 	   (inode.i_flags & EXT4_INLINE_DATA_FL))
>> @@ -1013,7 +1017,7 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
>> 	fd.ino = ino;
>> 	fd.ctx = ctx;
>> 	fd.buf = dir_buf;
>> -	fd.inode = &inode;
>> +	fd.inode = EXT2_INODE(&inode);
>> 	fd.dir = ino;
>> 	if (!ext2fs_has_feature_dir_index(fs->super) ||
>> 	    (inode.i_size / fs->blocksize) < 2)
>> @@ -1092,14 +1096,25 @@ resort:
>> 			goto errout;
>> 	}
>> 
>> -	retval = write_directory(ctx, fs, &outdir, ino, &inode, fd.compress);
>> +	retval = write_directory(ctx, fs, &outdir, ino, EXT2_INODE(&inode),
>> +				 fd.compress);
>> 	if (retval)
>> 		goto errout;
>> 
>> +	if ((osize > EXT2_I_SIZE(&inode)) &&
>> +	    (ino != quota_type2inum(PRJQUOTA, fs->super)) &&
>> +	    (ino != fs->super->s_orphan_file_inum) &&
>> +	    (ino == EXT2_ROOT_INO || ino >= EXT2_FIRST_INODE(ctx->fs->super)) &&
>> +	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
>> +		quota_data_sub(ctx->qctx, &inode,
>> +			       ino, osize - EXT2_I_SIZE(&inode));
>> +	}
>> +
>> 	if (ctx->options & E2F_OPT_CONVERT_BMAP)
>> 		retval = e2fsck_rebuild_extents_later(ctx, ino);
>> 	else
>> -		retval = e2fsck_check_rebuild_extents(ctx, ino, &inode, pctx);
>> +		retval = e2fsck_check_rebuild_extents(ctx, ino,
>> +						      EXT2_INODE(&inode), pctx);
>> errout:
>> 	ext2fs_free_mem(&dir_buf);
>> 	ext2fs_free_mem(&fd.harray);
>> 
>
>
> Cheers, Andreas


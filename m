Return-Path: <linux-ext4+bounces-9095-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B91B09906
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 03:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A51E4A782D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 01:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09AB42058;
	Fri, 18 Jul 2025 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="G3RCeyHQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71D2A1CF
	for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752800738; cv=none; b=JIhRTP4vXOTDTNSopeO1IsdNopDmGY5R8D6HJU3mO/gXwumK6LEnbAmXoAyrWasPkFnsQd9waYVlk+lYK/C4XDPJojgScMtjlVYearsQuulCkChigvDxPr4mFGqZiPOphvzNk12S5UpSAExSsWdO+DFq/Zf9dJ5kn/ECiaFsV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752800738; c=relaxed/simple;
	bh=XOrlqtqrDX/2HGjlVR4wdMWUi738RFOWWukkfL1LH3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG1TzeAF2QFgbLxSqtBbkCLt/sMn/HlF4uhS+BChg8RrjU6m2ERMWVv62pOxbq2+Eda2tF2iMoAMrpiZ0T5vcm5LFKWA+RdyQpJY2io8DVxec8a7UDZLpGff/3caXNxn3mHCPw7rcaryu//LEM8gODq18Anql7TTHeFyEqGRYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=G3RCeyHQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56I15LnL015966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 21:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752800724; bh=47MrvFVIL5gfquO0TuUwWAIK+sNLLvE+ehK38vF6nHU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=G3RCeyHQjLKBOadQ9r+lAWFneQuzh9IPGwMcsmVilGMsRgDAQbeV1IaM0EDVCXTwQ
	 f4qGjUQ/WUGQEsZyNZbWUnCuXxyab8IBnxtW9/MpDiYoXXeyihB0bnfEGpjEJJiTUo
	 HzY2pX/sQqYwUS3o6bm5AXGq8/w5Xn7mdAAdEcKv0PSmioxM6dA+ib6XJEaofJmYHe
	 CRh1QhyIFgXNsZxw88zeHXuEOc53EWfvh86Kh4GRrKP8Oe/dIf6rLFqCo03uuDUi4R
	 5BMLUGZYy0Uu1zxd0P1aUiK5tmvxEC6+bU3aYD+mrsMR2sp6Byd6c+cWn1ajVOjsKP
	 FTebFHj+ortxw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 176282E00D5; Thu, 17 Jul 2025 21:05:21 -0400 (EDT)
Date: Thu, 17 Jul 2025 21:05:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data
 xattr
Message-ID: <20250718010521.GC112967@mit.edu>
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
 <20250717145911.GB112967@mit.edu>
 <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>

On Thu, Jul 17, 2025 at 09:59:13AM -0700, Moon Hee Lee wrote:
> The current patch addresses ext4_update_inline_data() directly, but the
> same condition also leads to a BUG_ON in ext4_create_inline_data() [2],
> which the earlier approach intended to prevent as well.

Actually, the two conditions are opposite to each other.  The one in
ext4_update_inline_data() was:

         BUG_ON(is.s.not_found);

while te one in ext4_create_inline_data() was:

	BUG_ON(!is.s.not_found);

So your patch would not only cause an extra xattr lookup in
ext4_prepare_inline_data(), but it would actually cause problems by
causing spurious failures when first writing to an inline data file.
(Which makes me suspect that you hadn't run other test on your patich
other than just vaidating that the syzkaller reproduce was no longer
reproducing.)   

Also, having taking a closer look at te code paths, I became
suspicious that there is something about the syzkaller reproducer is
doing which might be a bit sus.  That's because whether we call
ext4_update_inline_data() or ext4_create_inline_data() is based on
whether i_inline off is set or not:

	if (ei->i_inline_off)
		ret = ext4_update_inline_data(handle, inode, len);
	else
		ret = ext4_create_inline_data(handle, inode, len);


But how is ei->i_inline_off set?  It's set from a former call to
ext4_xattr_ibody_find():

	error = ext4_xattr_ibody_find(inode, &i, &is);
	if (error)
		goto out;

	if (!is.s.not_found) {
		if (is.s.here->e_value_inum) {
			EXT4_ERROR_INODE(inode, "inline data xattr refers "
					 "to an external xattr inode");
			error = -EFSCORRUPTED;
			goto out;
		}
		EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
					(void *)ext4_raw_inode(&is.iloc));
		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
				le32_to_cpu(is.s.here->e_value_size);
	}

So the whole *reason* why i_inline_off exists is because we're caching
the result of calling ext4_xattr_ibody_find().  So if i_inline_off is
non-zero, and then when we call ext4_ibody_find() later on, and we
find that xattr has suddenly disappeared, there is something weird
going on.   That's why the BUG_ON was added orginally.

When I took a look at the reproduer, I found that indeed, it is
calling LOOP_CLR_FD and LOOP_SET_STATUS64 to reconfigure the loop
device out from under the mounted file system.  This is smashing the
file system, and is therefore corrupting the block device.  As it
turns out, Jan Kara recently sent out a patch, and it has been
accepted in the block tree, to prevent a similar Syzkaller issue using
LOOP_SET_BLOCK_SIZE[1].

[1] https://lore.kernel.org/r/20250711163202.19623-2-jack@suse.cz

We need to do something similar for LOOP_CLR_FD, LOOP_SET_STATUS,
LOOP_SET_STATUS64, LOOP_CHANGE_FD, and LOOP_SET_CAPACITY ioctls.

Cheers,

						- Ted


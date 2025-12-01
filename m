Return-Path: <linux-ext4+bounces-12115-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84830C9995A
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 00:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40F67345E0F
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 23:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1129D281;
	Mon,  1 Dec 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtsnt20a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2829C343;
	Mon,  1 Dec 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631553; cv=none; b=VxMU1J9Bsjt/6FVW+2ciANAQ5XY3vD1r6fr8uoObTOydW4JtSP2+vL86ar2hgHpkOArC+7G9BiZ1XhoxPz6DBjFtRaaNatSVQsE+NmxoN96WtV0SIgVACi4ytPN4+XosIotR8CAe33mXf2wodOKRl8VhUmmVVQwk/aO7Nh+dngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631553; c=relaxed/simple;
	bh=xGkROoIvoUcJWUknA264dG6FlmozswxekDwDGbxLWJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1Lk+65ZFmU9/+8KjvAMNe6FatD3fja3AhHNfb/nNfpoXaTObqaSr3z6J/esGhzaBT35HI2o3NcH+sEniUzK+te3usH0GHQAyYcFoMF19Ad6aggHNklKdN1ChSk1k+MsJ6vy6kTMgyyUXqOSS5bh1WSebgIxcd9WbTtqZI7cCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtsnt20a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FDEC4CEF1;
	Mon,  1 Dec 2025 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764631553;
	bh=xGkROoIvoUcJWUknA264dG6FlmozswxekDwDGbxLWJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gtsnt20a4uTHdyFHBCwsW8q8+HV1Uy2jSROfwK9FOxrdv49KqwtEyxpPl0L6MeTF9
	 S41PxS3AJvv06gnnTs7aHCWU9Wz9r3NhPuC3FlWo7UW7+kxMS974Lsccj5pGJClMSa
	 DqElBYqy9sGkxxckrLUYtZ+V0/HHe0hBtTw3SBPvW1rtvSKxsFG9en0VCCEJPKN5W0
	 K089JoqGXtqMUeesiz+h1ONJBdEXzQcDPeohopKRFdQOGyVdgQuce+sX0jO7gBWYMK
	 tzFZRsPUKR2mA2DItjWYCcmSdjBFNRDSX3hL6CuJT6AfZs8ZOfzZE4VE0EXnsrNrE3
	 1TA/bVvo6KKVQ==
Date: Mon, 1 Dec 2025 15:25:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Tso <tytso@mit.edu>,
	syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data
 (2)
Message-ID: <20251201232552.GA89435@frogsfrogsfrogs>
References: <690bcad7.050a0220.baf87.0076.GAE@google.com>
 <20251201161648.GA52186@macsyma.lan>
 <2ED9BD8E-9A4D-4800-8633-9FEAD464049D@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ED9BD8E-9A4D-4800-8633-9FEAD464049D@dilger.ca>

On Mon, Dec 01, 2025 at 04:17:02PM -0700, Andreas Dilger wrote:
> On Dec 1, 2025, at 9:16 AM, Theodore Tso <tytso@mit.edu> wrote:
> > 
> > That being said, we probably should just not try to expand the inode's
> > extra size while evicting the inode.  In practice we don't actually do
> > this since we haven't expanded the inode's extra size space in over a
> > decade, and so this only happens in a debugging mount option that
> > syzbot helpfully uses, and not in real life.
> 
> I think we would regret removing this if/when we *do* expand the inode
> size.  We used this functionality to upgrade filesystems online when
> i_projid was first added and users suddenly wanted to use project quotas.
> If we need some new inode field in the future it will be good to have it.

Or expand extra_isize only when someone tries to set an inode field that
actually requires it?  e.g. whenever setting the project id?

--D

> > Also, there's no real point in doing this on the evict path,
> > especially if the inode is about to be released as part of the
> > eviction.
> 
> This could check in ext4_orphan_cleanup()->ext4_evict_inode() path
> that this is orphan cleanup with EXT4_ORPHAN_FS and skip the expansion?
> As you write, it doesn't make sense to do that when the file is being
> deleted anyway.  Something like the following, which adds unlikely() to
> that branch since it may happen only once or never in the lifetime of
> any inode:
> 
> Cheers, Andreas
> ---
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..ae48748decc5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6481,7 +6490,8 @@ int __ext4_mark_inode_dirty(handle_t *handle,
>  	if (err)
>  		goto out;
> -	if (EXT4_I(inode)->i_extra_isize < sbi->s_want_extra_isize)
> +	if (unlikely(EXT4_I(inode)->i_extra_isize < sbi->s_want_extra_isize &&
> +		     !(sbi->s_mount_state & EXT4_ORPHAN_FS)))
>  		ext4_try_to_expand_extra_isize(inode, sbi->s_want_extra_isize,
>  					       iloc, handle);
> 
> 
> 
> 
> 
> 


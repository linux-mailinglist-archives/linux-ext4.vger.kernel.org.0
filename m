Return-Path: <linux-ext4+bounces-6356-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F7A2AD3D
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 17:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68F2162B22
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E01624E6;
	Thu,  6 Feb 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsukXNTG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96511F416F
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857895; cv=none; b=Kn7aTLnWiG1r0JlK9cIMNdyETgdMY70lpUpI9Z9L93pTc+YFxTCUIQvI0e1FCFIGcRmZa2O6MVkxxr5xgMmY+LXel4kM0xZzHzA42tY52pMKqjjA35l3doe3K3z+/al3dwSji104vUb8RsFr65YTAMfYO2n9kF0MNQ4H8Mci7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857895; c=relaxed/simple;
	bh=dcntmDEEiQRaOf3eMvDYYnAPy+CB/XwjKn/AZeVav4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCvP7GY+HY3w0N2a93r0UZZrpJ4dS079MmmOD20Tjc9IvozX1SgiwtO8QIpg3/BPbZCP21cAPOq4HknVjB+l+sx3HoEPEUylIC4uCmuTnbmfAmP5WmYE7otvavm0V2EEUveA26cZyHqO5qEkA5O0YrONl9188n0ZxkUlS9kth40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsukXNTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3767FC4CEDD;
	Thu,  6 Feb 2025 16:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857895;
	bh=dcntmDEEiQRaOf3eMvDYYnAPy+CB/XwjKn/AZeVav4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsukXNTGGc1hyU+gKJRwgiftaDavKjFRrdjwbayijkORJuD89hxtXSXEZvfAqyX+6
	 g8yCkbaKc+FHfOOL5r5uhTcYfiHgVrOEi6l3dxgNsS3BdElNltF/w0bTk5pf8t549C
	 VJ38pvuce+jpzT/epRjwOShPkXJAMiD2vhp1nxhY6qE6DhIrOKC7Wb5+dUKUuoe44b
	 +LSuGBtzcuVy/atCEvYTkorpL3vLbU/1E9ggaS3m8gM9aUD9kuh2KcRoR05nh4y7Ht
	 gu1YAD11a0xmGZBfWZOgY2YxzzTeLoGNatwhsATA0LbpWvshjA9BYUQlLiH5M006Ax
	 Urf4sRrz8oAhw==
Date: Thu, 6 Feb 2025 08:04:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: Verify fast symlink length
Message-ID: <20250206160453.GA4283@sol.localdomain>
References: <20250206094454.20522-2-jack@suse.cz>
 <20250206152419.GB1130956@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206152419.GB1130956@mit.edu>

On Thu, Feb 06, 2025 at 10:24:19AM -0500, Theodore Ts'o wrote:
> On Thu, Feb 06, 2025 at 10:44:55AM +0100, Jan Kara wrote:
> > Verify fast symlink length stored in inode->i_size matches the string
> > stored in the inode to avoid surprises from corrupted filesystems.
> > 
> > Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > Tested-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> > Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 7c54ae5fcbd4..64e280fed911 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> >  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
> >  		} else if (ext4_inode_is_fast_symlink(inode)) {
> >  			inode->i_op = &ext4_fast_symlink_inode_operations;
> > -			nd_terminate_link(ei->i_data, inode->i_size,
> > -				sizeof(ei->i_data) - 1);
> > +			if (inode->i_size == 0 ||
> > +			    inode->i_size >= sizeof(ei->i_data) ||
> > +			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> > +								inode->i_size) {
> > +				ext4_error_inode(inode, function, line, 0,
> > +					"invalid fast symlink length %llu",
> > +					 (unsigned long long)inode->i_size);
> > +				ret = -EFSCORRUPTED;
> > +				goto bad_inode;
> > +			}
> >  			inode_set_cached_link(inode, (char *)ei->i_data,
> >  					      inode->i_size);
> 
> 
> I don't think this will do the right thing if the fast symlink is
> encrypted.  See ext4_encrypted_get_link() in fs/ext4/symlink.c in the
> kernel sources, and also look at how e2fsck_pass1_check_symlink()
> handles checking the size of an encrypted, fast symlink.
> 

Encrypted symlinks are handled separately just a couple lines above.

- Eric


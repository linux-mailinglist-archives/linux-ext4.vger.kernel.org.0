Return-Path: <linux-ext4+bounces-6667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493CA4ED87
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80425171572
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370425F794;
	Tue,  4 Mar 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcfNCucj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8A23643E
	for <linux-ext4@vger.kernel.org>; Tue,  4 Mar 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116887; cv=none; b=mU9ZLy7qmAJb97FzA5m1LispC6RuNuuAs85QlCGz98i08bHpfnXsnzTj3+1ZYsg7216mmjSPCh8EWG8pstWHERU5Ej5BJCplk1fLWQjfZG3H9PpNisp3QVTk71MoyzKH9ut2l+lysst704fBUEBLGG4o8gnxEiCUZ9ca/15E6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116887; c=relaxed/simple;
	bh=8BhI20oBB4dyuQStmc++X6OL1FO3pcPkN4U/oMeSut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn8HHa0peEGo1epOX1Xtl6e4vGbbNkdQPGEFDw5NLYv/RboA3ZXwnoCTEjpWfGNTLJmfVolOxtzpjTi0kMrzXyISe9/T1uv//jmCqYwcc5p2SU9hE4Ws87UiI0/lHtMzRccLXQEGmBmWr3ur2Q3ZWmi/VgCviX72WldAYB2cU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcfNCucj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551E5C4CEE5;
	Tue,  4 Mar 2025 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741116887;
	bh=8BhI20oBB4dyuQStmc++X6OL1FO3pcPkN4U/oMeSut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcfNCucjaWQFDZyzD/aGko7YrtGmPCTfh+YBiw2GDt8rQ+KExUO8nSR7PntPBcADb
	 p3zr9HUHUHNDPw+WcCvMbVSHUerof0y8pJ1Lv5XB8KKmR6E67bl1kZ8k2zxmdBZn0c
	 o2dA87PyUZuGwt6N24mnGBBX4auAsaPcG/PNTUPK/0/VL6cJLFCqvUl2yVvdHj6b/r
	 Se0ULrlJ96UNgGLEPRhU8VRBBNg0iNs/iYlWcFz86lKC290qZVT2ZakUOfngBp+wd/
	 AJ2f+TJwwuJd8k64Xb+TFnSl3VTyXDIEbx+SxPETXdAVNUBbCqGBsEraxlzaQi1zG8
	 DEv5Pb6cXpKsA==
Date: Tue, 4 Mar 2025 11:34:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] debugfs: byteswap dirsearch dirent buf on big endian
 systems
Message-ID: <20250304193446.GA2803723@frogsfrogsfrogs>
References: <20250123135211.575895-1-bfoster@redhat.com>
 <Z8X-USvFA-ofGrHQ@bfoster>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8X-USvFA-ofGrHQ@bfoster>

On Mon, Mar 03, 2025 at 02:09:05PM -0500, Brian Foster wrote:
> On Thu, Jan 23, 2025 at 08:52:11AM -0500, Brian Foster wrote:
> > fstests test ext4/048 fails on big endian systems due to broken
> > debugfs dirsearch functionality. On an s390x system and 4k block
> > size, the dirsearch command seems to hang indefinitely. On the same
> > system with a 1k block size, the command fails to locate an existing
> > entry and causes the test to fail due to unexpected results.
> > 
> > The cause of the dirsearch failure is lack of byte swapping of the
> > on-disk (little endian) dirent buffer before attempting to iterate
> > entries in the given block. This leads to garbage record and name
> > length values, for example. To resolve this problem, byte swap the
> > directory buffer on big endian systems.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Hi all,
> > 
> > I'm not terribly familiar with this code, but this fixes the test and
> > doesn't show any regressions from fstests runs on big or little endian
> > systems. Thanks.
> > 
> 
> Ping... curious if anybody has thoughts on this for dirsearch on big
> endian? Thanks!

It looks correct to /me/... horrors of debugfs, etc. :(

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Brian
> 
> > Brian
> > 
> >  debugfs/htree.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/debugfs/htree.c b/debugfs/htree.c
> > index a1008150..4ea8f30b 100644
> > --- a/debugfs/htree.c
> > +++ b/debugfs/htree.c
> > @@ -482,6 +482,12 @@ static int search_dir_block(ext2_filsys fs, blk64_t *blocknr,
> >  		return BLOCK_ABORT;
> >  	}
> >  
> > +#ifdef WORDS_BIGENDIAN
> > +	errcode = ext2fs_dirent_swab_in(fs, p->buf, 0);
> > +	if (errcode)
> > +		return BLOCK_ABORT;
> > +#endif
> > +
> >  	while (offset < fs->blocksize) {
> >  		dirent = (struct ext2_dir_entry *) (p->buf + offset);
> >  		errcode = ext2fs_get_rec_len(fs, dirent, &rec_len);
> > -- 
> > 2.47.1
> > 
> > 
> 
> 


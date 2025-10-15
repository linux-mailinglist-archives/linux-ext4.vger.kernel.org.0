Return-Path: <linux-ext4+bounces-10886-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56701BE0D4E
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06C804E687D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601D2FFDDC;
	Wed, 15 Oct 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3M2nxyf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577C2D3220
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564429; cv=none; b=d3PiHk0oY57ZHHEr/5SbVLPD/ygur3d1TRkNjmcIYH3Hhtw09ymlzoWiu7GPIPe93Wj/yDsrPkNJa6GxOvAEDnP9yr1Km/R27rCMi7wFk+7AzuOfce9JKhlpAVwWkGEr3FdZD4cpjh+EuHHeWPXyd7hg9YXPAPmBtq3I00EamDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564429; c=relaxed/simple;
	bh=MjmM2nao1xSprOo/wXi1fdMsaWQH6yUtYap+xyDpI78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcGXYKaxVuV9b+fhgSweDP93tQr2to7vFWTm5qMvKLwo/Z9eOs5vJGnQRpN1qqZs7/C+nII7HyWgunt6yGER7h5EPzr7nsg/8Ag9UdmQ2F6uSznONBQy5KHHlYsRgWC9so7Lpfv1zu2VTp4DkYvmYgusUgmT/enha2gxSSGtjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3M2nxyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D447FC4CEF8;
	Wed, 15 Oct 2025 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760564428;
	bh=MjmM2nao1xSprOo/wXi1fdMsaWQH6yUtYap+xyDpI78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3M2nxyfid1IpgVQlipZ/NtZFkrk9qIzEfiNKkdGqHr0ZDy7T6TzM4d/DPrWKFXwB
	 le/5SQVVVc6H2AqnFic5kZ7ZyOcWGXgWoL0P9Bjf9HnF/xvHgwp1yKBYtYxcMUdCdz
	 4W2uVauiwLLajWMA6CtlCfAtjzJCFSF3mmgmZeOKNVXshU425AigifFNKmBE2ziV9E
	 w/Ekc9ueKGqe+NlmO9IP6zbVyfHXYr91BExR4CbPwHoDC1/0vsB/yQH4njOZrzI/Tg
	 P7k5obvHqaQ9fVmPBJoBtsJLRjP3VNUbqqIo1DF1cOj5bintfZGL+//fiRKAnaxR2P
	 fNT+Wue0urqdg==
Date: Wed, 15 Oct 2025 14:40:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dwd@cern.ch>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: reopen filesystem read-write for read-only
 journal recovery
Message-ID: <20251015214028.GE6170@frogsfrogsfrogs>
References: <20251010214735.22683-1-dave.dykstra@cern.ch>
 <20251015011505.GD6170@frogsfrogsfrogs>
 <aO--1J4bOVMYgbBt@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO--1J4bOVMYgbBt@cern.ch>

On Wed, Oct 15, 2025 at 10:33:40AM -0500, Dave Dykstra wrote:
> On Tue, Oct 14, 2025 at 06:15:05PM -0700, Darrick J. Wong wrote:
> > On Fri, Oct 10, 2025 at 04:47:35PM -0500, Dave Dykstra wrote:
> > > This changes the strategy added in c7f2688540d95e7f2cbcd178f8ff62ebe079faf7
> > > for recovery of journals when read-only is requested.
> ...
> > ro and EXT2_FLAG_RW are not the same thing!
> 
> I understand that.
> 
> ...
> > I don't like this, because we should open the filesystem with
> > EXT2_FLAG_RW set by default and only downgrade to !EXT2_FLAG_RW if we
> > can't open it...
> 
> I was following the suggestion of tytso at
>     https://github.com/tytso/e2fsprogs/issues/244#issuecomment-3390084495
> 
> However, I think your suggestion might be better.  I will try that.

Urrrrrgh, external conversations that need to be on the mailing list.
Already covered here:
https://lore.kernel.org/linux-ext4/175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs/

> ...
> 
> > ...if the close fails, you just leaked the old global_fs context.
> > ext2fs_close_free is what you want (and yes that's a bug in fuse2fs).
> 
> Ok, thanks, I'll use that.
> 
> ...
> > ...and also, if you re-do ext2fs_open2(), you then have to re-check all
> > the feature support bits above because we unlocked the filesystem
> > device, which means its contents could have been replaced completely
> > in the interim.
> 
> I'm not convinced that's something to worry about, but in any case
> your suggestion of only opening ro if rw fails should avoid it.

...and then in the pile of patches I break up all the stuff in main() so
that there's one fuse2fs_open() routine, after which the fs context
doesn't change and the fd stays open:
https://lore.kernel.org/linux-ext4/175798064597.349841.13113367506205034632.stgit@frogsfrogsfrogs/

> > Also note that I have a /very large/ pile of fuse2fs improvements and
> > rewrites and cleanups that are out for review on the list; you might
> > want to look at those first.
> 
> I do appreciate your efforts.  Unfortunately I have too many other
> priorities to have enough bandwidth to take on general responsibility
> for reviewing fuse2fs patches.  I also don't have much experience with
> filesystems.  I'm only trying to help here because it is impacting a

This exact mentality is why filesystem development has become very
frustrating...

> case that I support.  I was very happy when I found that the fuse2fs in
> v1.47.3 of e2fsprogs fixed another user-reported problem, but the new
> version ended up causing a couple of new problems.

...though I'm not blaming you (or any other user for that matter),
just venting about the development community. :(

Are there other problems I should know about?

> Having said that, if there are particular patches that you think are
> important bug fixes that you would like to call my attention to, please
> send me a direct message. I could test them and respond.

They're all just waiting for Ted to put out the last 1.47.x release and
open up 1.48 development.

--D

> Dave
> 


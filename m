Return-Path: <linux-ext4+bounces-1112-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707A849F86
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079C4B243F0
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691532E636;
	Mon,  5 Feb 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvSGc/3D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8AB3FB37;
	Mon,  5 Feb 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150758; cv=none; b=HP1NgFoPnZMEVJhfCFnOsvbApkK0wtQ+oLllBGiKmAT52LntBDzRKgltah7KcBNZnDMKsiXFUOmo7JR8aWP2ulxkzRKf2ljUxmk78E0xFLHmvMol9eZK+ACyh04lYbpQLbG/6LX9KTGRxuDldwZ5tu4ZKnXMYLqJQ8byGPhuvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150758; c=relaxed/simple;
	bh=UENOyErWeXOKGzE/txIIQKgGGewal06VF9cF2c3y61U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGl1jjI3KujxQFknUjhXlVIG23oiKmvjnUSv8vQbG8Haxd7hrMfDd39ufWkb5p86SttaBIF4+rv2hFna/GsGvXt6J8mSvz9VbrnHjJHXhSracXgsSFR8NPsdSy1I/ofOY6vMalPbB/Z1E2SLS8ieKS619LM6i2edZSJds936ICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvSGc/3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C29C433C7;
	Mon,  5 Feb 2024 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707150757;
	bh=UENOyErWeXOKGzE/txIIQKgGGewal06VF9cF2c3y61U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvSGc/3Dlfv0kiw+lX4rntbpb9Y/BTbqFQg+Hz/RYVyIZOvHx0mU9OvmPoMl5Qyjp
	 GDVaLC29Z8GFDl8GvbyNEX5xthITMTnHpGGxD1z3xDHu79x+cVrHYA5NDVNLX9q0y9
	 nI9H82cXeVyGGyfMieWS4WJv43OmgiZia19fgTTVZ5YURus4Ps2arkqwbDXVlhbo86
	 uWvfeGUiYScS2EGXnF2cEO1X5gDn5HY4jfn/iFDEwVeciyIs2HCcsyRRbDRiZABxJF
	 4zSfGPHcPhfG45HB28xSJxsWvpc89z2FuR7z1GndU1MjwWGD7zgVo4eKXcFLN+DdvQ
	 AvFvWPJuwSQ6w==
Date: Mon, 5 Feb 2024 08:32:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Whitney <enwlinux@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/459: don't run on non-journaled ext4 file systems
Message-ID: <20240205163236.GH6188@frogsfrogsfrogs>
References: <20240124195306.1177737-1-enwlinux@gmail.com>
 <20240202131529.jn5z64qfm5r5ibte@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Zb09Jy8KyxoBAnEN@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb09Jy8KyxoBAnEN@debian-BULLSEYE-live-builder-AMD64>

On Fri, Feb 02, 2024 at 02:06:15PM -0500, Eric Whitney wrote:
> * Zorro Lang <zlang@redhat.com>:
> > On Wed, Jan 24, 2024 at 02:53:06PM -0500, Eric Whitney wrote:
> > > generic/459 fails when run on an ext4 file system created without a
> > > journal or when its journal has not been loaded at mount time.
> > > 
> > > The test expects that a file system that it has been unable to freeze
> > > will be automatically remounted read only.  However, the default error
> > > handling policy for ext4 is to continue when possible after errors.
> > > 
> > > A workaround was added to the test in the past to force ext4 to
> > > perform a read only remount in order to meet the test's expectations.
> > > The touch command was used to create a new file after a freeze failure.
> > > This forces ext4 to start a new journal transaction, where it discovers
> > > the journal has previously aborted due to lack of space, and triggers
> > > special case error handling that results in a read only remount.
> > > 
> > > The workaround requires a journal.  Since ext4 is behaving as designed,
> > > prevent the test from running if there isn't one.
> > > 
> > > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > > ---
> > >  tests/generic/459 | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/tests/generic/459 b/tests/generic/459
> > > index c3f0b2b0..63fbbc9b 100755
> > > --- a/tests/generic/459
> > > +++ b/tests/generic/459
> > > @@ -49,6 +49,11 @@ _require_command "$THIN_CHECK_PROG" thin_check
> > >  _require_freeze
> > >  _require_odirect
> > >  
> > > +# non-journaled ext4 won't remount read only after freeze failure
> > > +if [ "$FSTYP" == "ext4" ]; then
> > > +	_require_metadata_journaling
> > 
> > I'm wondering ... won't other fs need this, besides ext4?
> 
> Thanks for looking at this patch.
> 
> I'd been mainly concerned with ext4, but since you mention it, ext2 and ext3
> ought to be added as well, since the failure behavior is similar.
> 
> The check for metadata journaling is limited to just ext4 here because the
> commit history for this test appears to suggest the touch command workaround
> is specific to ext4.  Perhaps the test should unconditionally require metadata
> journaling for all file system types, but given that I don't work with many
> other file systems I was uncomfortable asserting that in this patch.  If
> freezing any file system requires a metadata journal, then it would make
> sense to do that.
> 
> Your thoughts?

ext2 never had journalling, so requiring metadata journalling
effectively _notruns this test.

I don't think there's any harm done if you shortcut
"if [[ $FSTYP == ext* ]];..." to stop this test on ext2 and ext3-nojournal
as well.

That said, the exact behavior of filesystems during freeze is undefined,
so I think the only option is whackamole _notrun-listing. :/

--D

> Eric
> 
> > 
> > > +fi
> > > +
> > >  vgname=vg_$seq
> > >  lvname=lv_$seq
> > >  poolname=pool_$seq
> > > -- 
> > > 2.30.2
> > > 
> > > 
> > 
> 


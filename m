Return-Path: <linux-ext4+bounces-751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA146827EA6
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 07:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32929B2359D
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 06:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D96126;
	Tue,  9 Jan 2024 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2e8Hem"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A02912
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 06:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9B4C433C7;
	Tue,  9 Jan 2024 06:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704780390;
	bh=619njkWZZHs7dl0km2GnprIcwYPpHCHveMypigUGLhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJ2e8HemTEMEy08B/rNC0TQ/9+LY6EIzsUR21sNw1Mr+CXcytzQipD3K2akDQaC0Y
	 TP/LLEUR3XVyMV4ePvY7Ih69S9EEpvLaTcXXTiUwG733Wp/N01CUihAkEbiajz79mL
	 SCXhMaFGvNpCP7lQLP0tDJu5l+t0e0R10WZ4jMl3Ce/jDl3Sfa0xsDu/apth8ZesFV
	 Po2FqiNQksRiu6tinvpeXtOsZpsjLXxfOQ3KWzk2fTMuRoab+8/2/iG8aKok2Bh3PF
	 j1FkvMFJEC6RrVD5EQG49nh8XX7+/8aW3VVtM1cvV6CtmdQmTXyhvkoWVfTDX2HF7H
	 LRynrPalOAm7w==
Date: Mon, 8 Jan 2024 22:06:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-ext4@vger.kernel.org
Subject: Re: e2scrub finds corruption immediately after mounting
Message-ID: <20240109060629.GA722946@frogsfrogsfrogs>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
 <20240104045540.GD36164@frogsfrogsfrogs>
 <cf4fb33f3a60629d3b6108c1c206aa5b931d8498.camel@interlinx.bc.ca>
 <01b2c55a334cf970e49958a5f932d5822bfa74b4.camel@interlinx.bc.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01b2c55a334cf970e49958a5f932d5822bfa74b4.camel@interlinx.bc.ca>

On Mon, Jan 08, 2024 at 07:52:33AM -0500, Brian J. Murrell wrote:
> On Thu, 2024-01-04 at 09:13 -0500, Brian J. Murrell wrote:
> > On Wed, 2024-01-03 at 20:55 -0800, Darrick J. Wong wrote:
> > > Curious.  Normally e2scrub will run e2fsck twice: Once in journal-
> > > only
> > > preen mode to replay the journal, then again with -fy to perform
> > > the
> > > full filesystem (snapshot) check.
> > 
> > It is doing that.  I suspect the first e2fsck is silent.
> > 
> > > I wonder if you would paste the output of
> > > "bash -x e2scrub /dev/rootvol_tmp/almalinux8_opt" here?  I'd be
> > > curious
> > > to see what the command flow is.
> > 
> > Sure.
> 
> Was the bash -x output useful in any way, or was any of the information
> I supplied in my other replies on this list:
> 
> https://lore.kernel.org/linux-ext4/51aa3ceea05945c9f28e884bc2f43a249ef7e23e.camel@interlinx.bc.ca/
> https://lore.kernel.org/linux-ext4/be5e8488f8484194889216603d2aba2812c6adcb.camel@interlinx.bc.ca/
> 
> useful including the test of 1.47.0 being able to reproduce the
> behaviour?

It was good and bad -- good in that it eliminated all of my hypotheses
about what could be causing it; and bad in that now I have no idea.

*Something* is causing the e2fsck exit code to be nonzero, but there's
nothing identifying what did that in the stdout/stderr dump.

> Any thoughts on how to proceed?

If you're willing to share a metadata dump of the filesystem, injecting:

e2image -Q "${snap_dev}" /tmp/disk.qcow2

right before the second e2fsck invocation in check() might help us get a
reproducer going.  Please compress the qcow2 file before uploading it
somewhere.

--D

> Cheers,
> b.
> 




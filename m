Return-Path: <linux-ext4+bounces-12951-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EDD38C5E
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 05:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5201D302AACC
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649A299944;
	Sat, 17 Jan 2026 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPH7V6cC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541635959
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625345; cv=none; b=O6IGNaiHhYvitoh8UwI9N/6maK6nGNoxj+EtPXtl+ZQedJSAIg38e9OU/FpT2H+nR0/mY842aeGJnT5/qfyelAdE5MROnkvuJb0juzMl4k0Rh0iAWK4EtPmWM3E/ElEUPgVECtkD4J6ugEJsHYNHYsCUsZMyxN1EWED5lr4eH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625345; c=relaxed/simple;
	bh=fu2GpRXxzkKF4g5HmkbZkKdczwng/fsxsldTeBLkuss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDLFhzQCbRIsAAEMRBn54xQmJ2J5j94tdIVGRxbMXteNCoSqxjN8B5/c7tYaVBgaKpBmwf49HC0/o2xNx/30Oz8nTaZZ43PuKJ4cY8vRImhGO/x0hph1fc4PaqFIRdkzxwQD53oVrusEL4LvUjx3M8ZcRle0fNBeVb38FqidMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPH7V6cC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0ACC4CEF7;
	Sat, 17 Jan 2026 04:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768625345;
	bh=fu2GpRXxzkKF4g5HmkbZkKdczwng/fsxsldTeBLkuss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPH7V6cCmRrPBRK31uFATow/j5Ii6R/FnsT6Zue0a+pjvkXv5eJBZ2GJXk4otNQ4Z
	 aR+g8JF3glcSvGX6bjTQHtyhGqZkRSXBZY+K+gKyXnicZPUhVWIPAWo5ygTW7dsNqk
	 vpTD0J+IF/r255ks22QXlIqSoiLlFqW/OZGw3MIWY+hFk7eViG2Da1ZYHJqWbR19Jh
	 li6Yqwia6XNDRgEUdtZVF6BhT4Vrw8MGq7WnAd1gUAiMYi+wAlQnHcUxW4ggy21Gmp
	 WkX2GBcQ6935DlR2JSmc6h1rngl8z5N/ryOQrslWg+TXwybhnPvZnTEFrhyCq4w3Eh
	 WNZh1nQ5TiJRQ==
Date: Fri, 16 Jan 2026 20:49:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] e4defrag inline data segfault fix
Message-ID: <20260117044904.GD15522@frogsfrogsfrogs>
References: <4378305.GUtdWV9SEq@daniel-desktop3>
 <20260116172139.GB15522@frogsfrogsfrogs>
 <20260116234405.GG19200@macsyma.local>
 <20260117023559.GC15522@frogsfrogsfrogs>
 <20260117034747.GA19954@macsyma.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117034747.GA19954@macsyma.local>

On Fri, Jan 16, 2026 at 05:47:47PM -1000, Theodore Tso wrote:
> On Fri, Jan 16, 2026 at 06:35:59PM -0800, Darrick J. Wong wrote:
> > > -	/* Has no blocks */
> > > -	if (buf->st_blocks == 0) {
> > > +	/* Has 0 or 1 blocks, no point to defragment */
> > > +	if (buf->st_blocks <= buf->st_blksize / 512) {
> > 
> > ...because can't you call FS_IOC_GETFLAGS and look for
> > EXT4_INLINE_DATA_FL?
> 
> I could have checked for EXT4_INLINE_DATA_FL, but we need to call
> stat(2) to check for the st_blocks == 0 case, and while it is harmless
> to defrag a file with a single data block, it's also pointless and a
> waste of system calls.  So it's best that we skip defragging the file
> in these cases:
> 
>   A) A zero-length file with st_blocks == 0
>   B) A file with a single data block (st_blocks == st_blksize / 512)
>   C) A file with inline data (st_blocks == 1)
> 
> ... and we can do that only by checking the values returned by
> stat(2).
> 
> Yes, (B) and (C) relies on Linux's behavior, since Posix is silent on
> the semantics of st_blocks, but e4defrag works only by using a
> Linux-specific ioctl, and using FS_IOC_GETFLAGS would also be
> Linux-only.

Fair enough.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>     	       	       	       		- Ted
> 


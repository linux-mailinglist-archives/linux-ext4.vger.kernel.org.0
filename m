Return-Path: <linux-ext4+bounces-9132-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A475CB0BC10
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 07:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF83B9073
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 05:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804E1F03C5;
	Mon, 21 Jul 2025 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7zG80XN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54E1DFDE
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076557; cv=none; b=K3PCdUHSb7sTXTMcIzrAvHJY8OOIL7enzprkLgndMiul6+hKSSryReVR8mc+VpEmailxiESgRBKZz85M9KT7TNU6U1z55qgVfgid/mSaNo/+iIw39pH7G3tVX/qJ84QqH5i5GTQ3GGmIetgGxIhQXpuy0QU4SzPXJlTpOVcBi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076557; c=relaxed/simple;
	bh=LD4HIMCs28PTj999wJuBYiUHK56B42tSOK0t8SOpXOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhGMQp+gmEJYh/zU5ZNEo+K6Ujpxr47Qz6/aeiye8ZN/HfGddH9BqhrYZFXsHJnmccWrf2/l+jB9dZpNhupoouDZoCu18vaYR8yW218W21M+qBg345mJj3DltRKTbIxz/eOOtlLE/l4zlH5IxYIxLsAwOSwgIYu22mpktayx9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7zG80XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0435DC4CEF1;
	Mon, 21 Jul 2025 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753076555;
	bh=LD4HIMCs28PTj999wJuBYiUHK56B42tSOK0t8SOpXOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7zG80XNTKPn6i7KpSP5+1d5/1PUOy/X4wK0G/D2eC21a5TrH6LbLz5zIpalVz7ZR
	 /G0cTTUlrhXm8zXudfk6LtU2RParbKNkZDra/sVgDGQB/3NEBRkRHoL+qVvygLbouk
	 wpjrSFMTJJT0rHGAIQp1l0dtKNbXwh7L4pPNHJ+kY33bBKSPMdgh0ihY+MGGWOp/aD
	 gzjoAPsxgcnEVq7cx4VUKthNv+UlqMxcg3LplF+fNDQW4Y/NhmfKXV62FRwiaD0Ptd
	 2hswLRU9HTvDPB4FNKYAGq4Zrb4YPUtdpXJhyYC+WCXvIQRyMJmvGpgJqSwScFVoTG
	 DtMDpDQeIa14g==
Date: Sun, 20 Jul 2025 22:42:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/5] fuse2fs: stop aliasing stderr with ff->err_fp
Message-ID: <20250721054234.GN2672022@frogsfrogsfrogs>
References: <174553064491.1160047.2269966041756188067.stgit@frogsfrogsfrogs>
 <87seirz2pu.fsf@gentoo.org>
 <20250720185135.GS2672070@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250720185135.GS2672070@frogsfrogsfrogs>

On Sun, Jul 20, 2025 at 11:51:35AM -0700, Darrick J. Wong wrote:
> On Sun, Jul 20, 2025 at 09:27:41AM +0100, Sam James wrote:
> > This seems to have introduced https://github.com/tytso/e2fsprogs/issues/235.
> 
> Heh, section 7.23.1 paragraph 4 of the latest C2y draft says that
> stdin/stdout/stderr “are expressions of type "pointer to FILE" that
> point to the FILE objects associated, respectively, with the standard
> error, input, and output streams.”
> 
> The use of "expression" should have been the warning sign that a symbol
> that can be mostly used as a pointer is not simply a pointer.
> 
> Later in footnote 318, they say [stdin/stdout/stderr] “need not be
> modifiable lvalues to which the value returned by the fopen function
> could be assigned.”
> 
> "need not be" is the magic phrasing that means musl and glibc are both
> following the spec.  IOWs, every C programmer should reduce the amount
> of brainpower they spend on their program's core algorithm so that they
> can all be really smart about this quirk.
> 
> So yeah, you're right.
> 
> But we could also do:
> 
> 	fd = open(logfile, O_WRONLY | O_CREAT | O_APPEND, 0666);
> 	dup2(fd, STDOUT_FILENO);
> 	dup2(fd, STDERR_FILENO);
> 
> and skip all this standards-worrying.  I would have just done that, but
> for fear that somewhere there might be a library that actually *does* do
> freopen and this trick won't work.
> 
> Yaaay, it's 2025 and we all still suuuuuuuck.

Oh wait no it turns out that libfuse obliterates std{in,out,err} in
fuse_daemonize() by opening /dev/null and using that exact trick.  So
the only reason why I was ever getting any FUSE2FS debug output
throughout *any* of the fuse+iomap development sprints was that glibc
lets you assign stdout/stderr directly.

freopen also won't work (at least on glibc) because its freopen
implementation uses the dup2 trick which will be undone by libfuse.

GREAT!  I only got to debug my program because OF A WEIRD GLIBC QUIRK!!

So the only way to actually fix this is to open whatever logging file we
want to use, and explicitly pass that around to every function that
wants to log a message or an error, because the libraries can't be
trusted not to fsck it all up.  libext2fs has a callback for any errors
that it wants to print, and that will have to do.

--D


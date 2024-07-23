Return-Path: <linux-ext4+bounces-3358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C769398CC
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 06:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215431F2280A
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F813BAE5;
	Tue, 23 Jul 2024 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pj1jE6zM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AC2F2A
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721707918; cv=none; b=m5TL7xCXQTNS7drnpcUJZ5Y9/ky0TYdozTIm7F5kTk6Hr94nDYIVNrxLo6kEF0m5i1OLGABq1/mR61mmCdMrjEho2pMsOme6l2QFeknRG4BCa8p+xWng/cRhJn0d1IUMgY68r+AOb5Tj3WFQznxUmMc4WFRQDBCU+GnE6xeYMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721707918; c=relaxed/simple;
	bh=TRFEGu47ouliIPXrIqSdYKSvGrywME+zKX3Z8ya76Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYFbyUZ6BYJ0eLDp+glKrMwKoFgMfhRHqCTDWlrN1JXtSkWgrr0QcuLN7FWI7qzLa/3LRWknVbEiM9ZHGdrAXGJSi+COzaj+F7rfAL1T/NGjrk9u1vzYPN95E3qHeV4IVbCYnggia2Banzx5g1FctTc4XafSFVThBvSDmjibAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pj1jE6zM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-17.bstnma.fios.verizon.net [173.48.115.17])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46N4Bacr027019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 00:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721707899; bh=sa0gEU0E5oD5yrrEFUFG4ELQPFMtmyVDuqdh63sw4Tw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pj1jE6zMiGKQnxo1+wIhCyWgL5dSd+DFCfWoDN6NhhidQYy8wnzT8Wlgm06U74Vlh
	 bDBCvP53ksMjjavYxdkeSjzTV32ZE5UHnnG6pIXTHkmVMF6Kr8Pp/JmUlPzJdmROJW
	 WvW1jzL6xphEjydCpKU5mOCRO38gWcxAqzd6YWS7z97vFU31xnG/zf7KIyj7/EnbxV
	 Nrh+SONS6HBIju0/DTaS2mEpUCWCyBop1S9n2nlw2nXAIJdEbIHrGldqTACwR3hw8Z
	 RMIJvqvhM+LWYq9hl8G/zj15BmuoO6cj2Rt5nHSP4Vcs/+UAn2qHgqgfojcsPT5BsL
	 FPxayHr32S+aw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 57F7915C0300; Tue, 23 Jul 2024 00:11:36 -0400 (EDT)
Date: Tue, 23 Jul 2024 00:11:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <kees@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Artem S. Tashkinov" <aros@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, xcreativ@gmail.com, madeisbaer@arcor.de,
        justinstitt@google.com, keescook@chromium.org,
        linux-hardening@vger.kernel.org
Subject: Re: Linux 6.10 regression resulting in a crash when using an ext4
 filesystem
Message-ID: <20240723041136.GC3222663@mit.edu>
References: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com>
 <20240722041924.GB103010@frogsfrogsfrogs>
 <BEEA84E0-1CF5-4F06-BC5C-A0F97240D76D@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEEA84E0-1CF5-4F06-BC5C-A0F97240D76D@kernel.org>

On Mon, Jul 22, 2024 at 12:06:59AM -0700, Kees Cook wrote:
> >Is strscpy_pad appropriate if the @src parameter itself is a fixed
> >length char[16] which isn't null terminated when the label itself is 16
> >chars long?
> 
> Nope; it needed memtostr_pad(). I sent the fix back at the end of May, but it only just recently landed:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be27cd64461c45a6088a91a04eba5cd44e1767ef

Yeah, sorry, I was on vacation for 3.5 weeks starting just before
Memorial day, and it took me a while to get caught up.  Unfortunately,
I missed the bug in the strncpy extirpation patch, and it was't
something that our regression tests caught.  (Sometimes, the
old/deprecated ways are just more reliable; all of ext4's strncpy()
calls were working and had been correct for decades.  :-P )

Anyway, Kees's bugfix is in Linus's tree, and it should be shortly be
making its way to -stable.

     		      	    	      - Ted


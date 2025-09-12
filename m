Return-Path: <linux-ext4+bounces-9940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0DDB54036
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 04:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4FD1C862C7
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0561B87E8;
	Fri, 12 Sep 2025 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="l3csiw4G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4B1B043F
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643175; cv=none; b=Av2EfLHbk0TYC3hIHpy2n4q69xQCFwg67sLbaABwYfMECreFj9I4eL/7NM0+/I/RxaFUmZbQvZ4KAlJRmzRALF+i4KTYsEWXb3lJeEvvgIfgElIQa+VhXGv3OPxeQa9QRxZ1rRcXNbfcmS85Oc03nGSK2eE9BLocl35Tajz8wTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643175; c=relaxed/simple;
	bh=APyOXcey219oy8MlZKr87e1dIbx9TwgQH/TgzspETDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKh49ohlvBatet6bQr9a8PcQUwnq9ymtO6dzVAkU6mcUhiPc87TxdX7fZEji+KGWqz38I9Z1/GHSlR8XWwbZnfehqFXfaeAHjQhQiCa4rzJRinPeIyfeg/b9f5N7+F/aBJizwPgzwcjLRHBJqQGXczB1pBiHpZUZ029yS4Dnvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=l3csiw4G; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-47.bstnma.fios.verizon.net [173.48.111.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58C2CSEZ022231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 22:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757643150; bh=T3zcoPnQm/xc/xWRxS7jRIRZcXhAOUxzYlDYWRBtnMM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=l3csiw4G1plhTUw36n0L6g6X8+AZiPmgmGR0FOV0+gGtKhHR9FWJVffgNJjSug1Th
	 EQmuSgcTpAe3XKoflMDpIofFCe/qrY7W6LvvM6wnhvTrRxHk+3qkfcsn11Jlf8asHO
	 MHeSO8mUPQPUGKa1U6yB7quDag5rbVjDs8N1WvG1xZ1SORbV8UYIpM8xpTe84AYoAp
	 CKqJGZ078c1O+GTD4WjFWYI/VXqkvIvh6zmayAAIUjY7vX+sElBjUbxOdwz1CBkD+e
	 fyH42tkdShpAXYuVZXkbkB5gSiB1rxPVcB/er9lWWGwuGJ1TbXd1ewpR0QsEk8Ed5Z
	 +alxzaNScbTNw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC6D42E00D9; Thu, 11 Sep 2025 22:12:27 -0400 (EDT)
Date: Thu, 11 Sep 2025 22:12:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        jannh@google.com
Subject: Re: [PATCH 1/3] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()
Message-ID: <20250912021227.GB3703006@mit.edu>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
 <20250908-tune2fs-v1-1-e3a6929f3355@mit.edu>
 <20250911222700.GC8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911222700.GC8084@frogsfrogsfrogs>

On Thu, Sep 11, 2025 at 03:27:00PM -0700, Darrick J. Wong wrote:
> On Mon, Sep 08, 2025 at 11:15:48PM -0400, Theodore Ts'o via B4 Relay wrote:
> > From: Theodore Ts'o <tytso@mit.edu>
> > 
> > Unlike other strings in the ext4 superblock, we rely on tune2fs to
> > make sure s_mount_opts is NUL terminated.  Harden
> > parse_apply_sb_mount_options() by treating s_mount_opts as a potential
> > __nonstring.
> 
> Uh.... does that mean that a filesystem with exactly 64 bytes worth of
> mount option string (and no trailing null) could do something malicious?

Maybe.... I'm surprised syzkaller hasn't managed to create a
maliciously fuzzed file system along these lines.

This was one of the things that I found while I was poking about in
code that I hadn't examined in years.  And I guess the kernel
hardening folks have been looking for strndup() as a deprecated
interface, but apparently they haven't targetted kstrndup() yet.

> My guess is that s_usr_quota_inum mostly saves us, but a nastycrafted
> filesystem with more than 2^24 inodes could cause an out of bounds
> memory access?  But that most likely will just fail the mount option
> parser anyway?

Actually, s_usr_quota_inum won't help, because s_mount_opts is copied
into allocated memory using kstrndup().  So the buffer overrun is
going to be in the allocated memory buffer, and since parse_options()
uses strsep() it could potentially modify an adajacent string/buffer
by replacing ',' and '=' bytes with NUL characters.  I'll leave to
security engineers to see if they can turn it into a usuable exploit,
although I've always said that mounting untrusted file systems isn't a
wise thing for a paranoid system administrator to do/allow, which is
why I'm a big fan of your fuse2fs work.  :-)

						- Ted


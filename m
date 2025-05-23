Return-Path: <linux-ext4+bounces-8184-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB259AC24A1
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2843B234B
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1266293755;
	Fri, 23 May 2025 14:04:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EE248F73
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009046; cv=none; b=BCjaDdmFo8IGSYuUWp0WqXHq4Bvups5pKkFqHavsmeGZVSs64BJNQHmgp10BtFL3DiVWJbZ9Fhl3+jb96JIFO03ng9wvz+LFGJjIjk8YvRmoiIJ5TXTLyXqA4/2k0AqXgS+Y0rlKe+nZwxPE2klLY8qYKhvE49kVO0wFrtzP7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009046; c=relaxed/simple;
	bh=1WJisTWrKwIhrWGQL8ZapgOK0bJJuVKBXn+2eywksAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYR1a+/+GEBx+O2dEn4pzWeOJxkhKO+fJH5vn9dJduU3c/2NTBEJzRewn5gCjq54WmdLDBBqi6vyUk9M2MekEUC6pCysQWu65jAGG3/v9MxcgKbetmKOh6wHTSYTWxlrdrj3NPkrXTvVI1qgRY2Lw9lGy1aYywWNxgUlnplFtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54NE3iee022981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 10:03:45 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B5E5B2E00DD; Fri, 23 May 2025 10:03:44 -0400 (EDT)
Date: Fri, 23 May 2025 10:03:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 1/6] fuse2fs: even more bug fixes
Message-ID: <20250523140344.GA1414791@mit.edu>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>

On Wed, May 21, 2025 at 03:34:36PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> This series fixes even more bugs in fuse2fs.

Thanks, applied.  I found that it didn't compile, because it used
fuse2fs_{read,write}_inode() which doesn't get defined until PATCHSET
2/6.  So I've also applied the second patchset, and then split the
patch "fuse2fs: simplify reading and writing inodes" into two commits,
and applied the first half before "fuse2fs: fix removing ea inodes when
freeing a file" to keep the fuse2fs changes bisectable.

Also, I cleaned up some patches to keep fuse2fs portable enough to
work with MacOS.  I've lightly tested fuse2fs with MacFuse (installed
via MacPorts) on macOS Sequoia and it works without having to pay $$$
to Apple.  You do need to enable the MacFuse system extension (which
is signed by Benjamin Fleischer, so I guess Fleischer is the one who
paid $3000 to Apple) and reboot, but it does work.

I'll reach out to someone in FreeBSD land to test whether fuse2fs
works there, since I'd like to maintain cross-OS portability as much
as possible.  It does mean that I'm a bit concerned about the fuseblk
patchset because I'm pretty sure that's Linux-specific, correct?

Cheers,

						- Ted


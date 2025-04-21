Return-Path: <linux-ext4+bounces-7369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275EA954E3
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 18:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FCC17425A
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FD1DF977;
	Mon, 21 Apr 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvr9bVaN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0140224EA;
	Mon, 21 Apr 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254081; cv=none; b=bBG6H5wNaS9QbYE5sqhS1njZsko2x8yJD+JqPInUs9SLYpT/WP/GR3ve6AZBe41GXf1bctzoWRxsaGigUFSd7cKzoNviTJrq4/pesb/3cpYYNOgzluRDpl1n03ahuSTQeOHRXb/NdX/w9WnAlc++VTrmKAyXlzaAiC0X0oUYakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254081; c=relaxed/simple;
	bh=cUGssDusKLdis92WjnrnBFRgq5wjzgSEaaVaefAdvSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msKcWaS7idjPPHkymQJOFZuB7+nAihRh399QUWEviAmAQhVcsmDyJsvXno3cauYB2A+dhL24IvevSGA3IcI0sk3ie9ueJgB5Mg0CsBNao6UQYc3LDSbfFT6wuR+YNlxkYJwhAYfQ+BIF0XGL/N+Duq0xQa/wvuowUH310ITuqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvr9bVaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654F6C4CEE4;
	Mon, 21 Apr 2025 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745254080;
	bh=cUGssDusKLdis92WjnrnBFRgq5wjzgSEaaVaefAdvSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tvr9bVaN266jnoTyKaKJ7KSxbe3Dphseh3BdQ0owiTfPys8HTT3+TkXyIcJiJmC/4
	 Afrk1lph80cRt9yt7/LlkMw63Re0f5Sy9RaeTbqVcoGqM/pt2wS08dl6PShvIBx5lz
	 FSrPbj4tAHpCP5QVQlS6vXm89KM67PdIK3YFkIYxbpcdx/1A3xnq816J/bkAi87pi+
	 U+LOo8aql37cFifiCoAeyI15NL9NuU3UtKjyjCii70SHgjNVezjnHgHIR4FSo0s5EF
	 lR99uionAZrLhQFJ7AUFDCu+ikMsIJmo3yIIUkjaB96YEy6GgLQtzM1qSIQD5zECBV
	 7ovzLb05DRAdw==
Date: Mon, 21 Apr 2025 09:47:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, kdevops@lists.linux.dev,
	dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250421164759.GE25700@frogsfrogsfrogs>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417163820.GA25655@frogsfrogsfrogs>
 <20250417183711.GB6008@mit.edu>
 <aAFq_bef9liguosY@bombadil.infradead.org>
 <20250419182249.GC210438@mit.edu>
 <20250421155433.GC25700@frogsfrogsfrogs>
 <20250421162952.GC569616@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421162952.GC569616@mit.edu>

On Mon, Apr 21, 2025 at 11:29:52AM -0500, Theodore Ts'o wrote:
> On Mon, Apr 21, 2025 at 08:54:33AM -0700, Darrick J. Wong wrote:
> > 
> > I might be wading in deeper than I know, but it seems to me that
> > after a crash recovery it's not great to see 64k files with no blocks
> > allocated to them at all.
> 
> Well, what ext4 in no dioread_nolock mode will do is to allocate
> blocks marked as unitializationed, and then write the data blocks, and
> then change them to be marked as initialized.  So it's not that there
> are no blocks allocated at all; but that there are blocks allocated
> but attempts to read from the file will return all zeros.

But that's not what I see -- on my system, I get files with i_size ==
65536, but no mappings at all:

--- /run/fstests/bin/tests/generic/044.out      2025-04-17 14:52:53.521658441 -0700
+++ /var/tmp/fstests/generic/044.out.bad        2025-04-21 08:46:15.328757541 -0700
@@ -1 +1,95 @@
 QA output created by 044
+corrupt file /opt/906 - non-zero size but no extents
+corrupt file /opt/907 - non-zero size but no extents

# mount /opt/
# ls /opt/906
-rw------- 1 root root 65536 Apr 21 08:45 /opt/906
# filefrag -v !$
filefrag -v /opt/906
Filesystem type is: ef53
File size of /opt/906 is 65536 (16 blocks of 4096 bytes)
/opt/906: 0 extents found

...unless ext4 is removing those unwritten blocks during recovery?

> This is non-ideal, but my main concern is a performance issue, not a
> correctness one.  We're modifying the metadata blocks twice, and while
> most of the time the two modifications happen within a single
> transaction (so the user won't actually see the zero blocks after the
> crash _most_ of the time), the extra journal handles means extra CPU
> and extra jbd2 spinlocks getting taken and released.
> 
> So it's on my todo list to fix, in my copious spare time.....
> 
> > (I don't care about the others whining about _exclude_fs-- if
> > you make the design decision that the current ext4 behavior is
> > good enough, then the test cannot ever be satisfied so let's
> > capture that in the test > itself, not in everyone's scattered
> > exclusion lists.)
> 
> Fair enough, I can try, and see if we get people attempting to NACK
> the changes this time around.  Support beating back the whiners would
> be appreciated.

Ok, I'll chime in whenever I see patches. :)

> I can also see if Luis's LBS changes might it easier to deal with the
> bigalloc test bugs.  It will mean exposing the concept of cluster
> allocation size (as distinct from block size) to the core xfstests
> infrastructure, and again, we can see if people try to NACK the
> changes.  This will require a bit more work, however as this is a big
> difference between XFS's LBS feature and ext4's bigalloc feature.

That shouldn't be a problem; _xfs_get_file_block_size has returned the
allocation unit size for XFS files for quite some time, despite being
badly named.

--D

> 
> 						- Ted


Return-Path: <linux-ext4+bounces-7367-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9EA95413
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988C61894C0D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D439E1DF977;
	Mon, 21 Apr 2025 16:31:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4D1DF98D
	for <linux-ext4@vger.kernel.org>; Mon, 21 Apr 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253068; cv=none; b=V1jNyVHRPFo49jrXot7XX/IMMZZNfO5hc1tZsVTUp1hKi8iU7Ye7vyF3zDHMajJwaiiXIz2B3fEoY182Nd2oF2/AlOoRxJjq+EAiAs2B7Dmxcm9uB6iZuLzsKnISK0C2HoqyEqqvGTuoK2QarF0m3U9JHLhkq6zekGLYEDYfJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253068; c=relaxed/simple;
	bh=IFBrOGhuz5lZXdQiE1OfbkxzUlOYhSK+LBKZ54Y1NeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhZS5947sq5roGWFt0BEdWMPskRAoW2MizwokVQ4naszEGIlFrHdTx5YbOQr7FGtx1TzyUOLmIJv8faqJ5Amqoq4v0hg9GF9DWINBrFg4wACTLGOexfK5XFyskTMl6wIxgST0cxYcamMM0JteLgOLRMpbqNk5mUviIbvqgwLG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([204.26.30.8])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53LGUX5m011561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 12:30:34 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7F9B73463AE; Mon, 21 Apr 2025 11:29:52 -0500 (CDT)
Date: Mon, 21 Apr 2025 11:29:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, kdevops@lists.linux.dev, dave@stgolabs.net,
        jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250421162952.GC569616@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417163820.GA25655@frogsfrogsfrogs>
 <20250417183711.GB6008@mit.edu>
 <aAFq_bef9liguosY@bombadil.infradead.org>
 <20250419182249.GC210438@mit.edu>
 <20250421155433.GC25700@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421155433.GC25700@frogsfrogsfrogs>

On Mon, Apr 21, 2025 at 08:54:33AM -0700, Darrick J. Wong wrote:
> 
> I might be wading in deeper than I know, but it seems to me that
> after a crash recovery it's not great to see 64k files with no blocks
> allocated to them at all.

Well, what ext4 in no dioread_nolock mode will do is to allocate
blocks marked as unitializationed, and then write the data blocks, and
then change them to be marked as initialized.  So it's not that there
are no blocks allocated at all; but that there are blocks allocated
but attempts to read from the file will return all zeros.

This is non-ideal, but my main concern is a performance issue, not a
correctness one.  We're modifying the metadata blocks twice, and while
most of the time the two modifications happen within a single
transaction (so the user won't actually see the zero blocks after the
crash _most_ of the time), the extra journal handles means extra CPU
and extra jbd2 spinlocks getting taken and released.

So it's on my todo list to fix, in my copious spare time.....

> (I don't care about the others whining about _exclude_fs-- if
> you make the design decision that the current ext4 behavior is
> good enough, then the test cannot ever be satisfied so let's
> capture that in the test > itself, not in everyone's scattered
> exclusion lists.)

Fair enough, I can try, and see if we get people attempting to NACK
the changes this time around.  Support beating back the whiners would
be appreciated.

I can also see if Luis's LBS changes might it easier to deal with the
bigalloc test bugs.  It will mean exposing the concept of cluster
allocation size (as distinct from block size) to the core xfstests
infrastructure, and again, we can see if people try to NACK the
changes.  This will require a bit more work, however as this is a big
difference between XFS's LBS feature and ext4's bigalloc feature.

						- Ted


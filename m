Return-Path: <linux-ext4+bounces-5538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8949EB18C
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BF6288E7B
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0081BCA0A;
	Tue, 10 Dec 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GqmFIYnt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD91B6D08
	for <linux-ext4@vger.kernel.org>; Tue, 10 Dec 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835657; cv=none; b=NJ0T0PFRe4PPRqpE5XL0piovWa17lWs3HEwBHOIeEtr+rC/G153iR7Nwy/Hf3rAz8IJR3cl9WaSYdr7Hy7NGJRszOqNW1cldJCqv80J8tMC+HTSg18fsjCUncS8dCRSBAz9G3TkzbjvXXbkD4MLfOctuVDUb7tStRuxOWNJ18/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835657; c=relaxed/simple;
	bh=uBUbcgnLax/TXHUTyY7I7MvxNn4KyXa755W8StzgjS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVmioGrzEz5Bq8M6iBVffl3BaNXmN8N3PySNUV3GPvSN7pZYQq57rHAGDeaSFzgmX2YG4d7DMxwpYkxSgxbDbKnJXYMCI+d/RTX+8GdWlja7yxRGuhJC3Qy8wPU0uAIMtOTX2B1aaTz4Cs/aDJZojmdBIG9/hWXWNc9wiwOSSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GqmFIYnt; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-3.bstnma.fios.verizon.net [173.48.102.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BAD0XSM027840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 08:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733835635; bh=DHUmL1lsFJiVd97upOLWdbOsV6YNVAKHpoQhEyaESdg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GqmFIYnteg1gx7XCN28TwEIsKVKkfnGq1G0uRE1rTjL2jXMnbgjd+XA7FGDX7iPHj
	 omGF7hJpjgvNYOw9QxIO1JlzYynCTvrnXi0zVIBXeN6mFCbhxNyBPzdi1O2gW+iyhG
	 27QSMNk6qTQi8FXz/wRHp9DKYSR1tPeK8uZUwKbR13E2pvBenVi+gt8j4GrCWBxkmc
	 ar8e8G2/NVl0buRy2dCaZbj9Il/9iXqhCnUPcnq1fQaAQZjBIVC4yASJw0Qhcd3D7j
	 RNCCUDTV9dkJMdlB7nzh88gNRqBXB4RafnZmOt56Df9WJWsYckS/QhwYSV08k2pM4M
	 8S7aERKmQ8d3g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2AEC515C6796; Tue, 10 Dec 2024 08:00:33 -0500 (EST)
Date: Tue, 10 Dec 2024 08:00:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: remove _supported_fs
Message-ID: <20241210130033.GA1839653@mit.edu>
References: <20241210065900.1235379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210065900.1235379-1-hch@lst.de>

On Tue, Dec 10, 2024 at 07:58:24AM +0100, Christoph Hellwig wrote:
> this series removes the remaining _supported_fs calls and replaces them
> with a new _exclude_fs call.
> 
> The first patch removes a _supported_fs for a relatively new test from
> Brian that fails on other file systems.  We should still run it so that
> people have a chance to fix the corruption, so I think this make sense.
> 
> Then the ext4 directory is split so that the shared extN tests have their
> own directory, and then it finally does the switch over now that now many
> _supported_fs calls are left.

Hmm, instead of doing this (would require hard-coding support for ext2
and ext3 file systems needing to use ext-common), why not just have
special-case code which causes ext2 and ext3 file systems to include
the ext4 group, and then we'll have _exclude_fs declaractions as
needed for ext2 and ext3?

After all, ext3 has been removed except for the very oldest LTS
kernels (and I dount anyone is actually testing ext3 using xfstests
these days), and ext2 is not used by most distributions (they use
CONFIG_EXT4_USE_EXT2) and the reason why we've kept it around is that
it's a realtively simple file system that still uses the more modern,
non-legacy vfs/mm interfaces.

So it might not be worth it to move a bunch of tests and creating a
new (somewhat ugly) group, ext4-common, IMO.

Cheers,

						- Ted


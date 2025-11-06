Return-Path: <linux-ext4+bounces-11530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C19C3C103
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43E11AA6E05
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADF28C84D;
	Thu,  6 Nov 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bBH1bLQE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916D2882AF
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443052; cv=none; b=Zzu3UYf5y1M8AAEY1WNgtxg48ae9Z8U8LP+v9QXxg6Yqek6hagn3IAPuGUcPtMryZY+vPUWdw4fC4PD1G/Kz7YOa9dOHECRjBZ5eOLgR3RiNzQVq8H3Q9qYPQYr1hikRRoHwsizZWThLUIkJfQK09crPkjdStLTzkNmWP1IKT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443052; c=relaxed/simple;
	bh=sHjlHscY64/Hvbw1NPAWD/TdiPthHDgqPypIyEFYHA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDNifeIQeYT4tV5iZ13fWtKZScJo4YnNY0CBvu3duBMRq22XOLqBuqz85MfKgGYjGPQ6FfJzC0qgKGqiFdQln5LsAl5CaZkCFs9BJZZS6KUHMHTXwTQJhqtXAt85a1zIk90IkLZ5kknVUqS4gdjcz114l4q3Kg1aro6wDe8Iids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bBH1bLQE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A6FUZIQ029486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 10:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762443038; bh=+AQXTMZtR4YmtwvPjlKXxXRsmjXZa5xo9JSXfd1YChU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bBH1bLQEswT/KqaLbnRYtbxYztWdW/btVF3Re3Tw8yHiSSYA6zKPmABJtjcCf3mzP
	 OylVLJ3VZFeyhJ+6z0Dyq+X1Hfk4axEaP5TVemCX23nlTdwaEHeQo54TP8/sp4GZ+o
	 DF5yjskSpA9KwqBZN3XXidptNGeEv6Cnh8ie7FrLZrcGIhBRYU0jF7CdmizFn6tHar
	 Nw5QDHo7mr9jvKYNpsjMQYFw5BNqPzb+xq8a3lDq/j0JaBr28kD8GI1L+ACKGDdiWl
	 j8GGzpl6cSoxpDMU79QNTL42SGGZV2i70iAc1kv7I5F1m7fEUpffjJjO3BlosCCyaM
	 bD+8BTBIqff1w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 99B3D2E00D9; Thu, 06 Nov 2025 10:30:35 -0500 (EST)
Date: Thu, 6 Nov 2025 10:30:35 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
        Ahmet Eray Karadag <eraykrdg1@gmail.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: synchronize free block counter when detecting
 corruption
Message-ID: <20251106153035.GA3125470@mit.edu>
References: <20251010073801.5921-1-albinbabuvarghese20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010073801.5921-1-albinbabuvarghese20@gmail.com>

On Fri, Oct 10, 2025 at 03:38:00AM -0400, Albin Babu Varghese wrote:
> When ext4_mb_generate_buddy() detects block group descriptor
> corruption (free block count mismatch between descriptor and
> bitmap), it corrects the in-memory group descriptor (grp->bb_free)
> but does not synchronize the percpu free clusters counter.

Actually, we do.  This happens in ext4_mark_group_bitmap_corrupted in
fs/ext4/super.c.

	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
					    &grp->bb_state);
		if (!ret)
			percpu_counter_sub(&sbi->s_freeclusters_counter,
					   grp->bb_free);
	}

So we've *already* subtracted out the blocks that were in the block
group which we've busied out.

> This causes delayed allocation to read stale counter values when
> checking for available space. The allocator believes space is
> available based on the stale counter, makes reservation promises,
> but later fails during writeback when trying to allocate actual
> blocks from the bitmap. This results in "Delayed block allocation
> failed" errors and potential system crashes.

I suspect there is something else going on with s_freeclusters_counter
being incorrect, but adding an additional correction to
s_freeclusters_counter is not the answer.

How is the system crashing?  If we have errors=continue, then we
really shouldn't let the system crash.  If there is delayed allocation
failures, the user might lose data, but if the user really cares about
that, they shouldn't be using errors=continue.

						- Ted


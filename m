Return-Path: <linux-ext4+bounces-11998-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19ACC7AD72
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 17:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D7B3A1F16
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D52D8DAF;
	Fri, 21 Nov 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC0+/Z+M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A046BF;
	Fri, 21 Nov 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742453; cv=none; b=tfK+UVJBoEcup9FeSvEpYcnDCVtag8sJnKycVft3MwpVq8assm4kkDQWyWv5W+2UjVj2HnmTUejOS1z1WX6tLTc8/m467pjvbmKnUiGcSxZ88R41nTtUZtjwUmMW/mOZi9xsU6oDn38nIPH4Vkc6a2AjbnlBUPAhEJtOTHnq7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742453; c=relaxed/simple;
	bh=RmyRHzEPNsCf81/CdlaPY5Ck62FomO+Wkvot0oO0e08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTa2zbgKPgp767GGHqYS3BG4cdMVX4YDQzKyX+9qNonm4RMLkLLfzRhPr6UHgptvz1f30YSybK2aY6LRG42sLM7XIbfOl1M5jgRVXwReqDEJYBYbJo3OncJGgTSppAnaeEJq8mm/HefD4gL3fA/nNuKfr3kQz7kQs0FaysrcdDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC0+/Z+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFFAC4CEF1;
	Fri, 21 Nov 2025 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742452;
	bh=RmyRHzEPNsCf81/CdlaPY5Ck62FomO+Wkvot0oO0e08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bC0+/Z+MUq7EALsTjy/RNEKZJ7/atv3ij3Lrh79PO2KwGcEcOu8aL3mXeLuEYKoNc
	 K04TqhyMAHgk8l7GGIMXqOMhhjjxyNSrSp99axlG2x7zZ8tMyqZcr/LPwpaqPDF4Kv
	 Ah9dVDsFJTwegh3W4h5D1LShfqAIhmI9gfvjQ6Mt2V6kIswhOEqhjaX9j5TnLb+ftk
	 V/zhqHpvZfeR+qY21UKQNe7DBnziymKRXq/I9rsLw98gYqvHrzQOhz4dpNjs1lyl/s
	 fQJCVqaNDq9usW7P42Tu5LCBKpQLCHCCcXXAdEX6pWX5lMsDFWKusqpw8+25MgkXau
	 k7x7YugGerxzQ==
Date: Fri, 21 Nov 2025 08:27:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: check folio uptodate state in ext4_page_mkwrite()
Message-ID: <20251121162732.GU196358@frogsfrogsfrogs>
References: <20251121131305.332698-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121131305.332698-1-kartikey406@gmail.com>

On Fri, Nov 21, 2025 at 06:43:05PM +0530, Deepanshu Kartikey wrote:
> When a write fault occurs on a memory-mapped ext4 file, ext4_page_mkwrite()
> is called to prepare the folio for writing. However, if the folio could
> not be read successfully due to filesystem corruption or I/O errors, it
> will not be marked uptodate.
> 
> Attempting to write to a non-uptodate folio is problematic because:
> 1. We don't have valid data from the backing store to preserve
> 2. A subsequent writeback could write uninitialized data to disk
> 3. It triggers a warning in __folio_mark_dirty():
>    WARN_ON_ONCE(warn && !folio_test_uptodate(folio))
> This issue can be reproduced by:
> 1. Creating a corrupted ext4 filesystem with invalid extent entries
> 2. Memory-mapping a file on that filesystem
> 3. Attempting to write to the mapped region
> 
> The sequence of events is:
> - User accesses mmap region -> page fault
> - ext4_filemap_fault() -> ext4_map_blocks() detects corruption

    ^^^^^^^^^^^^^^^^^^ what function is this?

$ grep ext4_filemap_fault fs/ext4/
$

> - Returns error, folio allocated but NOT marked uptodate
> - User writes to same region -> ext4_page_mkwrite() called
> - Without check: folio marked dirty -> WARNING
> - With check: return VM_FAULT_SIGBUS immediately

Doesn't filemap_fault bring the contents into the folio and return
VM_FAULT_SIGBUS if that fails?

--D

> 
> Fix this by checking folio_test_uptodate() early in ext4_page_mkwrite(),
> before any code paths (delalloc, journal data, or normal). This ensures
> all paths are protected. If the folio is not uptodate, unlock it and
> return VM_FAULT_SIGBUS to signal the error to userspace.
> 
> Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/ext4/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..18a029362c1f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6688,6 +6688,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	if (err)
>  		goto out_ret;
>  
> +	folio_lock(folio);
> +	if (!folio_test_uptodate(folio)) {
> +		folio_unlock(folio);
> +		ret = VM_FAULT_SIGBUS;
> +		goto out;
> +	}
> +	folio_unlock(folio);
> +
>  	/*
>  	 * On data journalling we skip straight to the transaction handle:
>  	 * there's no delalloc; page truncated will be checked later; the
> -- 
> 2.43.0
> 
> 


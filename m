Return-Path: <linux-ext4+bounces-2248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F3A8B87A4
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 11:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673E71C22531
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FE851C2B;
	Wed,  1 May 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MUB5oW+V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B585502B1
	for <linux-ext4@vger.kernel.org>; Wed,  1 May 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555663; cv=none; b=ecIPY5bSvMGBReB/3Y/ElRoqsBohCzVfCI97T1lYS8CDsq7F2uBjsUwtgXKDMKc++9f5Gvs/uAKteo3WjmQywykRtKgdGGnHfKHw2inHJv8oZdZi5uMVLAJm5mzW6TdmXFPtAJdJmYlT8R1Ik6hTuhsuuQeU1D221BOUuV8XN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555663; c=relaxed/simple;
	bh=Xec4dXa4KgXAKTtDJ9pzwjO5S9z6T2Yo6Q4diMaJcg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEA3zNIhL0zAfu/hD59XekvnHt1RUCNH3TJBUi7GRKOiefirxlUrjZQMn8TuoUO1GrD24c/eZm5+kjvchkL9azbfaBAGldPAWez1/C4EDRhridNzOCzxFCo7+GqmTpDvjIgyGz3tSr92srqhQq4sipWyO39ZFmDq+OtZm/ywbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MUB5oW+V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e86d56b3bcso60467365ad.1
        for <linux-ext4@vger.kernel.org>; Wed, 01 May 2024 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714555660; x=1715160460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jA6/54rvNPCCZDDxvJHTB+TObNeo0PCUCsJwkWJa9LE=;
        b=MUB5oW+V6Pw7TLgW2AM1hBDkyX78rv+lu+GmQs85eoHc11ZHILnQuI1BXhH7lpim2Y
         6gi0LgTF1VgJ0tJdFHlpUSsRzWn8bmpwucXTAOV9G2NAqE6bWK98wJzqGwBBQvrZU1Pb
         QTjJnJn7uBnSRSf6Z+zRrSlAEJ4Dsd3k23KjEF82K895E4lAQWoegTHdstY8fH2I2bAS
         ShKAIMHFqZzHTYfydChE+KiIwjnX6emj4xPD8/dydq/+fUD+W2SOJKXj8jKP5nHWiVzf
         LV9sgEX8X6CNRvXHaAe7+cdg0yuc0Mbe7kdrdjwFRb87Subt02m2njvuR9uen0LUm7rs
         4gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555660; x=1715160460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA6/54rvNPCCZDDxvJHTB+TObNeo0PCUCsJwkWJa9LE=;
        b=JDtWRYYS8zAZkfEKwOCgrR0gSB92q4dyRvK9zFjAXE7mr0fL0VydUt08dpS20zWfm/
         WrEAR4fXPw3/zE0xtKQwkHXS3hnv6eiVy9JOnT9BrLjndGTKT8Ij+6x87uwCxbaeEU9e
         06UkSazmvN4EfqPOOfvBWQEkSuyPrDFkHUHOjeszqAcevxyuUlpTASipXKXHMbI/WJpE
         ttBEXfn7srSEu5Su4koOuAfjZuCzFzMgICDa7mZC/h4WksDnvKZmJ9uCNFG6ms59J/cs
         pkKm+EflcJV1FEdQOL7t266B8yN3ix+mvxHmd0k1QnoJEwqYddGLbnp5Ft38hPDL+Uki
         BN1g==
X-Gm-Message-State: AOJu0YxPBTdM1xFndiAi2Px2IuO0wjQhLKqRU9zWpUqAdFCChLKpmG3k
	/c0ISy3W3+kM0yrem/+E2JSM4iJLf+RcKFdaIcGDJSAZxD7abmY9cZus/paXi6k=
X-Google-Smtp-Source: AGHT+IFu0jN+KODiUpxx3eJcKXu/sUXR0fU20jgfQUgpRPXKLy/xtaPE3yAAScbeG4/pjwQ1tWY9yw==
X-Received: by 2002:a17:903:41cd:b0:1ea:c52d:e03e with SMTP id u13-20020a17090341cd00b001eac52de03emr2187607ple.13.1714555659445;
        Wed, 01 May 2024 02:27:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001e944fc9248sm19566438plh.194.2024.05.01.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:27:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s26FU-00HD6J-2B;
	Wed, 01 May 2024 19:27:36 +1000
Date: Wed, 1 May 2024 19:27:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v4 33/34] ext4: don't mark IOMAP_F_DIRTY for buffer
 write
Message-ID: <ZjILCPNZRHeazSqV@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410150313.2820364-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410150313.2820364-5-yi.zhang@huaweicloud.com>

On Wed, Apr 10, 2024 at 11:03:12PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The data sync dirty check in ext4_inode_datasync_dirty() is expansive
> since jbd2_transaction_committed() holds journal->j_state lock when
> journal is enabled, it costs a lot in high-concurrency iomap buffered
> read/write paths, but we never check IOMAP_F_DIRTY in these cases, so
> let's check it only in swap file, dax and direct IO cases. Tested by
> Unixbench on 100GB ramdisk:
> 
> ./Run -c 128 -i 10 fstime fsbuffer fsdisk
> 
>   == without this patch ==
>   128 CPUs in system; running 128 parallel copies of tests
> 
>   File Copy 1024 bufsize 2000 maxblocks       6332521.0 KBps
>   File Copy 256 bufsize 500 maxblocks         1639726.0 KBps
>   File Copy 4096 bufsize 8000 maxblocks      24018572.0 KBps
> 
>   == with this patch ==
>   128 CPUs in system; running 128 parallel copies of tests
> 
>   File Copy 1024 bufsize 2000 maxblocks      49229257.0 KBps
>   File Copy 256 bufsize 500 maxblocks        24057510.0 KBps
>   File Copy 4096 bufsize 8000 maxblocks      75704437.0 KBps
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1cb219d347af..269503749ef5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3281,9 +3281,13 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	 * there is no other metadata changes being made or are pending.
>  	 */
>  	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode) ||
> -	    offset + length > i_size_read(inode))
> -		iomap->flags |= IOMAP_F_DIRTY;
> +	if ((flags & (IOMAP_DAX | IOMAP_REPORT)) ||
> +	    ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) ==
> +	     (IOMAP_WRITE | IOMAP_DIRECT))) {
> +		if (offset + length > i_size_read(inode) ||
> +		    ext4_inode_datasync_dirty(inode))
> +			iomap->flags |= IOMAP_F_DIRTY;
> +	}

NACK. This just adds a nasty landmine that anyone working on the
iomap infrastructure can step on. i.e. any time we add a new check
for IOMAP_F_DIRTY in the generic infrastructure, ext4 is going to
break because it won't set the IOMAP_F_DIRTY flag correctly.

If checking an inode is dirty is expensive on ext4, then make it
less expensive and everyone will benefit.

/me goes and looks at jbd2_transaction_committed()

Oh, it it's just a sequence number comparison, and it needs a lock
because it has to dereference the running/committed transactions
structures to get the current sequence numbers. Why not just store
the commiting/running transaction tids in the journal_t, and then
you can sample them without needing any locking and the whole
ext4_inode_datasync_dirty() scalability problem goes away...

-Dave.
-- 
Dave Chinner
david@fromorbit.com


Return-Path: <linux-ext4+bounces-3053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB691E118
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914B91C2198C
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA015ECFA;
	Mon,  1 Jul 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rAqstR5h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDB15ECD6
	for <linux-ext4@vger.kernel.org>; Mon,  1 Jul 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841617; cv=none; b=Dw1W5avP1zuF4U75A2ukXcVhmSD/INV3H8qaqVHk4iCGdKTiXHpOjwfqC4WdHmsVBjLYNdyFYyy91cXOS7YbNsDLMg15Ev2Ze23IhKi8nTotLFzc2jgluHyJXWl04R0AGvBJu0UN06Re0ZxIuwBHpbxRcJQ01JRkoxZeQ1j6vi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841617; c=relaxed/simple;
	bh=Ww3zO2BWA6CNrPfVjdCQ8/edKcVa8UvzDOn/+wZVrEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFUI9i+ZT6HcMst1eiqIa2X2x9X2mcDKX03OYd3maWa7sws0OCopWWewtR5Q/s0ZEk6fC0bCdK7m0JCB3wCdy69loF6aAp42ZRiH+7wg0gtK7H2DMDA6N/p1wLoUkh5qGzaVgwdH4I1Y5iM71nUJCgRSnL4FSU+QZ7f40CPmZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rAqstR5h; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b05c9db85fso14177626d6.2
        for <linux-ext4@vger.kernel.org>; Mon, 01 Jul 2024 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719841615; x=1720446415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7pK8M+T679Mr4Uw1+2PXZ/iLLD0jN5yzRREJHhd/M8=;
        b=rAqstR5haeuwUowCfxCsQJIDf2qieHtgMh+/eTl2ebv8mkMM1HXvwROMApDpg6OG1m
         RqgsLoF652BqZbYRaiiuBfUxYrkv6/Oz5JDzyZma2wEKP7wTY/o3LltyoHd5HUXIo4fl
         0XSjC+XbKoPv58qG/XCotkfE7uut/wF1fCpRDqMY1MUEUtOwWDD6d7xy8pup9hVypChg
         /eRTAcd3ablPgl7txgWWcymn5qj10yEu1EkddYON84Q+tIl3mjdQOtYRv73QjZ1EqjsU
         IhU8ztbaR+NKHNO4lDc/gY6CB1waiKLXBNviHrfW4CRsj5QMny+jwXgvjjO4Td8ar6r0
         dHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841615; x=1720446415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7pK8M+T679Mr4Uw1+2PXZ/iLLD0jN5yzRREJHhd/M8=;
        b=G53cq1If1UIq7MLlSsNfkbtPzW+g1EmZ7XhwXx3i6d8B2KBr7eZKwoM8SuOHIa+v+d
         rPM8yRiNch1WkpUPaJZ245DfTi1/E+WyTga9cwwqZBGbrUosrMerD5GGMqgk3iB/s8Pd
         Vta8biy9Gusr5ClUlTwpQ3nlBzx+gJZdZmDsBqD+i7aOMiGeKcsud2m1trwT8hcEfyvx
         YvqRtnBkarc57aaea+s6cymiflhHXXQWB4M6D+7osvFtp6I+CBKu5a9xVVjHRTUA1Z6x
         u6t/zw9uKjZ9p4MEJNw1dXrrh1VZTfjwByPExen0N6Sc2rQFttXp10MwPt6o0zMk/oG0
         dw8g==
X-Forwarded-Encrypted: i=1; AJvYcCUovxlRaclkq5/HWnR7ukIjt+XEzLc5PF5LFvhZv5zF+m1TwirkPlz8H7VYrNHy+INVuIbdPriyCS4meukAyg826miN9M/7AQgGZw==
X-Gm-Message-State: AOJu0YwliUwtMWSHR0iAsZjUcEzIorUTwwOIcdyJ1TYYthVgq/DaINEs
	8kGgz34YrA/rrD7N+5gw5zn4qjOcOYF3Y0O9+QGdAY0M6Jv1sFBE1zmqCpQChgU=
X-Google-Smtp-Source: AGHT+IG8OekqgNnErri1uZBaOEWN7EF2UDkAF5obMoo6PPyjxSiFbWfhXRMS/kv2BHuTbAr7oS5ICw==
X-Received: by 2002:a05:6214:f03:b0:6b5:47b0:8f09 with SMTP id 6a1803df08f44-6b5b70cde0fmr83155356d6.36.1719841615063;
        Mon, 01 Jul 2024 06:46:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f5f51sm33227276d6.75.2024.07.01.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:46:54 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:46:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 07/11] xfs: switch to multigrain timestamps
Message-ID: <20240701134653.GA504479@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
 <20240701-mgtime-v2-7-19d412a940d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-mgtime-v2-7-19d412a940d9@kernel.org>

On Mon, Jul 01, 2024 at 06:26:43AM -0400, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> Also, anytime the mtime changes, the ctime must also change, and those
> are now the only two options for xfs_trans_ichgtime. Have that function
> unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> always set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_inode.c | 6 +++---
>  fs/xfs/xfs_iops.c               | 6 ++++--
>  fs/xfs/xfs_super.c              | 2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 69fc5b981352..1f3639bbf5f0 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
>  	ASSERT(tp);
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
> -	tv = current_time(inode);
> +	/* If the mtime changes, then ctime must also change */
> +	ASSERT(flags & XFS_ICHGTIME_CHG);
>  
> +	tv = inode_set_ctime_current(inode);
>  	if (flags & XFS_ICHGTIME_MOD)
>  		inode_set_mtime_to_ts(inode, tv);
> -	if (flags & XFS_ICHGTIME_CHG)
> -		inode_set_ctime_to_ts(inode, tv);
>  	if (flags & XFS_ICHGTIME_CREATE)
>  		ip->i_crtime = tv;
>  }
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index ff222827e550..ed6e6d9507df 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -590,10 +590,12 @@ xfs_vn_getattr(
>  	stat->gid = vfsgid_into_kgid(vfsgid);
>  	stat->ino = ip->i_ino;
>  	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	fill_mg_cmtime(stat, request_mask, inode);
> +
>  	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
>  
> +

Stray newline.  Thanks,

Josef


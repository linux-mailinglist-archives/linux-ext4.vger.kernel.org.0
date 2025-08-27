Return-Path: <linux-ext4+bounces-9713-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807DB38759
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466241B24B66
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211AF30FC17;
	Wed, 27 Aug 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="SWZleMlx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f54.google.com (unknown [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D702DFA3C
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310880; cv=none; b=S5uSAtIojDBPOJU9OFrCm7cHNAO/XPyyDrL3OElMMBQabsEPq93MtUci6B7qDkF+y4R1bs6muHfyHIC9XQShAA2EaWT2JbXfm1aT+/dHhpj8LuNWN0ELexIzQW+JWaW9Pgu8oL40d5F9gZgZdVyg+Qwk42bnlZ972QL42OIk+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310880; c=relaxed/simple;
	bh=Gx7xU0EwwmpQsQeC++G48wZoJ0PFQt/ki3BvUcTHe2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bssoi7IB1LzmDLJdJsMfakQ5BCrTlLrcKM2ueza8I61dYtYVWmiB7QtF3cAfSDsFkykB4l73xEpgndi9ichcg9B5HSdrd7KfVpUuEFcHYd0QyMscMrosnqUPK1/aKV9PAjdYQSk1TqolZZa3FHLWFKDE0UvxH3CugdHXsTlQRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=SWZleMlx; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-5f34874a934so55672d50.0
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756310878; x=1756915678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeqKXGh2k/fvZbtY7nlqP034nNJp6LLlTEXlFIX7b9M=;
        b=SWZleMlxhKWl40PHYB4ucoxJ0CFao+AtTgt3TDkcEF+/MIZKcVQ+GAlov/YRv2rtvK
         EKA6RVf2O7sn1umpz8AaccX0MpJn+UL1yit4pFTpwXsd+GJYlSjRpO7/z6ldYGIeo56e
         Ig2Ma0567nMVRODn9D80ISJXJK1YYhAqvSUF5Zo6o+zAdkhV29XQPSmG/il+xDb7IQQI
         GsZ9JgFcPAogkG+KhtczUy4egbr+G/WIYRy+yu1qwj/KFeENAc3SmR1LadnCWLJcJJCx
         T0dvrVKpi9rq0pOrIyUAdk6UKFtyeILpNWuC9jn15SbdI/23MJe5OKwjfr+4E38ivHnN
         1n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310878; x=1756915678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeqKXGh2k/fvZbtY7nlqP034nNJp6LLlTEXlFIX7b9M=;
        b=Ff3+zKnCV/8XCIImZcqJZ0GOtjRHJmOngJiEDE/Bxmh4MbvzMSz6uo37XduQl6GmUh
         +6FXwJrANbZqqVSvRP7fstqx6NPmJ28vE7/iyD+JXfrmDMGhO0X4ooQ/h3wJLFfqBjny
         IPqHFKF+n5pczekqzjIPNP4Omi71oigOzCidkZvV9qJHLsgwHofVd0d+Bb4BypnC4Mcu
         tf+qh+PBevgX9/XV6Xy2z+ZVx5hI7JxMf/u4YYj5FPQUrVIxVftiOfNJK913QkwI/nCD
         0al9DjU/FtOwP6jUVMkUmXsFvCnRpgATXi7Ntkd0uWGMPuToxnobMrAn2cQmx4jBbqyt
         5M4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvShWWEn6zPr5hToo58funN2tFPbB9kAbsQRbfslbNO5XawpAFYEO4bWqw6u3xwWIrhkrO9ke+Y7JM@vger.kernel.org
X-Gm-Message-State: AOJu0YzuS+FiFHT+FihS0b0/1f7mehjlx2tQOlO1t4o8JS3s3pgnQw0l
	moOhnGAtbNpeXoL4hJvcYU7IOH5ZVRoWL8PX7We83uMOXYI2nn9d74RRU/16cpaIM/Y=
X-Gm-Gg: ASbGncvbgAvBsoKqIIuMVy60+SrAEQ/0Ma2iR+1Ef4Yxtsj/IcR31MCLrl/FreUFkV3
	PEWg1F+P0Oy/zNZS2gtJW8DEPffS253850rPCHOAhjyaoQpFuaSE9Sf/VNogPcwIGHCl/EkmFf5
	JK8nSyeZhaD/2DZ4mYk+ppnYULfUPtwMwLI0T8ktYhWKC+rfJieXbTbwJn2xjNVkLRgnbLnwOa1
	jsBXq7lfjnYjcNRFdt+QbRHYeyvh6mpwbeL8Rm48XceZ1oCmn2hJ2CF7jUcQcfG1ci/TE8NrSBY
	CJFc86cGPtDHn1Mw0G1tPRpw7lNz7xaANc/MHjVH5ZWaHQtXd8HHzYIij92DCnRE5T+qhnMhp8K
	PJ6Dg+FbQP4ZF7Utn1b5QBRdChDdjOt+nzuA6SFvsZKc6LvFCPSmZTKmJeRXJlitePeRUm/YHaT
	Mytk6C
X-Google-Smtp-Source: AGHT+IHS9aTsbVkGsXkV8bfMPkBsYYqHVpKIqvIIEtcl6YxbxzkP6i6xFIvHd3ui1H2CD+Mz60vqoQ==
X-Received: by 2002:a05:690c:6702:b0:721:370e:2756 with SMTP id 00721157ae682-721370e2aafmr64643697b3.45.1756310877727;
        Wed, 27 Aug 2025 09:07:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b1b7dsm31881287b3.62.2025.08.27.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:07:56 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:07:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	amir73il@gmail.com
Subject: Re: [PATCH v2 15/54] fs: maintain a list of pinned inodes
Message-ID: <20250827160756.GA2272053@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <35dc849a851470e2a31375ecdfdf70424844c871.1756222465.git.josef@toxicpanda.com>
 <20250827-gelandet-heizt-1f250f77bfc8@brauner>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-gelandet-heizt-1f250f77bfc8@brauner>

On Wed, Aug 27, 2025 at 05:20:17PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:15AM -0400, Josef Bacik wrote:
> > Currently we have relied on dirty inodes and inodes with cache on them
> > to simply be left hanging around on the system outside of an LRU. The
> > only way to make sure these inodes are eventually reclaimed is because
> > dirty writeback will grab a reference on the inode and then iput it when
> > it's done, potentially getting it on the LRU. For the cached case the
> > page cache deletion path will call inode_add_lru when the inode no
> > longer has cached pages in order to make sure the inode object can be
> > freed eventually.  In the unmount case we walk all inodes and free them
> > so this all works out fine.
> > 
> > But we want to eliminate 0 i_count objects as a concept, so we need a
> > mechanism to hold a reference on these pinned inodes. To that end, add a
> > list to the super block that contains any inodes that are cached for one
> > reason or another.
> > 
> > When we call inode_add_lru(), if the inode falls into one of these
> > categories, we will add it to the cached inode list and hold an
> > i_obj_count reference.  If the inode does not fall into one of these
> > categories it will be moved to the normal LRU, which is already holds an
> > i_obj_count reference.
> > 
> > The dirty case we will delete it from the LRU if it is on one, and then
> > the iput after the writeout will make sure it's placed onto the correct
> > list at that point.
> > 
> > The page cache case will migrate it when it calls inode_add_lru() when
> > deleting pages from the page cache.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> Ok, I'm trying to wrap my head around the justification for this new
> list. Currently we have inodes with a zero reference counts that aren't
> on any LRU. They just appear on sb->i_sb_list and are e.g., dealt with
> during umount (sync_filesystem() followed by evict_inodes()).
> 
> So they're either dealt with by writeback or by the page cache and are
> eventually put on the regular LRU or the filesystem shuts down before
> that happens.
> 
> They're easy to handle and recognize because their inode->i_count is
> zero.
> 
> Now you make the LRUs hold a full reference so it can be grabbed from
> the LRU again avoiding the zombie resurrection from zero. So to
> recognize inodes that are pinned internally due to being dirty or having
> pagecache pages attached to it you need to track them in a new list
> otherwise you can't really differentiate them and when to move them onto
> the LRU after writeback and pagecache is done with them.
> 

Exactly. We need to put them somewhere so we can account for their reference.

We could technically just use a flag and not have a list for this, and just use
the flag to indicate that the inode is pinned and the flag has a full reference
associated with it.

I did it this way because if I had a nickel for every time I needed to figure
out where a zombie inode was and had to do the most grotesque drgn magic to find
it, I'd have like 15 cents, which isn't a lot but weird that it's happened 3
times. Having a list makes it easier from a debugging perspective.

But again, we have ->s_inodes, and I can just scan that list and look for
I_LRU_CACHED. We'd still need to hold a full reference for that, but it would
eliminate the need for another list if that's more preferable?  Thanks,

Josef


Return-Path: <linux-ext4+bounces-2255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB78B91BC
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 00:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45957282F2D
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BA1157A4D;
	Wed,  1 May 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QcbYw8ZN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA04E1DA
	for <linux-ext4@vger.kernel.org>; Wed,  1 May 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603769; cv=none; b=NqihoA5wDeAMnGD3ky7sFi6p5A1AocafCMuboSqkgAe+dnazKrnknALD/bCoC7JCN/jM2hTNU2cEeYso573yvfipokKIKxraAthQaSpyn613Yqh4obzgx7jXPl6RRUHzJVaT/WPuKQrMxuTPuuwEeHNc4LMEJAp5Dalo0XHhQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603769; c=relaxed/simple;
	bh=8LZG223ErRkadSkCS5+A3qPiOtT6bAbjMuFAeChgRJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOiTEHqFjbZHM8fy4qrMlLYBo0pLe6/te1YmiRqRsEoxCr9FfJ/r/nuBlI5hs0BBIYwXnOGu6uZ+U9Ahi+YI/FBXq+eAJ0L6mDjUTtYcrii2Y/StzPaVOxP49Vz0V24wNicoFynJbiK9NhA0L7aYg598Y2U9A46c189CDARDMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QcbYw8ZN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so238928a91.3
        for <linux-ext4@vger.kernel.org>; Wed, 01 May 2024 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714603767; x=1715208567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWcAbZK+N9gGi5DZfbKEGFQw8hTCqAY7aSRPf/sIHHU=;
        b=QcbYw8ZN6iSBXSgTj4+psXwI2Y0Yrt3xxVhIE99eb23HhxGXFkTn4W4QMo7Zcz+fAg
         vHeWCwf74QQ5YNNQ5ntJ45vIr+e7Er/ADVBQ3JWzWAmWNmt57mB9W/x0TVckBdn/WJJV
         ZZaSoTRNDEwe78fFIDueQc2xZZ+b/VbOOOj1CergyZYptVQ7EJc7EFyA7wXyYQ1MrtlB
         XfW9nqAujrwMoxoT37mIt37eaSNEBC4mgJ1t+JY4hKl2V8GCmy+2akN8QmPMuK9ORqy1
         9mwvZDrq3+joYEkTG3sqmKfjhxcAsb8XZ2oHj/sK8TzGe7yxry8AgpJtUuglUYe7U8In
         bTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714603767; x=1715208567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWcAbZK+N9gGi5DZfbKEGFQw8hTCqAY7aSRPf/sIHHU=;
        b=imE1DnqGMJsKChm6jgQQ3d7CZr2V/Xgxt8Slpza2RV2VLC70dvmjo7OC+B2Q4WDS4Y
         DeOD4/566v/LgHInmB3JS6HA+cZaxoj59hgdSuYIVpjzIaNAu6HzF2CqjUqggqBz+oZq
         17u+2U1s0NBdQWjiy7Aa+fk0w2wKQnIyJ2pynqfnsFWNtEPX6m4eQFfsrZB/szGQZdtq
         cLVPCOSWF8lH0XL19qFfJ8FZA5qurSRLg7VoqnnX9z1Q0CWNNsMg6D4ZASQXklLyX5RQ
         ahaaECpxnjpFbkd+54UB2RbT6GZKPAPw504ybcLXw4tb5SV1l9hosFgzZuWzIoAJMpc+
         NJXA==
X-Forwarded-Encrypted: i=1; AJvYcCVVkPih2Tz9LHNdZd7qIMHszescMtyUxFp0APwCJ21HgvWxCX0UDw5wBMiuDkUOB7K+nQC6lssV+F1MlhPRZlaPa2outxLT9GnhqA==
X-Gm-Message-State: AOJu0YyCAYSBzR4OuT9ty+VGlfJrXIWlw5o5zAaWoMsVJfV7m4Qd0Wh8
	uI1qy934KewCI+K9fM8603WKTcB1M7DODqgKMYGpa2xwJtZBEN5gSm263mmpgTw=
X-Google-Smtp-Source: AGHT+IFUVpD0ohKjsMi728ug09zevbMivjbV42nyO/wzm5OAgymbTe1EO9Wt0LCxXfVXbYRIPjbf4g==
X-Received: by 2002:a17:90a:3f87:b0:2ac:d9f:de9b with SMTP id m7-20020a17090a3f8700b002ac0d9fde9bmr331337pjc.45.1714603767063;
        Wed, 01 May 2024 15:49:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d20-20020a17090ae29400b0029bf32b524esm1846257pjz.13.2024.05.01.15.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 15:49:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2IlQ-000G1W-1B;
	Thu, 02 May 2024 08:49:24 +1000
Date: Thu, 2 May 2024 08:49:24 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org,
	djwong@kernel.org, willy@infradead.org, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
Message-ID: <ZjLG9PK0uMFgSqhj@dread.disaster.area>
References: <ZjHmY6RoE3ILnsMv@dread.disaster.area>
 <87le4t4tcp.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le4t4tcp.fsf@gmail.com>

On Wed, May 01, 2024 at 05:49:50PM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Wed, Apr 10, 2024 at 10:29:16PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >> 
> >> Now we lookup extent status entry without holding the i_data_sem before
> >> inserting delalloc block, it works fine in buffered write path and
> >> because it holds i_rwsem and folio lock, and the mmap path holds folio
> >> lock, so the found extent locklessly couldn't be modified concurrently.
> >> But it could be raced by fallocate since it allocate block whitout
> >> holding i_rwsem and folio lock.
> >> 
> >> ext4_page_mkwrite()             ext4_fallocate()
> >>  block_page_mkwrite()
> >>   ext4_da_map_blocks()
> >>    //find hole in extent status tree
> >>                                  ext4_alloc_file_blocks()
> >>                                   ext4_map_blocks()
> >>                                    //allocate block and unwritten extent
> >>    ext4_insert_delayed_block()
> >>     ext4_da_reserve_space()
> >>      //reserve one more block
> >>     ext4_es_insert_delayed_block()
> >>      //drop unwritten extent and add delayed extent by mistake
> >
> > Shouldn't this be serialised by the file invalidation lock?  Hole
> > punching via fallocate must do this to avoid data use-after-free
> > bugs w.r.t racing page faults and all the other fallocate ops need
> > to serialise page faults to avoid page cache level data corruption.
> > Yet here we see a problem resulting from a fallocate operation
> > racing with a page fault....
> 
> IIUC, fallocate operations which invalidates the page cache contents needs
> to take th invalidate_lock in exclusive mode to prevent page fault
> operations from loading pages for stale mappings (blocks which were
> marked free might get reused). This can cause stale data exposure.
> 
> Here the fallocate operation require allocation of unwritten extents and
> does not require truncate of pagecache range. So I guess, it is not
> strictly necessary to hold the invalidate lock here.

True, but you can make exactly the same argument for write() vs
fallocate(). Yet this path in ext4_fallocate() locks out 
concurrent write()s and waits for DIOs in flight to drain. What
makes buffered writes triggered by page faults special?

i.e. if you are going to say "we don't need serialisation between
writes and fallocate() allocating unwritten extents", then why is it
still explicitly serialising against both buffered and direct IO and
not just truncate and other fallocate() operations?

> But I see XFS does take IOLOCK_EXCL AND MMAPLOCK_EXCL even for this operation.

Yes, that's the behaviour preallocation has had in XFS since we
introduced the MMAPLOCK almost a decade ago. This was long before
the file_invalidation_lock() was even a glimmer in Jan's eye.

btrfs does the same thing, for the same reasons. COW support makes
extent tree manipulations excitingly complex at times...

> I guess we could use the invalidate lock for fallocate operation in ext4
> too. However, I think we still require the current patch. The reason is
> ext4_da_map_blocks() call here first tries to lookup the extent status
> cache w/o any i_data_sem lock in the fastpath. If it finds a hole, it
> takes the i_data_sem in write mode and just inserts an entry into extent
> status cache w/o re-checking for the same under the exclusive lock. 
> ...So I believe we still should have this patch which re-verify under
> the write lock if whether any other operation has inserted any entry
> already or not.

Yup, I never said the code in the patch is wrong or unnecessary; I'm
commenting on the high level race condition that lead to the bug
beting triggered. i.e. that racing data modification operations with
low level extent manipulations is often dangerous and a potential
source of very subtle, hard to trigger, reproduce and debug issues
like the one reported...

-Dave.
-- 
Dave Chinner
david@fromorbit.com


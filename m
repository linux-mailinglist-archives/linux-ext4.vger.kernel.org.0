Return-Path: <linux-ext4+bounces-9722-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF67B38BE9
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 00:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF89420416D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11E28643A;
	Wed, 27 Aug 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U/fGG2Uw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2E2080C8
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332105; cv=none; b=NWfW4gguS9IqZ/QHPcRBW74l77OIls/H1+inLRXwnSP95AaEQkvry3pzP52DxEKf/aI1fAdW3/JIqMRwvFo80bywp29+5yNOsUSGgkUBZhA9D0BDGhM9pP1DN7kCTJVcVM4SnBalSsePIHiqMAHnLYJdwJfwIqOPnkmf7soDrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332105; c=relaxed/simple;
	bh=gUSbciWGHJSH/JpDm7HHHqG5lHwQEqGuzdo99M+555I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KevPHLBTDuvAAk3Hur8G6P5meLy2+1QwZ4MHngICFbLk7bwq1QH5AjzJk8MRaZlMAxcQ4h/F/bZS3R4ye9hB2eQ2/yu548QodcR4hpbJ/6mHq5FO1YWwPlKv3QipbmNmwjTSGWfofWpIxhnTHBF/HoGPHdsfxvVDkUt1Ft9jiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U/fGG2Uw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2449978aceaso2485735ad.2
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756332103; x=1756936903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRXemL1WOR90JqvB5azJ40zCxySpJVvRo7r3rLc3Ivg=;
        b=U/fGG2UwBpYBMYO3JRPSzPxBQQLKLr0DdLM7TTnaccbvJWfi7CQx2CN4svzQUN6pSz
         PAt7Y3wNatSwMR9gIUGTV+Yj9A5hPkOfb02yfajOYXdQDKs7YuEbSBcSHUDFvlJe3obg
         YMb/exqXhqfkcOaZ+/nj4dqNeVAnpZdArm1ohnNy63uEt35s8yVVhRpYFQjobY/CvRa1
         mYc1IsscPeojFxMjdD0HqtwoOBt+/BGg3176fiMm/krAuuvrxCtcD4Y1fMCcjGOk073W
         6ymLH3YXMxuWTY6ZS7vI5GxYKiiMKAEwTQ5krrCGvZUlX4syMK1VkitNEEB1xC+vWzOA
         +4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332103; x=1756936903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRXemL1WOR90JqvB5azJ40zCxySpJVvRo7r3rLc3Ivg=;
        b=CT046ObcL1I9HOQYe1geRv84cXVz5gr6EXaujualnrUrihioMMy5NWzfWH0s/RTrOy
         UCWQYuM7yfwhwJ2c7Aly34ip6iJ2hIVbh7k+J+PF+SSmQOHZJxboD/YXGbwtpb3h7Yz9
         TNAcqCzIHt+zFBX3QhXZDyXj6nzqNF4rCmS5iEdUDpgvtCUvupvAfBtjd8Smco3NIwBn
         nyTEKaivohojGJgvkGtBCf/c713dztpPZ8dEfGqZEAUxkl9iMjWeveq0KJpP2J1PajDC
         1rcFYdZ0ubOwrl5KagJrVlGbXMNNApsEv5k8QOj+cS1HZ6dgpY0BxxxavdJPY2XR2xCx
         kVUw==
X-Forwarded-Encrypted: i=1; AJvYcCW2hJM+puI67NwFH6s0p+FPNCUe4l/cLnHKxle1izkae/T0cskdojVuxSBGqW8YLos6X7B3cUjKjSfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFkBOC8GgDlQfWaTsibiEeDfGQiRn6eUrDd89xJfxsGFvtE6G
	mR65bZYFHqbAqnZGvrvD0vLvSVjw7+sAQpKkQAAu+u2RLQVNDvrhgPVQAqEkYLcas8U=
X-Gm-Gg: ASbGncsiLNWoa3ODSpgCtsAu0NfNWn1T9uPvVVEsrxeBSbAWnfWS95j85I9o1voQ82B
	e08d29iucQliv2lBNcMR1mt1vQcnrxgKql1O53zzYCGfRZZAIs8jiCZ31Uss5PIq2s7wC9WMEmB
	pbnHtWjZsEYYKc+Vw64ZSmddqSB/HmiG5ybVlkXIIaMt+8zkhjV5Q3+LRZY9DrDgoA4ma8hWx7s
	UEDqfcG6JRDHHIXz54V6u76eZL4w0mmP0jT5MMdVnM21Cyo2Ztbaz7uXCAovztIdfNHBamKueDQ
	cIhXuoNP1LCT0DB6S0F1E9MyjQiQPxulq3+2fwrhQT9rf+DFWfRmopv5pb7X//h+YeGrjyUkqKT
	yPUK3p3Q9ImnfqBdbDR+oHZP6IbE51gfQjKs0CboJoaFScwKf8XkpVJt9yqccr/ox7Q3ifo5q5K
	8oMlaukOrQ
X-Google-Smtp-Source: AGHT+IEYVXzII1GgnlGLrms99adMC1KeEXXIyK7Szr2EAW6KvmLtHFK4fjFkfyUzwGUkKHyjR/4qEA==
X-Received: by 2002:a17:902:fd45:b0:244:214f:13a0 with SMTP id d9443c01a7336-2462efae428mr176577485ad.52.1756332103113;
        Wed, 27 Aug 2025 15:01:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248c34589e5sm11007985ad.9.2025.08.27.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:01:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1urOD5-0000000BvoF-2OcE;
	Thu, 28 Aug 2025 08:01:39 +1000
Date: Thu, 28 Aug 2025 08:01:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>

On Wed, Aug 27, 2025 at 02:32:49PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > We can end up with an inode on the LRU list or the cached list, then at
> > some point in the future go to unlink that inode and then still have an
> > elevated i_count reference for that inode because it is on one of these
> > lists.
> > 
> > The more common case is the cached list. We open a file, write to it,
> > truncate some of it which triggers the inode_add_lru code in the
> > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > it exists until writeback or reclaim kicks in and removes the inode.
> > 
> > To handle this case, delete the inode from the LRU list when it is
> > unlinked, so we have the best case scenario for immediately freeing the
> > inode.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> I'm not too fond of this particular change I think it's really misplaced
> and the correct place is indeed drop_nlink() and clear_nlink().

I don't really like putting it in drop_nlink because that then puts
the inode LRU in the middle of filesystem transactions when lots of
different filesystem locks are held.

IF the LRU operations are in the VFS, then we know exactly what
locks are held when it is performed (current behaviour). However,
when done from the filesystem transaction context running
drop_nlink, we'll have different sets of locks and/or execution
contexts held for each different fs type.

> I'm pretty sure that the number of callers that hold i_lock around
> drop_nlink() and clear_nlink() is relatively small.

I think the calling context problem is wider than the obvious issue
with i_lock....

-Dave.
-- 
Dave Chinner
david@fromorbit.com


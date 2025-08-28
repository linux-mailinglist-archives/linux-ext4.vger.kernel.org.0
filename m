Return-Path: <linux-ext4+bounces-9735-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65821B39BD0
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75881C24F0D
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4530EF80;
	Thu, 28 Aug 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mLPKNi9J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29B30E0F7
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381351; cv=none; b=GZ00vH8pWRwMQcV5BUcLfPUBqHMdLWqMuMyGifTUtLz26+yaxYKuXV2KJUCmwNEG+9dcAxOdrIsZub81+zJqUabDKibchX1YsAqyZrNvfy8TntaZ54NPbhQt+TxSpXmyXwxn4Pkn69KUIt7JMfLDQxk5mobNDw6Rl3PuFxlmZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381351; c=relaxed/simple;
	bh=pXGKWFVyVsRQelEkZGduol4s3jmhYKFx2akcAoEt+EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H44caZfHWmuCPreH0OaF7dvkj612C7qpfGfNquaBn4ikqRO+/MkpLio6svvbObjnP/+2S1vPuA8UGPANmXaUv3QsuzNqISdeoMXPrPXDbKbqdUSBlNP5ccO1xk+hZK2B4hh83dLuZk3+zf/3FM5P+O2fzXEVMCGW2NGKZn2WbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mLPKNi9J; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e9537b957caso569474276.2
        for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756381348; x=1756986148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2mtr4MahWN1CaeWoRERBafDml3LAYcHAVZcXe/+ugQ=;
        b=mLPKNi9J5ZHe7J0F5ExCMHZi80W3+MBpqsLUqPcu7z8vLe7wAPSnR5y/plrVPe0q9w
         FGiFGR4045PqryGPrpcMAhx9JrbkkMovLSGxymx7id3DvG5ZBuQYNF73/NxEE1Sm/NJo
         ogqfMyX560Tga3w9aFBZamZzjX2y8BJ5+X4xzxRcEnQ0uEpnIZIiFxJ8yVVy2dL+uQ1J
         aj7zwqJ1zFh0RYk8GntjbpclGFWKYlqmzEzqMDibuEbcuoPbFwMG/Q+WeijHPI/0fqmV
         QThshVmhegEeJxXLVLFWX0bI03bHfJlZqSWDacjywovrKOLPcc3TR1f1XEtSMIMzNm8L
         DItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381348; x=1756986148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2mtr4MahWN1CaeWoRERBafDml3LAYcHAVZcXe/+ugQ=;
        b=WdjRP16tNctExHLsv9DM5AT9BxZdjTpD1pOQjU+eSqu3PUsb6w+K2FdZAVPWpWZI3C
         P2K29eY9im7ZrawAMCJvMWkb27NgBZ7bpr+sYeK4Pnp/wX8fw4BshVnt7B3c2y3DZNM5
         MYmTVW0FgNgbAX9PdhDEMLYIJXf81E85WeGQN5gJijUhChUNpXQsKBUJ3R3dlC5ZZXNK
         HLl0pS93YEdEfLGRvCAQXoqUBj+N+QybUyj5Y8dOgPZVofyW4izhUeiYyeEStVxmQ5Ns
         TX2AJ8FeZm8FPh505BHb1n3ZfYAW8/VpoV0ex7DTtPi3PUDU0D59FLnY072+13bdDEq+
         IKMA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ILzcj5TnreF9l7oVTgwx2lQVrIrgOvuj7sdS58/cZD5pSpKJTYi4iPP2wiohHHHiDJmEPDjQcYNO@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdPQecv3YugNd3HEIYgcz1/tLLCo3crx6yRfY1pFZ1TKAkl9t
	hmP3sMMvoteomhFG8OrDjXerXf6FTpxoWPz6n6K5wJiWTNzZ1+CeYYAJQHxrU1w/hSw=
X-Gm-Gg: ASbGncsKw59Zy/B2EXdr0GzKN2F9sGhLWk3zuokZ7dHQUHh0oQaJT37hIICk2njDx8V
	GgFsV3vp4fBP2Nn9O42A7TNam11yJDDsp8E+JYfUq7sqg15qfKj0LBq3ZvCpAxXxepAyRzAY1bR
	LLPtzR7igpRbC7twwFXFrWjzP2VueOK1GeLAkiC1OY2vrgepdgMeXoaoiC4CvXuQJ22nZSsNAgM
	Wj9H75fYivTh5sHMa/J8pXcKHZqka358NajIkrP0+dGqkb1Gch41lrMwlaAT4a6LyzL6RA9Nw6p
	KDsMBgx80MaXuP0RU4MzhwVPEQ4q5ycTyG9ir4i6xn+WAAVxFsGW0c7gEaybs0IpWYlpRaHiXUJ
	4M/6GZ9Zu8bJ5DL1q1Wd1Y1O7Um5689U3Vg4LluRqzw82Efy7x9tmvEYhNRc=
X-Google-Smtp-Source: AGHT+IHzU9aYDYU3YAH3hfgvOIUS16goFJso3B9bUXGDolR4NrbvimCaMQ06YKvjMpun0m8FzBSWLA==
X-Received: by 2002:a05:6902:c06:b0:e96:f9fe:2f31 with SMTP id 3f1490d57ef6-e96f9fe30f7mr5099573276.42.1756381347519;
        Thu, 28 Aug 2025 04:42:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17093e9sm38418147b3.7.2025.08.28.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:42:26 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:42:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Message-ID: <20250828114225.GA2848932@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
 <aK980KTSlSViOWXW@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK980KTSlSViOWXW@dread.disaster.area>

On Thu, Aug 28, 2025 at 07:46:56AM +1000, Dave Chinner wrote:
> On Tue, Aug 26, 2025 at 11:39:16AM -0400, Josef Bacik wrote:
> > When we move to holding a full reference on the inode when it is on an
> > LRU list we need to have a mechanism to re-run the LRU add logic. The
> > use case for this is btrfs's snapshot delete, we will lookup all the
> > inodes and try to drop them, but if they're on the LRU we will not call
> > ->drop_inode() because their refcount will be elevated, so we won't know
> > that we need to drop the inode.
> > 
> > Fix this by simply removing the inode from it's respective LRU list when
> > we grab a reference to it in a way that we have active users.  This will
> > ensure that the logic to add the inode to the LRU or drop the inode will
> > be run on the final iput from the user.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Have you benchmarked this for scalability?
> 
> The whole point of lazy LRU removal was to remove LRU lock
> contention from the hot lookup path. I suspect that putting the LRU
> locks back inside the lookup path is going to cause performance
> regressions...
> 
> FWIW, why do we even need the inode LRU anymore?
> 
> We certainly don't need it anymore to keep the working set in memory
> because that's what the dentry cache LRU does (i.e. by pinning a
> reference to the inode whilst the dentry is active).
> 
> And with the introduction of the cached inode list, we don't need
> the inode LRU to track  unreferenced dirty inodes around whilst
> they hang out on writeback lists. The inodes on the writeback lists
> are now referenced and tracked on the cached inode list, so they
> don't need special hooks in the mm/ code to handle the special
> transition from "unreferenced writeback" to "unreferenced LRU"
> anymore, they can just be dropped from the cached inode list....
> 
> So rather than jumping through hoops to maintain an LRU we likely
> don't actually need and is likely to re-introduce old scalability
> issues, why not remove it completely?

That's next on the list, but we're already at 54 patches.  This won't be a hot
path, we're not going to consistently find inodes on the LRU to remove.

My rough plans are

1. Get this series merged.
2. Let it bake and see if any issues arise.
3. Remove the inode LRU completely.
4. Remove the i_hash and use an xarray for inode lookups.

The inode LRU removal is going to be a big change, and I want it to be separate
from this work from the LRU work in case we find that we do really need the LRU.
If that turns out to be the case then we can revisit if this is a scalability
issue.  Thanks,

Josef


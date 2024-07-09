Return-Path: <linux-ext4+bounces-3143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C252292AEE8
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jul 2024 06:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F342B1C21664
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jul 2024 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2750E12D745;
	Tue,  9 Jul 2024 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GHGMGzBJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74012C549
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jul 2024 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720497580; cv=none; b=IR68fTNW8+ijjfUPya4DzMs8souzs2FmMm+M6CHArVCKAaCPhjxaMWBsSOcARsfq0woaWDxTimVzS4i9gS8HbkHOkSLp21uuY8ebyDEJByhPVhUW3Sr7KgtXhiGp4K7sS5Xv8qqKChHxoFnQqAH2RMtM173ArEIccKLVfx10ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720497580; c=relaxed/simple;
	bh=pnt5oZTDim6QNiBcwnKkDGjfbsrvkshPUAFtfjidKxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwCq3+EOEiPsOiB1Zt4KW1y1Ie7i5ZTkA8doWOasfAHjq6LiaiEE0vZSQd25QOu63fMQhhKEvFEG2bjEo03Xrnd2iJ/a3075xopZABNLhx50DwHH76iHOvTuutsdRLjTZsSkUTkUte/SYBtK/ldeOgR2KOygS826ri3JWBNDvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GHGMGzBJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-31.bstnma.fios.verizon.net [173.48.117.31])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4693xBWq015651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720497553; bh=YDdYgrCa/y4KZDI/Yq+oNBPBBOfuf/072z7GMgWJcz4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GHGMGzBJ8gi2p2HoewF3QKyABGS3T85hvhugt6RmwznTmn9OnCXxiLWzFPDDh+pAT
	 pSHV80bZG0c4JM8Ama6jB71EaAg5Rn5aaR8mV912hnzDEFsPIXP13Sjk34Z1zIuq+P
	 jhYGHFqmCh28Yhkoo2n09HPxiRVj9SgvPr8UeZJSsGmRZAQVCxV2B6tzsFuIyLDcY6
	 Jx9dFqCNSWfaPk804sjR0GWuj9iGmalQA1DjzBuxhqVMIjxDCG1hcojKI6v6MRPtRJ
	 Y5UscseVfqeaEAj3PRyKOmCp7AI9WHw4wBsSx2R0nGe6LKCeWu09Sm0REWGVzKn9fl
	 w9tRMX0g4OJFw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1FD7C15C026C; Mon, 08 Jul 2024 23:59:11 -0400 (EDT)
Date: Mon, 8 Jul 2024 23:59:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
Message-ID: <20240709035911.GB10452@mit.edu>
References: <20240529092030.9557-1-luis.henriques@linux.dev>
 <20240529092030.9557-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529092030.9557-2-luis.henriques@linux.dev>

On Wed, May 29, 2024 at 10:20:29AM +0100, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> This patch fixes the issue by re-enqueuing an inode into the STAGING queue
> during the fast commit clean-up callback if it has a tid (i_sync_tid)
> greater than the one being handled.  The STAGING queue will then be spliced
> back into MAIN.
> 
> This bug was found using fstest generic/047.  This test creates several 32k
> bytes files, sync'ing each of them after it's creation, and then shutting
> down the filesystem.  Some data may be loss in this operation; for example a
> file may have it's size truncated to zero.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

This patch is causing a regression for the test generic/472
generic/496 generic/643 if fast_commit is enabled.  So using the
ext4/adv or ext4/fast_commit configuration, e.g:

% kvm-xfstests  -c ext4/fast_commit  generic/472 generic/496 generic/643

For all of these test, the failures seem to involve the swapon command
erroring out:

    --- tests/generic/496.out   2024-06-13 18:57:39.000000000 -0400
    +++ /results/ext4/results-fast_commit/generic/496.out.bad   2024-07-08 23:46:39.720
    @@ -1,3 +1,4 @@
     QA output created by 496
     fallocate swap
     mixed swap
    +swapon: Invalid argument
    ...

but it's unclear why this patch would affect swapon.

I've never been able to see generic/047 failure in any of my ext4/dev
testing, nor in any of my daily fs-next CI testing.  So for that
reason, I'm going to drop this patch from my tree.

The second patch in this series appears to be independent at least
from a logical perspective --- although a minor change is needed to
resolve a merge conflict after dropping this change.

Luis, Harshad, could you look in this failure and then resubmit once
it's been fixed?  Thanks!!  Also, Luis, can you give more details
about the generic/047 failure that you had seen?  Is it one of those
flaky tests where you need to run the test dozens or hundreds of time
to see the failure?

Many thanks!!

					- Ted


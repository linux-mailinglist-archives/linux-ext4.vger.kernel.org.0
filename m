Return-Path: <linux-ext4+bounces-6518-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19376A3DD33
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DB116B8D5
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C91C5D7E;
	Thu, 20 Feb 2025 14:46:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C7846C
	for <linux-ext4@vger.kernel.org>; Thu, 20 Feb 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062782; cv=none; b=XD/N0LTt3W0SHLIL3yYKWG4nJMHNxD6/2KZkG5K4q1mV/U/zOL86Z4N+y06yu2jqBsLj2xECo8cMzyZsoIX7NrJtYoUGwrsg4p68G4XREAoBJ5WdcHOZiFy8Er7pQR85fo+wUWLzXPOVY+NtLrM6lvEO8Cf3iu/usWtYaJDivdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062782; c=relaxed/simple;
	bh=tWUpuUXmV+QXaMp7Dgf/p+X4Mer4cA6yFBhX7vAz90Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk702lK0Is9CKSA7kjxVYmd5hlYAf20FeUXvMaf0bcKufWcS52o+WMwPLLI1wZeIRvu9TleWyJjFXpi9ZOdVFYRVZFCCHieVObvxeK2xrw6ls4T2+o/MDleLbPoTfEJsWTEGnt0SlVLZy+AxWmBqm/Noj0bF0JXoMLo97Wt0CAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-12.bstnma.fios.verizon.net [173.48.114.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51KEkBNh001914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:46:12 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 445A52E011A; Thu, 20 Feb 2025 09:46:11 -0500 (EST)
Date: Thu, 20 Feb 2025 09:46:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>, drosen@google.com
Subject: Re: [PATCH -v2] ext4: introduce linear search for dentries
Message-ID: <20250220144611.GA2150479@mit.edu>
References: <20250212164448.111211-1-tytso@mit.edu>
 <20250213201021.464223-1-tytso@mit.edu>
 <9ED1B796-23FE-422A-B6C9-5BEAE4FAA912@dilger.ca>
 <87cyfdvcdc.fsf@mailhost.krisman.be>
 <007522B4-E6F6-4DCA-9355-B1FBB1C1A6AF@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007522B4-E6F6-4DCA-9355-B1FBB1C1A6AF@dilger.ca>

On Wed, Feb 19, 2025 at 06:58:00PM -0700, Andreas Dilger wrote:
> Sure, my suggestions are aimed at minimizing the impact of this extra
> (and very expensive) fallback mechanism.  If there is a direct way to
> determine which filenames were impacted by the earlier bug, and then
> do only two lookups (one with the "buggy" casefolded name, one with the
> "good" casefolded name) then this would be (at worst) a 2x slowdown for
> the lookup, instead of a 1000x slowdown (or whatever, for large directories).
> 
> Also, since the number of users affected by this bug is relatively small
> (only users running kernels >= v6.12-rc2-1-g5c26d2f1d3f5 where the broken
> patch landed and v6.13-rc2-36-g231825b2e1ff when it was reverted), but the
> workaround by default affects everyone using the casefold feature, it
> behooves us to minimize the performance impact of the workaround.

This is why I added a new encoding flag, SB_ENC_NO_COMPAT_FALLBACK_FL,
so if the system administrator is sure that the device never had that
alternate encoding, we don't have to pay that performance penalty.

The problem is the original reason for making the change was a
"security vulnerability" where if you had one of these invisibile
zero-length characters in a directory named ".git", this could cause
someone who was using git on a case-fold directory vulnerable to an
attach where if they pulled from reponsitory that was controlled by a
malicious entity, that this could cause the pull to resullt in an
overwrite of .git/config.  So it was a relativey narrow range in
Linus's tree, but the "security fix" was backported into LTS kernels,
and pushed out to a large number of Android handsets which do use case
folding.

This is why the default is to do the fallback; other than Android
handsets, the number of user of case folding is mercifully quite
small.  And the problem was detected on Android machines, where users
who had files that included characters such as '❤️' or '❤' could no
longer access them; fixing that regression had to take priority.

> We have been looking at adding casefold support to Lustre, in order to
> improve Samba export performance (which also has a "scan all entries"
> fallback), and we cannot control how many files are in a single directory.

For Lustre, if you know that no one is going to be using kernels with
the changed encoding, you could just aways set
SB_ENC_NO_COMPAT_FALLBACK_FL and just be happy.  If you think that
Lustre users might actually use git, and you are worried about this
"security vulnerability", we could ask the git project to fix it at
their level.  I personally don't care that much, since I'm not sure
how many people would really want to be doing development using git on
an Android handset using Termux.  :-)

> It seems likely that systems have been using casefold directly on ext4
> for Samba as well.  If the performance impact of "scan all entries" is
> noticeable for Samba, then it would be noticeable for this fallback.

I'm not sure how many Samba installations actually do use it, but if
they do, but it might not be that bad, since we do have negative
dentries for the common misses in a search path (for example).  And if
it is safe, we can provide utilities to make it easier to
set SB_ENC_NO_COMPAT_FALLBACK_FL.

> One option would be to have the kernel re-hash any entries that it finds
> with the old filename, so that the directories repair themselves, and the
> workaround could be removed after some time.  Also, have e2fsck re-hash
> the filenames in this case, so that there is a long-term solution after
> the kernel workaround is removed.

There are quite a lot of things that can be done, but quite frankly,
I'm not really that excited to invest the time to do something more
complicated.  If someone does want to spend more time, including
changes that might involve another encoding bit so we could actualy
safely eliminate the "dangerous" zero-width characters while allowing
'❤️' or '❤' to be distinct and without breaking file systems that have
those characters, I'm certainly willing to entertain patches.

      		      			   	     - Ted


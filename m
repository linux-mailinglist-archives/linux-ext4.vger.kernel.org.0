Return-Path: <linux-ext4+bounces-13580-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /+9WBKWIhWn3DAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13580-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 07:22:29 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 673ECFA9C3
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 07:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7E11302E0FC
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA03019B0;
	Fri,  6 Feb 2026 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oed8r6If"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D42FFF88;
	Fri,  6 Feb 2026 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358943; cv=none; b=cRTGxYNE5g8r0ey7SdRGTvjiVJCH1+2xtJ59lUStLJn1gO6CvA/1Ea+sxV3TGUZvDstQ9HPjqZI/O+rYThlBznwq7wMuZzEicZhYRUHuGeDm+ikxmqRPINP1LdyDiIMZDdE4MKd0uTj949bfE0GHiGYgf6xxcsmXbdEG0SEoSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358943; c=relaxed/simple;
	bh=1K5F39xrueJmqgYxCys2rQ6ms33LqgJs6knC9gw/U0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czUqL/hVPa8t7HpPU4r+g1qGPxsbeRuEFcPvk40KtwBhEnoSuY945WynehPcX2M0hwMVsg4Sjwpk6mE+gGZMNAMYNDzrgmlKVwrz5Rx7vkwiQTuR9D0K0jUw4gmCLKIsRwS4q4e9e6yFffmK+OLKeYppIP0H6wT6UvAi8mRUors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oed8r6If; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BD4C116C6;
	Fri,  6 Feb 2026 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770358942;
	bh=1K5F39xrueJmqgYxCys2rQ6ms33LqgJs6knC9gw/U0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oed8r6Ify6cfuE2hstugU3oE//WHIlh44TCGae4CZq6626hz+K1G37mmZKFi85EgB
	 JSCQxwrFYcCd6QPSjClTCQFg096vRZAOQGIP11ZASiri93Xgym/RNJ+mYmDY5OdJV5
	 M5uBhw8ktkH7MN9m6Id1FszBZPEyAqWpT0LMnxc512h7LlSMKCJB07ojQwOaoaqUql
	 ZEqmyqBTljgjskB/1XJS3Myqhx2vOZd9JNwwvFgC6iIetNNBTizsfsp0jXV0bpV0jC
	 QNpNfBoAaQrcg/LLPZ1V7Q7hvqeecwQDjBLJGAxpRvIXjOt9qLb1qhUTHxgiATbBXa
	 V+j0Nyl5knh9A==
Date: Thu, 5 Feb 2026 22:22:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <20260206062222.GN7686@frogsfrogsfrogs>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
 <aYGGHMfca4gbB2vy@infradead.org>
 <20260205165624.GA7703@frogsfrogsfrogs>
 <aYWDTrxRhDAE2efB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYWDTrxRhDAE2efB@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13580-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 673ECFA9C3
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:59:42PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 05, 2026 at 08:56:24AM -0800, Darrick J. Wong wrote:
> > "In Linux 7.0 we've changed the extended attribute update code to try to
> > take a shortcut for performance reasons.  Before walking through the
> > attr intent state machine (slow), the update will check to see if the
> > attr structure is in short format and will stay in that format after the
> > change.  If so, then the incore inode can be updated and logged, and the
> > update is complete (fast) in a single transaction.
> > 
> > "(Obviously, for complex attr structures or large changes we still walk
> > through the intent machinery.)
> > 
> > "However, xfs/018 tests the behavior of the "larp" error injector, which
> > only triggers from inside the attr intent state machine.  Therefore, the
> > short format tests don't actually trip the injector.  It makes no sense
> > to add a new larp injection callsite for the shortcut because either the
> > single transaction gets written to disk or it doesn't."
> 
> Make sense, but from looking at the test I'm still a bit confused
> why it fails (vs just not testing something too useful)

The golden output no longer matches because the attr update doesn't
return EIO and shut down the filesystem due to the larp injection.

--D

> > 
> > > Only vaguely related, but should we ensure to always clear error
> > > tags after the test runs to ensure they don't leak into other tests?
> > 
> > They go away with _scratch_remount because error tags only live as long
> > as the mount.
> 
> True.  While still leaves me puzzled why generic/753 now hits attr log
> recovery for me sometimes.
> 
> 


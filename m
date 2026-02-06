Return-Path: <linux-ext4+bounces-13582-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBMVDd2JhWkWDQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13582-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 07:27:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12854FAA9D
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 07:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92ED33010634
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2953009D4;
	Fri,  6 Feb 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCBtn2Vx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCC2E11D2;
	Fri,  6 Feb 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359237; cv=none; b=i61c6sNY4knHoibq4SlfHzPJ9jjpp1XlhilwfOCYsE7ufzbWpVwwwPG8xRtmNho04x7BMIA2if+JJQqwcJf7l9xzVft+KmqLw6RHv8bbpCYOwclDZPMzE/0x8SdJ3m9qTE4qTV2PI6G2GGm/je5NuVxWfvCxXl3HZe3FPUqBA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359237; c=relaxed/simple;
	bh=EFK7bINGhhgJnC2FGSGhoGq4drzrbQYw+dzKcFB7XRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZVyeoIN8vksaf7IAeFWGIj7sOwfzLh4zZH2UPqfCrrl2UvM7FSUN5kDpBkRfIDm4DTjRhRn5bFOk1P4SVOZIE+PuiuBNzxOakQEBWy/1u1zqNYAFtaq9L7v0hft7xGNXK/zCr4s1nFB547p4pVCqsfjfr/LIDXLQdM+spDjgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCBtn2Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503EC116C6;
	Fri,  6 Feb 2026 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770359237;
	bh=EFK7bINGhhgJnC2FGSGhoGq4drzrbQYw+dzKcFB7XRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCBtn2Vx55VJ+hGY3lA03Ucgw6hl4etuc/Z0tBcOXcr0ySKJtDMLigp8r71Jzk98O
	 jenOuVHhzeLuhUTxJqHZnKa4KI81/xeB+okuUEY4HDvAeUZEgtjZBJEyVV0yQE4NbL
	 GBIsMs1web2hP532MP0DRQsY0ceGErCZ8TE5mdUTtOphpxHpEYOK+hqckKWcVD4pOU
	 yF/yZjqkS0UC4SKxN/9eQfMDc0lGPXEMxFpQlfNupEXvuYaHdi4/4maW+8FeWReQUH
	 ikkZyt6JntUSR6aUGz6q9TQYGi56SkB4ywKlUSg6YxI1lE0JK7pUWdEToA0QhIPD8w
	 e2S/ofKrNBo8w==
Date: Thu, 5 Feb 2026 22:27:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <20260206062716.GO7686@frogsfrogsfrogs>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
 <aYGGHMfca4gbB2vy@infradead.org>
 <20260205165624.GA7703@frogsfrogsfrogs>
 <aYWDTrxRhDAE2efB@infradead.org>
 <20260206062222.GN7686@frogsfrogsfrogs>
 <aYWJhGU-7YfXr2HR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYWJhGU-7YfXr2HR@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13582-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12854FAA9D
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:26:12PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 05, 2026 at 10:22:22PM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 05, 2026 at 09:59:42PM -0800, Christoph Hellwig wrote:
> > > On Thu, Feb 05, 2026 at 08:56:24AM -0800, Darrick J. Wong wrote:
> > > > "In Linux 7.0 we've changed the extended attribute update code to try to
> > > > take a shortcut for performance reasons.  Before walking through the
> > > > attr intent state machine (slow), the update will check to see if the
> > > > attr structure is in short format and will stay in that format after the
> > > > change.  If so, then the incore inode can be updated and logged, and the
> > > > update is complete (fast) in a single transaction.
> > > > 
> > > > "(Obviously, for complex attr structures or large changes we still walk
> > > > through the intent machinery.)
> > > > 
> > > > "However, xfs/018 tests the behavior of the "larp" error injector, which
> > > > only triggers from inside the attr intent state machine.  Therefore, the
> > > > short format tests don't actually trip the injector.  It makes no sense
> > > > to add a new larp injection callsite for the shortcut because either the
> > > > single transaction gets written to disk or it doesn't."
> > > 
> > > Make sense, but from looking at the test I'm still a bit confused
> > > why it fails (vs just not testing something too useful)
> > 
> > The golden output no longer matches because the attr update doesn't
> > return EIO and shut down the filesystem due to the larp injection.
> 
> Ah, that's the missing bit.  Can you add that blurb to the commit
> message?

Will do!

> With that and the above:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

--D


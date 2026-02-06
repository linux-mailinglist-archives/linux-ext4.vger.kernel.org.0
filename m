Return-Path: <linux-ext4+bounces-13579-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGu4LV6DhWmqCwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13579-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 06:59:58 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F11FA828
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 06:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25511300250D
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 05:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5F2EBB8D;
	Fri,  6 Feb 2026 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P4GLWakF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF32EA732;
	Fri,  6 Feb 2026 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357591; cv=none; b=IlQdBF7J+Wh4pGX+k0vfPAg7nbLzmRU3z55JhjQSlH1Bru1CW4rjS8fjPLBsgH7rI0vwDSyBC9WVtkHZZlw97e49SWNAhATzpUdmw4wh3q2MoHH4TJdpGKAWufLNw6ZY8BUwq4UJCKDvSt+pvwEOw2bjfSqzi5ToElxdJvhhvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357591; c=relaxed/simple;
	bh=ww5dN9yuAISM64Qe79VIwlx2pZZ5zM/e3VF/JnDkCZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INqg7/nbrKAVzM+TKTU55PmEWXSQ1VvG1J186bjwbqcJy9fjlELcOEvNR8a/VAogtqIRn8nuNy8BoRslv7SX0MDnOlhqQnsH7subGX4qkH+28ZAr50//NFvDPH3DRCsZywNItK6hgunpF6j/TszKBThetG66kHRyuHM8O7JMhdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P4GLWakF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ksbCmByBEVeiM/fDR99S7A8cO7127zWVvzqG6QESdXQ=; b=P4GLWakFNl+hqLIiwiiNIKZ5R4
	eWgaYSzNIyXwa5WzO2xgu9JBCfNTPF4Qo3sUANM/ZiGTMlWVsWOmOmmGq17YMsk/maILNkVFbKo4P
	JnIpis7sGgjBqORUMpmW6TbSJiadWJcYFYKH7kVRZfl6RnbKmCQvfS4vWS56jGnzyMLIBNQXtBUtC
	vyxEtm28JAl/0mjF4iP3ZukQc8MWSj4PoED7XVecxHs8++ZtbqeRXaIQFHdTFU2DRUdOsBPY2hi0Q
	wdXrxkIC1lExYTHjK5X2RlV33LCw1s6aTcT+N6wLPqosK3CHD1uBUVsm8MmDuQTkeY5Umv8DBEBI4
	7ibq9adg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voEsY-0000000AvMV-0DnD;
	Fri, 06 Feb 2026 05:59:42 +0000
Date: Thu, 5 Feb 2026 21:59:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com,
	linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <aYWDTrxRhDAE2efB@infradead.org>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
 <aYGGHMfca4gbB2vy@infradead.org>
 <20260205165624.GA7703@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205165624.GA7703@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13579-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: D5F11FA828
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 08:56:24AM -0800, Darrick J. Wong wrote:
> "In Linux 7.0 we've changed the extended attribute update code to try to
> take a shortcut for performance reasons.  Before walking through the
> attr intent state machine (slow), the update will check to see if the
> attr structure is in short format and will stay in that format after the
> change.  If so, then the incore inode can be updated and logged, and the
> update is complete (fast) in a single transaction.
> 
> "(Obviously, for complex attr structures or large changes we still walk
> through the intent machinery.)
> 
> "However, xfs/018 tests the behavior of the "larp" error injector, which
> only triggers from inside the attr intent state machine.  Therefore, the
> short format tests don't actually trip the injector.  It makes no sense
> to add a new larp injection callsite for the shortcut because either the
> single transaction gets written to disk or it doesn't."

Make sense, but from looking at the test I'm still a bit confused
why it fails (vs just not testing something too useful)

> 
> > Only vaguely related, but should we ensure to always clear error
> > tags after the test runs to ensure they don't leak into other tests?
> 
> They go away with _scratch_remount because error tags only live as long
> as the mount.

True.  While still leaves me puzzled why generic/753 now hits attr log
recovery for me sometimes.



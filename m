Return-Path: <linux-ext4+bounces-13581-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ+FCYyJhWkWDQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13581-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 07:26:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 612CFFA9E4
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 07:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 028C03008095
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704703002D8;
	Fri,  6 Feb 2026 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6ngIGnw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FF2E11D2;
	Fri,  6 Feb 2026 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359173; cv=none; b=rMuVtFYEpSz8h6XP+3O/Zm/KWt0eZJ2Kl/T8oVAmerdmtMUP/QoBxK3Ivk3aVyC0F4lOUCIZjRrmAJXUQJ4OsrJ8Iu/GKiYZrXfqG3tVLNPIGVij3SV07g8sqxpfsH1tXaVbP17Pg525QjH2+Fu2teC0nna3pJgy0YpRV1Q42ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359173; c=relaxed/simple;
	bh=HSEcY+AmfonRTX1o20RwTTeaFjnSoRBIo6axDNOfEN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNk+3M1cdI6PU+d2ij5FwK4lmOdbIwP8VEZUCMgE+XB0DYY03wK+WzAJa0sDDGAf9Ivo0abmKjWwj14wzsjcTWW42C42dogZ/G5WZbYGDLaWxAVnkW8DKRVHB8aPBH5yHb+rypM4kLTpHfvb300voif//UCXPQt5EkiHTpz/yKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k6ngIGnw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJB45Vb4k/+G1p59CEuJEsFMT+4qltm1VSjsyCW4hfs=; b=k6ngIGnwoNdzgFyb6eR70CiMnx
	xDy/+5IU4mULlNf9fcRGor5KB9jf0feFO2NfHRndqoVI19Js/aqizu9plYZsWT+jDapJAg0IiyotX
	V8y+VXdXCHSreKX1IRenVmRjLP2+rtJQ+3bcFZNGKc62yYipDfK4paw8eNZ2ybcPPUKM6kNiLayMg
	nAQmV8eUhD9MFUnsax2bORCURg8sL7EJUY0to16W9LnhisEPN0wBv2DsR8itB6wQhuRNae8FaiOwR
	+tzW+uVjAQF1mzE1rbmL6BuE4Y8FKDXTw04QREACUJcGLWIp+GEkLEXgld8OJ67lEh/rqTvmVlqrz
	61WflkXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voFIC-0000000Awkc-167I;
	Fri, 06 Feb 2026 06:26:12 +0000
Date: Thu, 5 Feb 2026 22:26:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com,
	linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <aYWJhGU-7YfXr2HR@infradead.org>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
 <aYGGHMfca4gbB2vy@infradead.org>
 <20260205165624.GA7703@frogsfrogsfrogs>
 <aYWDTrxRhDAE2efB@infradead.org>
 <20260206062222.GN7686@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206062222.GN7686@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13581-lists,linux-ext4=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 612CFFA9E4
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:22:22PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 05, 2026 at 09:59:42PM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 05, 2026 at 08:56:24AM -0800, Darrick J. Wong wrote:
> > > "In Linux 7.0 we've changed the extended attribute update code to try to
> > > take a shortcut for performance reasons.  Before walking through the
> > > attr intent state machine (slow), the update will check to see if the
> > > attr structure is in short format and will stay in that format after the
> > > change.  If so, then the incore inode can be updated and logged, and the
> > > update is complete (fast) in a single transaction.
> > > 
> > > "(Obviously, for complex attr structures or large changes we still walk
> > > through the intent machinery.)
> > > 
> > > "However, xfs/018 tests the behavior of the "larp" error injector, which
> > > only triggers from inside the attr intent state machine.  Therefore, the
> > > short format tests don't actually trip the injector.  It makes no sense
> > > to add a new larp injection callsite for the shortcut because either the
> > > single transaction gets written to disk or it doesn't."
> > 
> > Make sense, but from looking at the test I'm still a bit confused
> > why it fails (vs just not testing something too useful)
> 
> The golden output no longer matches because the attr update doesn't
> return EIO and shut down the filesystem due to the larp injection.

Ah, that's the missing bit.  Can you add that blurb to the commit
message?

With that and the above:

Reviewed-by: Christoph Hellwig <hch@lst.de>


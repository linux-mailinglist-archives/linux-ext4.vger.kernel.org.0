Return-Path: <linux-ext4+bounces-13548-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMs+O7zLhGk45QMAu9opvQ
	(envelope-from <linux-ext4+bounces-13548-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 17:56:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FDF58E9
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36973300D62E
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6543C044;
	Thu,  5 Feb 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSQkoGcp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFB43637F;
	Thu,  5 Feb 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310585; cv=none; b=atdsnipc/ec7TRnf/ndlfYRiteeV8A/UggyqucgY+h7b+Txk5OBitcXV77B/Uvkk2L6+l4CKcesrYWseD9YyxZVlq8eLrMylluyDdUEedWYI6YItkFA2m4IIKsCYbs3d3Rr7NAdOwZN/J1DJPFMymfVYYr2iKcqA2ni4p5sX4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310585; c=relaxed/simple;
	bh=5/UcDDrVi+HDThLKBk6WlNOILJ3OP5Q42gAfavRjINw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv1bLtDr9RLQolhdLRC8RpZu054w0ZxvjYVC802E6nlTTf07Ap1cmBbQhjcZ1Tk73VoAnqKXzW/ifh+Xebs19E+mEZANuq4Fx5Zrjm3NzSlUPPfP2/JX02LGA8cchBwTu8/JhwvlXmvXsGiZxpwvxpoQPy1sBJD0EJGd6k89Z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSQkoGcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8DFC4CEF7;
	Thu,  5 Feb 2026 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770310585;
	bh=5/UcDDrVi+HDThLKBk6WlNOILJ3OP5Q42gAfavRjINw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSQkoGcp5hjPq0Ni+HZzR9O9GDLZWFHzMZxMTQL20OWWnxUI+qX5BrdIdLhdE6PoU
	 L+1xABHsU5McWpPS4e4zwUI0JuzTirNzFitAGOu8+aeK4P74UQjytbjWzRHi2BuiHI
	 pWpVaUc9cQ0ARc4gBEfHVERCZ7pxZH0UrT8cICjYn1lcS1SwNpMK3qee3S+Hy/tjiQ
	 IYLDTanWYbtV+frXnxARou1cJnmW8tJvvG/x+Ah0mjrhJrWANpUulG722COyQQh28I
	 K/0V51vihstSk5NzZSuTatj62mnaPxQSW0aKFShyWlXxpKHt77zA0UojGxCCedeC36
	 P/Q2rPstwVa3A==
Date: Thu, 5 Feb 2026 08:56:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <20260205165624.GA7703@frogsfrogsfrogs>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
 <aYGGHMfca4gbB2vy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYGGHMfca4gbB2vy@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13548-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 681FDF58E9
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 09:22:36PM -0800, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 11:11:12AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Now that we can do xattr updates in a single transaction (as opposed to
> > using the attr intent machinery) if we keep the attr structure in short
> > format, remove the attr intent item log recovery tests.
> 
> I have a bit of a hard time parsing this.  Currently with xfs/for-next
> these fail, so removing them fixes it, which is probably what drove
> this.

Yep.

> But looking through the patches I'm not sure why they actually are
> failing - the updates are logged as part of the inode item, and
> nothing in test_attr_replay seems to actually look at log specific
> bits?

I've rewritten the commit message; does this help?

"In Linux 7.0 we've changed the extended attribute update code to try to
take a shortcut for performance reasons.  Before walking through the
attr intent state machine (slow), the update will check to see if the
attr structure is in short format and will stay in that format after the
change.  If so, then the incore inode can be updated and logged, and the
update is complete (fast) in a single transaction.

"(Obviously, for complex attr structures or large changes we still walk
through the intent machinery.)

"However, xfs/018 tests the behavior of the "larp" error injector, which
only triggers from inside the attr intent state machine.  Therefore, the
short format tests don't actually trip the injector.  It makes no sense
to add a new larp injection callsite for the shortcut because either the
single transaction gets written to disk or it doesn't."

> Only vaguely related, but should we ensure to always clear error
> tags after the test runs to ensure they don't leak into other tests?

They go away with _scratch_remount because error tags only live as long
as the mount.

--D


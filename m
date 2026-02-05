Return-Path: <linux-ext4+bounces-13551-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BlBBzjShGlo5gMAu9opvQ
	(envelope-from <linux-ext4+bounces-13551-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 18:24:08 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDFF5DDC
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870653017029
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44832FC037;
	Thu,  5 Feb 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot3+1e1J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E021A453;
	Thu,  5 Feb 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311977; cv=none; b=dtatqlPrfpg9B9cmlono6lV39va3mymA/5F0R0J+Sd8dQQjb+exPKYsnoyG/d2Q4b8PqrKgd4WpOBnjEr+hyUCfX2f0lu3zah48zDerPM1/DAQxINFhjjr/9T/+E+uA6TG+OJpzobF53Ven2IHK4+HJ7sJTDN5uJRIe4tfcwEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311977; c=relaxed/simple;
	bh=GBmx7iVATtfHF8n4egM8Oksu9mKWBze4Z2VkWqY6Fow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgG0DyNJKrF9Eu5bmwM0G3KwBAfTlClxYidOZNlkTZUKDnJeK8Zl9O8tM6d28TTLDhpf72QUIQNkPiEA6xMmnZguA9jlNmTCPj+nZIt/x2i9A33XdXTiaQDeDX1zbG+SplqgFkigNbKsZsInXVbd5xBMsd6Pz8izkr9gRS7mtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot3+1e1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC058C4CEF7;
	Thu,  5 Feb 2026 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770311977;
	bh=GBmx7iVATtfHF8n4egM8Oksu9mKWBze4Z2VkWqY6Fow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ot3+1e1JPzx2gClbTEkU43JbjLRPLuw6mAzjCNMZJjgfpdCu1sLKJfKBGP22h5gur
	 ZCcRFahuXT9GOFU17CWhHWVKjunHFO/6ZvHOfMD9lT34qXk3wb2CGzhmMf6OCLA0HS
	 vZbejmT+EFcXCw+VJNOLfmFe3AG47wfA41ifNI52UqwKELAFhGzsCAk0Qj6jgw8Z2b
	 cOpBqTM9gKpBIGST9ESgc35JfPx18hDcUZtfQB5y2nZIGoLfdqtTpYj6pNMEX4jz8w
	 85bl83Usq0UDfN9cmKNi9WWgCIRm9DVDiJiJfF1LwRCioDgSzK2HIkMKP7kOiyq8ot
	 hQPoFvS2AafYw==
Date: Thu, 5 Feb 2026 18:19:32 +0100
From: Carlos Maiolino <cem@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com, 
	linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <aYTQyseO0dEjfPIp@nidhogg.toxiclabs.cc>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13551-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nidhogg.toxiclabs.cc:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FFDFF5DDC
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 08:56:24AM -0800, Darrick J. Wong wrote:
> On Mon, Feb 02, 2026 at 09:22:36PM -0800, Christoph Hellwig wrote:
> > On Mon, Feb 02, 2026 at 11:11:12AM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 

FWIW, this fix the regressions I'm hitting on 7.0 merge window queue.


> > > Now that we can do xattr updates in a single transaction (as opposed to
> > > using the attr intent machinery) if we keep the attr structure in short
> > > format, remove the attr intent item log recovery tests.
> > 
> > I have a bit of a hard time parsing this.  Currently with xfs/for-next
> > these fail, so removing them fixes it, which is probably what drove
> > this.
> 
> Yep.
> 
> > But looking through the patches I'm not sure why they actually are
> > failing - the updates are logged as part of the inode item, and
> > nothing in test_attr_replay seems to actually look at log specific
> > bits?
> 
> I've rewritten the commit message; does this help?
> 
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
> 
> > Only vaguely related, but should we ensure to always clear error
> > tags after the test runs to ensure they don't leak into other tests?
> 
> They go away with _scratch_remount because error tags only live as long
> as the mount.

The changes looks good to me, if you re-send this, feel free to add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>


> 
> --D
> 


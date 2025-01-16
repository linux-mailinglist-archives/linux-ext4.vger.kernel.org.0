Return-Path: <linux-ext4+bounces-6136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F951A14163
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DCB3A231B
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C322A7F9;
	Thu, 16 Jan 2025 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZguWnqx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IYj+AfZz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puQALLD4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TY94q3zc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07414EC4E
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050652; cv=none; b=lrH0d3inAArgV6bYY9XuX3iTP9gDlsBRxidvdOYFMYMKj94SRNCRWqzFCvNvdRp9RkRLq8dq4XDK+YB9vm1DueT3+EFzAMQG9dqt4DfCkLtuyN0JIiqoxxaYsQqJ8WKpTGf+Xjk83K9tRbIT8bRpQaE0cELfb/ArQ/qR0WLI6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050652; c=relaxed/simple;
	bh=Si2dq6lXBxJiEOO4att5zrqEy3Mb65HY3HLDdRgjAB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWdP5/usAa0R7/XiIvoThyS83CkZHhSeuIiw3Lnutelml6mYMX9A1oVQHcc1SBZH1mmmIqf2ckt1uuFO4n8rBZGwYNY3fbNQ5I9jSmhK9HEHfh3DP2M3tHGTfNNJSNGIVov6g1xKCIZTn6kWS5FkLXyRBSZQiEJ3xzU5ltPcfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZguWnqx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IYj+AfZz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=puQALLD4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TY94q3zc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDFF721186;
	Thu, 16 Jan 2025 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737050649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ugtOgE1hXKnKXi39T+/6x0/25X6qqY8eK+vFu/ZBxwc=;
	b=FZguWnqxQTGH0VW2/msEKw2JottRYQQ64R96VEASnUoYhop8oyS1rXFnJcN6hpbuUVN2gp
	9DVT9uCopSNy36r5gqtCk7WJvevcgOJdOQaM8a0p0q1gNMIKlP+YrjZh/MS4Lfqtm4CSDm
	EIjg8CrAQVSuoyZLRkHANBHsUAww9uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737050649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ugtOgE1hXKnKXi39T+/6x0/25X6qqY8eK+vFu/ZBxwc=;
	b=IYj+AfZzhzoVPuP/75Bx0pD2dPcVpFuVyZGZRsiXqRFk8v/F1E4WOCMdQT6qvO3jK1SUf/
	cl+zjst849CY+ZBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737050648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ugtOgE1hXKnKXi39T+/6x0/25X6qqY8eK+vFu/ZBxwc=;
	b=puQALLD4Ex9fTdWq0ePM0zYqxdWg93OT8QGqyjvrpy5JErULkhL1eHydFX//PFCExb3Iph
	julczN60i1GXIY0HW6JbcFlJuSfB/BdwOXu0ce7IaUffaLIeevKGtBI175CTLlTCH+TipL
	fvto3xkOdxEA9nW+8wElfIAIpxdho64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737050648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ugtOgE1hXKnKXi39T+/6x0/25X6qqY8eK+vFu/ZBxwc=;
	b=TY94q3zc/UJsRrEo6OvGfZYXPuQLdKkl7f5DkXBqu8iRCzObpTl9JNv88VbERfNY8GxZVp
	7lMDeu1T+r++ULBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C843313332;
	Thu, 16 Jan 2025 18:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J0PUMBhKiWdNTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 18:04:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79D4DA08E0; Thu, 16 Jan 2025 19:04:08 +0100 (CET)
Date: Thu, 16 Jan 2025 19:04:08 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Li Dongyang <dongyangli@ddn.com>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Alex Zhuravlev <bzzz@whamcloud.com>
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Message-ID: <zdoxlcp3dl7ab2d3svzcr6lu226cq6lw7qzhbw3ac4wd7ftrrd@pmu4f3cpp2mh>
References: <20241105034428.578701-1-dongyangli@ddn.com>
 <20241108103358.ziocxsyapli2pexv@quack3>
 <20241108161118.GA42603@mit.edu>
 <11AF8D3C-411F-436C-AC8D-B1C057D02091@dilger.ca>
 <20241113144752.3hzcbrhvh4znrcf7@quack3>
 <C3DE528C-218D-49DD-AF81-3C84CA131ED5@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3DE528C-218D-49DD-AF81-3C84CA131ED5@dilger.ca>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 15-01-25 17:08:03, Andreas Dilger wrote:
> On Nov 13, 2024, at 7:47 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > On Tue 12-11-24 11:44:11, Andreas Dilger wrote:
> >> On Nov 8, 2024, at 9:11 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> >>> 
> >>> On Fri, Nov 08, 2024 at 11:33:58AM +0100, Jan Kara wrote:
> >>>>> 1048576 records - 95 seconds
> >>>>> 2097152 records - 580 seconds
> >>>> 
> >>>> These are really high numbers of revoke records. Deleting couple GB of
> >>>> metadata doesn't happen so easily. Are they from a real workload or just
> >>>> a stress test?
> >>> 
> >>> For context, the background of this is that this has been an
> >>> out-of-tree that's been around for a very long time, for use with
> >>> Lustre servers where apparently, this very large number of revoke
> >>> records is a real thing.
> >> 
> >> Yes, we've seen this in production if there was a crash after deleting
> >> many millions of log records.  This causes remount to take potentially
> >> several hours before completing (and this was made worse by HA causing
> >> failovers due to mount being "stuck" doing the journal replay).
> > 
> > Thanks for clarification!
> > 
> >>>> If my interpretation is correct, then rhashtable is unnecessarily
> >>>> huge hammer for this. Firstly, as the big hash is needed only during
> >>>> replay, there's no concurrent access to the data
> >>>> structure. Secondly, we just fill the data structure in the
> >>>> PASS_REVOKE scan and then use it. Thirdly, we know the number of
> >>>> elements we need to store in the table in advance (well, currently
> >>>> we don't but it's trivial to modify PASS_SCAN to get that number).
> >>>> 
> >>>> So rather than playing with rhashtable, I'd modify PASS_SCAN to sum
> >>>> up number of revoke records we're going to process and then prepare
> >>>> a static hash of appropriate size for replay (we can just use the
> >>>> standard hashing fs/jbd2/revoke.c uses, just with differently sized
> >>>> hash table allocated for replay and point journal->j_revoke to
> >>>> it). And once recovery completes jbd2_journal_clear_revoke() can
> >>>> free the table and point journal->j_revoke back to the original
> >>>> table. What do you think?
> >>> 
> >>> Hmm, that's a really nice idea; Andreas, what do you think?
> >> 
> >> Implementing code to manually count and resize the recovery hashtable
> >> will also have its own complexity, including possible allocation size
> >> limits for a huge hash table.  That could be worked around by kvmalloc(),
> >> but IMHO this essentially starts "open coding" something rhashtable was
> >> exactly designed to avoid.
> > 
> > Well, I'd say the result is much simpler than rhashtable code since
> > you don't need all that dynamic reallocation and complex locking. Attached is a patch that implements my suggestion. I'd say it is
> > simpler than having two types of revoke block hashing depending on
> > whether we are doing recovery or running the journal.
> > 
> > I've tested it and it seems to work fine (including replay of a
> > journal with sufficiently many revoke blocks) but I'm not sure
> > I can do a meaningful performance testing (I cannot quite reproduce
> > the slow replay times even when shutting down the filesystem after
> > deleting 1000000 directories). So can you please give it a spin?
> 
> Alex posted test results on the other rhashtable revoke thread,
> which show both the rhashtable and Jan's dynamically-allocated hash
> table perform much better than the original fixed-size hash table.

Yes, thanks for the testing! Patch submitted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-ext4+bounces-2864-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56E4904D2C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2024 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3456DB20FD2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C916C697;
	Wed, 12 Jun 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAO4ftX0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="URvqdu35";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAO4ftX0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="URvqdu35"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F872772A;
	Wed, 12 Jun 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178844; cv=none; b=IBJ1U3u67C6lEORaBpTGH2JnG9AG6Lj1u8IAGW9GDyPslwlDV4SgGGXf8YdVH7mRUl5qEVPkT1I7xsvBau+U/YBiKToSAoZBjm1aQRAvyRzYf5D5e10WTu6W6zr/ypjSv3VuX6kttRzcQFNNn05QwFWg81FPgtB0L86WfTCX5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178844; c=relaxed/simple;
	bh=frjf2yRoYppskJEjgW+Fs4LD5DAGHLdgINmxMcprX20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chbQZr42GIVPSKoWrddr7eMILcL62GGcgyZFuN6AqCsh3mxlmr76wIZVrdIpBMDDS16MkMhBhggwk2YmDyP6d1OWBf56mKg9ALwakjDWu4R0WqMtbwrCfcYPI941egYakIZMWGfxXfzuRukJISU1AQQQC6DSmKNzs405lhD0sYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAO4ftX0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=URvqdu35; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAO4ftX0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=URvqdu35; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 139825BDB3;
	Wed, 12 Jun 2024 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718178841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nECO5VH26rvrWqSX/kqsFSBcBZ6QGhFggX3HCcXRKs=;
	b=OAO4ftX0VHhGtesSCWGzzFz8W043mhdf8vCEcy/4gL+H7Hlctf0f68k6zL5FpdDggDKOGT
	V/5CKx7Dr3GqVr+8BpeYc9nUn50x+N8HiIuqxM0oMorOyCQ7o7kQJ+nsUicUeSWINWyLL3
	KoL7Pu9DhiNiHoimCa8mdgNE8hmeo3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718178841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nECO5VH26rvrWqSX/kqsFSBcBZ6QGhFggX3HCcXRKs=;
	b=URvqdu35GXkAcUSbpEvXU208bi5upvmGypa6CtyKaO2nkrb6jpV2J+xiHs887apYXUXiq5
	p1apIeCxfrRh5wAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718178841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nECO5VH26rvrWqSX/kqsFSBcBZ6QGhFggX3HCcXRKs=;
	b=OAO4ftX0VHhGtesSCWGzzFz8W043mhdf8vCEcy/4gL+H7Hlctf0f68k6zL5FpdDggDKOGT
	V/5CKx7Dr3GqVr+8BpeYc9nUn50x+N8HiIuqxM0oMorOyCQ7o7kQJ+nsUicUeSWINWyLL3
	KoL7Pu9DhiNiHoimCa8mdgNE8hmeo3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718178841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nECO5VH26rvrWqSX/kqsFSBcBZ6QGhFggX3HCcXRKs=;
	b=URvqdu35GXkAcUSbpEvXU208bi5upvmGypa6CtyKaO2nkrb6jpV2J+xiHs887apYXUXiq5
	p1apIeCxfrRh5wAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 827B91372E;
	Wed, 12 Jun 2024 07:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OlHOHwRUaWbcUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Jun 2024 07:53:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 554FCA0873; Wed, 12 Jun 2024 09:50:27 +0200 (CEST)
Date: Wed, 12 Jun 2024 09:50:27 +0200
From: Jan Kara <jack@suse.cz>
To: Hugh Dickins <hughd@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	syzbot <syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, chengming.zhou@linux.dev,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, nphamcs@gmail.com,
	syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in zswap_store
Message-ID: <20240612075027.5pzkkovaewtx63n5@quack3>
References: <000000000000d0f165061a6754c3@google.com>
 <CAJD7tkaTQU1Kxt935fmq+_BJd-VT6vKFj58o7Aq+QhoyrOtCmw@mail.gmail.com>
 <02a21a55-8fe3-a9eb-f54b-051d75ae8335@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a21a55-8fe3-a9eb-f54b-051d75ae8335@google.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[9c1fe13fcb51574b249b];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,syzkaller.appspotmail.com,linux-foundation.org,linux.dev,cmpxchg.org,vger.kernel.org,kvack.org,gmail.com,googlegroups.com,suse.cz];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue 11-06-24 02:13:59, Hugh Dickins wrote:
> On Mon, 10 Jun 2024, Yosry Ahmed wrote:
> > Hugh, do you mind taking a quick look at whether this is a real bug?
> > 
> > If this is expected behavior, perhaps there is some annotation we can
> > use in zswap that it is fine to encounter uninitialized data when
> > reading the folio.
> 
> I've not been faced with a KMSAN report before, so I might well be
> misunderstanding its language: but this looks like an ext4 "bug" to me.
> 
> I think the story that the three KMSAN stacks are telling is this:
> syzbot has an ext4 filesystem on a loop device on a tmpfs file (I do
> exactly that too); ext4 is doing some ext4_xattr_inode_write() business,
> in the course of which it writes back a not-fully-initialized block to
> the loop device; shmem faithfully copies that data into its pagecache,
> then later when under memory pressure that page gets "written" out to
> zswap: where zswap_is_page_same_filled() takes an interest in the data,
> and KMSAN objects because some of it was not originally initialized.
> 
> If that's a correct interpretation, then it's probably not a big deal:
> it's probably the uninitialized end of a buffer that's written out,
> not any part of the "disk" which ext4 would ever show to a user; but
> I do agree with KMSAN that ext4 would do better to clear that area,
> rather than accidentally storing someone else's super-secret info.

Yes, that seems to be accurate.  ext4_xattr_inode_write() stores large
extended attribute in the inode and we don't bother to zero out the tail of
the block we use since we never access bytes beyond xattr size. Frankly I
don't consider this a bug since the uninitialized bytes are never exposed
to (unpriviledged) userspace. But I agree that out of pure precaution and
because it doesn't cost much in terms of performance we could zero out the
block tail.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


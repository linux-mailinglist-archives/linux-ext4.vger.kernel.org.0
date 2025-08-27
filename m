Return-Path: <linux-ext4+bounces-9689-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FBB380A9
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35B07C36FA
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00F34DCCC;
	Wed, 27 Aug 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ptwtpgqm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9R11CgbE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D01oxWpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXp6+EV+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9E343D75
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293350; cv=none; b=DZsluM10sva6thLgqgXfRilGEjre3yQ0s16+eSJPNH+Fy7EsuNdrksgB5MLQb+RwP73q9MG5vNomBiC06fizYQCDMBgCDEjPnsXlDAdXqVaFJ7tQL9EyU4sN40eVXtMDu0wy6nkC+Z0MqIJD/9p0mBATE5oLjRHXA3f4F3OWhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293350; c=relaxed/simple;
	bh=0xGpYBeDZPTQ9ye0tYa6eBWNnwfv4XDDzbPpgCBBVKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEL+eysWi0zIBFCeFGLNA2dwtmpvDhdzz7As5YvRHbJTXcAEJ7RounSZ3exK+RGls2l4BoI3uIRB+NUnY+C92M/sIFSllVxqV3zkatAhRPAZII7Ypin8d1cq0V43Y3XY0PFf++D4+DIYMDud6jOHfU0L3jQkFqbOIYYtc8XoPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ptwtpgqm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9R11CgbE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D01oxWpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXp6+EV+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D435B201F1;
	Wed, 27 Aug 2025 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756293347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G76ieFBPvgzG7WGTdAkaHkUGa3iEfco8FtvTU2XSns0=;
	b=PtwtpgqmVDS4rwx0216Z0q6kYqSFRc6MTHDpVrfGGj+Ouc9yJ+g3epZpdpyLiuQSagxVin
	VPDq8d2YWe95W5pzPWaJdevASheC7HYfJ8tCA8+lzCcHDOUeJzgrkrbaAALVFVwuMUK8X3
	t5Zba3blC9IDwvkupS+Qd4trb41DsnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756293347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G76ieFBPvgzG7WGTdAkaHkUGa3iEfco8FtvTU2XSns0=;
	b=9R11CgbE1OIqlR3DFwIejswqVxNIDmQbFuJgsGptLba9futCGYKjLpJZ6Nr/Ghqgey/VqU
	iWTfBcZ1+tDSXTBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D01oxWpu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qXp6+EV+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756293346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G76ieFBPvgzG7WGTdAkaHkUGa3iEfco8FtvTU2XSns0=;
	b=D01oxWpuZ5bg1o4iJjC1ZE4VXtIOA/HVky7NYE7TjW34UrN2w9SKQFMoW15tZwWhlomNSk
	wUEqHWbe+OnhqB3E5sR1KwOlJUzLNqOZT/fPROA7XdtLNnB/BRChKEPsEmyz8/bb0RmBXn
	XWjpa3ovk+6ZcKsGKWRMZTvhWlXUPTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756293346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G76ieFBPvgzG7WGTdAkaHkUGa3iEfco8FtvTU2XSns0=;
	b=qXp6+EV+4FOH7t7WyRpvTH5YoFdVaPc+4AiXHMNu8cEWCQxTqpG22be/cIpVrUq8uqzbXD
	3FWApGp/znnz2uCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8C8313867;
	Wed, 27 Aug 2025 11:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ckz8MOLormiaOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 Aug 2025 11:15:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B4D1A0997; Wed, 27 Aug 2025 13:15:46 +0200 (CEST)
Date: Wed, 27 Aug 2025 13:15:46 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.com, yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
Message-ID: <pnskj4s6nxyyootkrxcz7nl5exqzs7sdw2jfehq2z4xc6yvs67@mx7dymx7vsjk>
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
 <877byprefg.fsf@gmail.com>
 <418cbbab-4046-494d-bfdf-899c3b66f5fc@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418cbbab-4046-494d-bfdf-899c3b66f5fc@bytedance.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mit.edu,suse.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D435B201F1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 27-08-25 12:57:32, Julian Sun wrote:
> 在 2025/8/27 04:55, Ritesh Harjani (IBM) 写道:
> > Julian Sun <sunjunchao@bytedance.com> writes:
> > 
> > > In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
> > > the priority of IOs initiated by jbd2 has been raised, exempting them
> > > from WBT throttling.
> > > Checkpoint is also a crucial operation of jbd2. While no serious issues
> > > have been observed so far, it should still be reasonable to exempt
> > > checkpoint from WBT throttling.
> > > 
> > 
> > Interesting.. I was wondering whether we were able to observe any
> > throttling for jbd2 log writes or for jbd2 checkpoint?
> > Maybe It would have been nice, if we had some kind of data for this.
> 
> Good idea. But AFAICS wbt lacks of such a obversation mechanism now..>

Well, I guess Ritesh meant some test case which is reproducing the
situation where jbd2 log writes get stalled.

> > BTW - does it make sense for fastcommit path too maybe for non-tail
> > fc write requests? I think it uses ext4_fc_submit_bh().
> 
> Yeah, I think so.
> After a rough check of the code, the following code paths may result in high
> latency or even task hangs:
>   1. fastcommit io is throttled by wbt or other block layer qos policies.
>   2. jbd2_fc_wait_bufs() might wait for a long time while
> JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
> jbd2_journal_commit_transaction() waits for the JBD2_FAST_COMMIT_ONGOING bit
> for a long time while holding the write lock of j_state_lock.
>   3. start_this_handle() waits for read lock of j_state_lock which results
> in high latency or task hang.
> 
> Hi, Jan, please correct me if I'm missing anything.

I think you're correct. In fact ext4_fc_commit() does modify current
process' io priority to match that of jbd2 thread so it would be logical
to match IO submission flags as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


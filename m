Return-Path: <linux-ext4+bounces-3288-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08CB932362
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EF71F22B87
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC219755B;
	Tue, 16 Jul 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIC4jQoR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ayk51sUa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TyBalTTs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gBhBdWMw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52A1957EA;
	Tue, 16 Jul 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123532; cv=none; b=tig3fyocwYo+pzi88EtiNWgCbxSqrwNRWcS7C2akkiexbXp7Kw5cXDZD8r84E5dY3eKZetAbrU6KZVTlZVUDWGyVP9UpRc3EwFKrR40qhukyq6uGf3KIvFpnhKxFs+HbunrPGOy7a8J51Od6AG2556ow71SUQsSrZ7xJp+3Vh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123532; c=relaxed/simple;
	bh=sTEq+71d74BYVRgRntDOvHNAUACrFmPk/YofTyor9gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCyudW/TE+fTxXO0+Al5R3KmnVUf52Y92niqgN2FwZJyGSjcFWp3tsv9sy3t7f41FixVCjYlj7+No9sehE9Qayc2hZmx72njnWJuxC0CB7F/W2t3Musth4/wYcf2D/5mPsNWmTWdj4d4Ifx15ZlRgHSZlcAHprWEEwAVr4wNxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIC4jQoR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ayk51sUa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TyBalTTs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gBhBdWMw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBC5921BF7;
	Tue, 16 Jul 2024 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721123527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faLu8ANarLN64HGOqW59wT/J2T9GSRfX6GdQz79QNrg=;
	b=IIC4jQoRmwsprrx0Cw+8GqOMvr4XhWNHcYEdYuCsMFQFd1JQbs246iHTRygSfuyD+HKF6M
	ND76nfpPy5iHyJ/0PgHdw8SbpXFn51qjwo1JzApmMbz8ie/QPqOauzehmm+9UuoT88KtsR
	XdWEX67flo9b2B8ZIKS1lHhiuiELA44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721123527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faLu8ANarLN64HGOqW59wT/J2T9GSRfX6GdQz79QNrg=;
	b=Ayk51sUaWccAfvkjogklhKJzJMzmzeNaUgsq2Lxm+jZlBc+jXl/W3dkUqImrfaI0SfrMln
	cxBjxKicmC6A5qCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TyBalTTs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gBhBdWMw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721123525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faLu8ANarLN64HGOqW59wT/J2T9GSRfX6GdQz79QNrg=;
	b=TyBalTTsXSavQfQGt3C8zUyKDX66zhMxYgtSmS+Db9+MauHZl9bNGqoy15N2du+oxsaM3t
	KkLbv7EemL0DrA7Sg7qUn3nB7wYDijyK9BItTugw/XI3lRoJvfcxX9M/q1m3c8MzG49vRI
	kqmfEplnnKSyF/vSUTdRSOsp+/WEt6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721123525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faLu8ANarLN64HGOqW59wT/J2T9GSRfX6GdQz79QNrg=;
	b=gBhBdWMwrZ29Hit3ULCHrRFho/kCSyMBnFlo71PaFXgVoHEZTV1yVnIvD471Fp9Qvtvp2J
	XbZG+o57rTmo7oBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2CDC13795;
	Tue, 16 Jul 2024 09:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +cCeK8VClmavIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jul 2024 09:52:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DF74A0987; Tue, 16 Jul 2024 11:52:01 +0200 (CEST)
Date: Tue, 16 Jul 2024 11:52:01 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Andreas Dilger <adilger@dilger.ca>,
	Wang Jianjian <wangjianjian0@foxmail.com>,
	"wangjianjian (C)" <wangjianjian3@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: make '0' an invalid transaction sequence
Message-ID: <20240716095201.o7kkrhfdy2bps3rw@quack3>
References: <20240711083520.6751-1-luis.henriques@linux.dev>
 <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
 <878qy8nem5.fsf@brahms.olymp>
 <tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
 <A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
 <87ed7znf8n.fsf@linux.dev>
 <87wmlrkkch.fsf_-_@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmlrkkch.fsf_-_@linux.dev>
X-Rspamd-Queue-Id: CBC5921BF7
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,foxmail.com,huawei.com,mit.edu,suse.cz,gmail.com,vger.kernel.org];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,dilger.ca:email,linux.dev:email]
X-Spam-Level: 
X-Spamd-Bar: /

On Fri 12-07-24 10:53:02, Luis Henriques wrote:
> Since there's code (in fast-commit) that already handles a '0' tid as a
> special case, it's better to ensure that jbd2 never sets it to that value
> when journal->j_transaction_sequence increment wraps.
> 
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Well, sadly it isn't so simple. If nothing else, journal replay
(do_one_pass()) will get broken by the skipped tid as we do check:

                if (sequence != next_commit_ID) {
                        brelse(bh);
                        break;
                }

So we'd abort journal replay too early. Secondly, there's also code
handling journal replay in libext2fs which would need to be checked and
fixed up. Finally, I've found code in mballoc which alternates between two
lists based on tid & 1, so this logic would get broken by skipping 0 tid
as well.

Overall, I think we might be better off to go and fix places that assume
tid 0 is not valid. I can see those assumptions in:

ext4_fc_mark_ineligible()
ext4_wait_for_tail_page_commit()
__jbd2_log_wait_for_space()
jbd2_journal_shrink_checkpoint_list()

Now I don't see it as urgent to fix all these right now. Just for this
series let's not add another place making tid 0 special. Later we can fixup
the other places...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


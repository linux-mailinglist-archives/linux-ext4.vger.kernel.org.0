Return-Path: <linux-ext4+bounces-6185-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E6A18254
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 17:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06234165923
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3A1F470D;
	Tue, 21 Jan 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MhX2SNv/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUQbyQRF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MhX2SNv/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUQbyQRF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2841192D70;
	Tue, 21 Jan 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478527; cv=none; b=cIhq7E47koRSp/rLv1UGBmtm8tOS4HTPBePoWUVuXJbCGOHcStpmb5cc4XeVSiQ2gFG2C+0qkyuG+UyQW8qTe8dYaA6hYgzwS4XDAanK2aeXe8C8KuDxaG9w6wG3cH6clhl38fwxQRUyN26j0T3uQnSat5nr7HvHAUj7RC52bGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478527; c=relaxed/simple;
	bh=ljot/MZZuF2wOpQ05QCP7Hnrmr/UdFh/DZMXMFbGddg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cahPksu670/vwNUgnWk+oT1Q6pUWUNg5tGn1vVrOZfTR6r9drwUu692Q/LWaBPFpzGjM7ngbMxQDobkhVc6RP6Ntl0o/L9mw1xVE7WyKCcxNoKMD/Sp1hlAGWAHgQmSkWw/YlLtmIBaSxnYizYBeUsijxnGzYqWSTizGM8yDcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MhX2SNv/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUQbyQRF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MhX2SNv/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUQbyQRF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7AE11F391;
	Tue, 21 Jan 2025 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737478523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZIBl1Ve9LPZa59rjaIvWIZ+XpvUUGcAkpHqg6nfJT4=;
	b=MhX2SNv/FLdumyga16efWbUAPQ10WytMiYxWJj38cmlPnJhwuntTrh4jaqY6vIpcEelNH/
	3fEdXobzCxARgSY086FmzJq6WjkAiDt3KsNwf1UN9yqxvHgRF2Cxp0pEC3c8fweelxWKlD
	A7Iik0zYsamS6TjtjhyTteSrTfQUFeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737478523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZIBl1Ve9LPZa59rjaIvWIZ+XpvUUGcAkpHqg6nfJT4=;
	b=XUQbyQRFVhArLk4a4FCjj5BL2/oUjf3ZsGdIZHvz1em7VY0rTzFYH+oqwVXFoVImy95i+u
	buU3fFzBcL+GHKAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737478523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZIBl1Ve9LPZa59rjaIvWIZ+XpvUUGcAkpHqg6nfJT4=;
	b=MhX2SNv/FLdumyga16efWbUAPQ10WytMiYxWJj38cmlPnJhwuntTrh4jaqY6vIpcEelNH/
	3fEdXobzCxARgSY086FmzJq6WjkAiDt3KsNwf1UN9yqxvHgRF2Cxp0pEC3c8fweelxWKlD
	A7Iik0zYsamS6TjtjhyTteSrTfQUFeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737478523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZIBl1Ve9LPZa59rjaIvWIZ+XpvUUGcAkpHqg6nfJT4=;
	b=XUQbyQRFVhArLk4a4FCjj5BL2/oUjf3ZsGdIZHvz1em7VY0rTzFYH+oqwVXFoVImy95i+u
	buU3fFzBcL+GHKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8C471387C;
	Tue, 21 Jan 2025 16:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tQUaLXvRj2e5DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 16:55:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60669A0889; Tue, 21 Jan 2025 17:55:19 +0100 (CET)
Date: Tue, 21 Jan 2025 17:55:19 +0100
From: Jan Kara <jack@suse.cz>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	li.kai4@h3c.com, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev, 
	Liebes Wang <wanghaichi0403@gmail.com>, syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
Message-ID: <vxsqorapn2flwqx6ipsye6wf6h5lvciqoywvwrd2w4nwxyuajz@l3mao3pmqikn>
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
 <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
 <20250114133815.GA1997324@mit.edu>
 <3655551d-b881-4f2b-8419-03efe4d3aca7@suse.com>
 <CADCV8srwww_--oOvi1sdS4JfUafidPOPr0srG1bWO66py2WTtQ@mail.gmail.com>
 <db4da8db-d501-4181-994b-c25845908161@suse.com>
 <2htuqhxolgddrwm5ka7ad4axu3gz7nprqnmspdtkwld7mzch3r@tqhjlxfidxsb>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2htuqhxolgddrwm5ka7ad4axu3gz7nprqnmspdtkwld7mzch3r@tqhjlxfidxsb>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[96ee12698391289383dd];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,h3c.com,suse.com,vger.kernel.org,googlegroups.com,linux.alibaba.com,lists.linux.dev,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 15-01-25 18:53:41, Jan Kara wrote:
> On Wed 15-01-25 13:00:23, Heming Zhao wrote:
> > Hello Jan,
> > 
> > On 1/15/25 09:32, Liebes Wang wrote:
> > > The bisection log shows the first cause commit is a09decff5c32060639a685581c380f51b14e1fc2:
> > > a09decff5c32 jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal
> > > 
> > > The full bisection log is attached. Hope this helps.
> > 
> > This bisearch commit a09decff5c32 appears to be the root cause
> > of this issue. It fixed one issue but introduced another.
> > 
> > Syzbot tested the patch with calling jbd2_journal_wipe() with 'write=1'.
> > The Syzbot test result [1] shows that the same WARN_ON() is triggered
> > in a subsequent routine – the classic whack-a-mole!
> > 
> > Back to commit a09decff5c32, it opened a door to allow jbd2 to update
> > sb regardless of whether the value of sb items are correct.
> > 
> > To fix a09decff5c32, it seems that jbd2 needs to add more sanity check
> > codes in a sub-routine of jbd2_journal_load().
> > 
> > btw, in my view, this is a jbd2 issue not ocfs2/ext4 issue.
> > 
> > [1]: https://lore.kernel.org/ocfs2-devel/04a9ad29-51de-4b50-a5bb-56f91817639d@suse.com/T/#m86d01f83d808868bb5e6548d30f79b4f9f889b13
> 
> Thanks for debugging this! So I'm not 100% convinced this is only jbd2 bug
> because jbd2_journal_recover() was never intended to be called after
> jbd2_journal_skip_recovery() (called from jbd2_journal_wipe()). You're
> supposed to call either jbd2_journal_wipe() or jbd2_journal_recover() but
> not both. So IMO this needs fixing in OCFS2 code. That being said you've
> also pointed at one bug in jbd2 code - the WARN_ON(!sb->s_sequence) in
> jbd2_journal_update_sb_log_tail() is indeed wrong. We were inconsistent
> inside jbd2 whether TID 0 is considered valid or not and relatively
> recently we've decided to accept TID 0 as valid but this place was left
> out. I'll send a fix for that.

OK, after checking again OCFS2 is indeed fine here. I'm sorry for the
confusion. I'll send appropriate jbd2 fixes shortly.

 
 								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


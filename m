Return-Path: <linux-ext4+bounces-282-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1180371A
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Dec 2023 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492B928129E
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Dec 2023 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93562288D7;
	Mon,  4 Dec 2023 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wI8PwYjE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WDJyYUy/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A28A9;
	Mon,  4 Dec 2023 06:41:08 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6870A1FCE8;
	Mon,  4 Dec 2023 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701700867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZ5GBwYG9yYyA/BLwztwhsbyqCCEQU8wZSQHMYMGfGY=;
	b=wI8PwYjECnoMx/1ik3UIhSJavowayEM+Pt/v9tfVpsUA+C4764jEXunRHprIqNyw/U1Sbk
	KjgDmS4iz2mCv68mYCe4BgGO+rxagYTrhx4H0BbFblac0C4iqIQ4gddyq86tZiC+RNwCh/
	b0eaE0rM9MSkL8xJHsQOUbQ5/TwQ7jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701700867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZ5GBwYG9yYyA/BLwztwhsbyqCCEQU8wZSQHMYMGfGY=;
	b=WDJyYUy/wKTW5vIqC5AvqhpoCXROn9S9aKSSGTZ9qQGvx1ZPFMk61NomQeOKeZKbFPsVeR
	bYjWQyquj9MyxnCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A433139E2;
	Mon,  4 Dec 2023 14:41:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wngFFgPlbWUwGAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 04 Dec 2023 14:41:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDD24A07DB; Mon,  4 Dec 2023 15:41:06 +0100 (CET)
Date: Mon, 4 Dec 2023 15:41:06 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, willy@infradead.org,
	akpm@linux-foundation.org, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <20231204144106.fk4yxc422gppifsz@quack3>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,kvack.org,vger.kernel.org,mit.edu,dilger.ca,infradead.org,linux-foundation.org,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Mon 04-12-23 21:50:18, Baokun Li wrote:
> On 2023/12/4 20:11, Jan Kara wrote:
> > On Sat 02-12-23 17:14:30, Baokun Li wrote:
> > > Recently, while running some pressure tests on MYSQL, noticed that
> > > occasionally a "corrupted data in log event" error would be reported.
> > > After analyzing the error, I found that extending DIO write and buffered
> > > read were competing, resulting in some zero-filled page end being read.
> > > Since ext4 buffered read doesn't hold an inode lock, and there is no
> > > field in the page to indicate the valid data size, it seems to me that
> > > it is impossible to solve this problem perfectly without changing these
> > > two things.
> > Yes, combining buffered reads with direct IO writes is a recipe for
> > problems and pretty much in the "don't do it" territory. So honestly I'd
> > consider this a MYSQL bug. Were you able to identify why does MYSQL use
> > buffered read in this case? It is just something specific to the test
> > you're doing?
> The problem is with a one-master-twoslave MYSQL database with three
> physical machines, and using sysbench pressure testing on each of the
> three machines, the problem occurs about once every two to three hours.
> 
> The problem is with the relay log file, and when the problem occurs, the
> middle dozens of bytes of the file are read as all zeros, while the data on
> disk is not. This is a journal-like file where a write process gets the data
> from
> the master node and writes it locally, and another replay process reads the
> file and performs the replay operation accordingly (some SQL statements).
> The problem is that when replaying, it finds that the data read is
> corrupted,
> not valid SQL data, while the data on disk is normal.
> 
> It's not confirmed that buffered reads vs direct IO writes is actually
> causing this issue, but this is the only scenario that we can reproduce
> with our local simplified scripts. Also, after merging in patch 1, the
> MYSQL pressure test scenario has now been tested for 5 days and has not
> been reproduced.
> 
> I'll double-check the problem scenario, although buffered reads with
> buffered writes doesn't seem to have this problem.

Yeah, from what you write it seems that the replay code is using buffered
reads on the journal file. I guess you could confirm that with a bit of
kernel tracing but the symptoms look pretty convincing. Did you try talking
to MYSQL guys about why they are doing this?

> > > In this series, the first patch reads the inode size twice, and takes the
> > > smaller of the two values as the copyout limit to avoid copying data that
> > > was not actually read (0-padding) into the user buffer and causing data
> > > corruption. This greatly reduces the probability of problems under 4k
> > > page. However, the problem is still easily triggered under 64k page.
> > > 
> > > The second patch waits for the existing dio write to complete and
> > > invalidate the stale page cache before performing a new buffered read
> > > in ext4, avoiding data corruption by copying the stale page cache to
> > > the user buffer. This makes it much less likely that the problem will
> > > be triggered in a 64k page.
> > > 
> > > Do we have a plan to add a lock to the ext4 buffered read or a field in
> > > the page that indicates the size of the valid data in the page? Or does
> > > anyone have a better idea?
> > No, there are no plans to address this AFAIK. Because such locking will
> > slow down all the well behaved applications to fix a corner case for
> > application doing unsupported things. Sure we must not crash the kernel,
> > corrupt the filesystem or leak sensitive (e.g. uninitialized) data if app
> > combines buffered and direct IO but returning zeros instead of valid data
> > is in my opinion fully within the range of acceptable behavior for such
> > case.
> > 
> I also feel that a scenario like buffered reads + DIO writes is strange.
> But theoretically when read doesn't return an error, the data read
> shouldn't be wrong.  And I tested that xfs guarantees data consistency in
> this scenario, which is why I thought it might be buggy.

Yes, XFS has inherited stronger consistency guarantees from IRIX times than
Linux filesystems traditionally had. We generally don't even guarantee
buffered read vs buffered write atomicity (i.e., buffered read can see a
torn buffered write).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


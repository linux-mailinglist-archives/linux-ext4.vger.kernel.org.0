Return-Path: <linux-ext4+bounces-6086-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC53A1069B
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43521883D65
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B696229629;
	Tue, 14 Jan 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LbhjniTU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/wj+dsFH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LbhjniTU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/wj+dsFH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFA20F97E;
	Tue, 14 Jan 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857769; cv=none; b=tyBdGthKdhfUPtedSvDQpnORSBeBGiVK2TGPGjjkh1drMZP/CE1t3HKRxYbzh+3uGHBO+A1VAWva66Yt+sxUnBqY/z2spKqsHveXcfzHn2Em+PfI6IYY0c1q8W+sm5JTC8EZsccZ+HZxCwoMGYjlFvUpiYrKM0CYLz0nxURr0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857769; c=relaxed/simple;
	bh=Qonob8WFTIk4fTEwcdk/eGYpqo229gV2biWqzHXJQZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ5XSb0YtfIcTyKMKtpvIuoLsu6IQ4eLkXQ8jpdxODitTkjyebTTZGOP56KHuU/SpjoySmb+z6aNbzGZqE/lOIRVs+zHOQyBfLSV1XTuIMRO78f9nRK0jwafXJ9wWgBXqJ09CTc4cwjtHwoaJpVtm+UdnfrgnZeWylHEZUcX/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LbhjniTU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/wj+dsFH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LbhjniTU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/wj+dsFH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E1941F385;
	Tue, 14 Jan 2025 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736857765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMutuCgd6Iqh49ZrMvuMKCOB74pZRQwXylWcE0jEjxg=;
	b=LbhjniTUqJkZaz3rrfO6BZDw+RCsi0y6XAP2miGVR/KNYOGHJDSzsqKuR5O+tQHWc6RDTM
	R0RdBiX+6CbfhE3GSnY5VG7kyY1w9eKY3e6sQeJoaIsLXzhU+b8KOYrI+C0gZ9MvmRPCHL
	7ha7MOzyONqob6o7hcCYTbddOQ8160E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736857765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMutuCgd6Iqh49ZrMvuMKCOB74pZRQwXylWcE0jEjxg=;
	b=/wj+dsFHeGyD76MTyUsCs05kePIjKNNS04/16Y/kymYpsYjQeo8eTU+aW6Ivcj/7OVIV2q
	QOJEPXnHt7EAR8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736857765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMutuCgd6Iqh49ZrMvuMKCOB74pZRQwXylWcE0jEjxg=;
	b=LbhjniTUqJkZaz3rrfO6BZDw+RCsi0y6XAP2miGVR/KNYOGHJDSzsqKuR5O+tQHWc6RDTM
	R0RdBiX+6CbfhE3GSnY5VG7kyY1w9eKY3e6sQeJoaIsLXzhU+b8KOYrI+C0gZ9MvmRPCHL
	7ha7MOzyONqob6o7hcCYTbddOQ8160E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736857765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMutuCgd6Iqh49ZrMvuMKCOB74pZRQwXylWcE0jEjxg=;
	b=/wj+dsFHeGyD76MTyUsCs05kePIjKNNS04/16Y/kymYpsYjQeo8eTU+aW6Ivcj/7OVIV2q
	QOJEPXnHt7EAR8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 849A61384C;
	Tue, 14 Jan 2025 12:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P21YIKVYhmdSMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jan 2025 12:29:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B8FDA08CD; Tue, 14 Jan 2025 13:29:21 +0100 (CET)
Date: Tue, 14 Jan 2025 13:29:21 +0100
From: Jan Kara <jack@suse.cz>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Jan Kara <jack@suse.cz>, Liebes Wang <wanghaichi0403@gmail.com>, 
	tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
Message-ID: <pzyayvjhburtp74auzd7weq73ndy3lttv4e3tw5cpxwlokvkgg@r5v6qjxolxfq>
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
 <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,mit.edu,suse.com,vger.kernel.org,googlegroups.com,linux.alibaba.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 14-01-25 14:25:21, Heming Zhao wrote:
> Hi Jan,
> 
> On 1/6/25 23:14, Jan Kara wrote:
> > On Tue 31-12-24 13:53:23, Liebes Wang wrote:
> > > Dear Linux maintainers and reviewers:
> > > 
> > > We are reporting a Linux kernel bug titled **WARNING in
> > > jbd2_journal_update_sb_log_tail**, discovered using a modified version of
> > > Syzkaller.
> > 
> > Very likely this is actually some issue with ocfs2 since the only thing the
> > reproducer seems to be doing is that it is mounting ocfs2 image. Joseph,
> > can you have a look please?
> > 
> 
> The root cause appears to be that the jbd2 bypass recovery logic
> is incorrect.
> 
> From the console log [1]:
>  [   70.568684][ T5316] JBD2: Ignoring recovery information on journal
> 
> The above output indicates that ocfs2 is calling jbd2_journal_wipe()
> to clean up jbd2. (IIUC), Therefore, the subsequent jbd2 initialization
> flow should not perform any recovery tasks.
> 
> However, in this crash issue, after calling jbd2_journal_wipe(),
> jbd2_journal_load() still attempts to perform a recovery, which triggers
> a WARN_ON().
> 
> On the other hand, the jbd2 code logic is correct, ocfs2 should call
> ocfs2_journal_wipe() with the parameter 'write=1' to address this issue.
> 
> code flow:
> ocfs2_mount_volume
>  ocfs2_check_volume
>  + ocfs2_journal_init => jbd2_journal_init_inode
>  + ocfs2_journal_wipe => jbd2_journal_wipe (input write is 0)
>  + ocfs2_journal_load => jbd2_journal_load => do recovery job => WARN_ON()
> 
> [1]: 2024/01/12 06:56 log
> https://syzkaller.appspot.com/text?tag=CrashLog&x=106f2bc4580000

Ah, ok. So the problem essentially is that OCFS2 journal inode has
OCFS2_JOURNAL_DIRTY_FL cleared (hence ocfs2_journal_wipe() is called) but
the journal actually has journal->j_head != journal->j_tail and hence
recovery will replay transactions. I guess calling jbd2_journal_wipe()
with write==1 makes sense (if writing to the block device is allowed).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


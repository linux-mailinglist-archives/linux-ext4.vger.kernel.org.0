Return-Path: <linux-ext4+bounces-8701-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A04AED5AF
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F96316D9A0
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED4221540;
	Mon, 30 Jun 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVA2tAbc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRnkOO20";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="17AulgZ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AyQ5exhj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED321E0AD
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268715; cv=none; b=qvF36M3a8T2JLNgQ6xGeVHcKpuJ37BFb965n4rPJeX1LINe3+SqBfZKnw2lIPtyr69vtynV/6ncDKYX/C2J77V1tLgiMgvuSXTMFY0w94xNxupt7qQ743niUf9L9ywxem2IFwm1HiXTkkiN+r5QFqOjevQ+hV570ENNQsQjtKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268715; c=relaxed/simple;
	bh=4NL8UsYtV8Nr0DA0sTxLX6ZzfeHF3QNep/tyEDeAGDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Posr4t2EYRps5me4k8OL5ZvGhkBz303QMXIgELOmqH9pXzGtUT+awwF2PIiNN+Qen4afddhpDeinGLAdMoguy7sFltIk8xEizXoUVWFVA8vkOqwn0pwRqyOVTSTYAimlAbUN/bE9hKgK4SSIR6dtHqnjtLyqSSVSEWdY7SMe4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVA2tAbc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRnkOO20; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=17AulgZ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AyQ5exhj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E42271F38C;
	Mon, 30 Jun 2025 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751268712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJrT3PqZewzWhJ6K1x8yJe75/062yU6iPGJzkoQxjSo=;
	b=ZVA2tAbc4fi289S+t/YnLPbz0tqJXYFDqZQidZo2EurO0jikDYan4JGYD5hW3tN20aHutH
	ZsU2HUjatvpA+/ZBTBixID7UuEdJ+Cwe1XUjoevWUuCH/hZDub1SERi7t1nJqOBepYGjyr
	+ecHYJLuj9IOFMBWnJl4he46xchTfBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751268712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJrT3PqZewzWhJ6K1x8yJe75/062yU6iPGJzkoQxjSo=;
	b=uRnkOO20hhyqaz+vwKPdAT0Ka+t0ZKfIGMcFYtQSABKTfNWury5oBprfsWe4u67BzToS0b
	B1XsalGXQUj256Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=17AulgZ+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AyQ5exhj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751268711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJrT3PqZewzWhJ6K1x8yJe75/062yU6iPGJzkoQxjSo=;
	b=17AulgZ+whlfWoV0e/NPGTv5BoXsAEVxKKhmhFeGIYEf7tPBH/k9E0TimzJtOI+lEra/gN
	JazfzYwjWl1YkZpf8DmwT6DKvBDV+vJKr0s80ZV5T8SN2B6P9SqXHr19mZBSH6c55yD8zT
	v9ViWnmnyNCLCXgoc/WQcgNkNGKRKBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751268711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJrT3PqZewzWhJ6K1x8yJe75/062yU6iPGJzkoQxjSo=;
	b=AyQ5exhj2z7yrXLBGUWRXF9Cu+7ntNqsJTlcwsx1QAaoR+xYbbwlSt8IioD7FUAjO7tnCD
	dzou5swcjnN/jZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D834E13983;
	Mon, 30 Jun 2025 07:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gl7BNGc9YmjgaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 07:31:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8389AA08D2; Mon, 30 Jun 2025 09:31:51 +0200 (CEST)
Date: Mon, 30 Jun 2025 09:31:51 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 02/16] ext4: remove unnecessary s_mb_last_start
Message-ID: <mztj3kc4slq3j6gxfk77omt4tdphg55jophea2j2dw5vj5hixq@ppj5lfxz2svk>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-3-libaokun1@huawei.com>
 <3p5udvc7fgd73kruz563pi4dmc6vjxvszmnegyym2xhuuauw5j@sjudcmk7idht>
 <0bcfc7c6-003f-4b4d-ac65-e01308a74f3b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcfc7c6-003f-4b4d-ac65-e01308a74f3b@huawei.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E42271F38C
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 30-06-25 11:32:16, Baokun Li wrote:
> On 2025/6/28 2:15, Jan Kara wrote:
> > On Mon 23-06-25 15:32:50, Baokun Li wrote:
> > > ac->ac_g_ex.fe_start is only used in ext4_mb_find_by_goal(), but STREAM
> > > ALLOC is activated after ext4_mb_find_by_goal() fails, so there's no need
> > > to update ac->ac_g_ex.fe_start, remove the unnecessary s_mb_last_start.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > I'd just note that ac->ac_g_ex.fe_start is also used in
> > ext4_mb_collect_stats() so this change may impact the statistics gathered
> > there. OTOH it is questionable whether we even want to account streaming
> > allocation as a goal hit... Anyway, I'm fine with this, I'd just mention it
> > in the changelog.
> Yes, I missed ext4_mb_collect_stats(). However, instead of explaining
> it in the changelog, I think it would be better to move the current
> s_bal_goals update to inside or after ext4_mb_find_by_goal().
> 
> Then, we could add another variable, such as s_bal_stream_goals, to
> represent the hit count for global goals. This kind of statistic would
> help us fine-tune the logic for optimizing inode goals and global goals.
> 
> What are your thoughts on this?

Sure that sounds good to me.

> > > @@ -2849,7 +2848,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> > >   		/* TBD: may be hot point */
> > >   		spin_lock(&sbi->s_md_lock);
> > >   		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> > > -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
> > Maybe reset ac->ac_g_ex.fe_start to 0 instead of leaving it at some random
> > value? Just for the sake of defensive programming...
> > 
> ac->ac_g_ex.fe_start holds the inode goal's start position, not a random
> value. It's unused after ext4_mb_find_by_goal() (if s_bal_stream_goals is
> added). Thus, I see no need for further modification. We can always re-add
> it if future requirements change.

Yeah, I was imprecise. It is not a random value. But it is not an offset in
the group we are now setting. Therefore I'd still prefer to reset fe_start
to 0 (or some invalid value like -1 to catch unexpected use).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


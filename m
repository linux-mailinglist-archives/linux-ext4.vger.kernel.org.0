Return-Path: <linux-ext4+bounces-11020-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC2BFB715
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50A0B4E2F67
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D54322C81;
	Wed, 22 Oct 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n2dhaER+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHGN08JH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CMCR+Bv5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMr+MjQ+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E870287257
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130158; cv=none; b=uermR/I967x5+ul+edBcRY2Salemm6eUyMWlIbl50sXxElc202vDCxGjewrqm8SISodZ/q3/clQxT+ocIXYZCWrPZZ/gBInU2iGGhcJ6aiGraHfU2bwQPYkKtPzTAfDQaLt8C91uV+Qm1zS/dD4LHs58SH19xJ6iF7En7oscubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130158; c=relaxed/simple;
	bh=EWGo/RWGIyYoPVGb3f16ctlnVeUGPqTObxnyPQYyuhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvpgEyMp8dJsHku5AWxcQPp537E2zVMuFA9C5hnl8q/2jc/KryXNkYsnJTRfyuIKQmmKrPJuESs/CI9m5VcKWv3/9z3FHo6n5v8wIRAB4GiwjC2naVlQid3Bg0sRG05tEHjg9bRvXPz4DhnPKrW2irTah08pQ6kwcog4ARDo3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n2dhaER+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kHGN08JH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CMCR+Bv5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMr+MjQ+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC122116A;
	Wed, 22 Oct 2025 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761130150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooiTj9BKflCYybLypC999pmvVmEGAdtqZGEpOENNzqM=;
	b=n2dhaER+i7tb/HJ+Yrt9FoikNaQhP1t5MtH1AfDBEYL54uJg1hW5SwePEGaT2bRLi8u52n
	qBl/dlOgTZCa6xSFm6bpHaPPWzU/+fdDzKT59JVcuKjq+fZbMl6GnkuWLSxTdx2kU05/dm
	qSS+aGJfCq7s0xNOzXxc0+ONpaqNUZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761130150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooiTj9BKflCYybLypC999pmvVmEGAdtqZGEpOENNzqM=;
	b=kHGN08JHyzy1azGe5mRbIZI/Q5rb2c5+Nd6wv91fanLOAOJIV+0TxCudKnZnUsM/fx9X+q
	2Z04tWx+Cx5fivDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CMCR+Bv5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fMr+MjQ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761130146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooiTj9BKflCYybLypC999pmvVmEGAdtqZGEpOENNzqM=;
	b=CMCR+Bv5XNtW2tGgP1M5dFyuPwTrl6c8/K9sD6nqQmif+YsuSM0dcOMsC2lbVjGrAaYP2+
	21zxV//OLVgjQrX35opgMCLSBFuPex9fr1mtZhNIg1jb4GJO4XKyNRsXXvaYif1D+ohArC
	auVZpbsfVX5Mvu5XUVq6enbF0WiOruo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761130146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooiTj9BKflCYybLypC999pmvVmEGAdtqZGEpOENNzqM=;
	b=fMr+MjQ+XsHx7UhIuPJSMDJl0vjqAIOfTMohAXJluqyfAN3XrJXIOqd538Z1+HglMMxGCJ
	ePHdo10zyhjKk2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8399B13AAD;
	Wed, 22 Oct 2025 10:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TOUZIKK2+GiUUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Oct 2025 10:49:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AA83A0990; Wed, 22 Oct 2025 12:49:06 +0200 (CEST)
Date: Wed, 22 Oct 2025 12:49:05 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Message-ID: <rajbaoxp7zvaiftmuip4mxdvrdxthhgvbjvtuq3zrwijtdab2j@ouligqrqxyth>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
 <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
 <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
 <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
 <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw>
 <a6fcc693-42f0-4d70-a1af-fc1bfb328eb7@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fcc693-42f0-4d70-a1af-fc1bfb328eb7@I-love.SAKURA.ne.jp>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8CC122116A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 22-10-25 19:04:33, Tetsuo Handa wrote:
> On 2025/10/21 22:39, Jan Kara wrote:
> >>> Yes, something like this. In fact, I think we could get away with just
> >>> jbd2_trans_commit_key. There's definitely no need for j_revoke_lock,
> >>> j_list_lock, j_history_lock, j_state_lock, j_abort_mutex keys as these are
> >>> internal to jbd2. j_checkpoint_mutex and j_barrier do wrap around some
> >>> filesystem code so maybe we'll need to specify keys for them but I'd start
> >>> with just jbd2_trans_commit_key and wait whether syzbot manages to trigger
> >>> another false positive report with that.
> >>
> >> I tried https://syzkaller.appspot.com/x/patch.diff?x=11b4dde2580000 .
> >> But I think https://syzkaller.appspot.com/x/patch.diff?x=1644c3cd980000
> >> pattern which all mutex_init_with_key() users follow seems more simpler
> >> and easier to apply. What do you think?
> > 
> > Yes, the second version looks nicer. Thanks! BTW, did you verify that
> > annotating j_barrier, j_checkpoint_mutex, and j_abort_mutex is really
> > needed? Because I'd be slightly surprised if it really was...
> 
> No. https://syzkaller.appspot.com/x/patch.diff?x=13a94e7c580000 was sufficient
> for this specific report. But I don't know what will happen with ocfs2 which has
> so complicated locking dependency ( https://syzkaller.appspot.com/upstream/s/ocfs2
> has currently 27 open "possible deadlock" reports).
> 
> Do you want me to try this minimal change in linux-next via my tree for a while?
> Or do you want to just apply this minimal change first?

Please just submit the minimal change and we'll merge it through ext4 tree.
If syzbot manages to trigger more reports, we can always add more
complications :). Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


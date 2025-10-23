Return-Path: <linux-ext4+bounces-11026-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB5BFFC00
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E40188D25E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D12E266C;
	Thu, 23 Oct 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5XU/NyV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WYOY9iu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UZ87einC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eiDd0Uc4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B15D2E2280
	for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206364; cv=none; b=KHuIZD7XakfrbOD7RdFywWTIkMiqXlAPJ9ew4kNy8Vro7plDRj477EULXcnaB4TxSNWb+0JsO+g+ese+8CRvwBSPaEcGfiJcCz4J2GpG9OZ+02kS6SuYmmGIAsJo2ef9fqJ47OhRUPr1H1hlw8ehajElIkjUs3Ui144i8g4U3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206364; c=relaxed/simple;
	bh=h9L+3MVsfWqXkWgKfFaSz+emT304I/13ICnE9PDFfR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT2rOeN7RbnUZoY8FTXgBFmGnL0UqY4j9LkNDY8La8g5zGhmRKIlA5nUnGf76x/Y1N5IMWWBFGqqQNDJK2bADAoA4xWaf/rqqyQYRQCNIhn0ubU195b2GDljsaIclJZEFpBS4Rnaf0/QGLLJeEvHjEJjgkzTCBUB+OQaD5e5S34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5XU/NyV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WYOY9iu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UZ87einC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eiDd0Uc4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95F751F445;
	Thu, 23 Oct 2025 07:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761206356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BjVMY+y9vsTstYFa6ma+sphPLgyQjk9w3dI5GO2fh0=;
	b=Q5XU/NyVuCe6wYCJ+yGhovcJxODFtjWWpBEPmyIg7MiJKzHpK8TDpQvzLX2fJtwhxfBcs1
	lJzZHdlzmg7HrHisehmQJmNYCQckCWMD5JMdu9y2mpmj4hhxsPL08ftAUPJgUQLr467xxr
	TZrRKUlGoPhgb9NQQt67Ang9YDoPkiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761206356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BjVMY+y9vsTstYFa6ma+sphPLgyQjk9w3dI5GO2fh0=;
	b=7WYOY9iuckh9s/rhCpPEtxguuhDEI/V6zL0eEaPyUGk5n2ove/t7y05cQzqFZ4RBAKPfWU
	nm8iQQ2eKx8iroDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UZ87einC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eiDd0Uc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761206352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BjVMY+y9vsTstYFa6ma+sphPLgyQjk9w3dI5GO2fh0=;
	b=UZ87einC71rhEmuw8dkfjZoxvOBH0cI8AoOwr03avVxB12j63Dc5WPw1V3vSHK4F49PGK0
	WQrzzXeWyTlCY3ueLI06JVeM84mJw8xZlxXgbY1FAqdSQbJ4/3H2AvVk/hKFzDHuVaW1ev
	LIDTt9/Br7qzl8xc5um+kajcntRMP6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761206352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BjVMY+y9vsTstYFa6ma+sphPLgyQjk9w3dI5GO2fh0=;
	b=eiDd0Uc4B+OS0QQZFfQa0x/QY6GV88zG9StdwhTLgnLh8ur7HIzVl4Q30E+sPODorQKpbf
	vdBwfucCDu6/VBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 893A413285;
	Thu, 23 Oct 2025 07:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hrh6IVDg+WgCaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 Oct 2025 07:59:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31640A28A6; Thu, 23 Oct 2025 09:59:12 +0200 (CEST)
Date: Thu, 23 Oct 2025 09:59:12 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] jbd2: allocate lock_class_key for jbd2_handle
 dynamically
Message-ID: <vgpy66rcs3mvitijmt2v2yfwuhkijh33z3s76ghlsqq6yjgmtw@prlpxdeoitif>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
 <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
 <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
 <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
 <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw>
 <a6fcc693-42f0-4d70-a1af-fc1bfb328eb7@I-love.SAKURA.ne.jp>
 <rajbaoxp7zvaiftmuip4mxdvrdxthhgvbjvtuq3zrwijtdab2j@ouligqrqxyth>
 <987110fc-5470-457a-a218-d286a09dd82f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <987110fc-5470-457a-a218-d286a09dd82f@I-love.SAKURA.ne.jp>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 95F751F445
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 22-10-25 20:11:37, Tetsuo Handa wrote:
> syzbot is reporting possibility of deadlock due to sharing lock_class_key
> for jbd2_handle across ext4 and ocfs2. But this is a false positive, for
> one disk partition can't have two filesystems at the same time.
> 
> Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com

Thanks! Tha patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c    | 6 ++++--
>  include/linux/jbd2.h | 6 ++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..f43474002f50 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1521,7 +1521,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  			struct block_device *fs_dev,
>  			unsigned long long start, int len, int blocksize)
>  {
> -	static struct lock_class_key jbd2_trans_commit_key;
>  	journal_t *journal;
>  	int err;
>  	int n;
> @@ -1530,6 +1529,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (!journal)
>  		return ERR_PTR(-ENOMEM);
>  
> +	lockdep_register_key(&journal->jbd2_trans_commit_key);
>  	journal->j_blocksize = blocksize;
>  	journal->j_dev = bdev;
>  	journal->j_fs_dev = fs_dev;
> @@ -1560,7 +1560,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_max_batch_time = 15000; /* 15ms */
>  	atomic_set(&journal->j_reserved_credits, 0);
>  	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
> -			 &jbd2_trans_commit_key, 0);
> +			 &journal->jbd2_trans_commit_key, 0);
>  
>  	/* The journal is marked for error until we succeed with recovery! */
>  	journal->j_flags = JBD2_ABORT;
> @@ -1611,6 +1611,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	kfree(journal->j_wbuf);
>  	jbd2_journal_destroy_revoke(journal);
>  	journal_fail_superblock(journal);
> +	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
>  	kfree(journal);
>  	return ERR_PTR(err);
>  }
> @@ -2187,6 +2188,7 @@ int jbd2_journal_destroy(journal_t *journal)
>  		jbd2_journal_destroy_revoke(journal);
>  	kfree(journal->j_fc_wbuf);
>  	kfree(journal->j_wbuf);
> +	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
>  	kfree(journal);
>  
>  	return err;
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 43b9297fe8a7..f5eaf76198f3 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1253,6 +1253,12 @@ struct journal_s
>  	 */
>  	struct lockdep_map	j_trans_commit_map;
>  #endif
> +	/**
> +	 * @jbd2_trans_commit_key:
> +	 *
> +	 * "struct lock_class_key" for @j_trans_commit_map
> +	 */
> +	struct lock_class_key	jbd2_trans_commit_key;
>  
>  	/**
>  	 * @j_fc_cleanup_callback:
> -- 
> 2.47.3
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


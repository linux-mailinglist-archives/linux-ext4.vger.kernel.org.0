Return-Path: <linux-ext4+bounces-1630-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6881087BB69
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E88128286D
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579B5DF26;
	Thu, 14 Mar 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+iGl1O1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BZx7Ptrm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+iGl1O1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BZx7Ptrm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994336E60E;
	Thu, 14 Mar 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412599; cv=none; b=VF9j2WSbfff1MQfXtwgj6eOye+082D4EEsQG1VFbHDVNOvfiAXbtt6jGG3AxUJufy4Le9nA15XHRagRxBy+o66YmMzMpWEz0C6JK1ENkDPb8QZqxUccgzDg1FoaFUSjC13jMrbWzsvCb29rqc/9YJa8SWg2Dm5iPogs5WLrbcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412599; c=relaxed/simple;
	bh=1sS4yvOcb7hSA7Oyqs+qwUa88zrXGRNvu3sd6wcwUGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3E74dPLerD2cuMWQrERaooDd6ETlHgthVHyR3W0gh4MFuiDwMJsgN37xvrbq4UhuClHGvxCSVBuUSM48+tYnYmUClOWjGTBTd7d45NW64ZFujwuvGLkSI+SFqyrz4sz4HFmKDH1eeKfS/T3tp8+gc+yCN7F/YA25wPLcElARzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+iGl1O1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BZx7Ptrm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+iGl1O1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BZx7Ptrm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C86901F844;
	Thu, 14 Mar 2024 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzkPi+J20GY+iWispN8Baja2fey3TzNDuqaBoZINMIs=;
	b=n+iGl1O1xirGbyvvdt90aEoXk3rtEYZ5gy2QLwhAhPul92xXJzLU5v6pgHqAnsmGA/NgKT
	zj3xg3RMFsc6l8FC8r/dGwpEf/mTHlXXr9qgBeYcKPD5kYFsshmO/bMtmlqyptkl/m5iyk
	07yl/b4pdzluHnsGrmi6Fz8evDPaHB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzkPi+J20GY+iWispN8Baja2fey3TzNDuqaBoZINMIs=;
	b=BZx7PtrmSVomVzzTr3ZAqL/8ZuFG2QZ82olCE9m9hhl/+dcvVK5VyHt5kdIrEj+debdwaw
	i9GhKvSff7X4thBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzkPi+J20GY+iWispN8Baja2fey3TzNDuqaBoZINMIs=;
	b=n+iGl1O1xirGbyvvdt90aEoXk3rtEYZ5gy2QLwhAhPul92xXJzLU5v6pgHqAnsmGA/NgKT
	zj3xg3RMFsc6l8FC8r/dGwpEf/mTHlXXr9qgBeYcKPD5kYFsshmO/bMtmlqyptkl/m5iyk
	07yl/b4pdzluHnsGrmi6Fz8evDPaHB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzkPi+J20GY+iWispN8Baja2fey3TzNDuqaBoZINMIs=;
	b=BZx7PtrmSVomVzzTr3ZAqL/8ZuFG2QZ82olCE9m9hhl/+dcvVK5VyHt5kdIrEj+debdwaw
	i9GhKvSff7X4thBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD66D139E7;
	Thu, 14 Mar 2024 10:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s6A8LjPT8mWQUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:36:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78B70A07D9; Thu, 14 Mar 2024 11:36:35 +0100 (CET)
Date: Thu, 14 Mar 2024 11:36:35 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 9/9] ext4: clean up s_mb_rb_lock to fix build warnings
 with C=1
Message-ID: <20240314103635.fp2jab2ayfkph4td@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-10-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-10-libaokun1@huawei.com>
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n+iGl1O1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BZx7Ptrm
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[11.28%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.69
X-Spam-Level: *
X-Rspamd-Queue-Id: C86901F844
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 27-02-24 17:11:48, Baokun Li wrote:
> Running sparse (make C=1) on mballoc.c we get the following warning:
> 
>  fs/ext4/mballoc.c:3194:13: warning: context imbalance in
>   'ext4_mb_seq_structs_summary_start' - wrong count at exit
> 
> This is because __acquires(&EXT4_SB(sb)->s_mb_rb_lock) was called in
> ext4_mb_seq_structs_summary_start(), but s_mb_rb_lock was removed in commit
> 83e80a6e3543 ("ext4: use buckets for cr 1 block scan instead of rbtree"),
> so remove the __acquires to silence the warning.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 7ad089df2408..7ae8e04d6ef4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3192,7 +3192,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  }
>  
>  static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
> -__acquires(&EXT4_SB(sb)->s_mb_rb_lock)
>  {
>  	struct super_block *sb = pde_data(file_inode(seq->file));
>  	unsigned long position;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


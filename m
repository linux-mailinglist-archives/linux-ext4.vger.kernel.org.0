Return-Path: <linux-ext4+bounces-6997-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D8A73DFE
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 19:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B847A5983
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4E321ABCF;
	Thu, 27 Mar 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxL29nS7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PADoBgQQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z9rVN75L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JARxz34o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2C13D52F
	for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099934; cv=none; b=OtCiCeTJqtMghQ9NfrKIEm24B2qburpwM0q5LyzJ1tj8sNXEDoJkQswE1Bbc58YdX7TDKI/TPF/Vz+2pmD2VCVWm3u9/SUWHXGERNJ+bH3VU2PTkMEvZ7/euBArgXVrFqB0zpVkg+QSDm7fu4p1SwdbAdWmW2CNiXQVYtkwHVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099934; c=relaxed/simple;
	bh=UAC3261gOaNLgFP2SMdn+a9WtsZ1/k1eK6D9YvdxkKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP/qlQdxmFoQ6IvkHNpTFuf7ahLb98F6zw4co3r/xnqW/LD9txRiEh7cGDLwhEunAxWFXOfCSFs4vhXgbYh++FR6ppf4hwoEv4phNgO1d1OK3gJO89N9awkxFS8ciQxIhz17bCROpqoP75bT3vpLx1dvXsm6iuMwEQuQPBNr44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxL29nS7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PADoBgQQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z9rVN75L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JARxz34o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9733211A2;
	Thu, 27 Mar 2025 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGOvXhiHYsnoUOyAcDl4yjW0IYOxH0t8y7wWIceT9X0=;
	b=FxL29nS7E/mK5apTXtR9onTKKiGgWGxFDcqZg6Siu5uFy2L0L21sJ2x/jOYRe8nlt9JzSQ
	ubm6WNU3SiuiZx8emHkMvKTorKoSB/KM8VrqtSxRyzXQ9OkjAjjp1/5l22SaxApT09np6F
	V6+0DptLJ4gWZOjbhi32ChFjiK3e46A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGOvXhiHYsnoUOyAcDl4yjW0IYOxH0t8y7wWIceT9X0=;
	b=PADoBgQQWHWFsS9p5n2Lirtb/Ys2EW88XmfCte+MNQa1QpTNGZWc4E0HqI+4lmFPtNle2s
	48wGcJNTvP1mBhDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGOvXhiHYsnoUOyAcDl4yjW0IYOxH0t8y7wWIceT9X0=;
	b=Z9rVN75LKUUMG+k8+9hmw1E52vNBhigYs/YWnG7Q2AFjq0oFX3WNFYpDm7carodRmnWwsc
	Z9K5XDtmlrTXggxOlzEBsEYwYo2oh3kaiITuMp1EZwR8ktB95s+kr489SmyRKwnN4fi6kU
	/ryuYicNoHGN8MwaVbWJeUuRMjbKIpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGOvXhiHYsnoUOyAcDl4yjW0IYOxH0t8y7wWIceT9X0=;
	b=JARxz34oIx/8RY+SgRAAG2adGmag2bXRMwP3Z2/YlXTISbX5399mnxkdzDs1/RPytFvBLK
	Ck2h0o7ZiK9R+uBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDB04139D4;
	Thu, 27 Mar 2025 18:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQEwMhqY5WfjKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Mar 2025 18:25:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F597A082A; Thu, 27 Mar 2025 19:25:30 +0100 (CET)
Date: Thu, 27 Mar 2025 19:25:30 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Make block validity check resistent to sb bh
 corruption
Message-ID: <4pgphzbzkwdkr5dwjhignsvbhwspavmz7ursalyy5nv7gjmztw@ebzz3sjiqxg4>
References: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,suse.cz,huawei.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 27-03-25 23:18:09, Ojaswin Mujoo wrote:
> Block validity checks need to be skipped in case they are called
> for journal blocks since they are part of system's protected
> zone.
> 
> Currently, this is done by checking inode->ino against
> sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
> buffer head. If someone modifies this underneath us then the
> s_journal_inum field might get corrupted. To prevent against this,
> change the check to directly compare the inode with journal->j_inode.
> 
> **Slight change in behavior**: During journal init path,
> check_block_validity etc might be called for journal inode when
> sbi->s_journal is not set yet. In this case we now proceed with
> ext4_inode_block_valid() instead of returning early. Since systems zones
> have not been set yet, it is okay to proceed so we can perform basic
> checks on the blocks.
> 
> Suggested-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One style nit below:

> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 87ee3a17bd29..e8c5525afc67 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
>  {
>  	__le32 *bref = p;
>  	unsigned int blk;
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>  
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> +	if (journal && inode == journal->j_inode)
>  		return 0;
>  
>  	while (bref < p+max) {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 365d31004bd0..8b048be14008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -384,10 +384,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
>  				unsigned int line,
>  				struct ext4_map_blocks *map)
>  {
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> -		return 0;
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +
> +	if (journal && inode == journal->j_inode)
> +			return 0;

Bogus indentation here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


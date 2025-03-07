Return-Path: <linux-ext4+bounces-6710-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909BA569E8
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637363B0053
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179721ADBC;
	Fri,  7 Mar 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1SdeFLvQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="by3Jljfr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1SdeFLvQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="by3Jljfr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE421ABC3
	for <linux-ext4@vger.kernel.org>; Fri,  7 Mar 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356328; cv=none; b=K8XnF6/s/tnmQQaimy5bDKsrOYjWGYib50e7iUqSesDNASgCCv9LKtLDdpDTtBSKnUByUnLUO7K/PPzfnKFCmJHBgjCifC2Id/HOybY1yNmKA5Y9sfSm+KRHew8KC2THNUQQVN8jrPyqnepjBOy2El7nJPkt90lOF3cPFTAoXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356328; c=relaxed/simple;
	bh=gWP3uGBgT1TS/8C1M0c03FnUiQCyB8mb7EWK8DxQ7po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxYazE8/KT9zvd/FOjPbWv+HJvzhsJ8ln+rhartw7cqqGn2zyFnlOSRJb72zO5f7pcYOh4Gjnf8luMOXG9CPkiFeMXm/U/aR9hvgzqKpN1CFJfFB42Ac73/vVFdlbU9LJlig7DaI/KHfmX0dlPnmLeHsU7zGO4px0bvCLEhyAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1SdeFLvQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=by3Jljfr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1SdeFLvQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=by3Jljfr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 367F01F38E;
	Fri,  7 Mar 2025 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741356325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPIn3OObraCO4N3C1YCvcirNEjIZmmXeenE7U97nYLg=;
	b=1SdeFLvQyQZvEE1/corpjfdX3xObnlXWQuT2FZ+E7nd6q5+2/b3GLPIkla52FNznARvDgU
	TXz3xZ1eOykmnCgka+0qYdn52UdKiSalJzQvZF31U2oJSel2KzneMmygq+6qz7koljKQwl
	L64Z8YP8iZ6h7QJV0q5hThScWdMEJFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741356325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPIn3OObraCO4N3C1YCvcirNEjIZmmXeenE7U97nYLg=;
	b=by3Jljfr6cIpKc0Z0kIg3Uul7FabxqkcuWpV1KDiqQQVkEaOocIAXAOfUeoR7Fs08KbcW6
	WMgCKEkwW0Gvk1Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741356325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPIn3OObraCO4N3C1YCvcirNEjIZmmXeenE7U97nYLg=;
	b=1SdeFLvQyQZvEE1/corpjfdX3xObnlXWQuT2FZ+E7nd6q5+2/b3GLPIkla52FNznARvDgU
	TXz3xZ1eOykmnCgka+0qYdn52UdKiSalJzQvZF31U2oJSel2KzneMmygq+6qz7koljKQwl
	L64Z8YP8iZ6h7QJV0q5hThScWdMEJFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741356325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPIn3OObraCO4N3C1YCvcirNEjIZmmXeenE7U97nYLg=;
	b=by3Jljfr6cIpKc0Z0kIg3Uul7FabxqkcuWpV1KDiqQQVkEaOocIAXAOfUeoR7Fs08KbcW6
	WMgCKEkwW0Gvk1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E1D313A22;
	Fri,  7 Mar 2025 14:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pU+CyX9ymfnJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Mar 2025 14:05:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EEA73A087F; Fri,  7 Mar 2025 15:05:24 +0100 (CET)
Date: Fri, 7 Mar 2025 15:05:24 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ext4: define ext4_journal_destroy wrapper
Message-ID: <34zw5gwnnmr3rrovdb4vaudlamvsnibofw6xf2eo7rzcc5axmq@hptbi3pxefhw>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <96d5153a015caf5da6b67cffaff3c03c2abecb95.1741270780.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d5153a015caf5da6b67cffaff3c03c2abecb95.1741270780.git.ojaswin@linux.ibm.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 06-03-25 19:58:32, Ojaswin Mujoo wrote:
> Define an ext4 wrapper over jbd2_journal_destroy to make sure we
> have consistent behavior during journal destruction. This will also
> come useful in the next patch where we add some ext4 specific logic
> in the destroy path.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.h | 14 ++++++++++++++
>  fs/ext4/super.c     | 16 ++++++----------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 3f2596c9e5f2..9b3c9df02a39 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -429,4 +429,18 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
>  	return 1;
>  }
>  
> +/*
> + * Pass journal explicitly as it may not be cached in the sbi->s_journal in some
> + * cases
> + */
> +static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *journal)
> +{
> +	int err = 0;
> +
> +	err = jbd2_journal_destroy(journal);
> +	sbi->s_journal = NULL;
> +
> +	return err;
> +}
> +
>  #endif	/* _EXT4_JBD2_H */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a963ffda692a..8ad664d47806 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1297,8 +1297,7 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	if (sbi->s_journal) {
>  		aborted = is_journal_aborted(sbi->s_journal);
> -		err = jbd2_journal_destroy(sbi->s_journal);
> -		sbi->s_journal = NULL;
> +		err = ext4_journal_destroy(sbi, sbi->s_journal);
>  		if ((err < 0) && !aborted) {
>  			ext4_abort(sb, -err, "Couldn't clean up the journal");
>  		}
> @@ -4960,8 +4959,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  out:
>  	/* flush s_sb_upd_work before destroying the journal. */
>  	flush_work(&sbi->s_sb_upd_work);
> -	jbd2_journal_destroy(sbi->s_journal);
> -	sbi->s_journal = NULL;
> +	ext4_journal_destroy(sbi, sbi->s_journal);
>  	return -EINVAL;
>  }
>  
> @@ -5652,8 +5650,7 @@ failed_mount8: __maybe_unused
>  	if (sbi->s_journal) {
>  		/* flush s_sb_upd_work before journal destroy. */
>  		flush_work(&sbi->s_sb_upd_work);
> -		jbd2_journal_destroy(sbi->s_journal);
> -		sbi->s_journal = NULL;
> +		ext4_journal_destroy(sbi, sbi->s_journal);
>  	}
>  failed_mount3a:
>  	ext4_es_unregister_shrinker(sbi);
> @@ -5958,7 +5955,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>  	return journal;
>  
>  out_journal:
> -	jbd2_journal_destroy(journal);
> +	ext4_journal_destroy(EXT4_SB(sb), journal);
>  out_bdev:
>  	bdev_fput(bdev_file);
>  	return ERR_PTR(errno);
> @@ -6075,8 +6072,7 @@ static int ext4_load_journal(struct super_block *sb,
>  	EXT4_SB(sb)->s_journal = journal;
>  	err = ext4_clear_journal_err(sb, es);
>  	if (err) {
> -		EXT4_SB(sb)->s_journal = NULL;
> -		jbd2_journal_destroy(journal);
> +		ext4_journal_destroy(EXT4_SB(sb), journal);
>  		return err;
>  	}
>  
> @@ -6094,7 +6090,7 @@ static int ext4_load_journal(struct super_block *sb,
>  	return 0;
>  
>  err_out:
> -	jbd2_journal_destroy(journal);
> +	ext4_journal_destroy(EXT4_SB(sb), journal);
>  	return err;
>  }
>  
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


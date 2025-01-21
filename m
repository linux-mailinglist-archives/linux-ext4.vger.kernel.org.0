Return-Path: <linux-ext4+bounces-6165-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD487A17C93
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356511884966
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AF1EF0BA;
	Tue, 21 Jan 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlTbP7Fu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gW2b+adj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6ah1V6t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UqqD5D58"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD631B4137;
	Tue, 21 Jan 2025 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457458; cv=none; b=TAh5zffM5L2IxfmiuX7Fdn4eSS8QDN5AwXakcW8WZmn1ODqSy6cJj2mTN5a0/NarNv7HLa4qNBXA05TrkMAoQ7jKVAkTCp1Jgrooir01+NS9/GVc1XKYhUCPMt251tug206FYM3ufBnFg28W75USGnhz4T2QqldyDthxNCPasBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457458; c=relaxed/simple;
	bh=MMU7ibYHhNfyyS3OksCiQXHalEkhN1Jo836ObrvjTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZyrGFhtCbtKrGci45ZoyDd8IBqG0cUFS+NOLscAuJ+C3gTu1QnW5Dno8B1aVspvSGRBtm9calJv+O8NuR5lDSrBDd2TrPKtgOP4UyHU03v6OROgRHvPEy1PMvioRHAzrtrPdL3H0GGeeX1bbCC0bVDVQswM4kkhtRFuetl8/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlTbP7Fu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gW2b+adj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6ah1V6t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UqqD5D58; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49DB91F785;
	Tue, 21 Jan 2025 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737457454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iHerOEeZZVWEdfRU0G9ztNYsnQaRANDF265UzLuuzg=;
	b=FlTbP7FuF30CJXmxA9HOd9pEkFDzXiLCA63MmNg+fSLEG3BcUsOILr/N3QIajtr9/W6Rp0
	JNUki2osfQTf3GXdd6gf/b9wWc6bioPKpnyLAm8iacavppUj9lbf98IP4P2UZIYR7F1n0S
	PmMr0/+fbhsokUHFYw39Kxx15UK+lfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737457454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iHerOEeZZVWEdfRU0G9ztNYsnQaRANDF265UzLuuzg=;
	b=gW2b+adjx9p++cnzaQz/48g+gYKhxWp5fedDGi4Pkf2VuR1zLuztL8IA8U6aLscbzfYvt7
	SRanmhrg96tEWEBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737457453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iHerOEeZZVWEdfRU0G9ztNYsnQaRANDF265UzLuuzg=;
	b=A6ah1V6t6+b7enlxp7shHWvBh2B1/oMiLJkZWlxTSYztSYwS7BV5WXAJk2lCe8HbVBnKXi
	VbLzk5kzsk3DNhWyhbT2b++kU9hyhhHltChL00PLUg+UraQiXU+ZkzZUaLjTLyPJfcqW8B
	9SKFfGFclrRRl900pZzY4pxv9cZMEig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737457453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iHerOEeZZVWEdfRU0G9ztNYsnQaRANDF265UzLuuzg=;
	b=UqqD5D58RI86eFmmlKkp2qA6j4dsBccS76fvdL8/uJXqxMhkbF8lrkLc9tsDer2/4aW8JC
	K1GGr8kPrKlmICDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31A4D1387C;
	Tue, 21 Jan 2025 11:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hzgaDC1/j2eBKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 11:04:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9E34A0889; Tue, 21 Jan 2025 12:04:04 +0100 (CET)
Date: Tue, 21 Jan 2025 12:04:04 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 4/8] ext4: extract ext4_check_nojournal_options() from
 __ext4_fill_super()
Message-ID: <nv5selt2rw3rn2f2hfk7doejpjj2tir4mho4i4fnwrj5mqqwru@bqmdwvefw4lh>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121071050.3991249-5-libaokun@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 21-01-25 15:10:46, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Extract the ext4_check_nojournal_options() helper function to reduce code
> duplication. No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Just a small naming suggestion:

> +static const char *ext4_check_nojournal_options(struct super_block *sb)

I'd call this ext4_has_journal_option() to make it somewhat more obvious
what we are checking. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	if (test_opt(sb, JOURNAL_ASYNC_COMMIT))
> +		return "journal_async_commit";
> +	if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM))
> +		return "journal_checksum";
> +	if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ)
> +		return "commit=";
> +	if (EXT4_MOUNT_DATA_FLAGS &
> +	    (sbi->s_mount_opt ^ sbi->s_def_mount_opt))
> +		return "data=";
> +	if (test_opt(sb, DATA_ERR_ABORT))
> +		return "data_err=abort";
> +	return NULL;
> +}
> +
>  static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  			   int silent)
>  {
> @@ -5411,35 +5429,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		       "suppressed and not mounted read-only");
>  		goto failed_mount3a;
>  	} else {
> -		/* Nojournal mode, all journal mount options are illegal */
> -		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "journal_async_commit, fs mounted w/o journal");
> -			goto failed_mount3a;
> -		}
> +		const char *journal_option;
>  
> -		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "journal_checksum, fs mounted w/o journal");
> -			goto failed_mount3a;
> -		}
> -		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "commit=%lu, fs mounted w/o journal",
> -				 sbi->s_commit_interval / HZ);
> -			goto failed_mount3a;
> -		}
> -		if (EXT4_MOUNT_DATA_FLAGS &
> -		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "data=, fs mounted w/o journal");
> -			goto failed_mount3a;
> -		}
> -		if (test_opt(sb, DATA_ERR_ABORT)) {
> +		/* Nojournal mode, all journal mount options are illegal */
> +		journal_option = ext4_check_nojournal_options(sb);
> +		if (journal_option != NULL) {
>  			ext4_msg(sb, KERN_ERR,
> -				 "can't mount with data_err=abort, fs mounted w/o journal");
> +				 "can't mount with %s, fs mounted w/o journal",
> +				 journal_option);
>  			goto failed_mount3a;
>  		}
> +
>  		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>  		clear_opt(sb, JOURNAL_CHECKSUM);
>  		clear_opt(sb, DATA_FLAGS);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


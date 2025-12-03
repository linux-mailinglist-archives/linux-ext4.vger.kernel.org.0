Return-Path: <linux-ext4+bounces-12140-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB7C9EBFC
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 11:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41B974E05AB
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B802EFD9B;
	Wed,  3 Dec 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZcSv7nJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSghaU4V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZcSv7nJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSghaU4V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B32EF654
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758411; cv=none; b=MONc75rpwAcXVyEsUEX6G9rBRzq+Q67+IKm2Cb/by15NO3KheahxzQ724rEpKWn4XCJP591pKNC+GVX5SQaBm9ERAlBBeDLG7aLynMI/4LvB/smFcX+HtY4X8F47RZ1tc0KZnJ6psbnyxdng2BIveJkufJfstQVf/5nBjnvHSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758411; c=relaxed/simple;
	bh=TLA3ZgySSI+WOmWHuJ5MQ3GExiYPcg8oW5dtCoIpdKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRLV2JX3dsp0Lpq8HfflI6JipqfYJzXVOLKVNxcUajnPRwn1gobCJZcFlv1fijHqyNJsa+IWccokEEvFzJgzsV3PS0xlJLD9BoAiNuATrF4PbCCBYx4UUgp7qOAC2gS6riA2KVSmq2cA1svGQZewipZ7qKp2xgKg8QZU9qpsnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kZcSv7nJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSghaU4V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kZcSv7nJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSghaU4V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 439295BD86;
	Wed,  3 Dec 2025 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764758407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aeqv3mXdGHw59QMf+JsFj1Fw+imTM7+0tHMVkaT9xto=;
	b=kZcSv7nJRsHKdQlx1W1RGv08YXRRTQDhfvEctDX9WmD1GU4+BLFu85mwi1nHdxgzy1g+7Z
	YNnU9YznJTIQJ8fhZr8whnRms2qlbcqeN+dVXblBsmauek0glBp4FHWXlF4nNHU46d5xuc
	tUuPM39qrCqRdZbLHJp8u9inigadOCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764758407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aeqv3mXdGHw59QMf+JsFj1Fw+imTM7+0tHMVkaT9xto=;
	b=cSghaU4VyvWSdUHKevUgcBHnHtUghpB+RpL3keFWmPfSHR+EmGo5h3IwhehwRFAYyZU6ok
	QfDV1nkBW1FnjrAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764758407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aeqv3mXdGHw59QMf+JsFj1Fw+imTM7+0tHMVkaT9xto=;
	b=kZcSv7nJRsHKdQlx1W1RGv08YXRRTQDhfvEctDX9WmD1GU4+BLFu85mwi1nHdxgzy1g+7Z
	YNnU9YznJTIQJ8fhZr8whnRms2qlbcqeN+dVXblBsmauek0glBp4FHWXlF4nNHU46d5xuc
	tUuPM39qrCqRdZbLHJp8u9inigadOCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764758407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aeqv3mXdGHw59QMf+JsFj1Fw+imTM7+0tHMVkaT9xto=;
	b=cSghaU4VyvWSdUHKevUgcBHnHtUghpB+RpL3keFWmPfSHR+EmGo5h3IwhehwRFAYyZU6ok
	QfDV1nkBW1FnjrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DF1E3EA63;
	Wed,  3 Dec 2025 10:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aHwrC4cTMGmTUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Dec 2025 10:40:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE5C7A09B4; Wed,  3 Dec 2025 11:40:06 +0100 (CET)
Date: Wed, 3 Dec 2025 11:40:06 +0100
From: Jan Kara <jack@suse.cz>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: factor out ext2_fill_super() teardown path
Message-ID: <herlaqmrxfzbh2yqumcquf4ex7qxz5sk47uswmwucdg3pmryez@bvyyavacx5rq>
References: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 03-12-25 04:50:48, Vivek BalachandharTN wrote:
> The error path at the end of ext2_fill_super() open-codes the final
> teardown of the ext2_sb_info structure and associated resources.
> Centralize this into a small helper to make the control flow a bit
> clearer and avoid repeating the same cleanup sequence in multiple
> labels.
> 
> Behavior is unchanged.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

This is pointless - no point in factoring out helper when it has a single
call site. Also your patch is broken in several ways (both in correctness
and style). Please be more thoughtful when submitting patches.

								Honza

> +static void ext2_free_sbi(struct super_block *sb,
> +			  struct ext2_sb_info *sbi,
> +			  struct buffer_head *bh)
> +{
> +	if (bh)
> +		brelse(bh);
> +
> +	fs_put_dax(sbi->s_daxdev, NULL);
> +	sb->s_fs_info = NULL;
> +	kfree(sbi->s_blockgroup_lock);
> +	kfree(sbi);
> +}
> +
>  static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct ext2_fs_context *ctx = fc->fs_private;
> @@ -1251,12 +1264,8 @@ static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
>  	kvfree(sbi->s_group_desc);
>  	kfree(sbi->s_debts);
>  failed_mount:
> -	brelse(bh);
>  failed_sbi:
> -	fs_put_dax(sbi->s_daxdev, NULL);
> -	sb->s_fs_info = NULL;
> -	kfree(sbi->s_blockgroup_lock);
> -	kfree(sbi);
> +	ext2_free_sbi(sb, sbi, bh);
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


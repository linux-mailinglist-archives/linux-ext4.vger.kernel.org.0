Return-Path: <linux-ext4+bounces-3327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133D89377A9
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ED9282240
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91261132113;
	Fri, 19 Jul 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1UzypoMW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hM3lDMuI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VChNcmEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D7PPlN+d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22A1E871
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jul 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391678; cv=none; b=C1klmWB/RtO1AvO5MlsJzoSSHvkL9mJVlBcG8iMokU8Cm2xlhGtXl66xVIDX77AKS0hc5LYsX1xepPLBJ7mZk9dlgb6tTl/218LwmL4NdUpqu1S5GoxrDrOqtaqT7q/ApFt1OTBmYQxyok6qswEn3szw37ahfam82e3wsZGMuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391678; c=relaxed/simple;
	bh=08wRGatxPKTcco98Cb/flc+N3dQLWT1fclAXwwHdZSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4GQYLn8cYySu7r7u7hcEL0RbBcMYEosja/FN+BF793zK3rtHYhV5jlXo0wM9qnCIX7CLtIie6MWJAQUSvFDPAkn7WLRDc8EAG1BK4rvy3M7EiS0+27QahDyisf/BY2UFH5OdNWKajz5JXvhH9rCLbP7IH72Qh9hYw5JNNLnJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1UzypoMW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hM3lDMuI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VChNcmEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D7PPlN+d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A0511F7A1;
	Fri, 19 Jul 2024 12:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721391674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuCvs5bM3FUP0Me+a/wru9EzqSLiDgN5MA1zVQ5b95k=;
	b=1UzypoMWtz67wEiUnkeqimYSfqxc1NKsFJ1ZQF3LYk7d96foB2KxqVx4OY63opjflVNRzN
	OzfGZ2Gmi8MxWKAXR+R7q65wcfg0zzO1tmrsskp6pAR71VLxu0oa4QNA53HZ+UwI/Hx6so
	VGFIJs5586HORWf0hukMk8mcGzIgl2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721391674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuCvs5bM3FUP0Me+a/wru9EzqSLiDgN5MA1zVQ5b95k=;
	b=hM3lDMuIHENU2oFbFVAM8MZeMbamMgoVrAModJwfp2TMgvCw500cCJNDHCCQGmCQZ8elB/
	WclcFKN4kHEuRdCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721391673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuCvs5bM3FUP0Me+a/wru9EzqSLiDgN5MA1zVQ5b95k=;
	b=VChNcmEO1tgMJL/NlBtBrpAGi4B2Da2dyAf0B8DOApjiZ4Fcryq89Kw2gBNk5wp4rPhsod
	YoUOVTdMPH4iUKHkYbX2qv0s7v35HvYX20YOgJ4fn0g0WkS7JX0S4NefXzZDk1ukIFtF0N
	JuDKQ5G0/9W4yqyjhivXvdGzyShDEjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721391673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuCvs5bM3FUP0Me+a/wru9EzqSLiDgN5MA1zVQ5b95k=;
	b=D7PPlN+dyImnhEvRz+TljKaIzP62cC8T8ll/bBWZgDebmiV/eNnPTbj63ynCNIN91sog95
	Jnpbbqq5rJbhrSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C0B0132CB;
	Fri, 19 Jul 2024 12:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DShuFjhammYKewAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Jul 2024 12:21:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F4C0A0987; Fri, 19 Jul 2024 14:21:04 +0200 (CEST)
Date: Fri, 19 Jul 2024 14:21:04 +0200
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	carrion bent <carrionbent@linux.alibaba.com>
Subject: Re: [PATCH v2] ext4: fix macro definition error of EXT4_DIRENT_HASH
 and EXT4_DIRENT_MINOR_HASH
Message-ID: <20240719122104.c5nzc6m3uoszgbj2@quack3>
References: <1717412239-31392-1-git-send-email-carrionbent@163.com>
 <1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com>
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,alibaba.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu 06-06-24 13:43:16, carrion bent wrote:
>     the macro parameter 'entry' of EXT4_DIRENT_HASH and
>     EXT4_DIRENT_MINOR_HASH was not used, but rather the
>     variable 'de' was directly used, which may be a local
>     variable inside a function that calls the macros.
>     Fortunately, all callers have passed in 'de' so far,
>     so this bug didn't have an effect.
> 
> Signed-off-by: carrion bent <carrionbent@linux.alibaba.com>

Ted, this seems to have fallen through the cracks. The bug in the macro is
really nasty trap...

								Honza

> ---
>  fs/ext4/ext4.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 983dad8..04bdd27 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2338,9 +2338,9 @@ struct ext4_dir_entry_2 {
>  	((struct ext4_dir_entry_hash *) \
>  		(((void *)(entry)) + \
>  		((8 + (entry)->name_len + EXT4_DIR_ROUND) & ~EXT4_DIR_ROUND)))
> -#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(de)->hash)
> +#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(entry)->hash)
>  #define EXT4_DIRENT_MINOR_HASH(entry) \
> -		le32_to_cpu(EXT4_DIRENT_HASHES(de)->minor_hash)
> +		le32_to_cpu(EXT4_DIRENT_HASHES(entry)->minor_hash)
>  
>  static inline bool ext4_hash_in_dirent(const struct inode *inode)
>  {
> -- 
> 2.7.4
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


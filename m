Return-Path: <linux-ext4+bounces-5665-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76809F2E82
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 11:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24921165125
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1D203D5A;
	Mon, 16 Dec 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xa7EHcCo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3nnr5iGr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xa7EHcCo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3nnr5iGr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA72AF03
	for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346240; cv=none; b=QuY9OjMznfgNqcMxkoXRYguW0N+CVHP/ptZzGVnZqV5FboDxIeq1+itZQSrpAHYYnrev9yJX3zcE1FndmjcnLZpsq9Lzafz0p+En4cZc1N+vIPGK38PDGPXMrOBWrMNpnX8oqJHLsPqLVNiWRNPXmDvYGHtKkkFVihAxolU89Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346240; c=relaxed/simple;
	bh=sioGirDSkOOJ0iim4jpOOg8GYE8IErI4JzkH6ktbrpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4zrKmv+EYxep6Z7U1RZZNmbik1qqqxmfYM17YDfehSBNzEOtNy/4KCyEK4uxHHn8rtN5AO9JtE/Y9z6fQmoZ0o+OTbLkBZiMcZSwcY6HaB/yBGB8b4b4QdHyacqucZXqzMHS9a/JL1GHJE6pLHFC1EB3bCVS7xgCRqImRbP2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xa7EHcCo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3nnr5iGr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xa7EHcCo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3nnr5iGr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B86951F787;
	Mon, 16 Dec 2024 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734346236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tpUHxGjGeZlEkKh9NHmid9SxJ+qNZ0mOIZfltd6zlr8=;
	b=xa7EHcCop5JVTYNU87Px+nl5WQlPHusUatNWKgoDtI8ujHbq5sRQ/2QYSb03iXHI+nK9c9
	yrFJ29QhIZfWCnA28wWk/4Tbry/vkIkEpoKidN/NjE7L7mK9rD2EDSq/ukbDcoA1WZ13pu
	8AE2uEZbtikTxeXDQNxRu1RJLsIGwZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734346236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tpUHxGjGeZlEkKh9NHmid9SxJ+qNZ0mOIZfltd6zlr8=;
	b=3nnr5iGr8XMpNBCAmnCBAflSlVzQzr+zQzy5Mq1VEaPddtevRpRw1OAmaETnxjlzd9HgDt
	S1U3sCy2U5ODjkAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xa7EHcCo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3nnr5iGr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734346236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tpUHxGjGeZlEkKh9NHmid9SxJ+qNZ0mOIZfltd6zlr8=;
	b=xa7EHcCop5JVTYNU87Px+nl5WQlPHusUatNWKgoDtI8ujHbq5sRQ/2QYSb03iXHI+nK9c9
	yrFJ29QhIZfWCnA28wWk/4Tbry/vkIkEpoKidN/NjE7L7mK9rD2EDSq/ukbDcoA1WZ13pu
	8AE2uEZbtikTxeXDQNxRu1RJLsIGwZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734346236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tpUHxGjGeZlEkKh9NHmid9SxJ+qNZ0mOIZfltd6zlr8=;
	b=3nnr5iGr8XMpNBCAmnCBAflSlVzQzr+zQzy5Mq1VEaPddtevRpRw1OAmaETnxjlzd9HgDt
	S1U3sCy2U5ODjkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACEF9137CF;
	Mon, 16 Dec 2024 10:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y9YyKvwFYGeDKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 10:50:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E000A08E1; Mon, 16 Dec 2024 11:50:28 +0100 (CET)
Date: Mon, 16 Dec 2024 11:50:28 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 9/9] ext4: hold s_fc_lock while during fast commit
Message-ID: <20241216105028.nb32aqzig2wmm4md@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-11-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818040356.241684-11-harshadshirwadkar@gmail.com>
X-Rspamd-Queue-Id: B86951F787
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 18-08-24 04:03:56, Harshad Shirwadkar wrote:
> Leaving s_fc_lock in between during commit in ext4_fc_perform_commit()
> function leaves room for subtle concurrency bugs where ext4_fc_del() may
> delete an inode from the fast commit list, leaving list in an inconsistent
> state. Also, this patch converts s_fc_lock to mutex type so that it can be
> held when kmem_cache_* functions are called.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This would be easier to review if you split the patch into two - one for
mindless conversion of a spinlock into a mutex and another one for the
change when the lock is held which can have non-trivial effects.

Otherwise the patch looks good, just one nit below. With that fixed feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1010,26 +1011,22 @@ __releases(&sbi->s_fc_lock)
^^ the sparse annotation with __acquires, __releases needs updating as
well

>  	list_for_each_entry_safe(fc_dentry, fc_dentry_n,
>  				 &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
>  		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
> -			spin_unlock(&sbi->s_fc_lock);
> -			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
> -				ret = -ENOSPC;
> -				goto lock_and_exit;
> -			}
> -			spin_lock(&sbi->s_fc_lock);
> +			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry))
> +				return -ENOSPC;
>  			continue;
>  		}
>  		/*
>  		 * With fcd_dilist we need not loop in sbi->s_fc_q to get the
> -		 * corresponding inode pointer
> +		 * corresponding inode. Also, the corresponding inode could have been
> +		 * deleted, in which case, we don't need to do anything.
>  		 */
> -		WARN_ON(list_empty(&fc_dentry->fcd_dilist));
> +		if (list_empty(&fc_dentry->fcd_dilist))
> +			continue;
>  		ei = list_first_entry(&fc_dentry->fcd_dilist,
>  				struct ext4_inode_info, i_fc_dilist);
>  		inode = &ei->vfs_inode;
>  		WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
>  
> -		spin_unlock(&sbi->s_fc_lock);
> -
>  		/*
>  		 * We first write the inode and then the create dirent. This
>  		 * allows the recovery code to create an unnamed inode first

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


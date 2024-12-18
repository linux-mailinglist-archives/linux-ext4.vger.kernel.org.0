Return-Path: <linux-ext4+bounces-5745-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475FB9F6505
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877DA16224A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AB1A0739;
	Wed, 18 Dec 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9R7plYp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKs3aqzt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9R7plYp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKs3aqzt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F119D090;
	Wed, 18 Dec 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521832; cv=none; b=TVwNbXEmLL1J+Ve5yF6AF2rzo5MupKSMFRKrIFqbTNyA3iHDiNuiba2LIGYiPS1a0DZIlg2mretcZd4QQKO/23n2oWKac4KL2nae4H7yV9TmoYbBclvELV5N2ivzz2E6n7cHkL68QKpMHOITNhGquVTEDaF/Buh6ZKv2FCbo+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521832; c=relaxed/simple;
	bh=UwefhFV1tTYqgGlcSwfNIm0wSZ08bO4fNRSh8E3oFUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/lJkK6ARgjVaJdlWgtoJLktWzwrGNXu4Rou2W9ATvbXHWc7c9lkgxUkA4ZwIbGVbecJvySpzvU3rfbGFOnpJLmMGNaULY9LtsAIj7KN81H0HTWdTPWeEnQV6A12hgpr3/D64GizQGlIi0z5EyYJgM2FWUOM+7QCbkD8b+AIxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9R7plYp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKs3aqzt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9R7plYp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKs3aqzt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AEBB21102;
	Wed, 18 Dec 2024 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734521828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stce49XZxYotzMwzcTRiOXCvRr8V07HO6G2u1tSh5wI=;
	b=J9R7plYpexpFbh+ZIFjwaAZ66Ut+WLSvYJQ1QZ8g+4VfEQs/eX7uWPpjEnMFeOKkgJITnP
	O1uVqtZQy+LfAfdyKCG/QJchmZRvgeaJC8iVHrX7K7oIzJPVF3emd4k88QujiebwkTvfIR
	DAGBbWsS6UidR16bGB6T/xsNZM8eavk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734521828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stce49XZxYotzMwzcTRiOXCvRr8V07HO6G2u1tSh5wI=;
	b=OKs3aqzt3sAa33tCa0lJeXxINskZnHBtyw7eE5azYbdt2v1LQGtnqSr3dc2AzRQZUi3h+O
	YOcSkQU/Py3FqaAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734521828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stce49XZxYotzMwzcTRiOXCvRr8V07HO6G2u1tSh5wI=;
	b=J9R7plYpexpFbh+ZIFjwaAZ66Ut+WLSvYJQ1QZ8g+4VfEQs/eX7uWPpjEnMFeOKkgJITnP
	O1uVqtZQy+LfAfdyKCG/QJchmZRvgeaJC8iVHrX7K7oIzJPVF3emd4k88QujiebwkTvfIR
	DAGBbWsS6UidR16bGB6T/xsNZM8eavk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734521828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stce49XZxYotzMwzcTRiOXCvRr8V07HO6G2u1tSh5wI=;
	b=OKs3aqzt3sAa33tCa0lJeXxINskZnHBtyw7eE5azYbdt2v1LQGtnqSr3dc2AzRQZUi3h+O
	YOcSkQU/Py3FqaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DE46132EA;
	Wed, 18 Dec 2024 11:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7wLsFuSzYmfRbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 11:37:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D954A0935; Wed, 18 Dec 2024 12:37:08 +0100 (CET)
Date: Wed, 18 Dec 2024 12:37:08 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: remove unneeded forward declaration
Message-ID: <20241218113708.t3cpe3a7b3tmkkni@quack3>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217120356.1399443-4-shikemeng@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.com,gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 17-12-24 20:03:56, Kemeng Shi wrote:
> Remove unneeded forward declaration of ext4_destroy_lazyinit_thread().
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8dfda41dabaa..d294cd43d3f2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -79,7 +79,6 @@ static int ext4_unfreeze(struct super_block *sb);
>  static int ext4_freeze(struct super_block *sb);
>  static inline int ext2_feature_set_ok(struct super_block *sb);
>  static inline int ext3_feature_set_ok(struct super_block *sb);
> -static void ext4_destroy_lazyinit_thread(void);
>  static void ext4_unregister_li_request(struct super_block *sb);
>  static void ext4_clear_request_list(void);
>  static struct inode *ext4_get_journal_inode(struct super_block *sb,
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


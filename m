Return-Path: <linux-ext4+bounces-625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D6821C33
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF328374F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51BFC02;
	Tue,  2 Jan 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KyI0bHLC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zYQCXc4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KyI0bHLC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zYQCXc4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191DFBF8;
	Tue,  2 Jan 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA7361FCF9;
	Tue,  2 Jan 2024 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXPOITzvh6Zn/mmqB0IL6gJjvC/Rku2a8VXc7b9wi8Y=;
	b=KyI0bHLCyuAK06R7d0Cus0O8RTaTp36PE/FTL+CcYWxm1pJf/tBrEHDsBjrjdzppPT4y5J
	w6t/ZqN6stgdt23QRbUkymeWp2+4KCDxg4+84BQGrSawSugEvKffETqaCqIit4YEjC7ki+
	CKNaxQNcPhH5KqWpdTB8YqtQqBn/Oy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXPOITzvh6Zn/mmqB0IL6gJjvC/Rku2a8VXc7b9wi8Y=;
	b=7zYQCXc4G9mh5nuhKyfnozhO9K5kGu9WaARAQMo31jForL8StLVtWbzPN2flQAESj5KSaZ
	M1W8VqH4t3sRWSCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXPOITzvh6Zn/mmqB0IL6gJjvC/Rku2a8VXc7b9wi8Y=;
	b=KyI0bHLCyuAK06R7d0Cus0O8RTaTp36PE/FTL+CcYWxm1pJf/tBrEHDsBjrjdzppPT4y5J
	w6t/ZqN6stgdt23QRbUkymeWp2+4KCDxg4+84BQGrSawSugEvKffETqaCqIit4YEjC7ki+
	CKNaxQNcPhH5KqWpdTB8YqtQqBn/Oy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXPOITzvh6Zn/mmqB0IL6gJjvC/Rku2a8VXc7b9wi8Y=;
	b=7zYQCXc4G9mh5nuhKyfnozhO9K5kGu9WaARAQMo31jForL8StLVtWbzPN2flQAESj5KSaZ
	M1W8VqH4t3sRWSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 999BE13AC6;
	Tue,  2 Jan 2024 13:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4x1JTIKlGX2SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:05:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E821A07EF; Tue,  2 Jan 2024 14:05:54 +0100 (CET)
Date: Tue, 2 Jan 2024 14:05:54 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ext4: remove unused return value of
 ext4_mb_release_inode_pa
Message-ID: <20240102130554.dawoitclnhxmrrfs@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-7-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.40%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.40
X-Spam-Flag: NO

On Sun 26-11-23 00:11:41, Kemeng Shi wrote:
> Remove unused return value of ext4_mb_release_inode_pa
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8d6246db3..1ed6d1d5a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5278,7 +5278,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>   * the caller MUST hold group/inode locks.
>   * TODO: optimize the case when there are no in-core structures yet
>   */
> -static noinline_for_stack int
> +static noinline_for_stack void
>  ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
>  			struct ext4_prealloc_space *pa)
>  {
> @@ -5328,8 +5328,6 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
>  		 */
>  	}
>  	atomic_add(free, &sbi->s_mb_discarded);
> -
> -	return 0;
>  }
>  
>  static noinline_for_stack int
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


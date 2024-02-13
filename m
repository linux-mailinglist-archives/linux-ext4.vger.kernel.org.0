Return-Path: <linux-ext4+bounces-1226-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5CA8535C3
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E221B28B10F
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05F5F84B;
	Tue, 13 Feb 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5oqnftu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4YT91tp0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5oqnftu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4YT91tp0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF022089;
	Tue, 13 Feb 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840912; cv=none; b=jN1+8H7/e1XPM3uZAd1JZ3lbUnagSFwCwXtDgqYg2SZF10giufzSysd3jVMarqcCmc6C/L1xvbB9OXckEraLbBDQQHTu1ArYUmdTh6MzImVTiuDE7WsowcdNhD/lA0nxUsRvGueXBfPcyqi8KW6cHiha7qlzY8CKoqU/ohR75I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840912; c=relaxed/simple;
	bh=Y1YL0DSRI7g0BqyNeAKlenbpvSj1jIwXIZ3opnvWDtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEF04Uuizkw0oO0L+5SRikihqw1ouX5GSLXJks8gk1kzKi5g1yNJYcIyXQ9D31Y3AoklxtlKf9l/F8j7WIef33zpqy7AOwHBdy6Fv4Od4ifxSKfZEwGHu4XLDPx/jxjFQg5JVX0WVSe01xIpP4G8Qp5TZJHXCilxPX7sAIM2o1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o5oqnftu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4YT91tp0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o5oqnftu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4YT91tp0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EE991FCE6;
	Tue, 13 Feb 2024 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707840909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0okwJB7vgL1WOohmmm9lGtttNoCx6X/mkIgLjfB1S4=;
	b=o5oqnftuj1eaqco4wPnIPNK4n3H/ZWO5ga3ocBKIag5Tt1GQWfyVcanGxUNgK74JDzY2G3
	pVC+NmEFRfl3FqBRiUl5LADvsFxyu6jgPHv5/SxtUR7L8ig4CVPd5y0LJS3BIEaXBypnN3
	JvUe7q0wtBB14bXlZUTG5v725w2Nsak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707840909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0okwJB7vgL1WOohmmm9lGtttNoCx6X/mkIgLjfB1S4=;
	b=4YT91tp0DgqwMULcDWuJ8WHNfMi0e1HUkZb1fwm1JLQ83mX4TJIV9iGgP9REPpYfLRVgIE
	jp32hLa1iRngYnAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707840909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0okwJB7vgL1WOohmmm9lGtttNoCx6X/mkIgLjfB1S4=;
	b=o5oqnftuj1eaqco4wPnIPNK4n3H/ZWO5ga3ocBKIag5Tt1GQWfyVcanGxUNgK74JDzY2G3
	pVC+NmEFRfl3FqBRiUl5LADvsFxyu6jgPHv5/SxtUR7L8ig4CVPd5y0LJS3BIEaXBypnN3
	JvUe7q0wtBB14bXlZUTG5v725w2Nsak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707840909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0okwJB7vgL1WOohmmm9lGtttNoCx6X/mkIgLjfB1S4=;
	b=4YT91tp0DgqwMULcDWuJ8WHNfMi0e1HUkZb1fwm1JLQ83mX4TJIV9iGgP9REPpYfLRVgIE
	jp32hLa1iRngYnAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 27BE31329E;
	Tue, 13 Feb 2024 16:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NlOyCY2Vy2VICAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:15:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5E58A0809; Tue, 13 Feb 2024 17:15:08 +0100 (CET)
Date: Tue, 13 Feb 2024 17:15:08 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, stable@kernel.org
Subject: Re: [PATCH 6/7] ext4: set type of ac_groups_linear_remaining to
 __u32 to avoid overflow
Message-ID: <20240213161508.ytowat2xixkd45de@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-7-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-7-libaokun1@huawei.com>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o5oqnftu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4YT91tp0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.25 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.24)[72.74%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.25
X-Rspamd-Queue-Id: 3EE991FCE6
X-Spam-Flag: NO

On Fri 26-01-24 16:57:15, Baokun Li wrote:
> Now ac_groups_linear_remaining is of type __u16 and s_mb_max_linear_groups
> is of type unsigned int, so an overflow occurs when setting a value above
> 65535 through the mb_max_linear_groups sysfs interface. Therefore, the
> type of ac_groups_linear_remaining is set to __u32 to avoid overflow.
> 
> Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
> CC: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index d7aeb5da7d86..498af2abc5d8 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -194,8 +194,8 @@ struct ext4_allocation_context {
>  
>  	__u32 ac_groups_considered;
>  	__u32 ac_flags;		/* allocation hints */
> +	__u32 ac_groups_linear_remaining;
>  	__u16 ac_groups_scanned;
> -	__u16 ac_groups_linear_remaining;
>  	__u16 ac_found;
>  	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
>  	__u16 ac_tail;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


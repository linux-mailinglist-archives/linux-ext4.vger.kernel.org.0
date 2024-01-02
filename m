Return-Path: <linux-ext4+bounces-623-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C2D821C29
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FBFB21ECF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1AFBEC;
	Tue,  2 Jan 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nKGosC+v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2CpODGh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nKGosC+v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2CpODGh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D403FBE1;
	Tue,  2 Jan 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81EE521EB7;
	Tue,  2 Jan 2024 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49RMakn0VSJ/uXhOOuMdnd8VS3RL4VUdiHonmzokx/s=;
	b=nKGosC+vt7RzWDJift5xqSJ0T/EiflwKxN8jykcsxfvsIYIWa6ejEWQZ+KSGkzEGj08xLY
	qSNLDpgN63Tlx5vrGOWBAMjFQoWnQBvPCBbd3LSmA3+cUHUvYeRrtaS0ABTMX13/g4zY7M
	+uRCDibYl7Nu1nQyCwZNNBoQjDeuMzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49RMakn0VSJ/uXhOOuMdnd8VS3RL4VUdiHonmzokx/s=;
	b=O2CpODGhEsOkYhWzyvinwoufHMwApxQUB6A0STnOhKyTSPavdcwxALjQgSiTLvOrs63yFc
	zWPaoERntUpsNqAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49RMakn0VSJ/uXhOOuMdnd8VS3RL4VUdiHonmzokx/s=;
	b=nKGosC+vt7RzWDJift5xqSJ0T/EiflwKxN8jykcsxfvsIYIWa6ejEWQZ+KSGkzEGj08xLY
	qSNLDpgN63Tlx5vrGOWBAMjFQoWnQBvPCBbd3LSmA3+cUHUvYeRrtaS0ABTMX13/g4zY7M
	+uRCDibYl7Nu1nQyCwZNNBoQjDeuMzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49RMakn0VSJ/uXhOOuMdnd8VS3RL4VUdiHonmzokx/s=;
	b=O2CpODGhEsOkYhWzyvinwoufHMwApxQUB6A0STnOhKyTSPavdcwxALjQgSiTLvOrs63yFc
	zWPaoERntUpsNqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4621340C;
	Tue,  2 Jan 2024 13:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3F1uGrAJlGVlSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:03:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 29FBDA07EF; Tue,  2 Jan 2024 14:03:44 +0100 (CET)
Date: Tue, 2 Jan 2024 14:03:44 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] ext4: remove unused
 ext4_allocation_context::ac_groups_considered
Message-ID: <20240102130344.a3tbpf7sftmrfjbw@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-5-shikemeng@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.88
X-Spamd-Result: default: False [-2.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.08)[95.53%]
X-Spam-Flag: NO

On Sun 26-11-23 00:11:39, Kemeng Shi wrote:
> Remove unused ext4_allocation_context::ac_groups_considered
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Hum, indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index d7aeb5da7..56938532b 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -192,7 +192,6 @@ struct ext4_allocation_context {
>  	 */
>  	ext4_grpblk_t	ac_orig_goal_len;
>  
> -	__u32 ac_groups_considered;
>  	__u32 ac_flags;		/* allocation hints */
>  	__u16 ac_groups_scanned;
>  	__u16 ac_groups_linear_remaining;
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


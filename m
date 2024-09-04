Return-Path: <linux-ext4+bounces-4044-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5C96B8AA
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432731C2405C
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B91CDA1E;
	Wed,  4 Sep 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cj/5eqQ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SB4x+eTE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cj/5eqQ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SB4x+eTE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61E126C01;
	Wed,  4 Sep 2024 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446231; cv=none; b=RTFaLgJaXkYzM4aJgJxGoQg5PnEKcUD2WSkQzIswqMOHlsEa3rwa/xeIcR+295nZppo/MPVDXrkGTmV6Yv5w1IoZhLnKw8GJxYdqZOpZYalcA4IvwMHQexZDEFsLUm4F2OpbCRZZ001kXVLQSUEE7kBio/jKb6ifnNja2C1dMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446231; c=relaxed/simple;
	bh=KFsTtEN+XARugQ0gu7a2OXWT8kJ4doETJZCJyP9Jy9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5mF4xgvm1y5ZeM5lH0hacAIcpLl5foAhIh751nTWsUdAd2pcGhJ8A020RGHJJBifVq24blRxiSZj2JBLUUAbPZK7o7lDc8mgzVI353SNDaWU76ZTlNNwRTG2g06kavqoFrQ/TSJCv5r0xqjeGDm0MRuQKkmjHcjOOEH8aHtSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cj/5eqQ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SB4x+eTE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cj/5eqQ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SB4x+eTE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9F8C1FD1A;
	Wed,  4 Sep 2024 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725446227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6f2m65/C+ryUTWxn3jBXvfR5Hc9dn7hOQEdPe0zMjI=;
	b=cj/5eqQ+EkPFB3EgCWs7cY3HRUsN/ICVURPhWrmI/nvrKnoLa6NuGzKF8l42xISVb/h9ii
	6Pfk1hZBeAItIXH3LIOFo7ODU3udsQj83/0gC+eojqCycHNlAV5cP3B8WGR+azCOkPRDDD
	SohUUViCYA0Nu7dl4K4wdfml8+aDa74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725446227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6f2m65/C+ryUTWxn3jBXvfR5Hc9dn7hOQEdPe0zMjI=;
	b=SB4x+eTErcprUZ833oG1hy+P+vNvNPIidc2lz8D79wtLeKueZU5J+9XsKZutu5rB1jL9IF
	sJz9xszbp5Y2THAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725446227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6f2m65/C+ryUTWxn3jBXvfR5Hc9dn7hOQEdPe0zMjI=;
	b=cj/5eqQ+EkPFB3EgCWs7cY3HRUsN/ICVURPhWrmI/nvrKnoLa6NuGzKF8l42xISVb/h9ii
	6Pfk1hZBeAItIXH3LIOFo7ODU3udsQj83/0gC+eojqCycHNlAV5cP3B8WGR+azCOkPRDDD
	SohUUViCYA0Nu7dl4K4wdfml8+aDa74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725446227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6f2m65/C+ryUTWxn3jBXvfR5Hc9dn7hOQEdPe0zMjI=;
	b=SB4x+eTErcprUZ833oG1hy+P+vNvNPIidc2lz8D79wtLeKueZU5J+9XsKZutu5rB1jL9IF
	sJz9xszbp5Y2THAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A836139D2;
	Wed,  4 Sep 2024 10:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d1cWJVM42GYHLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:37:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49C35A0968; Wed,  4 Sep 2024 12:37:03 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:37:03 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>, Zorro Lang <zlang@kernel.org>,
	linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: return error on syncfs after shutdown
Message-ID: <20240904103703.cwp6jw3vd2cu3szc@quack3>
References: <20240904084657.1062243-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904084657.1062243-1-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 10:46:57, Amir Goldstein wrote:
> This is the logic behavior and one that we would like to verify
> using a generic fstest similar to xfs/546.
> 
> Link: https://lore.kernel.org/fstests/20240830152648.GE6216@frogsfrogsfrogs/
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yeah, makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Ted,
> 
> Please see the discussion about moving test xfs/546 to generic.
> 
> WDYT?
> 
> Thanks,
> Amir.
> 
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e72145c4ae5a..b9cf18819e11 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6279,7 +6279,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
>  	if (unlikely(ext4_forced_shutdown(sb)))
> -		return 0;
> +		return -EIO;
>  
>  	trace_ext4_sync_fs(sb, wait);
>  	flush_workqueue(sbi->rsv_conversion_wq);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


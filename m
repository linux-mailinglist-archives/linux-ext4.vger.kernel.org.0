Return-Path: <linux-ext4+bounces-1858-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6E8988B0
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 15:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A11C21262
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DE1272B7;
	Thu,  4 Apr 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tfKqhYH4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xdAFOZPO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvyHCJsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYgUJsxZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140D18AF6;
	Thu,  4 Apr 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236947; cv=none; b=paE//nkJxZidCTG7708iP9Yfhr1Fh0VB3BQVEjjGhNYbxA9ObEjjCewEe6/SAodu3qScXY/pgTL2ak2adR89ZBdmI9y39N4quLvWqvJgAWcy3K71qXRNVPrKij8InGfn1Urccb1sSjtHvCq/GuGigAt6hYUtGpjO5nJVhWfVSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236947; c=relaxed/simple;
	bh=C26GEQmF0yzY1/2yRCLUfSnRdKRPVpkt0GKXY7N2i6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy2u1VQ5qCltvAGjS8ybZ5vYWVn78z64yLs/qsVAHb6QDTfiXFtXCz2lvXLuLdpLfK0LvUfsGJGMKR3aLWVogK9djMBoknWukG2FPP56jEMlev9htGXY1NFvB9TUirT2cRdMg5tDEcr9xg1GQD+hbePaTIy2yk7VyrFV/yTnx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tfKqhYH4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xdAFOZPO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvyHCJsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYgUJsxZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9DFD37C07;
	Thu,  4 Apr 2024 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712236942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FqFHP02mrX+zb0ebadzMDbBlUgI5RchQt3YBs3WUxg=;
	b=tfKqhYH49ZKwp6JFjF1nBhUyw3A3pcPFd82ZbW+3rf4Prf1MB2/6xpT8KIwD20SgLfQa0B
	DrxnyIGwTlbELdtC3RcQRHeNqy4jB5EDks8Z1S6DJvUx+ZyyNhsXMbb/eoGA0K98wz5rMy
	JYMPkhQ1L2l5aehUru10Hz8jclbVhFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712236942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FqFHP02mrX+zb0ebadzMDbBlUgI5RchQt3YBs3WUxg=;
	b=xdAFOZPOEirLRBQ+BGXTV8I5Mm1McFa1POU8Rq8494K59qhfTxI4b+hQThb0bYgVKyyucL
	GNNdckKZxydS8BBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712236941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FqFHP02mrX+zb0ebadzMDbBlUgI5RchQt3YBs3WUxg=;
	b=dvyHCJsym86I5CcEDMyI4bQgEIqWyqzeLaQ8lKiUtNVXego3AImrJnTqBMmzdvKZUdqiIZ
	96JoEHHPKdbgCapUUTmI8U3P/17UGeTkQ1Eq5lf7BmLpax+MdrhIcNsm9vXkC5Sv7+XFX6
	uLD5v9TAUsr+sTRBa71PbL3Q0alphAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712236941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FqFHP02mrX+zb0ebadzMDbBlUgI5RchQt3YBs3WUxg=;
	b=oYgUJsxZzwFadcRpmIklMOwdhQkmVvEtm8S6HnsTuyky+j83w9dpDOxgYfO95zNpt79KSN
	jyUhIn0Po0bbxrAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DE6D4139E8;
	Thu,  4 Apr 2024 13:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8llLNo2pDmYbcgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 13:22:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 844AEA0816; Thu,  4 Apr 2024 15:22:21 +0200 (CEST)
Date: Thu, 4 Apr 2024 15:22:21 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH 1/5] ext4: keep "prefetch_grp" and "nr" consistent
Message-ID: <20240404132221.uliif3mw7acy7t7l@quack3>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-2-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: 0.70
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[39.50%];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,suse.cz,linux.ibm.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]

On Wed 27-03-24 05:38:19, Kemeng Shi wrote:
> Keep "prefetch_grp" and "nr" consistent to avoid to call
> ext4_mb_prefetch_fini with non-prefetched groups.
> When we step into next criteria, "prefetch_grp" is set to prefetch start
> of new criteria while "nr" is number of the prefetched group in previous
> criteria. If previous criteria and next criteria are both inexpensive
> (< CR_GOAL_LEN_SLOW) and prefetch_ios reachs sbi->s_mb_prefetch_limit
> in previous criteria, "prefetch_grp" and "nr" will be inconsistent and
> may introduce unexpected cost to do ext4_mb_init_group for non-prefetched
> groups.
> Reset "nr" to 0 when we reset "prefetch_grp" to start of prefech in next
> criteria to ensure "prefetch_grp" and "nr" are consistent.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 12b3f196010b..a61fc52956b2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2856,6 +2856,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  		group = ac->ac_g_ex.fe_group;
>  		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
>  		prefetch_grp = group;
> +		nr = 0;
>  
>  		for (i = 0, new_cr = cr; i < ngroups; i++,
>  		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


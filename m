Return-Path: <linux-ext4+bounces-4124-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6D976529
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2024 11:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2866E2820DD
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0C19259B;
	Thu, 12 Sep 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="btIgOAZ9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fvr4jxgd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="btIgOAZ9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fvr4jxgd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A770188A35;
	Thu, 12 Sep 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132046; cv=none; b=DFQtA0x1ii9zGjHpb2HE14ankQyDh7k2mneVIktWfGqXCKi0k0ERtDL0h1nJOBPrPkp9h8kyHXOvpCMJYdLukWnmAyJWS5rHycRNiWRjugE9xKQ1CarhP7iOs/OJe+gx8daoiET9Vbjhznz3NcWuFPlm7HKEyscbhmqZ3zjfCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132046; c=relaxed/simple;
	bh=jOgLfYrRrYA6YqozFCaYTUHe2HSPPtO0emZuQRzxWpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwn9h0jMJ9sCJd/8X1TIVPxRQfXBqPZYCHiHyV4/unabhaftagAXc8tpWwkqSVplGCRA+1yiAv3k75DNGwT4M+4yfSjIjwXYxL6ZlbSenQH/fNYKYATwIR5l/vTQQd6a42xYcIEauQdovhc54qXzd5yQM1SG1/ooTorO74RXcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=btIgOAZ9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fvr4jxgd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=btIgOAZ9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fvr4jxgd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A501A219E7;
	Thu, 12 Sep 2024 09:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726132042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNNn9u5EOy3XN6BN/n/lP5n9ds6j5LP/KiWNjpZ/eO8=;
	b=btIgOAZ91iv/CvuR9ikDr4G7dNZC56ON3oIPs1/KV4oQHZTMWn/kjUCticrKWny1RGU8Ud
	vc+xKVkwBp+aYg2YkzKWYTZjHMXlqnIl0EZAcvZ7jfavgdOYRKzN7EkmCTxP8lQWY/GYZ7
	rQwusDTUYCJythIGtFTtV+SG8IiyvvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726132042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNNn9u5EOy3XN6BN/n/lP5n9ds6j5LP/KiWNjpZ/eO8=;
	b=Fvr4jxgd87DDQYA4ArrwAWMkxdtxDIejD1cEsjdhsuonYqjJS2CfZL41IPBW9jMqNPM793
	I4vpFQawtXw9gfAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726132042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNNn9u5EOy3XN6BN/n/lP5n9ds6j5LP/KiWNjpZ/eO8=;
	b=btIgOAZ91iv/CvuR9ikDr4G7dNZC56ON3oIPs1/KV4oQHZTMWn/kjUCticrKWny1RGU8Ud
	vc+xKVkwBp+aYg2YkzKWYTZjHMXlqnIl0EZAcvZ7jfavgdOYRKzN7EkmCTxP8lQWY/GYZ7
	rQwusDTUYCJythIGtFTtV+SG8IiyvvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726132042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNNn9u5EOy3XN6BN/n/lP5n9ds6j5LP/KiWNjpZ/eO8=;
	b=Fvr4jxgd87DDQYA4ArrwAWMkxdtxDIejD1cEsjdhsuonYqjJS2CfZL41IPBW9jMqNPM793
	I4vpFQawtXw9gfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 999F513A73;
	Thu, 12 Sep 2024 09:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KL98JUqv4mYxGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Sep 2024 09:07:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54956A08B3; Thu, 12 Sep 2024 11:07:22 +0200 (CEST)
Date: Thu, 12 Sep 2024 11:07:22 +0200
From: Jan Kara <jack@suse.cz>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ext4: Simplify if condition
Message-ID: <20240912090722.4e7o4l462y6hccau@quack3>
References: <20240830071713.40565-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830071713.40565-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:17:13, Jiapeng Chong wrote:
> The if condition !A || A && B can be simplified to !A || B.
> 
> ./fs/ext4/fast_commit.c:362:21-23: WARNING !A || A && B is equivalent to !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9837
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 326c16a4e51e..53a77172dc9f 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -357,9 +357,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>  	}
>  	spin_lock(&sbi->s_fc_lock);
>  	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> -	if (has_transaction &&
> -	    (!is_ineligible ||
> -	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
> +	if (has_transaction && (!is_ineligible || tid_gt(tid, sbi->s_fc_ineligible_tid)))
>  		sbi->s_fc_ineligible_tid = tid;
>  	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>  	spin_unlock(&sbi->s_fc_lock);
> -- 
> 2.32.0.3.g01195cf9f
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


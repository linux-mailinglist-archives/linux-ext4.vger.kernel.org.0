Return-Path: <linux-ext4+bounces-5881-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B77A00AB4
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F17D163E47
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB001FA8D2;
	Fri,  3 Jan 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKGtojdC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vy4qD0my";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKGtojdC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vy4qD0my"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFF1C5F29;
	Fri,  3 Jan 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915176; cv=none; b=b55nrTBtQGDGkR8IHTANFHcIzQQn8/vzorjGnys8d36RzXKvGbmrqNJ4PlBku8dO1qsg7ghpWE4P0+pdXyu02XXAHfnapbY07JW7UfQNCrmOQq+yiAD8vG/L+aTXXBqRpChWATTUa4+/t+Kuwd7RMxa+H4Yjx4PAttwhrpnW2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915176; c=relaxed/simple;
	bh=JDa7NXl1hOHdHIoIwH92hhBEOT0MFsHxNekuETWrTeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDWkANzAp395itTdbUGn1AmgPzI566NjUUPQj0BcY9WP79g98RcbwioU1bgrle0LewLPNDyzKMGjWo3638p5pZ1LUgjmDV73awwBRUQ6JjpwfGzfpDGh4iOUXBYswhx0HGs83IIBetlWrcxctSXdh+XZ1QQKWIm3pBoBoBoK91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKGtojdC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vy4qD0my; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKGtojdC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vy4qD0my; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69E1321119;
	Fri,  3 Jan 2025 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjX07fq4JNLToHGJR5rsC8ZRN40WeqEaDZQ336azrdg=;
	b=hKGtojdCAxW2aSlADtT+ulHG+bkLCW8aekhwS+UcROJtESECm1EoAIodmr75IDIO7cS1yH
	uwxRMwRq7mnTyXQPtgXOh9OtpZAEcTSvwrsGx5cjDTmFAzAoEtE5p/rYOHXST4fi/ygaIP
	ENBDWjfpqDpsBPO1m9uSI7opt61G4Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjX07fq4JNLToHGJR5rsC8ZRN40WeqEaDZQ336azrdg=;
	b=vy4qD0myn7ctJqocDzbobkvfeu1QKwhjtxdAaGELb88jqAeUl1qkJ5MyJIA0CuWPUiEg9+
	jbV0HPYKZZ04isAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjX07fq4JNLToHGJR5rsC8ZRN40WeqEaDZQ336azrdg=;
	b=hKGtojdCAxW2aSlADtT+ulHG+bkLCW8aekhwS+UcROJtESECm1EoAIodmr75IDIO7cS1yH
	uwxRMwRq7mnTyXQPtgXOh9OtpZAEcTSvwrsGx5cjDTmFAzAoEtE5p/rYOHXST4fi/ygaIP
	ENBDWjfpqDpsBPO1m9uSI7opt61G4Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjX07fq4JNLToHGJR5rsC8ZRN40WeqEaDZQ336azrdg=;
	b=vy4qD0myn7ctJqocDzbobkvfeu1QKwhjtxdAaGELb88jqAeUl1qkJ5MyJIA0CuWPUiEg9+
	jbV0HPYKZZ04isAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FA6E134E4;
	Fri,  3 Jan 2025 14:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2cdtE6T2d2fMXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:39:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45D24A0844; Fri,  3 Jan 2025 15:39:30 +0100 (CET)
Date: Fri, 3 Jan 2025 15:39:30 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] jbd2: remove stale comment of update_t_max_wait
Message-ID: <yc5c3u6abjbazoy7hxfb2pjnklssmbeihryyfdq3o5cpz473fz@aw2qwha6zst6>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224202707.1530558-5-shikemeng@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,huaweicloud.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 25-12-24 04:27:05, Kemeng Shi wrote:
> Commit 2d44292058828 "jbd2: remove CONFIG_JBD2_DEBUG to update t_max_wait"
> removed jbd2_journal_enable_debug, just remove stale comment about
> jbd2_journal_enable_debug.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 66513c18ca29..e00b87635512 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -119,7 +119,6 @@ static void jbd2_get_transaction(journal_t *journal,
>   * t_max_wait is carefully updated here with use of atomic compare exchange.
>   * Note that there could be multiplre threads trying to do this simultaneously
>   * hence using cmpxchg to avoid any use of locks in this case.
> - * With this t_max_wait can be updated w/o enabling jbd2_journal_enable_debug.
>   */
>  static inline void update_t_max_wait(transaction_t *transaction,
>  				     unsigned long ts)
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


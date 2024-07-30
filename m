Return-Path: <linux-ext4+bounces-3523-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A421941308
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F24B26851
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB219F471;
	Tue, 30 Jul 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="votp6cOY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8b7jXPd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="votp6cOY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8b7jXPd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9C18FC6E;
	Tue, 30 Jul 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345727; cv=none; b=KVqp7QcVgSD21mtUwHRtPbVvjSfM+TIBm3wh3jpGRCtF6GV+XIt/pskpTpNc9ifhyt3GjC9P5VnGbB2zT8nt33tyoNCRSb1yt4TGSVu7jHO4jZlB1d0vb9qNhc77+AQLE/See4RCFimJZk8ho7GhX5upwO75v9pcaayxUP47Qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345727; c=relaxed/simple;
	bh=YtU1TPryWvNIWmx42Vw3r+Efss/+g9rkHWZ0tyJAbTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBr41h6PkUsvRkX0AZpb6Hadz1qitIaV2jifJl1giEbpkWtMsMxVigpKKnlvLW3J23GXEdgQAWBlqMXJEGM6RmJW6jyx3E6EC+W8loT8+pyP4JSYTWRemC5po/Mu75il6a/yoeyBViHeHFYVIp0GP3r6A0lo1HdfoTz1Z2zns8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=votp6cOY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8b7jXPd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=votp6cOY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8b7jXPd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F58E1F7F6;
	Tue, 30 Jul 2024 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO9THBwWbYxMnnSpqWuhpohTcpKv7cgEmJdurnNricQ=;
	b=votp6cOYDuZnmq0FXxdBNhPv7yDS1nEL8FYXME2txQcz7Y/eT/1FLIoeij10zIkPkZ3WiU
	Go+SbS0VW0M5HI8ivtJdgtdrdgdJnMcEM2SQ1bjLslwZG15sIdfQCNsVm3VhLE1H6JwTFx
	sCY6RxkJPskmnKgGsVllYpFdiMmNaIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO9THBwWbYxMnnSpqWuhpohTcpKv7cgEmJdurnNricQ=;
	b=L8b7jXPdtInwzxFQIKOA5ZwXF7flfqZBLGAtpbBPADRPJL5CER8FJ70PAxEeChM9LhqKCU
	ZG6v1X1SCKNG4ZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO9THBwWbYxMnnSpqWuhpohTcpKv7cgEmJdurnNricQ=;
	b=votp6cOYDuZnmq0FXxdBNhPv7yDS1nEL8FYXME2txQcz7Y/eT/1FLIoeij10zIkPkZ3WiU
	Go+SbS0VW0M5HI8ivtJdgtdrdgdJnMcEM2SQ1bjLslwZG15sIdfQCNsVm3VhLE1H6JwTFx
	sCY6RxkJPskmnKgGsVllYpFdiMmNaIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO9THBwWbYxMnnSpqWuhpohTcpKv7cgEmJdurnNricQ=;
	b=L8b7jXPdtInwzxFQIKOA5ZwXF7flfqZBLGAtpbBPADRPJL5CER8FJ70PAxEeChM9LhqKCU
	ZG6v1X1SCKNG4ZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1C1813983;
	Tue, 30 Jul 2024 13:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q8wCO/voqGZkWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:22:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFE6AA099C; Tue, 30 Jul 2024 15:21:59 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:21:59 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] jbd2: correctly compare tids with tid_geq function
 in jbd2_fc_begin_commit
Message-ID: <20240730132159.opjknn477owojkrq@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-2-shikemeng@huaweicloud.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 19:33:29, Kemeng Shi wrote:
> Use tid_geq to compare tids to work over sequence number wraps.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Indeed, Luis seems to have missed this when fixing these bugs recently.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1ebf2393bfb7..da5a56d700f1 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -710,7 +710,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
>  		return -EINVAL;
>  
>  	write_lock(&journal->j_state_lock);
> -	if (tid <= journal->j_commit_sequence) {
> +	if (tid_geq(journal->j_commit_sequence, tid)) {
>  		write_unlock(&journal->j_state_lock);
>  		return -EALREADY;
>  	}
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


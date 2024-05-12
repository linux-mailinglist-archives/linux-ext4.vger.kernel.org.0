Return-Path: <linux-ext4+bounces-2490-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE88C424D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240BFB21EB2
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE57153500;
	Mon, 13 May 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJ0jE588";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4T7MawJs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJ0jE588";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4T7MawJs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93873154428;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607701; cv=none; b=kCXnEKrk6rhFRXOPrQCSPKcFv3S6HddI5zMyS6/kmTxa6CLveG2gjNr6bp+d6Kx9wJl0TmYLoFKsqfV+J6/F63tTX99ftnObVzUK/yOo7VNamx5MGPOnkn9YMi2CFKyEwfryYxSgdvLQHf+vmHKh93J0JyHLspZXompr0L0MeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607701; c=relaxed/simple;
	bh=/1JNBe9F/PZ69a8YFr7ZyMpTtpTq9sTHPBzD+2WUixo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn3Cx/zhGrtM1E9z+mU2UcmXNOkKNFy36COJEjV1xOspfTe4a6iRrR3gGHG/d09k7l34ncNB6LfE+fI8WbeWAF3csVISZ+ArzxFjaLyr5icbdiPM/GaG8YVcFZ4PQRGJApi6pkVScKTx2/sIFSIMLm/q+VgbNAHasJRSKFRr/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJ0jE588; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4T7MawJs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJ0jE588; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4T7MawJs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42A275C0D9;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FQiO+ZNvZ+0y/Dlc2wC0U7u+dzb10N71bNPEiRmEzs=;
	b=EJ0jE588kgVEsvtw0YxaWwwpJhU93kJ4UhHmsTNCGxDXWpmpYLo6hB11FvcGhoQY3wRyuK
	MGDlfzVdalUJxqGxFsiro+aLWUrM4/zEK8GD3yAA0FWqFV2/+8cF1s7Y2jQMauoztZRw0V
	YZWDNVfRYfOgr03c1TD7CN8oXitF5+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FQiO+ZNvZ+0y/Dlc2wC0U7u+dzb10N71bNPEiRmEzs=;
	b=4T7MawJsM76mhrgutOvdUyTvOC4d4rxf9XDo0tnypfMlfNzXQIFosFTQ1CrAjavJEBm9ux
	S1SqrNNmzqLw/zDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FQiO+ZNvZ+0y/Dlc2wC0U7u+dzb10N71bNPEiRmEzs=;
	b=EJ0jE588kgVEsvtw0YxaWwwpJhU93kJ4UhHmsTNCGxDXWpmpYLo6hB11FvcGhoQY3wRyuK
	MGDlfzVdalUJxqGxFsiro+aLWUrM4/zEK8GD3yAA0FWqFV2/+8cF1s7Y2jQMauoztZRw0V
	YZWDNVfRYfOgr03c1TD7CN8oXitF5+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FQiO+ZNvZ+0y/Dlc2wC0U7u+dzb10N71bNPEiRmEzs=;
	b=4T7MawJsM76mhrgutOvdUyTvOC4d4rxf9XDo0tnypfMlfNzXQIFosFTQ1CrAjavJEBm9ux
	S1SqrNNmzqLw/zDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 144B613A67;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R6PsBJEYQmaZDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2EB84A08E9; Sun, 12 May 2024 13:26:39 +0200 (CEST)
Date: Sun, 12 May 2024 13:26:39 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] jbd2: remove unnecessary "should_sleep" in kjournald2
Message-ID: <20240512112639.6sprlmgbm7jrazsv@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-10-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-10-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DATE_IN_PAST(1.00)[26];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email]

On Mon 06-05-24 22:18:01, Kemeng Shi wrote:
> We only need to sleep if no running transaction is expired. Simply remove
> unnecessary "should_sleep".
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index ce9004f40ffb..65c6cfce9d92 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -220,15 +220,12 @@ static int kjournald2(void *arg)
>  		 * so we don't sleep
>  		 */
>  		DEFINE_WAIT(wait);
> -		int should_sleep = 1;
>  
>  		prepare_to_wait(&journal->j_wait_commit, &wait,
>  				TASK_INTERRUPTIBLE);
>  		transaction = journal->j_running_transaction;
> -		if (transaction && time_after_eq(jiffies,
> -						transaction->t_expires))
> -			should_sleep = 0;
> -		if (should_sleep) {
> +		if (transaction == NULL ||
> +		    time_before(jiffies, transaction->t_expires)) {
>  			write_unlock(&journal->j_state_lock);
>  			schedule();
>  			write_lock(&journal->j_state_lock);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


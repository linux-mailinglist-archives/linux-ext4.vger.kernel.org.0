Return-Path: <linux-ext4+bounces-5878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D0A00A9F
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BC83A3C56
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AED1FA257;
	Fri,  3 Jan 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwvjLr2E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6sevoWhp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwvjLr2E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6sevoWhp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A361FA158;
	Fri,  3 Jan 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914991; cv=none; b=U5ZLYXECl8r5JZPoNbEmm4uouvhWGVQCDQEicFZukvJ0PvvwWH5ZHvLxC98JGt9CuFPkWFWo+UV8Txzk0yFOBEpEiZLxtyMUx1KN3PYcmn+hcdcXnNtufFAjgyQah7mVCRe7kNUCLD/fvUR9zXluYT63kp3h5yJkZGlmC1KivlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914991; c=relaxed/simple;
	bh=AtMujhQ6xZWFRAys/j/CegIxz9t1eSo6cF+MwL0PGgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYJyHqSoGutDA+juWYl0UEMh1Z06QaHIoZUn8Xpgq1ZO4k0bItz+af8XPzgaFYBpRLT48iu2jpvIlP4HSHSGggsCkEin8/avQaBUzWa0EBuuxVyzRnSawQ3KOymv1kVYcpT1Cw0asczULWRncnQA2nQVO4V6ccElyW3KAIS8VN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwvjLr2E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6sevoWhp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwvjLr2E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6sevoWhp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60B0F1F38E;
	Fri,  3 Jan 2025 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735914985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXch+oM/gEi+T3tSeKl3jm+SS9r73clNIUKa8YlrBzU=;
	b=zwvjLr2EDjUT5e9gavbQepbc2jblBROVnyYRNgiglYPk74Jk6/bWJY/3bgEir5JoESpa59
	CfiPfUKBC68FQ0061LeJOAIhci4K3VjOvctBmB2zQr8BBm0q0pNBKfHbYREne+nvqmHHo0
	QfUarKz4QJs587JHo9zQrmSeM8o9Oqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735914985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXch+oM/gEi+T3tSeKl3jm+SS9r73clNIUKa8YlrBzU=;
	b=6sevoWhppbK8JjWITC1W2xiI8rLW1GB/0blrGWlXhU3xu5RXAiAL70eQdk2xduxyM8HZK+
	lZk8K+dZXxmLmhBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zwvjLr2E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6sevoWhp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735914985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXch+oM/gEi+T3tSeKl3jm+SS9r73clNIUKa8YlrBzU=;
	b=zwvjLr2EDjUT5e9gavbQepbc2jblBROVnyYRNgiglYPk74Jk6/bWJY/3bgEir5JoESpa59
	CfiPfUKBC68FQ0061LeJOAIhci4K3VjOvctBmB2zQr8BBm0q0pNBKfHbYREne+nvqmHHo0
	QfUarKz4QJs587JHo9zQrmSeM8o9Oqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735914985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXch+oM/gEi+T3tSeKl3jm+SS9r73clNIUKa8YlrBzU=;
	b=6sevoWhppbK8JjWITC1W2xiI8rLW1GB/0blrGWlXhU3xu5RXAiAL70eQdk2xduxyM8HZK+
	lZk8K+dZXxmLmhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FAFF134E4;
	Fri,  3 Jan 2025 14:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sXxzE+n1d2cMXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:36:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC4F8A0844; Fri,  3 Jan 2025 15:36:24 +0100 (CET)
Date: Fri, 3 Jan 2025 15:36:24 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] jbd2: correct stale function name in comment
Message-ID: <ftkmmhb5hgpb3rncut5weocx46hmyyektaq5wkigf2yryk4bzi@upjmojgajinb>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224202707.1530558-6-shikemeng@huaweicloud.com>
X-Rspamd-Queue-Id: 60B0F1F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 25-12-24 04:27:06, Kemeng Shi wrote:
> Rename stale journal_clear_revoked_flag to jbd2_clear_buffer_revoked_flags.
> Rename stale journal_switch_revoke to jbd2_journal_switch_revoke_table.
> Rename stale __journal_file_buffer to __jbd2_journal_file_buffer.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/revoke.c      | 8 ++++----
>  fs/jbd2/transaction.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index af0208ed3619..5b7350109c5a 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -474,7 +474,7 @@ void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  }
>  
>  /*
> - * journal_clear_revoked_flag clears revoked flag of buffers in
> + * jbd2_clear_buffer_revoked_flags clears revoked flag of buffers in
>   * revoke table to reflect there is no revoked buffers in the next
>   * transaction which is going to be started.
>   */
> @@ -503,9 +503,9 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
>  	}
>  }
>  
> -/* journal_switch_revoke table select j_revoke for next transaction
> - * we do not want to suspend any processing until all revokes are
> - * written -bzzz
> +/* jbd2_journal_switch_revoke_table table select j_revoke for next
> + * transaction we do not want to suspend any processing until all
> + * revokes are written -bzzz
>   */
>  void jbd2_journal_switch_revoke_table(journal_t *journal)
>  {
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index e00b87635512..908baf73b188 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2191,7 +2191,7 @@ static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
>  		/*
>  		 * We don't want to write the buffer anymore, clear the
>  		 * bit so that we don't confuse checks in
> -		 * __journal_file_buffer
> +		 * __jbd2_journal_file_buffer
>  		 */
>  		clear_buffer_dirty(bh);
>  		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


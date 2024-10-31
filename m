Return-Path: <linux-ext4+bounces-4859-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C39B7A98
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 13:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A461C225CF
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5919C567;
	Thu, 31 Oct 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jeW7xaz/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNzKKuBB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jeW7xaz/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNzKKuBB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292F86131;
	Thu, 31 Oct 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378013; cv=none; b=clxeVBfan4hymqWeTJVBpSBPxptDPH8hE2l1o0NF45woMZyzWow7K6CMsPyLD4gowvRV7U1ARIDXZUGKBuRJ8Gk5KR/gzs0yWaKw35mkXPExdFkH0TGKnA76/xhM93rWhJGAlGl3X00I+DS+Ns1J4F3UpXYOcSijtsYVAhD2AvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378013; c=relaxed/simple;
	bh=MnojP16IxpHjSnfoX+d0TDnCx8JoGYUys4yTOn9wPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msj8mZVNAKem0kdJJbgHb2xEvjgUq2vXft3SHwjmAnw5fRpsYSaCQfPeQsRmENcbUNzL+Se3ywaMQMsAQVa3O2vEfs5vHQIhS2TsL2Bd/HMFDPvKOtCse8C9DA/2yRY6kKKhQm43+Hvq7hzmlHpUczHIl+1ewdurj8m1AH5qeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jeW7xaz/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNzKKuBB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jeW7xaz/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNzKKuBB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBD2D1FE67;
	Thu, 31 Oct 2024 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730378008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOk+0L/qMfcG8d20k9kFjixmwqvkZmMJVp8V/fJ5zzA=;
	b=jeW7xaz/rgZtYit2xGJ++8J9pF7F0wjOPeOy9QuUva0VsVIknDKFMqNIdXtPTixOx1mzA+
	cJUxsXbCUp17DWS1xvVX/Bb0lqxZ/1ZnHev9TlHfVkHCoAosm69dFzbct0DQAAQDmy65j5
	RZ+hOAb1qVNagwxkRmUnrdGwm5Zbgnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730378008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOk+0L/qMfcG8d20k9kFjixmwqvkZmMJVp8V/fJ5zzA=;
	b=jNzKKuBB4GMed8welJa3i2fHd26JCuutIqDCAvaJkDOUbBVWcr7hMKns6Grx1zV/wKB3S7
	wBc0cFGHdevSa5DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="jeW7xaz/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jNzKKuBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730378008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOk+0L/qMfcG8d20k9kFjixmwqvkZmMJVp8V/fJ5zzA=;
	b=jeW7xaz/rgZtYit2xGJ++8J9pF7F0wjOPeOy9QuUva0VsVIknDKFMqNIdXtPTixOx1mzA+
	cJUxsXbCUp17DWS1xvVX/Bb0lqxZ/1ZnHev9TlHfVkHCoAosm69dFzbct0DQAAQDmy65j5
	RZ+hOAb1qVNagwxkRmUnrdGwm5Zbgnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730378008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOk+0L/qMfcG8d20k9kFjixmwqvkZmMJVp8V/fJ5zzA=;
	b=jNzKKuBB4GMed8welJa3i2fHd26JCuutIqDCAvaJkDOUbBVWcr7hMKns6Grx1zV/wKB3S7
	wBc0cFGHdevSa5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD3DB13A53;
	Thu, 31 Oct 2024 12:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gckWMhh5I2eWZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Oct 2024 12:33:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8BAABA086F; Thu, 31 Oct 2024 13:33:13 +0100 (CET)
Date: Thu, 31 Oct 2024 13:33:13 +0100
From: Jan Kara <jack@suse.cz>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241031123313.dfcuttwzzs5f5i7a@quack3>
References: <ZxvyavDjXDaV9cNg@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxvyavDjXDaV9cNg@kspp>
X-Rspamd-Queue-Id: DBD2D1FE67
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 25-10-24 13:32:58, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we
> are getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure (`struct shash_desc`) where the size of the
> flexible-array member (`__ctx`) is known at compile-time, and
> refactor the rest of the code, accordingly.
> 
> So, with this, fix 77 of the following warnings:
> 
> include/linux/jbd2.h:1800:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/jbd2.h | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 8aef9bb6ad57..ce4560e62d3b 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1796,22 +1796,19 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>  static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
>  			      const void *address, unsigned int length)
>  {
> -	struct {
> -		struct shash_desc shash;
> -		char ctx[JBD_MAX_CHECKSUM_SIZE];
> -	} desc;
> +	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx, 1);

Am I missing some magic here or the 1 above should be
JBD_MAX_CHECKSUM_SIZE?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


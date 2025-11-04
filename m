Return-Path: <linux-ext4+bounces-11442-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A51C30FDB
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F83A9769
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662B2ED866;
	Tue,  4 Nov 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rRdI5IRj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="66XQZ5Tc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rRdI5IRj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="66XQZ5Tc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CF2D23BF
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259536; cv=none; b=S3RrKqciJsQOd0b0hTuirWUVGycJjAuv6XFMJYtKdBazYiJzyghEFy2fVl9hDbUWGlIzQHBSJ0cMp/dRWhgwRXFJgrEj+JNBehh5gs+Up/I0o+gcJOnVMboi5k0HBeolHtKKfaPOiT+4EGnH5fSseCghTuUJ7kdXsZ6yBzKn1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259536; c=relaxed/simple;
	bh=EZeiVFXzmAhIysd18CbRemQB8422+KtXrOFCPz47XMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1iBUPUXuo+cztqFV3XIJR8xw+KG2GEIq478dpypHXbcpAZCv8bzyacymbRgHo7VvcTpSrFE/PHMKksY6IYokCmo2PFgZrD+veYDHFi5uFK0IyEtDCKUZ62VQWNCOAkvnHJy3oIYPcsLa99Nk+xEPRgCCyX6ZjDbs6xUq+zInP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rRdI5IRj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=66XQZ5Tc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rRdI5IRj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=66XQZ5Tc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6D26211B4;
	Tue,  4 Nov 2025 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762259532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+52gTWbdmp2XM+RqnoXSUnrTxdwr/nOOMnANuv+oaTI=;
	b=rRdI5IRjQcfF1DnqcKwq0BN7gDAfwdNngIA58CZ8tPSArT5iRDgaqhMIr1KD4qgnuFLpA/
	EkSZ07vSqXzInnK4yNG77fQEF1Tsx/jiAYwFBSU4EU6lDbOcGE5B2I1mflI7UyCJP0wbik
	g211rmYwa8Fwu7j8+BzDaGzFt8tiuUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762259532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+52gTWbdmp2XM+RqnoXSUnrTxdwr/nOOMnANuv+oaTI=;
	b=66XQZ5TcdjM6pByQsXIKeEzg4N2QreBOlITJt/eDdJjys5+gBJD/fcclCAA65TdodHQt9B
	llo8P66n/wm8kFBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762259532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+52gTWbdmp2XM+RqnoXSUnrTxdwr/nOOMnANuv+oaTI=;
	b=rRdI5IRjQcfF1DnqcKwq0BN7gDAfwdNngIA58CZ8tPSArT5iRDgaqhMIr1KD4qgnuFLpA/
	EkSZ07vSqXzInnK4yNG77fQEF1Tsx/jiAYwFBSU4EU6lDbOcGE5B2I1mflI7UyCJP0wbik
	g211rmYwa8Fwu7j8+BzDaGzFt8tiuUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762259532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+52gTWbdmp2XM+RqnoXSUnrTxdwr/nOOMnANuv+oaTI=;
	b=66XQZ5TcdjM6pByQsXIKeEzg4N2QreBOlITJt/eDdJjys5+gBJD/fcclCAA65TdodHQt9B
	llo8P66n/wm8kFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB8EB136D1;
	Tue,  4 Nov 2025 12:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N5zELUzyCWnUVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 12:32:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65751A28E6; Tue,  4 Nov 2025 13:32:12 +0100 (CET)
Date: Tue, 4 Nov 2025 13:32:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/8] fs: add super_write_guard
Message-ID: <wybltui5ewo25wrvw4j53pk5bnepdnkjmgp5232tjvmnrmvcab@cklxztcoqtfa>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-1-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-1-5108ac78a171@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 04-11-25 13:12:30, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yeah, I think this can be a win. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..9d403c00fbf3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2052,6 +2052,11 @@ static inline void sb_start_write(struct super_block *sb)
>  	__sb_start_write(sb, SB_FREEZE_WRITE);
>  }
>  
> +DEFINE_GUARD(super_write,
> +	     struct super_block *,
> +	     sb_start_write(_T),
> +	     sb_end_write(_T))
> +
>  static inline bool sb_start_write_trylock(struct super_block *sb)
>  {
>  	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


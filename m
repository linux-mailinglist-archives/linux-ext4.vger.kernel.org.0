Return-Path: <linux-ext4+bounces-3370-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E2939D6B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 11:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFBC1C212F7
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036014BFB4;
	Tue, 23 Jul 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qKrd29Id";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rIYQLz1F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qKrd29Id";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rIYQLz1F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E3208B6;
	Tue, 23 Jul 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726525; cv=none; b=L2eL6LiPcjibIVChIBt902tnqKV8/atU/dATMa+yCrkxJdr7YWNji1OG3KW0NA9G9mr29ONPKBJYLGRI80RjlsNrRb91d1yModI4iMHsPrTmxWQ69ClcDCNn8w7vuEHqPTmEbqb0m/HJ2VVjoZGX1a2MUJbBZLzCa20ZaqRwdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726525; c=relaxed/simple;
	bh=DEmamzG20cTeuQWM1KjnzQtCkudnGYamD96iRxyUuWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMYQ0Uhf9rytpk/uQ9qDfRYmq9nRDl+AynX/IU0U3O4NhT/yKDZnwske7jw4BfaEHWprfSDV9bWOEBAjhDl5Z+Mwa87gLpXfZMuFDPR+OqA7PNJ0J/ACcm3mfNVK3+g5lb4WnuufFmCPI8t+8pIWVR487m+zhphzkZlXb1W6uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qKrd29Id; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rIYQLz1F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qKrd29Id; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rIYQLz1F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88382218EC;
	Tue, 23 Jul 2024 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721726521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7AV0LYF3bz/EKMkYK4kYRuRBuSTAZsD68Mdlb9Reys=;
	b=qKrd29Id6DSo0K/pphd1NEBQCyL+tILZRTrUv0Ih7j/WQTquGXnx9aRZub0FYBTYu4hnjA
	HUaFWbKdgE32Qn/61E8NBh4Y0+ATgtRmNVNO3o27zRZb3hqaZOSQ3rsDuqHwfxhTkCJpoN
	DTfI6NBat03QVfQgToM3dJqAN33jylw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721726521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7AV0LYF3bz/EKMkYK4kYRuRBuSTAZsD68Mdlb9Reys=;
	b=rIYQLz1F/1GebmxIQDyCski7VlrfzibvJBMGit/9Y+JCrtnCKyqZhn9k7Sezvs+3kg5Qf3
	akhnUa9eIN+ex3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721726521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7AV0LYF3bz/EKMkYK4kYRuRBuSTAZsD68Mdlb9Reys=;
	b=qKrd29Id6DSo0K/pphd1NEBQCyL+tILZRTrUv0Ih7j/WQTquGXnx9aRZub0FYBTYu4hnjA
	HUaFWbKdgE32Qn/61E8NBh4Y0+ATgtRmNVNO3o27zRZb3hqaZOSQ3rsDuqHwfxhTkCJpoN
	DTfI6NBat03QVfQgToM3dJqAN33jylw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721726521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7AV0LYF3bz/EKMkYK4kYRuRBuSTAZsD68Mdlb9Reys=;
	b=rIYQLz1F/1GebmxIQDyCski7VlrfzibvJBMGit/9Y+JCrtnCKyqZhn9k7Sezvs+3kg5Qf3
	akhnUa9eIN+ex3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D6701393E;
	Tue, 23 Jul 2024 09:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UE+YHjl2n2ateAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jul 2024 09:22:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2BC85A08BD; Tue, 23 Jul 2024 11:22:01 +0200 (CEST)
Date: Tue, 23 Jul 2024 11:22:01 +0200
From: Jan Kara <jack@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: fix kernel-doc for j_transaction_overhead_buffers
Message-ID: <20240723092201.cr6kxdjrdvmlbfga@quack3>
References: <20240723051647.3053491-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723051647.3053491-1-rdunlap@infradead.org>
X-Spam-Score: -0.60
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,infradead.org:email]
X-Spam-Level: 

On Mon 22-07-24 22:16:47, Randy Dunlap wrote:
> Use the correct struct member name in the kernel-doc notation
> to prevent a kernel-doc build warning.
> 
> include/linux/jbd2.h:1303: warning: Function parameter or struct member 'j_transaction_overhead_buffers' not described in 'journal_s'
> include/linux/jbd2.h:1303: warning: Excess struct member 'j_transaction_overhead' description in 'journal_s'
> 
> Fixes: e3a00a23781c ("jbd2: precompute number of transaction descriptor blocks")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20240710182252.4c281445@canb.auug.org.au/
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Yeah, thanks and sorry for breaking the doc here. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Cc: Jan Kara <jack@suse.cz>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: linux-ext4@vger.kernel.org
> 
>  include/linux/jbd2.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/include/linux/jbd2.h b/include/linux/jbd2.h
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1086,7 +1086,7 @@ struct journal_s
>  	int			j_revoke_records_per_block;
>  
>  	/**
> -	 * @j_transaction_overhead:
> +	 * @j_transaction_overhead_buffers:
>  	 *
>  	 * Number of blocks each transaction needs for its own bookkeeping
>  	 */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-ext4+bounces-2775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B298FC69F
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 10:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78AE285B97
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9B1946C1;
	Wed,  5 Jun 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2GQrqcb3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAhIBfIH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Anz0bD87";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bvwICSPj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733271946AA;
	Wed,  5 Jun 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576549; cv=none; b=At7u+pivsQLj4QLesgcpB57+7852IZ2h9B3LvN7d+XD5BXpszLRfN3gNhwvdcBiWvKxuydv8z1zFtVQvyU5Kj+C/pnv4yNsM7PTz9gyQ/aVmNPr+lg+Z7nVh+R6Bru9qWDO4n6xMPyXpkd1zmeocEkcbqj+vmDhmoxHE4ZvhjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576549; c=relaxed/simple;
	bh=kYH2yJi/HdTLkne42i/lQgVn2DMQeUge9VKw06RK4Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9EfKwAQ745TNbZSXV+n8wNlIacollamytNnKKBzeKRjND3ndt1ZYIXB0cHOfKeKSoiptOmGaozzhk+S//QjgqMxDvm3iHVAJ4iU9M/t9pZmjkrmeU/GLrIPFtGwW2Tc7kobibX0BDAsWtjq6YI6oByWEgJF1gF4PA4kjDjGBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2GQrqcb3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAhIBfIH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Anz0bD87; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bvwICSPj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66072216E7;
	Wed,  5 Jun 2024 08:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717576540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1FdvGcK/hiBia9Wy/QJQW13yM7Cwjgy8SdWOUF2qUU=;
	b=2GQrqcb30fRAdH5pYPABN0yKafVhE9cs89GmLAhFAg9tJNmH0CtLmNMzsBG1o6DdDysxH9
	skodYHy9Q6n363udOk1V0/K16ncZsRI3t8lJfKFyW0qVMSOn2SEhBK2bpgJu5xBSUK/urE
	WkwJFzKWlBIKQ0DyQOYyI8EVyZrm4U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717576540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1FdvGcK/hiBia9Wy/QJQW13yM7Cwjgy8SdWOUF2qUU=;
	b=uAhIBfIHJOsBk2zAAZ1Vw+TZ9StWf6jFiIJgHf+4RVk6SK3ZJzJWikthS5IRa2bWZcDiQD
	WUt61Fi9Q0hmpiCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717576538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1FdvGcK/hiBia9Wy/QJQW13yM7Cwjgy8SdWOUF2qUU=;
	b=Anz0bD87U6W0gxGzMgRyUNLlcBPgwQxN/Y+bFFinJsZmqaao7iYBJYYHSzOVfRje8R6vHc
	Qo0goBSPcdSFZJ1y6xSjhLuNXF1bluJhUEHcW+Y0EvoICqF7YQtj+35briTGwIooPtjyIU
	s1r2VSnxpjEdtxOhDTEa2to92RwAS+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717576538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1FdvGcK/hiBia9Wy/QJQW13yM7Cwjgy8SdWOUF2qUU=;
	b=bvwICSPjcWaM4oxJH38m+qMCAgh0RMIAjA/BJe0d/tG6dSwCAyU/eeyZC+K7+E+mPcWqAy
	dgPUnwOU18ftM2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55FDC13AA1;
	Wed,  5 Jun 2024 08:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yhn4FFojYGZQOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 08:35:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0286BA088A; Wed,  5 Jun 2024 10:35:33 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:35:33 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] jbd2: add missing MODULE_DESCRIPTION()
Message-ID: <20240605083533.qr3gmecrtdotxxxv@quack3>
References: <20240526-md-fs-jbd2-v1-1-7bba6665327d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526-md-fs-jbd2-v1-1-7bba6665327d@quicinc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sun 26-05-24 11:53:49, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/jbd2/jbd2.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks added to my tree.

								Honza

> ---
>  fs/jbd2/journal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 03c4b9214f56..0d2825c131cc 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -3181,6 +3181,7 @@ static void __exit journal_exit(void)
>  	jbd2_journal_destroy_caches();
>  }
>  
> +MODULE_DESCRIPTION("Generic filesystem journal-writing module");
>  MODULE_LICENSE("GPL");
>  module_init(journal_init);
>  module_exit(journal_exit);
> 
> ---
> base-commit: 416ff45264d50a983c3c0b99f0da6ee59f9acd68
> change-id: 20240526-md-fs-jbd2-bd0acb6527b8
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


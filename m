Return-Path: <linux-ext4+bounces-6181-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D96A17EA2
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D0D1883F7B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF71F0E36;
	Tue, 21 Jan 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6qaM/eA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZzfSLr7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6qaM/eA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZzfSLr7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E02E406;
	Tue, 21 Jan 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465235; cv=none; b=QbbzTcWUr+nLlm8UM8Lmlxj54bWacXUWMgN5bEG5P/9JqodRHXcSsf37+zGrFrJ4WgMrJIKZNi9sy1NlEzRTpJSSOHyda1GXRoOvGizcnvF2AledeSEW6FO2QDNLo66kbwiFX8cih3WS/Qb4QYR7JxU1okADm2kUESYLT93jSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465235; c=relaxed/simple;
	bh=cvmQqAIXTsncIHPYILSyKHE5oEO6AnftFa6Kp9IqeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvTA9bAk1kPOhzXCL9lmZOtwzYZw4W2Puk8574lcJTvcw2XOwmgWHhEKVDj1Tz/zMwwCUS9z1U8Nt2iyJh5BmczzI+7JFBRGmskSBSf1dQGRyUcafh0WjXb5uva60pLwuZeElQ+Fv2L1p8Z+jGlM0TX2SFsg+ANuCJoWQdFJZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6qaM/eA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZzfSLr7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6qaM/eA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZzfSLr7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F21B211D6;
	Tue, 21 Jan 2025 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0JbRW5zev1jRxXqXzkmFeKnwGT+2dh8k/lAVI0WqIE=;
	b=o6qaM/eAesQhP5ze7sTLpaloX2dTEB0p9Dlj91ZQpgOJ/2kio0RV2nfSPRfL7RCTJvjULh
	P1qzJcgWQm/lFHOOigavTe/asAKdKzH9W9qMmuSJIpK2L/H7oHJ2NOoG6EPqW4P9Vvtmf3
	gzoqOevXjhKcur5NRHlOr5EQbZYzBhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0JbRW5zev1jRxXqXzkmFeKnwGT+2dh8k/lAVI0WqIE=;
	b=2ZzfSLr71ecoN3C+c8CYf1Iraa0Ri/zO4e56X+ZUGvluphUVFgWmTe1bjLS3KqyrPymB3q
	wW4FvJC+HXeTa7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0JbRW5zev1jRxXqXzkmFeKnwGT+2dh8k/lAVI0WqIE=;
	b=o6qaM/eAesQhP5ze7sTLpaloX2dTEB0p9Dlj91ZQpgOJ/2kio0RV2nfSPRfL7RCTJvjULh
	P1qzJcgWQm/lFHOOigavTe/asAKdKzH9W9qMmuSJIpK2L/H7oHJ2NOoG6EPqW4P9Vvtmf3
	gzoqOevXjhKcur5NRHlOr5EQbZYzBhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0JbRW5zev1jRxXqXzkmFeKnwGT+2dh8k/lAVI0WqIE=;
	b=2ZzfSLr71ecoN3C+c8CYf1Iraa0Ri/zO4e56X+ZUGvluphUVFgWmTe1bjLS3KqyrPymB3q
	wW4FvJC+HXeTa7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 725101387C;
	Tue, 21 Jan 2025 13:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UiznG4+dj2cNNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 13:13:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23089A0889; Tue, 21 Jan 2025 14:13:51 +0100 (CET)
Date: Tue, 21 Jan 2025 14:13:51 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 7/7] ext4: show 'shutdown' hint when ext4 is forced to
 shutdown
Message-ID: <sishjtws6welda7u5zwd7ca5wbfmde4rexz3f6gfevw7trjnlu@yqfwu7ibteyf>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-8-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117082315.2869996-8-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 17-01-25 16:23:15, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Now, if dmesg is cleared, we have no way of knowing if the file system has
> been shutdown. Moreover, ext4 allows directory reads even after the file
> system has been shutdown, so when reading a file returns -EIO, we cannot
> determine whether this is a hardware issue or if the file system has been
> shutdown.
> 
> Therefore, when ext4 file system is shutdown, we're adding a 'shutdown'
> hint to commands like mount so users can easily check the file system's
> status.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2377ebf0aff1..b15c36df934c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3032,6 +3032,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	if (ext4_emergency_ro(sb))
>  		SEQ_OPTS_PUTS("emergency_ro");
>  
> +	if (ext4_forced_shutdown(sb))
> +		SEQ_OPTS_PUTS("shutdown");
> +
>  	ext4_show_quota_options(seq, sb);
>  	return 0;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


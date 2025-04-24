Return-Path: <linux-ext4+bounces-7451-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A4FA9AC37
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 13:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE485466FC3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB502253B0;
	Thu, 24 Apr 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="25wm+t35";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mhXLE/qc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="25wm+t35";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mhXLE/qc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740E222595
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494780; cv=none; b=LIKkfHUocSavMQMx1Q93JVsL6fTuJRUUwV4Jr5c8AimhIGlhmi/KblaC1okkbXmImA+f1N1wm7UY5tfQIck7cleYsAm8PC+fvsy/EdpCbjgyuu2zCkBViKZT4/FoDTDyxvGTEAmizKl9w6g5pnBdQ7LDHVm6RXS6YV+CvbHhD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494780; c=relaxed/simple;
	bh=p/iA1aOs81ozYfLqBjwCGoqgA0/reQeD9IhdoGQZhR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuiOdbtN1AUIidBAXEs1dydpdbBVBFhp5g7RwDgl83G268LOw3ijdFOmFdKdO7Z137KFDuYMHWU068P8nQwEU9QnLY5SD3uNZqw5Bi+KAaqoRsix7o+He+KJMoVkOLuovgBFtU4ucvztNWP+de1zwxBbxQz6jBzqmDFqhyUAeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=25wm+t35; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mhXLE/qc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=25wm+t35; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mhXLE/qc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC80D1F445;
	Thu, 24 Apr 2025 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745494776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow+0LWKmJJfC77IxmPqmE/uvBg7B41voNt86HZPe9Es=;
	b=25wm+t35ZGS/JyEAQ8iux3WSjW/d1l2FSxvhW4ZlLlcHOWaK+kws5qFrnxceBBMoGkuiju
	dug4Fm2ykABpNSI4G70eRc8NW3FIGCEi4YH5PyfTl3CXjqS0qwy8WKdkslYTkoMYXTrC3R
	ZkZVtqktDy/J0PHG0UGcXtpfYRm+px8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745494776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow+0LWKmJJfC77IxmPqmE/uvBg7B41voNt86HZPe9Es=;
	b=mhXLE/qc12dNhUMUOZMTxtufc1m3XupHYyBnG06NFnacTLCM5QrfDxbP3XzNSFVexLYkPw
	6dYmZE2PU6pU7dDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745494776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow+0LWKmJJfC77IxmPqmE/uvBg7B41voNt86HZPe9Es=;
	b=25wm+t35ZGS/JyEAQ8iux3WSjW/d1l2FSxvhW4ZlLlcHOWaK+kws5qFrnxceBBMoGkuiju
	dug4Fm2ykABpNSI4G70eRc8NW3FIGCEi4YH5PyfTl3CXjqS0qwy8WKdkslYTkoMYXTrC3R
	ZkZVtqktDy/J0PHG0UGcXtpfYRm+px8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745494776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow+0LWKmJJfC77IxmPqmE/uvBg7B41voNt86HZPe9Es=;
	b=mhXLE/qc12dNhUMUOZMTxtufc1m3XupHYyBnG06NFnacTLCM5QrfDxbP3XzNSFVexLYkPw
	6dYmZE2PU6pU7dDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B70311393C;
	Thu, 24 Apr 2025 11:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yfapLPgiCmiHPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Apr 2025 11:39:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56066A0921; Thu, 24 Apr 2025 13:39:36 +0200 (CEST)
Date: Thu, 24 Apr 2025 13:39:36 +0200
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, 
	Zhang Yi <yi.zhang@huawei.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shida Zhang <zhangshida@kylinos.cn>, 
	Baokun Li <libaokun1@huawei.com>, Jann Horn <jannh@google.com>, Brian Foster <bfoster@redhat.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: avoid -Wformat-security warning
Message-ID: <6vjo6wo5c5tadvhnrvo2affcqu2cf6ecrx4ol5jxl6mvz7vu3z@6wgvyptlpq4p>
References: <20250423164354.2780635-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164354.2780635-1-arnd@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,arndb.de,suse.cz,huawei.com,linux.ibm.com,kernel.org,infradead.org,gmail.com,kylinos.cn,google.com,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 23-04-25 18:43:49, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> check_igot_inode() prints a variable string, which causes a harmless
> warning with 'make W=1':
> 
> fs/ext4/inode.c:4763:45: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  4763 |         ext4_error_inode(inode, function, line, 0, err_str);
> 
> Use a trivial "%s" format string instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Frankly I don't care much either way but if my memory serves me well year
or two ago someone was going through the kernel and was replacing pointless
("%s", str) cases with printing the string directly. So we should make up
our minds how we want this... In my opinion this is one of the warnings
which may be useful but have false positives too often (like here where
err_str is just a selection from several string literals) so I'm not sure
it's worth the effort to try to silence it.

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..3cfb1b670ea4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4760,7 +4760,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return 0;
>  
>  error:
> -	ext4_error_inode(inode, function, line, 0, err_str);
> +	ext4_error_inode(inode, function, line, 0, "%s", err_str);
>  	return -EFSCORRUPTED;
>  }
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


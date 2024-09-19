Return-Path: <linux-ext4+bounces-4231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FBF97CED5
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 23:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593D61C216FF
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723F143894;
	Thu, 19 Sep 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K1MnR2pG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RgtQI6zp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bJV2z48B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qq4S8d0J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70071CAA6;
	Thu, 19 Sep 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782455; cv=none; b=lujCpX3ZTUKmWDEOZjHPluB2Gfo9mQ7kMY59p/nKONnkeJFk+A92gnRKA9jvOkHwphNwpZSp4KvykIC40zICn5IjHD+BU6ucpUUckG0vGoIT9lYOHqZGn64hsmyGaeLAEf8JYyj5PuefIFzLdDrvKsdrByWrFEqgtoaWvidSNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782455; c=relaxed/simple;
	bh=OMbl4BXGmQyO9OIbhoNttq83hZs2fa6Xevvb9yJ9F5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIq2IJjDOttKCZZ4en6fwIuodpqMcwXPs/+QBe+3lqKnKmKmkXiu7e25UqPuzd9eTJC2c3cPMVJ3AoX3t4uBa71X3Suqa6XJy2dblmrmzOEHRT6ijyhYswwM69kFQTCeBEVl8xgU7O+iRytIq/+vYQqo9j94c37u8scmRoge4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K1MnR2pG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RgtQI6zp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bJV2z48B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qq4S8d0J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D135720A42;
	Thu, 19 Sep 2024 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726782451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZCCU/gPfDXlHYe9op4I7AhE0PHClzJ8vhPX7WGahQs=;
	b=K1MnR2pGw5YQBQzgvNhtrbKh7XJwdEYGUyxWIR6d0zSHOUIr3aChioy1mFzjkh+JSLhHKU
	aym98kcq4PIeckKa8VkayOCg6PzMhiWy7HCkmGWpyvxUJ+IxsXOY24vWmbWIzVQ+1CRXJu
	LcEWwiN1c5GJk8dOd6JIK4EdjGsYSFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726782451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZCCU/gPfDXlHYe9op4I7AhE0PHClzJ8vhPX7WGahQs=;
	b=RgtQI6zp/p0hdTno0Hi256HfHOcBqp4EJXX2yhyuxIWn7mz/GZrdSfGjFktMBiolo5H8nO
	i1yGBKW8b8AKXbBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726782450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZCCU/gPfDXlHYe9op4I7AhE0PHClzJ8vhPX7WGahQs=;
	b=bJV2z48Bgf/Xe49pXLfgio0rFWjBi5XAy3jd28dyu+9y4V5tl8i8UQ8fxdZM+6Q8++xGKW
	dyAM7a4/RxR7InbT1mmcusZUxXbtMVODJH6FKC9rDGC1fHOtvAVT0rfIYnvGzo4RmpJtxd
	MyK9EM0M+awY0VYSM12kZHNMQjr1Id4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726782450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZCCU/gPfDXlHYe9op4I7AhE0PHClzJ8vhPX7WGahQs=;
	b=qq4S8d0J1tDEEU9ydG5K2NlBP89AMgX0PJdxawzEUK6LVe2gG1UkEWVctedV3t/RdvOv05
	Mc273Sp+uxuRTXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C814413A1E;
	Thu, 19 Sep 2024 21:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2YbUMPKb7GbYQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Sep 2024 21:47:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7323DA08BD; Thu, 19 Sep 2024 23:47:30 +0200 (CEST)
Date: Thu, 19 Sep 2024 23:47:30 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: mark fc as ineligible using an handle in
 ext4_xattr_set()
Message-ID: <20240919214730.gza4j3gkrn34tcyn@quack3>
References: <20240919093848.2330-1-luis.henriques@linux.dev>
 <20240919093848.2330-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919093848.2330-3-luis.henriques@linux.dev>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 19-09-24 10:38:48, Luis Henriques (SUSE) wrote:
> Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may result
> in a fast-commit being done before the filesystem is effectively marked as
> ineligible.  This patch reduces the risk of this happening in function
> ext4_xattr_set() by using an handle if one is available.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

One comment below:

> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..dbe4d11cd332 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2554,11 +2554,15 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
>  	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
>  	if (IS_ERR(handle)) {
>  		error = PTR_ERR(handle);
> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
> +					NULL);

So when starting a transaction fails:

a) We have a big problem, the journal is aborted so marking fs ineligible
is moot.

b) We don't set anything and bail with error to userspace so again marking
fs as ineligible is pointless.

So there's no need to do anything in this case.

								Honza

>  	} else {
>  		int error2;
>  
>  		error = ext4_xattr_set_handle(handle, inode, name_index, name,
>  					      value, value_len, flags);
> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
> +					handle);
>  		error2 = ext4_journal_stop(handle);
>  		if (error == -ENOSPC &&
>  		    ext4_should_retry_alloc(sb, &retries))
> @@ -2566,7 +2570,6 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
>  		if (error == 0)
>  			error = error2;
>  	}
> -	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
>  
>  	return error;
>  }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


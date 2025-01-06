Return-Path: <linux-ext4+bounces-5903-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F70DA02AA0
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928C81650D5
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1C159565;
	Mon,  6 Jan 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oropRjYO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6gKOUorq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ug5h397S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DKYVhjBf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15906166F1B;
	Mon,  6 Jan 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177719; cv=none; b=ZooXHuMbKrBoZVjkd0WQffWhnRNMT5kEmOZFs8RgC16/++gh4VTePeFJUMAzO21ICNpBbUgVoYD7/isbJVYOJ5k/+Gc/3Io19A9Y8+uoMqIvNMI+fzbdAZFzBoQJCeACQHDPR+rNG0+F7sL/n24JqIlvVEy6SLu/WHMhxl+sO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177719; c=relaxed/simple;
	bh=Vh/enkoQyhpNaFWnui1hcm77OxIrQOUCKHCly3ypf0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln+GG110HixYsG/6AaQon4iMM9qsRxJk+nwf84hWznaYwSQpVxr0hk8ZhJGCJsDTQcI2OWl4A6LixNDUU05uhF4mJJ8huPXzAYgrBgksCSI3Beh2OspMnnqAqqZWBtEF41A3UuOU+I3xM/BscitI5CbiQeVQH+tzfDtHsxgnHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oropRjYO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6gKOUorq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ug5h397S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DKYVhjBf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6DF51F449;
	Mon,  6 Jan 2025 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmmAAfWWaKImy1UFT6JxXt5+D/C8pjD9A2Xs73j/9H8=;
	b=oropRjYOhOnn4T0VFKfb4+dAIAS2iLa/R0m663WkE+h28BM8R6wDXohcFLUlzp4xy+eXCw
	P7I/LaqEIPeK8eRZULwhaVcjU9JrxRiklr6qOFSMhzuRbhJgv4tlphrE9HFKgWcClwhTE9
	zzCccgJn1KeX2YTYXQycJnY5/4dZV0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmmAAfWWaKImy1UFT6JxXt5+D/C8pjD9A2Xs73j/9H8=;
	b=6gKOUorqfoIxKe4X1BRwHb+4DLlK9G6kr8AiU5w0mb8lRan1D552GZotPUv3fvidfN9rZv
	mqcyoI4LdfEbnQDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ug5h397S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DKYVhjBf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmmAAfWWaKImy1UFT6JxXt5+D/C8pjD9A2Xs73j/9H8=;
	b=ug5h397Scb8ubt177uy/BE0q9uD22PKt6sCNIJGffwO8pF7TMYbcO8Ljq9bwwwc1ZkmS4g
	8I8fLLZMURm4mO6VTQNtBRKT9sjkj+SzHMiEclfl9vONW636biZEuIU8VqchI3kDz8iaDw
	VTtTd29b10WtskxoYLUsO+LfwWhsRMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmmAAfWWaKImy1UFT6JxXt5+D/C8pjD9A2Xs73j/9H8=;
	b=DKYVhjBf+xLbr5V3JvGQ14p7FjBt1mJyHrQ9CNQ0jVg70dM6LAOvDtzM8wdM7yIYKGQjGr
	gRfJhQyEbgCV+HAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6CD7139AB;
	Mon,  6 Jan 2025 15:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KQcVMDP4e2e9SwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:35:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75212A089C; Mon,  6 Jan 2025 16:35:15 +0100 (CET)
Date: Mon, 6 Jan 2025 16:35:15 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 4/7] ext4: Introduce a new helper function
 ext4_generic_write_inline_data()
Message-ID: <b7nmpjvncdcywd6d3xxoobo3nvoj53gpm5jrjjummuega55qsf@lso74twq6fyz>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-5-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-5-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: D6DF51F449
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 20-12-24 23:16:22, Julian Sun wrote:
> A new function, ext4_generic_write_inline_data(), is introduced
> to provide a generic implementation of the common logic found in
> ext4_da_write_inline_data_begin() and ext4_try_to_write_inline_data().
> 
> This function will be utilized in the subsequent two patches.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good, just one style nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

...
> +	*foliop = folio;
> +	up_read(&EXT4_I(inode)->xattr_sem);
> +	brelse(iloc.bh);
> +	return 1;

Here I'd suggest empty line for better readability.

> +out_release_folio:
> +	up_read(&EXT4_I(inode)->xattr_sem);
> +	folio_unlock(folio);
> +	folio_put(folio);
> +out_stop_journal:
> +	ext4_journal_stop(handle);
> +out_release_bh:
> +	brelse(iloc.bh);
> +	return ret;
> +}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


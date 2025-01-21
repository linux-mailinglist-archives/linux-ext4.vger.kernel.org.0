Return-Path: <linux-ext4+bounces-6166-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48CAA17CB8
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6399163CD5
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DF1F12F3;
	Tue, 21 Jan 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSlFwH1j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJk2TlCw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DpYP8Kkr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7jJifmFK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595F1B4137;
	Tue, 21 Jan 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457999; cv=none; b=BlO6GcR+VvwmDgFAaOSDyzDMKxdKX8wPEWZfpflcZ43g2VdKLkH/q56HuMtB0l/DVOqvqwo11IqcwzJj2wddhbwLaOVXi2K323QuEKsyBM+KO8RJLPBu3D/KvpEe6dADziItf0kAgGsd/84Ke5vC4Bv0QZren/j1BaKglGJCYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457999; c=relaxed/simple;
	bh=oZxlZUQFQh5qmdcsXE+hlqSyAbXozEgk2x6GdQYVsWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKBgLOfE+KT6qJDCh4Sub9YIz2st25CBH5IRDlQpXbbHEg5vlI8EK58efQQwCNbsETQqAzaJUjCjGt1ZI5o4hjEWtxBOQbwkoYfOTOm+sf2P1ALEM6VqpOHw4pSgqw4mGqUeytfTrxOMHB5DGACgTO5fEK6iDxdHdAoMnF0vfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSlFwH1j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJk2TlCw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DpYP8Kkr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7jJifmFK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C1822116D;
	Tue, 21 Jan 2025 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737457994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/aC8w+qzteWdLPubUwLrw6xEflxUqX99pAxHG7jtto=;
	b=HSlFwH1jsILBRy7mUSRuVZ4/E/S6g8FvF73r6GXFJDUjkDTzEiY4ZGSizk39PgvFR+qM/r
	IxzTWW+OzFBwsFDVVlImvssY/cIGq3k7sDxwhfgkNmdPLwPrv/fty0a/IvsA2MIyUgxMS0
	S2aO+Qqme6v7CRSMr5PeBYwyKYdLbKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737457994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/aC8w+qzteWdLPubUwLrw6xEflxUqX99pAxHG7jtto=;
	b=LJk2TlCwCTFkkvUQuNX2KHBFWrpktf13tcD5TyfoGUeiyqBh1rP3xLLlIhGmsmmSJcGVbb
	Tvgt9lhobrqPIgAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DpYP8Kkr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7jJifmFK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737457993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/aC8w+qzteWdLPubUwLrw6xEflxUqX99pAxHG7jtto=;
	b=DpYP8KkrvGBef8cMmjds2tStHJd7PAllJ6px7DpHXes2TeAp1Spazydw5+D+khCGvBsaBo
	joXyaALWFGaPjKhZYS0FQgr4oPV2LLOhXUGgepIJNhpqlF2bWTZEQZTxHiZHp2UBDt+yBn
	/U32OxrPChOe36+319Be1rtEAL3kM14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737457993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/aC8w+qzteWdLPubUwLrw6xEflxUqX99pAxHG7jtto=;
	b=7jJifmFKM6q2vSulrAOdPtU8RYCRS7Ja+D1pLJ0Ft+oY7uXFNDkvye0Reg5g4UALYc27Fu
	rjZdqc6c30YYQ7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 016431387C;
	Tue, 21 Jan 2025 11:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H61OAEmBj2dJUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 11:13:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9755A0889; Tue, 21 Jan 2025 12:13:12 +0100 (CET)
Date: Tue, 21 Jan 2025 12:13:12 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 5/8] ext4: abort journal on data writeback failure if
 in data_err=abort mode
Message-ID: <cuanusobp4oiptmmyruiimehe25zizbgdxgx5a7oudvo6repox@drpwkdfp7hpw>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121071050.3991249-6-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 0C1822116D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 21-01-25 15:10:47, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The data_err=abort was initially introduced to address users' worries
> about data corruption spreading unnoticed. With direct writes, we can
> rely on return values to confirm successful writes to disk. But with
> buffered writes, a successful return only means the data has been written
> to memory. Users have no way of knowing if the data has actually written
> it to disk unless they use fsync (which impacts performance and can
> sometimes miss errors).
> 
> The current data_err=abort implementation relies on the ordered data list,
> but past changes have inadvertently altered its behavior. For example, if
> an extent is unwritten, we do not add the inode to the ordered data list.
> Therefore, jbd2 will not wait for the data write-back of that inode to
> complete and check for errors in the inode mapping. Moreover, the checks
> performed by jbd2 can also miss errors.
> 
> Now, all buffered writes eventually call ext4_end_bio(), where I/O errors
> are checked. Therefore, we can check for the data_err=abort mode at this
> point and abort the journal in a kworker (due to the interrupt context).
> 
> Therefore, when data_err=abort is enabled, the journal is aborted in
> ext4_end_io_end() when an I/O error is detected in ext4_end_bio() to make
> users who are concerned about the contents of the file happy.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://patch.msgid.link/c7ab26f3-85ad-4b31-b132-0afb0e07bf79@huawei.com
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one naming suggestion below:

> +#define EXT4_IO_END_NEED_COMPLETION (EXT4_IO_END_UNWRITTEN | EXT4_IO_END_FAILED)

I'd call this EXT4_IO_END_DEFER_COMPLETION

> +static bool ext4_io_end_need_completion(ext4_io_end_t *io_end)

And this would then be ext4_io_end_defer_completion().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


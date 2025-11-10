Return-Path: <linux-ext4+bounces-11712-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F1C45B8F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268013B7B55
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E71D25DAEA;
	Mon, 10 Nov 2025 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EctUO5bI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsbE4z7V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EctUO5bI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsbE4z7V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AD10F1
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768120; cv=none; b=e863GKk8fO7rMe0+rU57YVQCfC3w1XjpdVFfOflrORfm0GNo1vRDk9UISBGDgGt4sYviT39yJPxXfE2xahA6fMo/2Xqop1J/RiRYcx7E+kr8O8ELz7PBxV2gJUjs8gk5eCThhyagaLAZtnaBgRxzZ/gDRHWSPtizzDWRwBkRmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768120; c=relaxed/simple;
	bh=DZgbW9BFBWg1TIR5Jl2wOLgWABb4QAUC4Oy4kmBFxQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmDiDY6EoBfuOdXsH2yTDrkAVjKJlrnYrkbWnuYraJSYwDRFeKZO1ZwhjD/vAy/Huo9gp3TszJUwNqsLmmFdfju2M77A6FkZHbV5mBKpOTmaTDpfhmNDbiXFUbm8z9qbVL05W2rkW/8hp4V8e5PiItng5GGHM93tDzDIiwimsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EctUO5bI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsbE4z7V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EctUO5bI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsbE4z7V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73DE31F397;
	Mon, 10 Nov 2025 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WU7G98rrEt7tXe5E2faQc4Poi7KzUxvIQKpI3xwvQy4=;
	b=EctUO5bIAqq0Tpzus55v7D/Q4OyISy7k3m2Y7AcIqN0N7NXFBFohwY1Oz50JbNa3US30WV
	gosCT4C2VVuPlAkZHO6BtKC7WCDWPnLWH4E7W/4HMtn9iKtAlATphCGNb74yUj0Y4elXI5
	HRu7GTZa3oyoaI8EPqBKmks47kuEdao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WU7G98rrEt7tXe5E2faQc4Poi7KzUxvIQKpI3xwvQy4=;
	b=zsbE4z7VqB+E7a+RYrwvPy9Gjl+7k9oqr+lX2PKuoc4zrfbf/C97FRMjmcYolIHSscqWk9
	I0n1OZhE/h4zRWAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WU7G98rrEt7tXe5E2faQc4Poi7KzUxvIQKpI3xwvQy4=;
	b=EctUO5bIAqq0Tpzus55v7D/Q4OyISy7k3m2Y7AcIqN0N7NXFBFohwY1Oz50JbNa3US30WV
	gosCT4C2VVuPlAkZHO6BtKC7WCDWPnLWH4E7W/4HMtn9iKtAlATphCGNb74yUj0Y4elXI5
	HRu7GTZa3oyoaI8EPqBKmks47kuEdao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WU7G98rrEt7tXe5E2faQc4Poi7KzUxvIQKpI3xwvQy4=;
	b=zsbE4z7VqB+E7a+RYrwvPy9Gjl+7k9oqr+lX2PKuoc4zrfbf/C97FRMjmcYolIHSscqWk9
	I0n1OZhE/h4zRWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67FC71431B;
	Mon, 10 Nov 2025 09:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +CRjGfS0EWnTewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:48:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F6B9A28B1; Mon, 10 Nov 2025 10:48:36 +0100 (CET)
Date: Mon, 10 Nov 2025 10:48:36 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 21/24] ext4: make data=journal support large block size
Message-ID: <4xsntqfuxy3xiezmztf26qytijdfi3zwxjjgvkpsmxnumkpsf5@2gr4h36mti3g>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-22-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-22-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,huaweicloud.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Fri 07-11-25 22:42:46, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Currently, ext4_set_inode_mapping_order() does not set max folio order
> for files with the data journalling flag. For files that already have
> large folios enabled, ext4_inode_journal_mode() ignores the data
> journalling flag once max folio order is set.
> 
> This is not because data journalling cannot work with large folios, but
> because credit estimates will go through the roof if there are too many
> blocks per folio.
> 
> Since the real constraint is blocks-per-folio, to support data=journal
> under LBS, we now set max folio order to be equal to min folio order for
> files with the journalling flag. When LBS is disabled, the max folio order
> remains unset as before.
> 
> Additionally, the max_order check in ext4_inode_journal_mode() is removed,
> and mapping order is reset in ext4_change_inode_journal_flag().
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

...

> @@ -6585,6 +6590,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>  		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
>  	}
>  	ext4_set_aops(inode);
> +	ext4_set_inode_mapping_order(inode);
>  
>  	jbd2_journal_unlock_updates(journal);
>  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);

I think more needs to be done here because this way we could leave folios
in the page cache that would be now larger than max order. To simplify the
logic I'd make filemap_write_and_wait() call in
ext4_change_inode_journal_flag() unconditional and add there
truncate_pagecache() call to evict all the page cache before we switch the
inode journalling mode.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


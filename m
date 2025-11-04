Return-Path: <linux-ext4+bounces-11452-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440CC3191A
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F7A18C688E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E832E75E;
	Tue,  4 Nov 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xKq4pj+l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mBzBGGss";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xKq4pj+l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mBzBGGss"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43923EA8D
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266760; cv=none; b=UOvsCoAjt3zswE8pk+mrdbaLswfoAcYkIU0XVqq7mHwZLwdPq7ZtbTax7Tn1V9lV7jfT4Lf842AKPaXtdfMkCA+/sFIZa6tiOvbXuRAe2HHgSmuoLzBRFYlrEbl4QPEXBXsve/ogt4Ckp1ngI24Lt/HJ/yy32oDMUwZ6hHy4iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266760; c=relaxed/simple;
	bh=5WAqAT0o3uii4xacT5JqsKiwhBeLNjAL17sxzVmbRmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR858nbS5opFO9LwnR9gDaiP9yUiCUQEVEWEJ3anahJDyU0ZLPk39P1AciYFf8tC43K1FIdfgSCh+q+GJWjOkkv+kyV6xrOB2r1rNZ0Cb0zKq5+NM9ggPQH9OxL236InDXiWnPfQwNbP8cJaqezBE5RNFBH7TO98oubO+U7GaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xKq4pj+l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mBzBGGss; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xKq4pj+l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mBzBGGss; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F7051F385;
	Tue,  4 Nov 2025 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762266756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVfplHnJy8xtT7eQidlgiq5XvEy7wuOCrbpIc5D+WEU=;
	b=xKq4pj+lae+sRDymI4K2IqWgHrSmEU1kZYzRYrnc3QwHn3CjpoD2ki2tZq/XuSz71j3+SW
	9P7uNy6nKoSASpGh/cnO3V50xAlfk6Zh3znbHPeN/f2JaGc3vcxJXi0qM7qqNAfqt6I5v0
	gjD5P0a9n/f/MkDqjxvJYScK6PsnvLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762266756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVfplHnJy8xtT7eQidlgiq5XvEy7wuOCrbpIc5D+WEU=;
	b=mBzBGGss7xssN8JsDOKSV+b938u5sdQ/ewdsczMNmtFb3C/+4KsUfg64pIstWoHBIe6GKB
	Kgu9Hl0UkNDMzFDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762266756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVfplHnJy8xtT7eQidlgiq5XvEy7wuOCrbpIc5D+WEU=;
	b=xKq4pj+lae+sRDymI4K2IqWgHrSmEU1kZYzRYrnc3QwHn3CjpoD2ki2tZq/XuSz71j3+SW
	9P7uNy6nKoSASpGh/cnO3V50xAlfk6Zh3znbHPeN/f2JaGc3vcxJXi0qM7qqNAfqt6I5v0
	gjD5P0a9n/f/MkDqjxvJYScK6PsnvLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762266756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVfplHnJy8xtT7eQidlgiq5XvEy7wuOCrbpIc5D+WEU=;
	b=mBzBGGss7xssN8JsDOKSV+b938u5sdQ/ewdsczMNmtFb3C/+4KsUfg64pIstWoHBIe6GKB
	Kgu9Hl0UkNDMzFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C1A136D1;
	Tue,  4 Nov 2025 14:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sjvBOoMOCmkpUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 14:32:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CB67A28EA; Tue,  4 Nov 2025 15:32:35 +0100 (CET)
Date: Tue, 4 Nov 2025 15:32:35 +0100
From: Jan Kara <jack@suse.cz>
To: Yang Erkun <yangerkun@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v2 2/4] ext4: rename EXT4_GET_BLOCKS_PRE_IO
Message-ID: <yk27mj4w5t4jpbrkd7a5exkuvzghj3ou2yaa45dninci765xlu@ndftxnnxhtao>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
 <20251104131750.1581541-2-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104131750.1581541-2-yangerkun@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 04-11-25 21:17:48, Yang Erkun wrote:
> This flag has been generalized to split an unwritten extent when we do
> dio or dioread_nolock writeback, or to avoid merge new extents which was
> created by extents split. Update some related comments too.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Just a few spelling corrections. Otherwise I like the patch. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +	/*
> +	 * Caller is from the dio or dioread_nolock buffer writeback,
						    ^^^ buffered IO

> +	 * request to creation of an unwritten extent if not exist or split
			^^ create an unwritten extent if it does not exist

> +	 * the found unwritten extent. Also do not merge the new create
							     ^^^ newly created

> +	 * unwritten extent, io end will convert unwritten to written, and
> +	 * try to merge the written extent.
> +	 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


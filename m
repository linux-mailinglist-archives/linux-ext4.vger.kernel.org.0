Return-Path: <linux-ext4+bounces-5627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F99F109D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25F8280CB6
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B281E105B;
	Fri, 13 Dec 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpdNvYY+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhcsaGxW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1nBX+Lw8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zg16zDzY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED51DF98D
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102927; cv=none; b=pC5ycQfp45nWlvYJgX0LIwpypWpE8c1hJYRyViiCkLsH4mhW2wPboBn5UzXoJeZMAzclHYxTVL8NA5oxE1IBmECnGR7tLgwlZm25RxbpHAvXF1FTSg69/BTV2wyuWEbtenybTGjBXGdxh+ZwQL3RRt9pmFP/W40ODkUCe5ebyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102927; c=relaxed/simple;
	bh=B+7CPsgqN4Hm1zY44Q1ZsKUlZPQuPtdXDGEkUBptvUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrSn3Qeyfcnqww9HWYMekw8gVd6zvroOL97NaeKbhJeefX4ny0ZzDLkwpYNKLsBm+ndcsNknAt/4mzaqIYibCBvUUHeXwo2TPanAM7d3VOpKNqyUPWFz8sqjlO5Q1dhSsoW68YYZKwwEKk/BUXhQZIsAlLRwoEi/rfUnG9a0ADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpdNvYY+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhcsaGxW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1nBX+Lw8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zg16zDzY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E533D1F74C;
	Fri, 13 Dec 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734102924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsq/qNV7dNxKRROVHIBZS26++zIY/Cuf4HX8clJr68M=;
	b=FpdNvYY+8lKAxt7BoYQxLvuNJQft18ZurlWotlkTOjaSVehnfmq26L2K1wJeIYHw4Q3dkb
	J0VZ4KsLTCiC9MBwvmAbflt2/u2ZFKyyuNIAYDP8Vgsrlm7TTbh5ehfIXZ5nJqOHAFzceR
	BaL9SL1JbGsEX16oyT0cVEyE/ISicI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734102924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsq/qNV7dNxKRROVHIBZS26++zIY/Cuf4HX8clJr68M=;
	b=JhcsaGxWtEcY0VriIV/RQ/hbHOwgpfS5TV5T6wZUHfnzkj0nDuxaZ6EjL7/XqHt5raJj4k
	U8WuihZwvQr996BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734102923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsq/qNV7dNxKRROVHIBZS26++zIY/Cuf4HX8clJr68M=;
	b=1nBX+Lw87BiD2Fhiu5PAIGmZB0XjHtP7oqjrof7DZVV0hZiSDR/mcPnbOoQ3wQ9+cY+yJV
	FYJvHs9Bb/ublWr9hosHM+YZbG2Zy5Glwsxx6XeXE2MT97GQOFIY2VFwZ2zpqGbbPnxihu
	M88JkeS33/oFgiSS7D+aWC7OwpZa6cA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734102923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsq/qNV7dNxKRROVHIBZS26++zIY/Cuf4HX8clJr68M=;
	b=Zg16zDzY5Vab+K36XewTatZmCc7Q16h7OA4TkB+0VNasAx40pAdKHX5tbNkKU1/wiD6EUU
	E+83XNiK+2992PCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD8813927;
	Fri, 13 Dec 2024 15:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bfFnNYtPXGcpMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Dec 2024 15:15:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97B6AA0B0E; Fri, 13 Dec 2024 16:15:19 +0100 (CET)
Date: Fri, 13 Dec 2024 16:15:19 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 6/9] ext4: update code documentation
Message-ID: <20241213151519.ieotjpd2w6zw6mpn@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-8-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818040356.241684-8-harshadshirwadkar@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 18-08-24 04:03:53, Harshad Shirwadkar wrote:
> This patch updates code documentation to reflect the commit path changes
> made in this series.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Just noticed one thing:

>   * All the inode updates must call ext4_fc_start_update() before starting an
>   * update. If such an ongoing update is present, fast commit waits for it to

This paragraph is outdated as well. Can you please fix it? Thanks!

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


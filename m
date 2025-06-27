Return-Path: <linux-ext4+bounces-8678-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B4AEBEEC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 20:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02056A3327
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49D2ECD3B;
	Fri, 27 Jun 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVltAp/f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qzeQLHCU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9ittYpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IAFygEbd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5C1E0B91
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048113; cv=none; b=tInKHWoNWIsoksvEs/ztpQxvl6ASbSkPyGZMz4hPbrYRfQsY+4J3qpDewrjabJGJh22yH9QBCACxkLZPgPgS8Xks8LmoseBFZ0o1i5n8DD86Z3PwtaSjA4kUk6N1SdwGsfgvfseVLNs1nu4bwd51Du2ubx2VzAlBJSLcuHq5F9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048113; c=relaxed/simple;
	bh=9igrBSRMP0xAn8jZPX9OXCmARCR83pIiRv9zd9HOPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiNwv2lHM+JG+SYr3bYXyKut9XhZ/ktBuh90qEURLsMqltG9NgVAoUCN4Jyfyz74VGU6ueBZCfNIS2pwzxqwkQRSzqsni9xyxzAR9PBwiPoUUUjR90stoui1QjqcsFjwf6i0q7YhPkBIyrCBri9DwaxdYfb6IeW+0gclVb9dJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVltAp/f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qzeQLHCU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9ittYpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IAFygEbd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9418721179;
	Fri, 27 Jun 2025 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751048107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qq+o72ZtEYLOiGa519bmnD2lsigFsARlXramy6oxyI=;
	b=ZVltAp/fJtaxbKs7ar9XaO1Rx+RXSSnt7LDZt2V5IYBa0RQV6oDGrWlkzu4OcjTAQ6jZNC
	3y13ZCJ3JNdE1AZ+CR5sVn+FQklpXwJMblw2J/f+PI52X5+Zh4RH1PXGuPsQIbrNzk/kUW
	5M16npZGD05I+WAlzj4J9T+DfdlVYt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751048107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qq+o72ZtEYLOiGa519bmnD2lsigFsARlXramy6oxyI=;
	b=qzeQLHCURvHtLbc1wXbuo8SnnBHz+SyFIRPmmIvhlO+5AvUxALxhQeih0t9t9gkgDs45K7
	eQ1lQ5X/2Y3NOGCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s9ittYpH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IAFygEbd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751048106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qq+o72ZtEYLOiGa519bmnD2lsigFsARlXramy6oxyI=;
	b=s9ittYpHepCBe+UEykkLhQQaBGddGdzloouWOufDnFF9YlB3EyYnxdFaocvgjtyX71QgTa
	i1FQZf8cYKBFS+FFHNP1HSRcmjv1hq6AwiAE05mT1OMI61zOO1Ltj970r8UyBvlDf14pYA
	2n6/U8h5SG5PLqd1/9l4tqTJerwIPnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751048106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qq+o72ZtEYLOiGa519bmnD2lsigFsARlXramy6oxyI=;
	b=IAFygEbdz7pUmz0jvU4jzyfvJKQd3AtFkjNiTkX8iA7v7leMfsbtGBnFvVFvdP8+03QSY3
	uBD4E8JQlljFXiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79D9113786;
	Fri, 27 Jun 2025 18:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HYtgHarfXmjPEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 18:15:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F206DA08D2; Fri, 27 Jun 2025 20:15:05 +0200 (CEST)
Date: Fri, 27 Jun 2025 20:15:05 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 02/16] ext4: remove unnecessary s_mb_last_start
Message-ID: <3p5udvc7fgd73kruz563pi4dmc6vjxvszmnegyym2xhuuauw5j@sjudcmk7idht>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-3-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-3-libaokun1@huawei.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9418721179
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 23-06-25 15:32:50, Baokun Li wrote:
> ac->ac_g_ex.fe_start is only used in ext4_mb_find_by_goal(), but STREAM
> ALLOC is activated after ext4_mb_find_by_goal() fails, so there's no need
> to update ac->ac_g_ex.fe_start, remove the unnecessary s_mb_last_start.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I'd just note that ac->ac_g_ex.fe_start is also used in
ext4_mb_collect_stats() so this change may impact the statistics gathered
there. OTOH it is questionable whether we even want to account streaming
allocation as a goal hit... Anyway, I'm fine with this, I'd just mention it
in the changelog.

Also one nit below but feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -2849,7 +2848,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  		/* TBD: may be hot point */
>  		spin_lock(&sbi->s_md_lock);
>  		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;

Maybe reset ac->ac_g_ex.fe_start to 0 instead of leaving it at some random
value? Just for the sake of defensive programming...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


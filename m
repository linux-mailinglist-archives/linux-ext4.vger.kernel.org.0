Return-Path: <linux-ext4+bounces-11483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA3C35133
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 11:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC101920052
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AAC2FD673;
	Wed,  5 Nov 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xs74QUPL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UAbP5OsZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xs74QUPL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UAbP5OsZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DE2EDD51
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338028; cv=none; b=Ad9iIcoxU0s3X4adcpC/2sCd5wDym9aZnhLfsTKbUE6le1l54kq7bTwoM2eEvXGDCas+WG3XAydOvF8ZbRWhkjv3cD9/tumms7sX3KNy2JZtdTBiugDBb6ZA1MxDvk0KEON3sGfJ/6jD703bZIGXMX/lBecLAxe7ughfajTDhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338028; c=relaxed/simple;
	bh=MqtNJjVu5rm/lD2uM4Gzno/PRZ2A/KjGRJY3ZI/Weks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGDhAUbFXjIMxIm1r74/kT95CZ/UdTuJfhspfvBvTwYG8pNx/DXky8Hz5WNyhIuOozkdXQa5zAp8VfQnEG89xIr341/GOe2Ef0P0S2bgcJLWaBbgKOHahk3SuYuAHXxhIK2Fz2O0rWDNSXKCYaId4IE4b65TrwJyf8e0XGHdvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xs74QUPL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UAbP5OsZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xs74QUPL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UAbP5OsZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1399621196;
	Wed,  5 Nov 2025 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762338025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljN0jm2OS3YIcrjfN2C19Sv+K+RgTdbkaJGoxyLvwfk=;
	b=Xs74QUPL6UrKbw2KfzA1BgYFhY0pmqfhChPmZ03zIFkB8RZHheM3Q9vG7MY5XnJ3Hfj5uh
	DM1NEsfA2zteYXo0CEgKjsuKcWXieBxefZN++cVfq4wMX8p0fPYb0d/kDVOXshlQrOo18s
	AvkDLsTZXW3lR0ItsW8cVtXIDuoAGVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762338025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljN0jm2OS3YIcrjfN2C19Sv+K+RgTdbkaJGoxyLvwfk=;
	b=UAbP5OsZ5XDpfA+1IH+UmOOPjWzT7U5ZDG4siSxK5QqEVxgGdTKl1Jp5KDHIypuQwwLGLL
	TFZYSuWGkvQunSAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762338025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljN0jm2OS3YIcrjfN2C19Sv+K+RgTdbkaJGoxyLvwfk=;
	b=Xs74QUPL6UrKbw2KfzA1BgYFhY0pmqfhChPmZ03zIFkB8RZHheM3Q9vG7MY5XnJ3Hfj5uh
	DM1NEsfA2zteYXo0CEgKjsuKcWXieBxefZN++cVfq4wMX8p0fPYb0d/kDVOXshlQrOo18s
	AvkDLsTZXW3lR0ItsW8cVtXIDuoAGVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762338025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljN0jm2OS3YIcrjfN2C19Sv+K+RgTdbkaJGoxyLvwfk=;
	b=UAbP5OsZ5XDpfA+1IH+UmOOPjWzT7U5ZDG4siSxK5QqEVxgGdTKl1Jp5KDHIypuQwwLGLL
	TFZYSuWGkvQunSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 092B013699;
	Wed,  5 Nov 2025 10:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q4s1AukkC2m9TwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 10:20:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B22F8A28C2; Wed,  5 Nov 2025 11:20:24 +0100 (CET)
Date: Wed, 5 Nov 2025 11:20:24 +0100
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v2 1/4] ext4: remove useless code in
 ext4_map_create_blocks
Message-ID: <d3s3h73uzuspthfkenm47ib5peaynakel3f3betafi7szguouj@v6e5cjssj3tn>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
 <j7hzyzb6ounq5tofuxg6mwmb4w5c2ldmkat6ngaf2ijt3rgsfc@fdty7kn7bdjn>
 <09cae118-2ee1-745f-afb8-6c6723b59e7d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09cae118-2ee1-745f-afb8-6c6723b59e7d@huawei.com>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 05-11-25 09:39:01, yangerkun wrote:
> 
> 
> 在 2025/11/4 22:28, Jan Kara 写道:
> > On Tue 04-11-25 21:17:47, Yang Erkun wrote:
> > > IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
> > > dioread_nolock buffer writeback, they all means we need a unwritten
> > > extent(or this extent has already been initialized), and the split won't
> > > zero the range we really write. So this check seems useless. Besides,
> > > even if we repeatedly execute ext4_es_insert_extent, there won't
> > > actually be any issues.
> > > 
> > > Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> > > Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> > 
> > I agree the check isn't needed for correctness but it seems to be
> > reasonable performance optimization for a common case of writing back
> > already written data in dioread_nolock mode?
> 
> Hi!
> 
> Thank you for your detailed review! I believe you are referring to
> writing back a block within the written extent in dioread_nolock mode.
> If that's the case, we might never enter ext4_map_create_blocks because
> ext4_map_query_blocks will return the block as MAPPED. Please correct me
> if I misunderstood!

No, you're correct and I was confused. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


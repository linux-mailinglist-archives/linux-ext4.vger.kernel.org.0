Return-Path: <linux-ext4+bounces-8929-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E58B0056C
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6077AFCB8
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B1273D83;
	Thu, 10 Jul 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jJpIA8pu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EObSc+5f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jJpIA8pu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EObSc+5f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E44273D60
	for <linux-ext4@vger.kernel.org>; Thu, 10 Jul 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158321; cv=none; b=os1KWOhaLanQr3UfkJoC1sjm7JVm2yJLqMqUhSqHcY+D+jC/v4neeijbcnHk0hL6JTcoEiS5r1l4dEg1U3pWKUOxbslk91KrUFCnrxHcNEIrYC+T+dpOwjjDymflIAp+4IWkvixalm2o8vx1xJQMFEjoiG1qiaXVgeQSJHjiFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158321; c=relaxed/simple;
	bh=cRt7UGQZN8+4O01IcOIY28tD3US5zQZgWXkz8/KUoOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPrUVXtfNwHtdrFV68Bc0VM16ZcVN1NxfKETRDTX+XLP5HoWJ9uvSGh1aXy4WpdqN0fcdDaYdhAI9PAyvUW2DTaNuX8FBThQSg9mptfbHQRHGnueV6Z2fhPNugicObv7q5tLxIrsR1i5m01e6bEc7lFUp36rSqsc7iPtCGaieGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jJpIA8pu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EObSc+5f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jJpIA8pu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EObSc+5f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2C6E21755;
	Thu, 10 Jul 2025 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752158317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01QWlgVhoMPFwf4Far4BayktnHTsyOPbnHlHamwLxCI=;
	b=jJpIA8puKLamy/AoL1QJZOfLEdcVCRHXXrI2R6oAvI+7Cr+PCPCwT4KFgGqn7N6gKWvfz8
	8drkH2l5H+oViAh1aVEVSTxpvcSyXfJbkfLUJXr7ZeBEs5Pzq31oDRk2cydN76xs2jEG8u
	cDLcjYklsg+qiapVc0s4J+WOoJMx2Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752158317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01QWlgVhoMPFwf4Far4BayktnHTsyOPbnHlHamwLxCI=;
	b=EObSc+5f0a5OfEmheNKT0mCuNe+AiZnXl/5+8DZiDpHZcODnwSa56VzsQeANgD+b9jEeaI
	4qXdO3W5nCVzJ2CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752158317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01QWlgVhoMPFwf4Far4BayktnHTsyOPbnHlHamwLxCI=;
	b=jJpIA8puKLamy/AoL1QJZOfLEdcVCRHXXrI2R6oAvI+7Cr+PCPCwT4KFgGqn7N6gKWvfz8
	8drkH2l5H+oViAh1aVEVSTxpvcSyXfJbkfLUJXr7ZeBEs5Pzq31oDRk2cydN76xs2jEG8u
	cDLcjYklsg+qiapVc0s4J+WOoJMx2Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752158317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01QWlgVhoMPFwf4Far4BayktnHTsyOPbnHlHamwLxCI=;
	b=EObSc+5f0a5OfEmheNKT0mCuNe+AiZnXl/5+8DZiDpHZcODnwSa56VzsQeANgD+b9jEeaI
	4qXdO3W5nCVzJ2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F30136DC;
	Thu, 10 Jul 2025 14:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b1/TLm3Qb2h4OAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Jul 2025 14:38:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 516B9A098F; Thu, 10 Jul 2025 16:38:33 +0200 (CEST)
Date: Thu, 10 Jul 2025 16:38:33 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <6bf7irhdjrsvuodga344g2ulha52z65f2qf2l3tuldvwbb5pf6@cz7m2gypd4su>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
 <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
 <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
 <kvgztznp6z2gwuujrw5vtklfbmq3arjg54bpiufmxdwmuwjliw@og7qkacbdtax>
 <9ecfe98f-b9d5-478a-b2a5-437b452dbd58@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ecfe98f-b9d5-478a-b2a5-437b452dbd58@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 08-07-25 21:08:00, Baokun Li wrote:
> Sorry for getting to this so late – I've been totally overloaded
> with stuff recently.
> 
> Anyway, back to what we were discussing. I managed to test
> the performance difference between READ_ONCE / WRITE_ONCE and
> smp_load_acquire / smp_store_release on an ARM64 server.
> Here's the results:
> 
> CPU: Kunpeng 920
> Memory: 512GB
> Disk: 960GB SSD (~500M/s)
> 
>         | mb_optimize_scan  |       0        |       1        |
>         |-------------------|----------------|----------------|
>         | Num. containers   |  P80  |   P1   |  P80  |   P1   |
> --------|-------------------|-------|--------|-------|--------|
>         | acquire/release   | 9899  | 290260 | 5005  | 307361 |
>  single | [READ|WRITE]_ONCE | 9636  | 337597 | 4834  | 341440 |
>  goal   |-------------------|-------|--------|-------|--------|
>         |                   | -2.6% | +16.3% | -3.4% | +11.0% |
> --------|-------------------|-------|--------|-------|--------|
>         | acquire/release   | 19931 | 290348 | 7365  | 311717 |
>  muti   | [READ|WRITE]_ONCE | 19628 | 320885 | 7129  | 321275 |
>  goal   |-------------------|-------|--------|-------|--------|
>         |                   | -1.5% | +10.5% | -3.2% | +3.0%  |
> 
> So, my tests show that READ_ONCE / WRITE_ONCE gives us better
> single-threaded performance. That's because it skips the mandatory
> CPU-to-CPU syncing. This also helps explain why x86 has double the
> disk bandwidth (~1000MB/s) of Arm64, but surprisingly, single
> containers run much worse on x86.

Interesting! Thanks for measuring the data!

> However, in multi-threaded scenarios, not consistently reading
> the latest goal has these implications:
> 
>  * ext4_get_group_info() calls increase, as ext4_mb_good_group_nolock()
>    is invoked more often on incorrect groups.
> 
>  * ext4_mb_load_buddy() calls increase due to repeated group accesses
>    leading to more folio_mark_accessed calls.
> 
>  * ext4_mb_prefetch() calls increase with more frequent prefetch_grp
>    access. (I suspect the current mb_prefetch mechanism has some inherent
>    issues we could optimize later.)
> 
> At this point, I believe either approach is acceptable.
> 
> What are your thoughts?

Yes, apparently both approaches have their pros and cons. I'm actually
surprised the impact of additional barriers on ARM is so big for the
single container case. 10% gain for single container cases look nice OTOH
realistical workloads will have more container so maybe that's not worth
optimizing for. Ted, do you have any opinion?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


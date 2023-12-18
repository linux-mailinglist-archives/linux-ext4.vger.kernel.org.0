Return-Path: <linux-ext4+bounces-495-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECF8174AA
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9AD282798
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144D3A1D9;
	Mon, 18 Dec 2023 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CbM1VR35";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWfQwZy8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CbM1VR35";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWfQwZy8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792395A843;
	Mon, 18 Dec 2023 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9864E21F76;
	Mon, 18 Dec 2023 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702911773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9QYYgvVECfx39sMB+5FAGoxV4WVugIO+Aj4S4B/9Dqc=;
	b=CbM1VR35/ZMHQoU4ahEzCymr41VP+h56dbl+isXf2J8yB+vvp3U82lh7uR0Ib0MB6y8oZX
	yahhKxLd2k6TQ9fwUKliJHi49bVwLH7JM9e9cVz7TfLLGzFMGrbyZ8W0p1bWzfQcLEN1OI
	mIaVsVqArvNe+dYGdH6SMAqMJdYptSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702911773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9QYYgvVECfx39sMB+5FAGoxV4WVugIO+Aj4S4B/9Dqc=;
	b=nWfQwZy8luMQlwccrxJyh0ibqPIpe9hsTiRF0VHmiDCWBJmcGGYWKyC3RMOwZ12sakw6SW
	d++DUV0buRSyMbCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702911773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9QYYgvVECfx39sMB+5FAGoxV4WVugIO+Aj4S4B/9Dqc=;
	b=CbM1VR35/ZMHQoU4ahEzCymr41VP+h56dbl+isXf2J8yB+vvp3U82lh7uR0Ib0MB6y8oZX
	yahhKxLd2k6TQ9fwUKliJHi49bVwLH7JM9e9cVz7TfLLGzFMGrbyZ8W0p1bWzfQcLEN1OI
	mIaVsVqArvNe+dYGdH6SMAqMJdYptSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702911773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9QYYgvVECfx39sMB+5FAGoxV4WVugIO+Aj4S4B/9Dqc=;
	b=nWfQwZy8luMQlwccrxJyh0ibqPIpe9hsTiRF0VHmiDCWBJmcGGYWKyC3RMOwZ12sakw6SW
	d++DUV0buRSyMbCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87F8C13927;
	Mon, 18 Dec 2023 15:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kAnlIB1fgGXfdQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 18 Dec 2023 15:02:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B6E9A07E0; Mon, 18 Dec 2023 16:02:53 +0100 (CET)
Date: Mon, 18 Dec 2023 16:02:53 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/4] ext4: do not trim the group with corrupted block
 bitmap
Message-ID: <20231218150253.f75x2lju736weiky@quack3>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-3-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218141814.1477338-3-libaokun1@huawei.com>
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.69
X-Spamd-Result: default: False [0.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.62%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon 18-12-23 22:18:12, Baokun Li wrote:
> Otherwise operating on an incorrupted block bitmap can lead to all sorts
> of unknown problems.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I agree this is a safer option. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..a95fa6e2b0f9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6757,6 +6757,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  	bool set_trimmed = false;
>  	void *bitmap;
>  
> +	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
> +		return 0;
> +
>  	bitmap = e4b->bd_bitmap;
>  	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
>  		set_trimmed = true;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-ext4+bounces-4357-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A09882DE
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D011C2259F
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FF188CD6;
	Fri, 27 Sep 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UbMiJWtk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bCMKr1nK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzK9n+RT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhVI8TSH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7F176231;
	Fri, 27 Sep 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434607; cv=none; b=o9N1Uj59RDTQpiG4/hIMDt9npahihbj6pyyppYQ04OkIrFhMmMnyMWXuSRAIVS4w/mRnXVc38dy7nViYNbJ/+CIvVrLktEdR2I/NRFQ5KK4bc+SagSgZ7njozBeE95r0T/WyLX6RWEP9FkfmSPioKZYOnif+B5nCDngOnKV6TUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434607; c=relaxed/simple;
	bh=zESR3K2Jq1dcJ2qZGed0oVKJ3pFoF5CF1TOUyybCqoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfKRMmPZKKa0SmVpLTgnACjztY4ki6/3F7EB5tzokBNrkXtO+M71SHkjOVRT73858wgbXKALGMMYbU1WbYccLgSR2aoExzhXSbJ66UTltgxXL+DfONaNZDZAhsV1JVEPT+Jgf6MSDJhqJvjZJ8GTDF3tQL9QkJyX497VL9bVaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UbMiJWtk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bCMKr1nK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzK9n+RT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhVI8TSH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEC971FD73;
	Fri, 27 Sep 2024 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727434604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgF9R9s9imIY5hY32djPCrmT+BnOQ2JaDGEea9O/4PE=;
	b=UbMiJWtkyB82NEnVc9Ao7vQTG+NsWLKfGdyX0rxAHKgfKKoF0CFyCYK5kS3Nbhy99IPhB6
	60pjQg2e2gKcgQFT1ZcxMN1uT3XsTx4zvvJM5/lNP0ZHPEvoqDujq3GxYip9AyMHhU/kWE
	C4xl6Us9ASSH9V1mKS3Nz0QiTvy84HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727434604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgF9R9s9imIY5hY32djPCrmT+BnOQ2JaDGEea9O/4PE=;
	b=bCMKr1nKq1aB2NflnNrFstG2t8AgDB2uPenck9pSIM+KGB5QUnjI40OISgO6ucJ0X5Pcsy
	AqNK60r7mPgaWOAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727434603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgF9R9s9imIY5hY32djPCrmT+BnOQ2JaDGEea9O/4PE=;
	b=jzK9n+RTwVInQEs9WYhlf124s68pgCJLNik3HmYIeQrDlVh/eqRpZ9lWKqIOJ8Sffcg6Rm
	cen6VUSquknestoTdrlvwW0fVOOg0jP729GtVTs2dJGTpxWLkYhecqFvKMgzJslYBnB/63
	zbOwZGYG/fQSx5Ppdyi2hcuGDmYWB4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727434603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgF9R9s9imIY5hY32djPCrmT+BnOQ2JaDGEea9O/4PE=;
	b=fhVI8TSHTbhB0fP4yHgAxjqfx9FXPbU0lw5QpujOg3azMuCx506OBFFM0AL2Zka16SbVM4
	5N4Xmfu0o+CJHfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D153F1386E;
	Fri, 27 Sep 2024 10:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kPYQM2uP9maTYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Sep 2024 10:56:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9ADE6A0826; Fri, 27 Sep 2024 12:56:43 +0200 (CEST)
Date: Fri, 27 Sep 2024 12:56:43 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
	Wesley Hershberger <wesley.hershberger@canonical.com>,
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: fix off by one issue in alloc_flex_gd()
Message-ID: <20240927105643.h4b4zunjivv4nkzu@quack3>
References: <20240927063620.2630898-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927063620.2630898-1-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 27-09-24 14:36:20, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Wesley reported an issue:
> 
> ==================================================================
> EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/resize.c:324!
> CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
> RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> Call Trace:
>  __ext4_ioctl+0x4e0/0x1800
>  ext4_ioctl+0x12/0x20
>  __x64_sys_ioctl+0x99/0xd0
>  x64_sys_call+0x1206/0x20d0
>  do_syscall_64+0x72/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> While reviewing the patch, Honza found that when adjusting resize_bg in
> alloc_flex_gd(), it was possible for flex_gd->resize_bg to be bigger than
> flexbg_size.
> 
> The reproduction of the problem requires the following:
> 
>  o_group = flexbg_size * 2 * n;
>  o_size = (o_group + 1) * group_size;
>  n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>  o_size = (n_group + 1) * group_size;
> 
> Take n=0,flexbg_size=16 as an example:
> 
>               last:15
> |o---------------|--------------n-|
> o_group:0    resize to      n_group:30
> 
> The corresponding reproducer is:
> 
> img=test.img
> truncate -s 600M $img
> mkfs.ext4 -F $img -b 1024 -G 16 8M
> dev=`losetup -f --show $img`
> mkdir -p /tmp/test
> mount $dev /tmp/test
> resize2fs $dev 248M
> 
> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
> to prevent the issue from happening again.

I don't think you are adding WARN_ON_ONCE() :). Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Eric Sandeen <sandeen@redhat.com>
> Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/resize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..397970121d43 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -253,9 +253,9 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
>  	/* Avoid allocating large 'groups' array if not needed */
>  	last_group = o_group | (flex_gd->resize_bg - 1);
>  	if (n_group <= last_group)
> -		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
> +		flex_gd->resize_bg = 1 << fls(n_group - o_group);
>  	else if (n_group - last_group < flex_gd->resize_bg)
> -		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
> +		flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
>  					      fls(n_group - last_group));
>  
>  	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


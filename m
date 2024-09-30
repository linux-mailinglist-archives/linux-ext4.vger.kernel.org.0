Return-Path: <linux-ext4+bounces-4386-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C849989F07
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EDC1C2241E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0C1189F5C;
	Mon, 30 Sep 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+uoTGau";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V185848S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+uoTGau";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V185848S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF3188006;
	Mon, 30 Sep 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690261; cv=none; b=Rtdzd/DDPY00G6544XdMdnIgWN7drjuRNJZlEVGNocOqM9XDnMplLPMVe1qY0Sw2WRNTah1+lWeLRvZ2fwe5aAQZa3U/b0D9qjW6ArNwJ1FeSLCTeaKQhEEzta0a/U7R0pSt87+6Tink6AYiO6zS4NKbgXE54oTTMqG938UBb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690261; c=relaxed/simple;
	bh=PxlkKXNt4FfW3kXiWThoZjEnjVEpmS3Ec8x/6iM/CQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQzXGS2C6Q2KVIku+0L290PntSbB+aDgpZNhj3r0wg3hbG+mVZSTyQdicNQ20NGbbCHWQWJdIoI2fyt1skHjfs3jobE8DEad/XNzYBu3ylfv0xocIOkdMqFPMcSHEqhdcyGHU3LWdfnGfnB78wFhjOzvYenZHyEnuhW1KiUrx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+uoTGau; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V185848S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+uoTGau; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V185848S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A3361F7FA;
	Mon, 30 Sep 2024 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727690257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIOuWAbizfXdcZdpjzcGy/FAWPITVnjDo6ImDR/caHI=;
	b=H+uoTGauPC7dL94cP56C7KbODn5HgC91IWmEAppSLx8wt14g1WibocojWLkk3jh1+ySmiE
	sCHpE1LYyYq4HQ8qqh9Th6sW2r5IQdmWf5TQ5li6Rb1egbTB/oF3kdAKqaqBzt7d03E8V/
	Cbe5x4wvNYSn4UMZ1tqgGJMqP4bOn1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727690257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIOuWAbizfXdcZdpjzcGy/FAWPITVnjDo6ImDR/caHI=;
	b=V185848SE/ppfD182NHTneVUsa6gsyijJehUqtr7S55klReQT5V0qZTRoT8pbQHIusios5
	ihUeWNU322wWjiAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H+uoTGau;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V185848S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727690257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIOuWAbizfXdcZdpjzcGy/FAWPITVnjDo6ImDR/caHI=;
	b=H+uoTGauPC7dL94cP56C7KbODn5HgC91IWmEAppSLx8wt14g1WibocojWLkk3jh1+ySmiE
	sCHpE1LYyYq4HQ8qqh9Th6sW2r5IQdmWf5TQ5li6Rb1egbTB/oF3kdAKqaqBzt7d03E8V/
	Cbe5x4wvNYSn4UMZ1tqgGJMqP4bOn1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727690257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIOuWAbizfXdcZdpjzcGy/FAWPITVnjDo6ImDR/caHI=;
	b=V185848SE/ppfD182NHTneVUsa6gsyijJehUqtr7S55klReQT5V0qZTRoT8pbQHIusios5
	ihUeWNU322wWjiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AE6813A8B;
	Mon, 30 Sep 2024 09:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GjGJBhF2+mYfOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 09:57:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C60DBA0845; Mon, 30 Sep 2024 11:57:36 +0200 (CEST)
Date: Mon, 30 Sep 2024 11:57:36 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
	Wesley Hershberger <wesley.hershberger@canonical.com>,
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix off by one issue in alloc_flex_gd()
Message-ID: <20240930095736.63jxu22xfnxrwvar@quack3>
References: <20240927133329.1015041-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927133329.1015041-1-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 2A3361F7FA
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 27-09-24 21:33:29, libaokun@huaweicloud.com wrote:
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

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v1:
>  * Add missing WARN_ON_ONCE().
>  * Correct the comment of alloc_flex_gd().
> 
>  fs/ext4/resize.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..a2704f064361 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -230,8 +230,8 @@ struct ext4_new_flex_group_data {
>  #define MAX_RESIZE_BG				16384
>  
>  /*
> - * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
> - * @flexbg_size.
> + * alloc_flex_gd() allocates an ext4_new_flex_group_data that satisfies the
> + * resizing from @o_group to @n_group, its size is typically @flexbg_size.
>   *
>   * Returns NULL on failure otherwise address of the allocated structure.
>   */
> @@ -239,25 +239,27 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
>  				ext4_group_t o_group, ext4_group_t n_group)
>  {
>  	ext4_group_t last_group;
> +	unsigned int max_resize_bg;
>  	struct ext4_new_flex_group_data *flex_gd;
>  
>  	flex_gd = kmalloc(sizeof(*flex_gd), GFP_NOFS);
>  	if (flex_gd == NULL)
>  		goto out3;
>  
> -	if (unlikely(flexbg_size > MAX_RESIZE_BG))
> -		flex_gd->resize_bg = MAX_RESIZE_BG;
> -	else
> -		flex_gd->resize_bg = flexbg_size;
> +	max_resize_bg = umin(flexbg_size, MAX_RESIZE_BG);
> +	flex_gd->resize_bg = max_resize_bg;
>  
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
> +	if (WARN_ON_ONCE(flex_gd->resize_bg > max_resize_bg))
> +		flex_gd->resize_bg = max_resize_bg;
> +
>  	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>  					sizeof(struct ext4_new_group_data),
>  					GFP_NOFS);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


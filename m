Return-Path: <linux-ext4+bounces-2333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5A8BD64D
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 22:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7848C283222
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1F15B15E;
	Mon,  6 May 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pn+b/quK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDEc/JQr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pn+b/quK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDEc/JQr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406582BAE5;
	Mon,  6 May 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027836; cv=none; b=KaRDFQQdWMxtrhTa4+xKMqs96TVYFJtvjcOZYQqt+Fp0M7CXprPvoome7/G8Tj9jzRk1q54F1PfnRW+e3I0lnadrqFDfwgNSAaJ3fOwn8q5nxCmB63anJ4ZggtorW98qN+aCx9qUT7O2aib+/rulSRytKxTvfAFFnVDNvFne4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027836; c=relaxed/simple;
	bh=Bnf1pFA/bdwZS9FVY9+H5YYvCPEp7R1uJYzZbOL2Yp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVlAG9zLpRBPyy9GS/BxxfO9HBdB23b7o3H6XqjBzpYYfGHnMORj8CAcC//kbjF/bVPoNXz3C5uAwp6v54ouISdjci3JUeGWm0qtg7+zmoXGh0t/lISS3im07EVux8vYxmT2z7HZveC8A2PtSGD/340FVFFCiyB49Glti7lvuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pn+b/quK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDEc/JQr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pn+b/quK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDEc/JQr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49D18227C9;
	Mon,  6 May 2024 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715027832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7l+QGCXqyZoSc1FHTQnMrW7cIc2MQyDEqTbODhY7gA=;
	b=Pn+b/quKF+Fj74Z8mhH3XK+s9xUT7Wav0mI8cjddCouW7JAc6SnZOw7q3wasIl4I5GQ1P+
	ey4jp4JYrALlTfhOhABazozVAcaQ938mSCOuyw0rZ++xgRJ2UdnAuwba/JhqXG9rVc0SlB
	VF2+6s1XSrZDjFNGoJQH8i7YssS+Zgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715027832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7l+QGCXqyZoSc1FHTQnMrW7cIc2MQyDEqTbODhY7gA=;
	b=sDEc/JQrJ1sor4N6Abii0NAT/Zfxkw0VQNQ4lfg3W3OsY2hzgqypyPAv2sGB5RZmEFbt5a
	Gfc/2S/QC9G4BDDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Pn+b/quK";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="sDEc/JQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715027832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7l+QGCXqyZoSc1FHTQnMrW7cIc2MQyDEqTbODhY7gA=;
	b=Pn+b/quKF+Fj74Z8mhH3XK+s9xUT7Wav0mI8cjddCouW7JAc6SnZOw7q3wasIl4I5GQ1P+
	ey4jp4JYrALlTfhOhABazozVAcaQ938mSCOuyw0rZ++xgRJ2UdnAuwba/JhqXG9rVc0SlB
	VF2+6s1XSrZDjFNGoJQH8i7YssS+Zgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715027832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7l+QGCXqyZoSc1FHTQnMrW7cIc2MQyDEqTbODhY7gA=;
	b=sDEc/JQrJ1sor4N6Abii0NAT/Zfxkw0VQNQ4lfg3W3OsY2hzgqypyPAv2sGB5RZmEFbt5a
	Gfc/2S/QC9G4BDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A26F1386E;
	Mon,  6 May 2024 20:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pufkDXg/OWYuZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 May 2024 20:37:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B00EEA1306; Mon,  6 May 2024 22:37:11 +0200 (CEST)
Date: Mon, 6 May 2024 22:37:11 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: Re: [PATCH 1/2] ext4: fix mb_cache_entry's e_refcnt leak in
 ext4_xattr_block_cache_find()
Message-ID: <20240506203711.m76utvtmptd5a4du@quack3>
References: <20240504075526.2254349-1-libaokun@huaweicloud.com>
 <20240504075526.2254349-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504075526.2254349-2-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dd43bd0f7474512edc47];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,syzkaller.appspotmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49D18227C9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sat 04-05-24 15:55:25, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Syzbot reports a warning as follows:
> 
> ============================================
> WARNING: CPU: 0 PID: 5075 at fs/mbcache.c:419 mb_cache_destroy+0x224/0x290
> Modules linked in:
> CPU: 0 PID: 5075 Comm: syz-executor199 Not tainted 6.9.0-rc6-gb947cc5bf6d7
> RIP: 0010:mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
> Call Trace:
>  <TASK>
>  ext4_put_super+0x6d4/0xcd0 fs/ext4/super.c:1375
>  generic_shutdown_super+0x136/0x2d0 fs/super.c:641
>  kill_block_super+0x44/0x90 fs/super.c:1675
>  ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7327
> [...]
> ============================================
> 
> This is because when finding an entry in ext4_xattr_block_cache_find(), if
> ext4_sb_bread() returns -ENOMEM, the ce's e_refcnt, which has already grown
> in the __entry_find(), won't be put away, and eventually trigger the above
> issue in mb_cache_destroy() due to reference count leakage.
> 
> So call mb_cache_entry_put() on the -ENOMEM error branch as a quick fix.
> 
> Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
> Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index b67a176bfcf9..9fdd13422073 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -3113,8 +3113,10 @@ ext4_xattr_block_cache_find(struct inode *inode,
>  
>  		bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
>  		if (IS_ERR(bh)) {
> -			if (PTR_ERR(bh) == -ENOMEM)
> +			if (PTR_ERR(bh) == -ENOMEM) {
> +				mb_cache_entry_put(ea_block_cache, ce);
>  				return NULL;
> +			}
>  			bh = NULL;
>  			EXT4_ERROR_INODE(inode, "block %lu read error",
>  					 (unsigned long)ce->e_value);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


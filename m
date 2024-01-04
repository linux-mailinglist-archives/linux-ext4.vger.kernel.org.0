Return-Path: <linux-ext4+bounces-673-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FD823FA2
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9D11C23E0D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492320DD8;
	Thu,  4 Jan 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bMRb2KJn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QSUJu3FP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bMRb2KJn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QSUJu3FP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DE20DC6;
	Thu,  4 Jan 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26D1E1F800;
	Thu,  4 Jan 2024 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSn78KqV0Tpz7Cut9LWpj/BNuNX1i+/PmVXWNjv61vo=;
	b=bMRb2KJnyaT5bUUh01gOIev65OM3dqACLdLmMD74f18T2wq1PVyMBrOzI1lfLbMmnpAVDl
	8KTgvYtms9Ax6zgA9o/VfdLadBwRUCr+q5me1ZdTczZjzDWYcI0OKNjbPDcjMhFrD4zFFJ
	8KTe3zDOC4eYK7KZR6nUzpdQteTHCoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSn78KqV0Tpz7Cut9LWpj/BNuNX1i+/PmVXWNjv61vo=;
	b=QSUJu3FPWdavFBci8EKzlGa1+UrDwqWvBzAPJl1oOBtCDfkKszdYwugtP+6umjtqJi5B7U
	tUgT+FGUDWnXhvBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSn78KqV0Tpz7Cut9LWpj/BNuNX1i+/PmVXWNjv61vo=;
	b=bMRb2KJnyaT5bUUh01gOIev65OM3dqACLdLmMD74f18T2wq1PVyMBrOzI1lfLbMmnpAVDl
	8KTgvYtms9Ax6zgA9o/VfdLadBwRUCr+q5me1ZdTczZjzDWYcI0OKNjbPDcjMhFrD4zFFJ
	8KTe3zDOC4eYK7KZR6nUzpdQteTHCoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSn78KqV0Tpz7Cut9LWpj/BNuNX1i+/PmVXWNjv61vo=;
	b=QSUJu3FPWdavFBci8EKzlGa1+UrDwqWvBzAPJl1oOBtCDfkKszdYwugtP+6umjtqJi5B7U
	tUgT+FGUDWnXhvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D57813722;
	Thu,  4 Jan 2024 10:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tT8oB9SLlmXCdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:43:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9C98A07EF; Thu,  4 Jan 2024 11:43:31 +0100 (CET)
Date: Thu, 4 Jan 2024 11:43:31 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 5/8] ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <20240104104331.udagyt3wv4xfchgq@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-6-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-6-libaokun1@huawei.com>
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[35.80%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

On Thu 21-12-23 23:05:55, Baokun Li wrote:
> Determine if bb_fragments is 0 instead of determining bb_free to eliminate
> the risk of dividing by zero when the block bitmap is corrupted.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1f15774971d7..03500aec43ac 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -842,7 +842,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	int new_order;
>  
> -	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
>  		return;
>  
>  	new_order = mb_avg_fragment_size_order(sb,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


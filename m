Return-Path: <linux-ext4+bounces-624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3582A821C2C
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD8E1F20F1C
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4CBF9E6;
	Tue,  2 Jan 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bSUbwPwp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="18Fnup+f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SlliV/RE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWw58kbU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEADF9D2;
	Tue,  2 Jan 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19FDA21D9B;
	Tue,  2 Jan 2024 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfSiVYMEnaDEKNgKuc8cA5E2hWB+E8HsDeJLGdG75n0=;
	b=bSUbwPwpOuUQCxHbU8sNgr12BbJJpSX8NOZOQICTJQFgYhBEW0wMXEuuAAKaryDQKPjSaw
	CuOy0XOgpYYZiZuaaojlx+NFlKLQULNJcVoB4u7GToMXqB8fkwYSAOLJAaxKxBpsj68qdU
	ei78Cyzwk81CfL7xO9XpKPDOTm+In9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfSiVYMEnaDEKNgKuc8cA5E2hWB+E8HsDeJLGdG75n0=;
	b=18Fnup+f30pV1KMQHMPrmI+GJ85DqUPpCnSxCx2wD/FfImdF/O7qChJbP5KltmEDLxM5X2
	4o3fm0aVuLINocCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfSiVYMEnaDEKNgKuc8cA5E2hWB+E8HsDeJLGdG75n0=;
	b=SlliV/REKwjSy5miE70yhmUnqxoxeGeYjr2EeZjGEyWzjjWSpJQdNGt3h3LZQ+K6T237r+
	wsRKy5GU3aMSsrn8VJ/m28aVUDUCm2L/DswuiXlO9jK2Thd7xaq2VS5ZPt7xtHWemINCIa
	CSKO2YUdFM9cRNQzsXbCFTvRiz0lhSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfSiVYMEnaDEKNgKuc8cA5E2hWB+E8HsDeJLGdG75n0=;
	b=rWw58kbUXNXp+fuhC11wABZa14VX8rMH3ZPlgA1KCY3lUiFH0eiZzXXpcBC5su/igK1B/c
	m6ADoZJ+39v8JeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F45C13AC6;
	Tue,  2 Jan 2024 13:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/q4A+4JlGWnSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:04:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4A2AA07EF; Tue,  2 Jan 2024 14:04:41 +0100 (CET)
Date: Tue, 2 Jan 2024 14:04:41 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] ext4: remove unused return value of ext4_mb_release
Message-ID: <20240102130441.cq2lc4itpuaskg7l@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-6-shikemeng@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 5.29
X-Spamd-Bar: +++++
X-Spam-Flag: NO
X-Spamd-Result: default: False [5.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="SlliV/RE";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rWw58kbU
X-Spam-Level: *****
X-Rspamd-Queue-Id: 19FDA21D9B

On Sun 26-11-23 00:11:40, Kemeng Shi wrote:
> Remove unused return value of ext4_mb_release.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 2 +-
>  fs/ext4/mballoc.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8ccebe0d4..fb35cae16 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2902,7 +2902,7 @@ extern const struct seq_operations ext4_mb_seq_groups_ops;
>  extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
>  extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
>  extern int ext4_mb_init(struct super_block *);
> -extern int ext4_mb_release(struct super_block *);
> +extern void ext4_mb_release(struct super_block *);
>  extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>  				struct ext4_allocation_request *, int *);
>  extern void ext4_discard_preallocations(struct inode *, unsigned int);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f79e87ad3..8d6246db3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3725,7 +3725,7 @@ static int ext4_mb_cleanup_pa(struct ext4_group_info *grp)
>  	return count;
>  }
>  
> -int ext4_mb_release(struct super_block *sb)
> +void ext4_mb_release(struct super_block *sb)
>  {
>  	ext4_group_t ngroups = ext4_get_groups_count(sb);
>  	ext4_group_t i;
> @@ -3801,8 +3801,6 @@ int ext4_mb_release(struct super_block *sb)
>  	}
>  
>  	free_percpu(sbi->s_locality_groups);
> -
> -	return 0;
>  }
>  
>  static inline int ext4_issue_discard(struct super_block *sb,
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


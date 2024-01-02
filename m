Return-Path: <linux-ext4+bounces-621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6229821C22
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B6281F9C
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67687F9E6;
	Tue,  2 Jan 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzD0a/cV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8NS+Rm6R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzD0a/cV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8NS+Rm6R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8CF9D2;
	Tue,  2 Jan 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10BEF1FD60;
	Tue,  2 Jan 2024 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZoeJmEwC8cyYtQvESJPMTmB6Pqe0KyQyZMZD9R5Q5A=;
	b=uzD0a/cVppPVBj1AxhKJq2r7R8AFGbUZeeeQAmlYQhN2TvnXSFh1A5w9WyjlUwiFsUuBiI
	JcJQKfd2rx5IIgvavyFYRunyJQhpVa6foJRLa/+IJ7DPPFn1AF40rSQx8TeN3AiIuLrfde
	Qo1mXFK732fgi93/uyaGLhRH7LfpG/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZoeJmEwC8cyYtQvESJPMTmB6Pqe0KyQyZMZD9R5Q5A=;
	b=8NS+Rm6Rx21+lSvXj2sOTzxMr63ez2YsEJs4EsOOUAha8G5RgZ3wg5uhjGS9L/EpiO/yj0
	aJaQJtIZriSURcAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZoeJmEwC8cyYtQvESJPMTmB6Pqe0KyQyZMZD9R5Q5A=;
	b=uzD0a/cVppPVBj1AxhKJq2r7R8AFGbUZeeeQAmlYQhN2TvnXSFh1A5w9WyjlUwiFsUuBiI
	JcJQKfd2rx5IIgvavyFYRunyJQhpVa6foJRLa/+IJ7DPPFn1AF40rSQx8TeN3AiIuLrfde
	Qo1mXFK732fgi93/uyaGLhRH7LfpG/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZoeJmEwC8cyYtQvESJPMTmB6Pqe0KyQyZMZD9R5Q5A=;
	b=8NS+Rm6Rx21+lSvXj2sOTzxMr63ez2YsEJs4EsOOUAha8G5RgZ3wg5uhjGS9L/EpiO/yj0
	aJaQJtIZriSURcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFFE81340C;
	Tue,  2 Jan 2024 13:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FAWWOjcJlGXkSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:01:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AA75CA07EF; Tue,  2 Jan 2024 14:01:43 +0100 (CET)
Date: Tue, 2 Jan 2024 14:01:43 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] ext4: remove unused parameter group in
 ext4_mb_choose_next_group_*()
Message-ID: <20240102130143.5yngez5r6npn67ky@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-3-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.22%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uzD0a/cV";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8NS+Rm6R
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: 10BEF1FD60

On Sun 26-11-23 00:11:37, Kemeng Shi wrote:
> Remove unused parameter group in ext4_mb_choose_next_group_*().
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9f9b8dd06..765b62729 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -870,7 +870,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>   * cr level needs an update.
>   */
>  static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
> -			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +			enum criteria *new_cr, ext4_group_t *group)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_group_info *iter;
> @@ -944,7 +944,7 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
>   * order. Updates *new_cr if cr level needs an update.
>   */
>  static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *ac,
> -		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +		enum criteria *new_cr, ext4_group_t *group)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_group_info *grp = NULL;
> @@ -989,7 +989,7 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
>   * much and fall to CR_GOAL_LEN_SLOW in that case.
>   */
>  static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context *ac,
> -		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +		enum criteria *new_cr, ext4_group_t *group)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_group_info *grp = NULL;
> @@ -1124,11 +1124,11 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  	}
>  
>  	if (*new_cr == CR_POWER2_ALIGNED) {
> -		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group, ngroups);
> +		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
>  	} else if (*new_cr == CR_GOAL_LEN_FAST) {
> -		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group, ngroups);
> +		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
>  	} else if (*new_cr == CR_BEST_AVAIL_LEN) {
> -		ext4_mb_choose_next_group_best_avail(ac, new_cr, group, ngroups);
> +		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>  	} else {
>  		/*
>  		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


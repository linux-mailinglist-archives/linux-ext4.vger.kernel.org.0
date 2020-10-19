Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6F2924B4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgJSJhJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:37:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:59998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJSJhI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 05:37:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16E98AB95;
        Mon, 19 Oct 2020 09:37:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9AD841E1340; Mon, 19 Oct 2020 11:37:06 +0200 (CEST)
Date:   Mon, 19 Oct 2020 11:37:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH v2 1/2] ext4: add helpers for checking whether quota can
 be enabled/is journalled
Message-ID: <20201019093706.GC30825@quack2.suse.cz>
References: <1602986547-15886-1-git-send-email-dotdot@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602986547-15886-1-git-send-email-dotdot@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 18-10-20 05:02:26, Roman Anufriev wrote:
> Right now, there are several places, where we check whether fs is
> capable of enabling quota or if quota is journalled with quite long
> and non-self-descriptive condition statements.
> 
> This patch wraps these statements into helpers for better readability
> and easier usage.
> 
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>

Looks good to me. You can add:

Reviewe-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
>   - Fix misleading helper name 'ext4_any_quota_enabled()' ->
>     'ext4_quota_capable()'.
> 
>  fs/ext4/ext4.h      | 15 +++++++++++++++
>  fs/ext4/ext4_jbd2.h |  9 +++------
>  fs/ext4/super.c     |  5 +----
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 250e905..897df24 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3251,6 +3251,21 @@ static inline void ext4_unlock_group(struct super_block *sb,
>  	spin_unlock(ext4_group_lock_ptr(sb, group));
>  }
>  
> +#ifdef CONFIG_QUOTA
> +static inline bool ext4_quota_capable(struct super_block *sb)
> +{
> +	return (test_opt(sb, QUOTA) || ext4_has_feature_quota(sb));
> +}
> +
> +static inline bool ext4_is_quota_journalled(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	return (ext4_has_feature_quota(sb) ||
> +		sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]);
> +}
> +#endif
> +
>  /*
>   * Block validity checking
>   */
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 00dc668..a124c68 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -86,17 +86,14 @@
>  #ifdef CONFIG_QUOTA
>  /* Amount of blocks needed for quota update - we know that the structure was
>   * allocated so we need to update only data block */
> -#define EXT4_QUOTA_TRANS_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
> -		ext4_has_feature_quota(sb)) ? 1 : 0)
> +#define EXT4_QUOTA_TRANS_BLOCKS(sb) ((ext4_quota_capable(sb)) ? 1 : 0)
>  /* Amount of blocks needed for quota insert/delete - we do some block writes
>   * but inode, sb and group updates are done only once */
> -#define EXT4_QUOTA_INIT_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
> -		ext4_has_feature_quota(sb)) ?\
> +#define EXT4_QUOTA_INIT_BLOCKS(sb) ((ext4_quota_capable(sb)) ?\
>  		(DQUOT_INIT_ALLOC*(EXT4_SINGLEDATA_TRANS_BLOCKS(sb)-3)\
>  		 +3+DQUOT_INIT_REWRITE) : 0)
>  
> -#define EXT4_QUOTA_DEL_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
> -		ext4_has_feature_quota(sb)) ?\
> +#define EXT4_QUOTA_DEL_BLOCKS(sb) ((ext4_quota_capable(sb)) ?\
>  		(DQUOT_DEL_ALLOC*(EXT4_SINGLEDATA_TRANS_BLOCKS(sb)-3)\
>  		 +3+DQUOT_DEL_REWRITE) : 0)
>  #else
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9d01318..a988cf3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6158,11 +6158,8 @@ static int ext4_release_dquot(struct dquot *dquot)
>  static int ext4_mark_dquot_dirty(struct dquot *dquot)
>  {
>  	struct super_block *sb = dquot->dq_sb;
> -	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
> -	/* Are we journaling quotas? */
> -	if (ext4_has_feature_quota(sb) ||
> -	    sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
> +	if (ext4_is_quota_journalled(sb)) {
>  		dquot_mark_dquot_dirty(dquot);
>  		return ext4_write_dquot(dquot);
>  	} else {
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3D292501
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgJSJxB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:35046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgJSJxB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 05:53:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBDDCB29D;
        Mon, 19 Oct 2020 09:52:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B5461E1340; Mon, 19 Oct 2020 11:52:59 +0200 (CEST)
Date:   Mon, 19 Oct 2020 11:52:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH v2 2/2] ext4: print quota journalling mode on (re-)mount
Message-ID: <20201019095259.GD30825@quack2.suse.cz>
References: <1602986547-15886-1-git-send-email-dotdot@yandex-team.ru>
 <1602986547-15886-2-git-send-email-dotdot@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602986547-15886-2-git-send-email-dotdot@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 18-10-20 05:02:27, Roman Anufriev wrote:
> Right now, it is hard to understand what quota journalling type is enabled:
> you need to be quite familiar with kernel code and trace it or really
> understand what different combinations of fs flags/mount options lead to.
> 
> This patch adds printing of current quota jounalling mode on each
> mount/remount, thus making it easier to check it at a glance/in autotests.
> The semantics is similar to ext4 data journalling modes:
> 
> * journalled - quota accounting and journaling are enabled
> * writeback  - quota accounting is enabled, but journalling is disabled

The above two descriptions are still somewhat misleading - in fact we don't
know whether accounting is enabled or not. Just *if* it is enabled, quota
will be journalled / non-journalled. So I'd probably describe it like:
 * journalled - quota configured, journalling will be enabled
 * writeback - quota configured, journalling will be disabled

We've talked with Ted on last ext4 conf call and we agreed that it's
probably time to deprecate old style quotas in external quota files and
transition everybody to using quotas with quota feature. That way things
will get simpler again. But before we can disable that functionality, it
will take a few years of deprecation warnings etc. so that's not directly
related to your patch here. JFYI.

								Honza

> * none       - quota accounting is disabled
> * disabled   - kernel compiled without CONFIG_QUOTA feature
> 
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
> ---
> Changes in v2:
>   - Print quota journalling mode instead of exporting it via sysfs.
> 
>  fs/ext4/super.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a988cf3..09b5645 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3985,6 +3985,21 @@ static void ext4_set_resv_clusters(struct super_block *sb)
>  	atomic64_set(&sbi->s_resv_clusters, resv_clusters);
>  }
>  
> +static const char *ext4_quota_mode(struct super_block *sb)
> +{
> +#ifdef CONFIG_QUOTA
> +	if (!ext4_quota_capable(sb))
> +		return "none";
> +
> +	if (ext4_is_quota_journalled(sb))
> +		return "journalled";
> +	else
> +		return "writeback";
> +#else
> +	return "disabled"
> +#endif
> +}
> +
>  static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
> @@ -5039,10 +5054,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
>  		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
> -			 "Opts: %.*s%s%s", descr,
> +			 "Opts: %.*s%s%s. Quota mode: %s.", descr,
>  			 (int) sizeof(sbi->s_es->s_mount_opts),
>  			 sbi->s_es->s_mount_opts,
> -			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data);
> +			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data,
> +			 ext4_quota_mode(sb));
>  
>  	if (es->s_error_count)
>  		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
> @@ -5979,7 +5995,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  	 */
>  	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
>  
> -	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
> +	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
> +		 orig_data, ext4_quota_mode(sb));
>  	kfree(orig_data);
>  	return 0;
>  
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

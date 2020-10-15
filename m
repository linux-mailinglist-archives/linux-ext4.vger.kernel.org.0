Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7558728F2FD
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJONPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 09:15:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgJONPZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Oct 2020 09:15:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E5F3B1DC;
        Thu, 15 Oct 2020 13:15:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BCE771E133C; Thu, 15 Oct 2020 15:15:22 +0200 (CEST)
Date:   Thu, 15 Oct 2020 15:15:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH 2/2] ext4: export quota journalling mode via sysfs attr
 quota_mode
Message-ID: <20201015131522.GF7037@quack2.suse.cz>
References: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru>
 <1602761572-4713-2-git-send-email-dotdot@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602761572-4713-2-git-send-email-dotdot@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-10-20 14:32:52, Roman Anufriev wrote:
> Right now, it is hard to understand what quota journalling type is enabled:
> you need to be quite familiar with kernel code and trace it or really
> understand what different combinations of fs flags/mount options lead to.
> 
> This patch exports via sysfs attr /sys/fs/ext4/<disk>/quota_mode current
> quota jounalling mode, making it easier to check at a glance/in autotests.
> The semantics is similar to ext4 data journalling modes:
> 
> * journalled - quota accounting and journaling are enabled
> * writeback  - quota accounting is enabled, but journalling is disabled
> * none       - quota accounting is disabled
> * disabled   - kernel compiled without CONFIG_QUOTA feature
> 
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
> Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

Hum, I'm not sure about this. The state of quota can be found out with
"quotaon -p <mntpoint>" (or corresponding quotactl if you need this from
C). The only thing you won't learn is journalled / writeback mode and
generally you should not care about this although I agree that for fs
crash testing purposes you may care. But is that big enough usecase for a
new sysfs file when all the information is already available for userspace
just not in a convenient form?

BTW, I've now realized ext4_any_quota_enabled() has actually misleading
name in the sysfs file reports wrong information. It is rather
ext4_any_quota_may_be_enabled() since presence of QUOTA mount option only
says that quotaon(8) will enable quotas if it is run, not that quota
accounting is enabled. sb_any_quota_loaded() tells you if accounting is
actually enabled or not (however this can change anytime so that's why we
use more relaxed checks for the purpose of journal credit estimates).

								Honza

> ---
>  fs/ext4/sysfs.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index bfabb79..a46487f 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -36,6 +36,7 @@ typedef enum {
>  	attr_pointer_string,
>  	attr_pointer_atomic,
>  	attr_journal_task,
> +	attr_quota_mode,
>  } attr_id_t;
>  
>  typedef enum {
> @@ -140,6 +141,23 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>  			task_pid_vnr(sbi->s_journal->j_task));
>  }
>  
> +static ssize_t quota_mode_show(struct ext4_sb_info *sbi, char *buf)
> +{
> +#ifdef CONFIG_QUOTA
> +	struct super_block *sb = sbi->s_buddy_cache->i_sb;
> +
> +	if (!ext4_any_quota_enabled(sb))
> +		return snprintf(buf, PAGE_SIZE, "none\n");
> +
> +	if (ext4_is_quota_journalled(sb))
> +		return snprintf(buf, PAGE_SIZE, "journalled\n");
> +	else
> +		return snprintf(buf, PAGE_SIZE, "writeback\n");
> +#else
> +	return snprintf(buf, PAGE_SIZE, "disabled\n");
> +#endif
> +}
> +
>  #define EXT4_ATTR(_name,_mode,_id)					\
>  static struct ext4_attr ext4_attr_##_name = {				\
>  	.attr = {.name = __stringify(_name), .mode = _mode },		\
> @@ -248,6 +266,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
>  EXT4_ATTR(journal_task, 0444, journal_task);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> +EXT4_ATTR_FUNC(quota_mode, 0444);
>  
>  static unsigned int old_bump_val = 128;
>  EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -296,6 +315,7 @@ static struct attribute *ext4_attrs[] = {
>  #endif
>  	ATTR_LIST(mb_prefetch),
>  	ATTR_LIST(mb_prefetch_limit),
> +	ATTR_LIST(quota_mode),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ext4);
> @@ -425,6 +445,8 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  		return print_tstamp(buf, sbi->s_es, s_last_error_time);
>  	case attr_journal_task:
>  		return journal_task_show(sbi, buf);
> +	case attr_quota_mode:
> +		return quota_mode_show(sbi, buf);
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16E2A4C24
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 18:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgKCRBC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 12:01:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:38284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCRBC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 12:01:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6260AD29;
        Tue,  3 Nov 2020 17:01:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AEFCB1E12FB; Tue,  3 Nov 2020 18:01:00 +0100 (CET)
Date:   Tue, 3 Nov 2020 18:01:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 09/10] ext4: disable fast commit with data journalling
Message-ID: <20201103170100.GM3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-10-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-10-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:17, Harshad Shirwadkar wrote:
> Fast commits don't work with data journalling. This patch disables the
> fast commit support when data journalling is turned on.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c       | 7 +++++++
>  fs/ext4/fast_commit.h       | 1 +
>  fs/ext4/super.c             | 3 ++-
>  include/trace/events/ext4.h | 6 ++++--
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 4c0a3e858ea3..9ae8ba213961 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -472,6 +472,12 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  	if (S_ISDIR(inode->i_mode))
>  		return;
>  
> +	if (ext4_should_journal_data(inode)) {
> +		ext4_fc_mark_ineligible(inode->i_sb,
> +					EXT4_FC_REASON_INODE_JOURNAL_DATA);
> +		return;
> +	}
> +
>  	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
>  	trace_ext4_fc_track_inode(inode, ret);
>  }
> @@ -2095,6 +2101,7 @@ const char *fc_ineligible_reasons[] = {
>  	"Resize",
>  	"Dir renamed",
>  	"Falloc range op",
> +	"Data journalling",
>  	"FC Commit Failed"
>  };
>  
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index cde86747faf8..cdb36a10dfd0 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -105,6 +105,7 @@ enum {
>  	EXT4_FC_REASON_RESIZE,
>  	EXT4_FC_REASON_RENAME_DIR,
>  	EXT4_FC_REASON_FALLOC_RANGE,
> +	EXT4_FC_REASON_INODE_JOURNAL_DATA,
>  	EXT4_FC_COMMIT_FAILED,
>  	EXT4_FC_REASON_MAX
>  };
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e67d2fa41a78..9333475737ac 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4340,9 +4340,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  #endif
>  
>  	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
> -		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!\n");
> +		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
>  		/* can't mount with both data=journal and dioread_nolock. */
>  		clear_opt(sb, DIOREAD_NOLOCK);
> +		clear_opt2(sb, JOURNAL_FAST_COMMIT);
>  		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "both data=journal and delalloc");
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 239e98014f9b..ee7362f31eb6 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -104,7 +104,8 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
>  		{ EXT4_FC_REASON_SWAP_BOOT,	"SWAP_BOOT"},		\
>  		{ EXT4_FC_REASON_RESIZE,	"RESIZE"},		\
>  		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
> -		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"})
> +		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"},	\
> +		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"})
>  
>  TRACE_EVENT(ext4_other_inode_update_time,
>  	TP_PROTO(struct inode *inode, ino_t orig_ino),
> @@ -2917,7 +2918,7 @@ TRACE_EVENT(ext4_fc_stats,
>  		    ),
>  
>  	    TP_printk("dev %d:%d fc ineligible reasons:\n"
> -		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
> +		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
>  		      "num_commits:%ld, ineligible: %ld, numblks: %ld",
>  		      MAJOR(__entry->dev), MINOR(__entry->dev),
>  		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> @@ -2928,6 +2929,7 @@ TRACE_EVENT(ext4_fc_stats,
>  		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
>  		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
>  		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
>  		      __entry->sbi->s_fc_stats.fc_num_commits,
>  		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
>  		      __entry->sbi->s_fc_stats.fc_numblks)
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

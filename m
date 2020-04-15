Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8FF1AB270
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 22:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437344AbgDOUZo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 16:25:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:25055 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406376AbgDOUZl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 16:25:41 -0400
IronPort-SDR: yVPEuY4Qwpt25tjwSAsnDpwv1HsYp8sBmYZoBeaDde8i0Yr0vcs2TIJlBd3imBPShaSRdVG2Jl
 JX6y/blQJ71w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 13:25:38 -0700
IronPort-SDR: KxOCebor9wmobYTI5Sf2XTdB9TwGmxyL/7nXSLBqlE0fUVAR9f0jOfbSA7ZSz9aNaYqXK3qg4v
 4s4PDyg/7maw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="332607424"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 13:25:38 -0700
Date:   Wed, 15 Apr 2020 13:25:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, stable@kernel.org,
        syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: reject mount options not supported when remounting
 in handle_mount_opt()
Message-ID: <20200415202537.GA2309605@iweiny-DESK2.sc.intel.com>
References: <to=00000000000098a5d505a34d1e48@google.com>
 <20200415174839.461347-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415174839.461347-1-tytso@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 15, 2020 at 01:48:39PM -0400, Theodore Y. Ts'o wrote:
> Rejecting the mount options in ext4_remount() means that some mount
> options would be enabled for a small amount of time, and then the
> mount option change would be reverted.  In the case of "mount -o
> remount,dax", this can cause a race where files would temporarily
> treated as DAX --- and then not.
> 
> Cc: stable@kernel.org
> Reported-and-tested-by: syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf5fcb477f66..6fe32f9aa889 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1726,6 +1726,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
>  #define MOPT_NO_EXT3	0x0200
>  #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
>  #define MOPT_STRING	0x0400
> +#define MOPT_NO_REMOUNT	0x0800
>  
>  static const struct mount_opts {
>  	int	token;
> @@ -1775,12 +1776,12 @@ static const struct mount_opts {
>  	{Opt_min_batch_time, 0, MOPT_GTE0},
>  	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
>  	{Opt_init_itable, 0, MOPT_GTE0},
> -	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET},
> +	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET | MOPT_NO_REMOUNT},
>  	{Opt_stripe, 0, MOPT_GTE0},
>  	{Opt_resuid, 0, MOPT_GTE0},
>  	{Opt_resgid, 0, MOPT_GTE0},
> -	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0},
> -	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING},
> +	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0 | MOPT_NO_REMOUNT},
> +	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING | MOPT_NO_REMOUNT},
>  	{Opt_journal_ioprio, 0, MOPT_NO_EXT2 | MOPT_GTE0},
>  	{Opt_data_journal, EXT4_MOUNT_JOURNAL_DATA, MOPT_NO_EXT2 | MOPT_DATAJ},
>  	{Opt_data_ordered, EXT4_MOUNT_ORDERED_DATA, MOPT_NO_EXT2 | MOPT_DATAJ},
> @@ -1817,7 +1818,7 @@ static const struct mount_opts {
>  	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
>  	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
>  	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
> -	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET | MOPT_NO_REMOUNT},
>  	{Opt_err, 0, 0}
>  };
>  
> @@ -1915,6 +1916,12 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  			 "Mount option \"%s\" incompatible with ext3", opt);
>  		return -1;
>  	}
> +	if ((m->flags & MOPT_NO_REMOUNT) && is_remount) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Mount option \"%s\" not supported when remounting",
> +			 opt);
> +		return -1;
> +	}
>  
>  	if (args->from && !(m->flags & MOPT_STRING) && match_int(args, &arg))
>  		return -1;
> @@ -1994,11 +2001,6 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  		}
>  		sbi->s_resgid = gid;
>  	} else if (token == Opt_journal_dev) {
> -		if (is_remount) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Cannot specify journal on remount");
> -			return -1;
> -		}
>  		*journal_devnum = arg;
>  	} else if (token == Opt_journal_path) {
>  		char *journal_path;
> @@ -2006,11 +2008,6 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  		struct path path;
>  		int error;
>  
> -		if (is_remount) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Cannot specify journal on remount");
> -			return -1;
> -		}
>  		journal_path = match_strdup(&args[0]);
>  		if (!journal_path) {
>  			ext4_msg(sb, KERN_ERR, "error: could not dup "
> @@ -5427,18 +5424,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  		}
>  	}
>  
> -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_NO_MBCACHE) {
> -		ext4_msg(sb, KERN_ERR, "can't enable nombcache during remount");
> -		err = -EINVAL;
> -		goto restore_opts;
> -	}
> -
> -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX) {
> -		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
> -			"dax flag with busy inodes while remounting");
> -		sbi->s_mount_opt ^= EXT4_MOUNT_DAX;
> -	}

I like the simplification but I'm confused...

This fundamentally changes the behavior from forcing the dax mode to be the
same across the remount to only failing if we are going from non-dax to dax,
adding -o dax on the remount?

But going from -o dax to 'not -o dax' would be ok?

FWIW after thinking about it some I _think_ it would be ok to allow the dax
mode to change on a remount and let the inodes in memory stay in the mode they
are at.  And newly loaded inodes would get the new mode...  Unfortunately
without the STATX patch I have proposed the user does not have any way of
knowing which files are in which mode.

Ira

> -
>  	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
>  		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
>  
> -- 
> 2.24.1
> 

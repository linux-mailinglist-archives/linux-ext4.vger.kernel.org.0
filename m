Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF172A42B5
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgKCKeI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 05:34:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:37028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgKCKeA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 05:34:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8182EACC6;
        Tue,  3 Nov 2020 10:33:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 374861E12FB; Tue,  3 Nov 2020 11:33:59 +0100 (CET)
Date:   Tue, 3 Nov 2020 11:33:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 01/10] ext4: describe fast_commit feature flags
Message-ID: <20201103103359.GD3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-2-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:09, Harshad Shirwadkar wrote:
> Fast commit feature has flags in the file system as well in JBD2. The
> meaning of fast commit feature flags can get confusing. Update docs
> and code to add more documentation about it.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good to me. Thanks! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/ext4/journal.rst | 6 ++++++
>  Documentation/filesystems/ext4/super.rst   | 7 +++++++
>  fs/ext4/ext4.h                             | 7 +++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> index 805a1e9ea3a5..849d5b119eb8 100644
> --- a/Documentation/filesystems/ext4/journal.rst
> +++ b/Documentation/filesystems/ext4/journal.rst
> @@ -256,6 +256,10 @@ which is 1024 bytes long:
>       - s\_padding2
>       -
>     * - 0x54
> +     - \_\_be32
> +     - s\_num\_fc\_blocks
> +     - Number of fast commit blocks in the journal.
> +   * - 0x58
>       - \_\_u32
>       - s\_padding[42]
>       -
> @@ -310,6 +314,8 @@ The journal incompat features are any combination of the following:
>       - This journal uses v3 of the checksum on-disk format. This is the same as
>         v2, but the journal block tag size is fixed regardless of the size of
>         block numbers. (JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3)
> +   * - 0x20
> +     - Journal has fast commit blocks. (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT)
>  
>  .. _jbd2_checksum_type:
>  
> diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
> index 93e55d7c1d40..2eb1ab20498d 100644
> --- a/Documentation/filesystems/ext4/super.rst
> +++ b/Documentation/filesystems/ext4/super.rst
> @@ -596,6 +596,13 @@ following:
>       - Sparse Super Block, v2. If this flag is set, the SB field s\_backup\_bgs
>         points to the two block groups that contain backup superblocks
>         (COMPAT\_SPARSE\_SUPER2).
> +   * - 0x400
> +     - Fast commits supported. Although fast commits blocks are
> +       backward incompatible, fast commit blocks are not always
> +       present in the journal. If fast commit blocks are present in
> +       the journal, JBD2 incompat feature
> +       (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT) gets
> +       set (COMPAT\_FAST\_COMMIT).
>  
>  .. _super_incompat:
>  
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2337e443fa30..12673f9ec880 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1875,6 +1875,13 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>  #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
>  #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
>  #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
> +/*
> + * The reason why "FAST_COMMIT" is a compat feature is that, FS becomes
> + * incompatible only if fast commit blocks are present in the FS. Since we
> + * clear the journal (and thus the fast commit blocks), we don't mark FS as
> + * incompatible. We also have a JBD2 incompat feature, which gets set when
> + * there are fast commit blocks present in the journal.
> + */
>  #define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
>  #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
>  
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

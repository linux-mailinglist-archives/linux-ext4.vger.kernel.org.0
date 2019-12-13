Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C511E23E
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLMKoH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 05:44:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfLMKoG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Dec 2019 05:44:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8893CAD49;
        Fri, 13 Dec 2019 10:44:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25AFE1E0CAF; Fri, 13 Dec 2019 11:44:04 +0100 (CET)
Date:   Fri, 13 Dec 2019 11:44:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH] ext4: uninline ext4_inode_journal_mode()
Message-ID: <20191213104404.GB15474@quack2.suse.cz>
References: <20191209233602.117778-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209233602.117778-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 09-12-19 15:36:02, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Determining an inode's journaling mode has gotten more complicated over
> time.  Move ext4_inode_journal_mode() from an inline function into
> ext4_jbd2.c to reduce the compiled code size.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Yeah, you're right. The function is pretty big and used quite a lot. Also
I'm not aware of any place where the additional function call would make a
noticeable performance difference. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.c | 22 ++++++++++++++++++++++
>  fs/ext4/ext4_jbd2.h | 22 +---------------------
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index d3b8cdea5df75..621c9e19d081f 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -7,6 +7,28 @@
>  
>  #include <trace/events/ext4.h>
>  
> +int ext4_inode_journal_mode(struct inode *inode)
> +{
> +	if (EXT4_JOURNAL(inode) == NULL)
> +		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
> +	/* We do not support data journalling with delayed allocation */
> +	if (!S_ISREG(inode->i_mode) ||
> +	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
> +	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> +	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> +	    !test_opt(inode->i_sb, DELALLOC))) {
> +		/* We do not support data journalling for encrypted data */
> +		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
> +			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> +		return EXT4_INODE_JOURNAL_DATA_MODE;	/* journal data */
> +	}
> +	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
> +		return EXT4_INODE_ORDERED_DATA_MODE;	/* ordered */
> +	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
> +		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
> +	BUG();
> +}
> +
>  /* Just increment the non-pointer handle value */
>  static handle_t *ext4_get_nojournal(void)
>  {
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index a6b9b66dbfade..7ea4f6fa173b4 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -463,27 +463,7 @@ int ext4_force_commit(struct super_block *sb);
>  #define EXT4_INODE_ORDERED_DATA_MODE	0x02 /* ordered data mode */
>  #define EXT4_INODE_WRITEBACK_DATA_MODE	0x04 /* writeback data mode */
>  
> -static inline int ext4_inode_journal_mode(struct inode *inode)
> -{
> -	if (EXT4_JOURNAL(inode) == NULL)
> -		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
> -	/* We do not support data journalling with delayed allocation */
> -	if (!S_ISREG(inode->i_mode) ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
> -	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> -	    !test_opt(inode->i_sb, DELALLOC))) {
> -		/* We do not support data journalling for encrypted data */
> -		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
> -			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> -		return EXT4_INODE_JOURNAL_DATA_MODE;	/* journal data */
> -	}
> -	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
> -		return EXT4_INODE_ORDERED_DATA_MODE;	/* ordered */
> -	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
> -		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
> -	BUG();
> -}
> +int ext4_inode_journal_mode(struct inode *inode);
>  
>  static inline int ext4_should_journal_data(struct inode *inode)
>  {
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

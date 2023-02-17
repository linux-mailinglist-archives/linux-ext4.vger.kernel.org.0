Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDB69A9F7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 12:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBQLM5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 06:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBQLM4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 06:12:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE3FF3C
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 03:12:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DCDEE226E6;
        Fri, 17 Feb 2023 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676632260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZEdl4BquxjJAFlMQwB9ZDvj60r8+MlEjs3/0xteS80=;
        b=F4LVHcx3MCKlescY4DpCU/5EFWlfT0LrZZShaFZ6858QzfF2jFu3Gr6yjfQEgzoNDaWJ/p
        CnPLNWjf27iB/r82sZds6qSIXVd6y+udjddj+aRWdeZOBpYNnh3k6iikVWwfWNTQQ1UT2i
        p8fsndDMi7X6Y91wO8hJGz6w2EDA4BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676632260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZEdl4BquxjJAFlMQwB9ZDvj60r8+MlEjs3/0xteS80=;
        b=91fOVS0smy+GaKiGlwqojlzKH886oj0c37ZV6NSyTgnJPiqEOzK3+fDnzdNd/dcQhydQF+
        WTVZpBFUcqm0fjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFD75138E3;
        Fri, 17 Feb 2023 11:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iZe9MsRg72MnQwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:11:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7238EA06E1; Fri, 17 Feb 2023 12:11:00 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:11:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] tune2fs/fuse2fs/debugfs: save error information
 during journal replay
Message-ID: <20230217111100.m36cuxqnvmr7fejx@quack3>
References: <20230217100922.588961-1-libaokun1@huawei.com>
 <20230217100922.588961-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217100922.588961-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-02-23 18:09:22, Baokun Li wrote:
> Saving error information during journal replay, as in the kernel,
> prevents information loss from making problems difficult to locate.
> We save these error information until someone uses e2fsck to check
> for and fix possible errors.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  debugfs/journal.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index 5bac0d3b..79e3fff8 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -789,6 +789,8 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>  	char *fsname;
>  	int fsflags;
>  	int fsblocksize;
> +	char *save;
> +	__u16 s_error_state;
>  
>  	if (!(fs->flags & EXT2_FLAG_RW))
>  		return EXT2_ET_FILE_RO;
> @@ -808,6 +810,12 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>  	if (stats && stats->bytes_written)
>  		kbytes_written = stats->bytes_written >> 10;
>  
> +	save = malloc(EXT4_S_ERR_LEN);
> +	if (save)
> +		memcpy(save, ((char *) fs->super) + EXT4_S_ERR_START,
> +		       EXT4_S_ERR_LEN);
> +	s_error_state = fs->super->s_state & EXT2_ERROR_FS;
> +
>  	ext2fs_mmp_stop(fs);
>  	fsname = fs->device_name;
>  	fs->device_name = NULL;
> @@ -818,11 +826,15 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>  	retval = ext2fs_open(fsname, fsflags, 0, fsblocksize, io_ptr, fsp);
>  	ext2fs_free_mem(&fsname);
>  	if (retval)
> -		return retval;
> +		goto outfree;
>  
>  	fs = *fsp;
>  	fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>  	fs->super->s_kbytes_written += kbytes_written;
> +	fs->super->s_state |= s_error_state;
> +	if (save)
> +		memcpy(((char *) fs->super) + EXT4_S_ERR_START, save,
> +		       EXT4_S_ERR_LEN);
>  
>  	/* Set the superblock flags */
>  	ext2fs_clear_recover(fs, recover_retval != 0);
> @@ -832,6 +844,9 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>  	 * the EXT2_ERROR_FS flag in the fs superblock if needed.
>  	 */
>  	retval = ext2fs_check_ext3_journal(fs);
> +
> +outfree:
> +	free(save);
>  	return retval ? retval : recover_retval;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

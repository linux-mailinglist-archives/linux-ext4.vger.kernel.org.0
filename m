Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A2741433
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjF1Osj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjF1Osi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 10:48:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5829A1984;
        Wed, 28 Jun 2023 07:48:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D04D41F37F;
        Wed, 28 Jun 2023 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687963715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaXdh1KFTwTLnhJwlh22gGE6uZWJAZgaTyJ+Wnl5PrI=;
        b=ZDOhglrGlDcNdFdJmzW5ldZVObsj152LZ1rLfrgDVl5t/jtmGgqTC/v0wgnoepQUMttCHc
        ht3bC98w+gqe6x9OSSOxeD05G0t6pu73pjgu7dEz5Qzg4qIziuRG00hy4MMUKnY2q/qFDN
        x+EbtboXktwgc171b7G1ygMvof4RXXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687963715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaXdh1KFTwTLnhJwlh22gGE6uZWJAZgaTyJ+Wnl5PrI=;
        b=9ZnE9EhSJZ5yUfMsIaKwnusgg8eBTrzElFboY4+OuhYoVEBzwWLFdzZtSaqv2X69xwoqS4
        Cc0nTGAmp3TgxcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1FDE138EF;
        Wed, 28 Jun 2023 14:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id epVRL0NInGQoKwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 14:48:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2E529A0707; Wed, 28 Jun 2023 16:48:35 +0200 (CEST)
Date:   Wed, 28 Jun 2023 16:48:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix unttached inode after power cut with orphan
 file feature enabled
Message-ID: <20230628144835.fqhmbpxoj6fee762@quack3>
References: <20230628132011.650383-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628132011.650383-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 28-06-23 21:20:11, Zhihao Cheng wrote:
> Running generic/475(filesystem consistent tests after power cut) could
> easily trigger unattached inode error while doing fsck:
>   Unattached zero-length inode 39405.  Clear? no
> 
>   Unattached inode 39405
>   Connect to /lost+found? no
> 
> Above inconsistence is caused by following process:
>        P1                       P2
> ext4_create
>  inode = ext4_new_inode_start_handle  // itable records nlink=1
>  ext4_add_nondir
>    err = ext4_add_entry  // ENOSPC
>     ext4_append
>      ext4_bread
>       ext4_getblk
>        ext4_map_blocks // returns ENOSPC
>    drop_nlink(inode) // won't be updated into disk inode
>    ext4_orphan_add(handle, inode)
>     ext4_orphan_file_add
>  ext4_journal_stop(handle)
> 		      jbd2_journal_commit_transaction // commit success
>               >> power cut <<
> ext4_fill_super
>  ext4_load_and_init_journal   // itable records nlink=1
>  ext4_orphan_cleanup
>   ext4_process_orphan
>    if (inode->i_nlink)        // true, inode won't be deleted
> 
> Then, allocated inode will be reserved on disk and corresponds to no
> dentries, so e2fsck reports 'unattached inode' problem.
> 
> The problem won't happen if orphan file feature is disabled, because
> ext4_orphan_add() will update disk inode in orphan list mode. There
> are several places not updating disk inode while putting inode into
> orphan area, such as ext4_add_nondir(), ext4_symlink() and whiteout
> in ext4_rename(). Fix it by updating inode into disk in all error
> branches of these places.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217605
> Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Nice catch. Thanks for fixing this. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..6bcc3770ee19 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2799,6 +2799,7 @@ static int ext4_add_nondir(handle_t *handle,
>  		return err;
>  	}
>  	drop_nlink(inode);
> +	ext4_mark_inode_dirty(handle, inode);
>  	ext4_orphan_add(handle, inode);
>  	unlock_new_inode(inode);
>  	return err;
> @@ -3436,6 +3437,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  
>  err_drop_inode:
>  	clear_nlink(inode);
> +	ext4_mark_inode_dirty(handle, inode);
>  	ext4_orphan_add(handle, inode);
>  	unlock_new_inode(inode);
>  	if (handle)
> @@ -4021,6 +4023,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			ext4_resetent(handle, &old,
>  				      old.inode->i_ino, old_file_type);
>  			drop_nlink(whiteout);
> +			ext4_mark_inode_dirty(handle, whiteout);
>  			ext4_orphan_add(handle, whiteout);
>  		}
>  		unlock_new_inode(whiteout);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

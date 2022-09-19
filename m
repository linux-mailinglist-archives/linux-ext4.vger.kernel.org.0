Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F15BC49A
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiISIrZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiISIrY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 04:47:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8CE09F;
        Mon, 19 Sep 2022 01:47:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAC5F224BA;
        Mon, 19 Sep 2022 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663577241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ff0uszg6kyjjELlo/PJR1UpnAEFAdUb1P9UtheARqeY=;
        b=ybSjSH+xjpYZL9EWarkl3iGp0mLiDA5WSleqvEt2dyXx6+UJSDixMbiD54XnJ6Q8VC8bW7
        NAyJSs056lV36Snr29IfLMDw2LQqGVjcKTFBNyCcL1lCvqGdkXZPDeuOVRhbttdaS/NHJ6
        6bGMccorMoy4Lr0SysybNOf0CpiG29g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663577241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ff0uszg6kyjjELlo/PJR1UpnAEFAdUb1P9UtheARqeY=;
        b=ae0bScQ44D8sXI7cvTQwCfPfacrwk658Bz6JTu2BJ8PA9p3aHNAuA1lJH8PxI1Ndabwhfl
        GMvUwT+u/tPdx0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BD2C13A96;
        Mon, 19 Sep 2022 08:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nuz/JZksKGPzQgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 08:47:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 31B7FA0682; Mon, 19 Sep 2022 10:47:21 +0200 (CEST)
Date:   Mon, 19 Sep 2022 10:47:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 1/2] ext4: factor out ext4_fc_disabled()
Message-ID: <20220919084721.ofhjs2ah4aihwpyd@quack3>
References: <20220916083836.388347-1-yebin10@huawei.com>
 <20220916083836.388347-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916083836.388347-2-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-09-22 16:38:35, Ye Bin wrote:
> Factor out ext4_fc_disabled(). No functional change.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b7414a5812f6..eadab945b856 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -229,6 +229,12 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
>  	finish_wait(wq, &wait.wq_entry);
>  }
>  
> +static bool ext4_fc_disabled(struct super_block *sb)
> +{
> +	return (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> +		(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY));
> +}
> +
>  /*
>   * Inform Ext4's fast about start of an inode update
>   *
> @@ -240,8 +246,7 @@ void ext4_fc_start_update(struct inode *inode)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  restart:
> @@ -265,8 +270,7 @@ void ext4_fc_stop_update(struct inode *inode)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  	if (atomic_dec_and_test(&ei->i_fc_updates))
> @@ -283,8 +287,7 @@ void ext4_fc_del(struct inode *inode)
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct ext4_fc_dentry_update *fc_dentry;
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  restart:
> @@ -337,8 +340,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	tid_t tid;
>  
> -	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> -	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(sb))
>  		return;
>  
>  	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> @@ -493,10 +495,8 @@ void __ext4_fc_track_unlink(handle_t *handle,
>  void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (sbi->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> @@ -522,10 +522,8 @@ void __ext4_fc_track_link(handle_t *handle,
>  void ext4_fc_track_link(handle_t *handle, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (sbi->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> @@ -551,10 +549,8 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
>  void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (sbi->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> @@ -576,7 +572,6 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
>  
>  void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	int ret;
>  
>  	if (S_ISDIR(inode->i_mode))
> @@ -588,8 +583,7 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  		return;
>  	}
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (sbi->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> @@ -634,15 +628,13 @@ static int __track_range(struct inode *inode, void *arg, bool update)
>  void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
>  			 ext4_lblk_t end)
>  {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct __track_range_args args;
>  	int ret;
>  
>  	if (S_ISDIR(inode->i_mode))
>  		return;
>  
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (sbi->s_mount_state & EXT4_FC_REPLAY))
> +	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

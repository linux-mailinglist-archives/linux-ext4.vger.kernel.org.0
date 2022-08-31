Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED895A7C67
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiHaLrs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiHaLrr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:47:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D4AC04EF
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:47:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF2A41F9BC;
        Wed, 31 Aug 2022 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XaHqhPS2OfxPMF9Ae5EnZPVWECSl989D854zuNL6ow=;
        b=SjtGLVVy0LIhFKiZ+8B5LNNpnNztWYW5DCz9d3Ci0724t5nlLGvcihb01R0UZvJrVzQx/o
        eWmFSBy8iQD0fCGM6mGYPP9ErKAgmI/fVo8YOc/CcrF8bnlHEmN7pvloZDne0U9iy11c7C
        p9FXZlVoDcM6xgHEoguQJk3On60adgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XaHqhPS2OfxPMF9Ae5EnZPVWECSl989D854zuNL6ow=;
        b=9Y4eoexLPakWBsQOu9HZI+fBjOGQ1fzNhDVogZda/JQhsF7FYCT0JACTnXgJQ2Kg4ntmzo
        QnxbQGk2EbIYCrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912321332D;
        Wed, 31 Aug 2022 11:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1dxtI15KD2P5BwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:47:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12228A067B; Wed, 31 Aug 2022 13:47:42 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:47:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 05/13] ext4: factor out ext4_fast_commit_init()
Message-ID: <20220831114742.d2ivd2f6geugorpt@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-6-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-6-yanaijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:03, Jason Yan wrote:
> Factor out ext4_fast_commit_init(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Why not :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1855559be4f2..d355eda2f184 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4424,6 +4424,30 @@ static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
>  	return 0;
>  }
>  
> +static void ext4_fast_commit_init(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	/* Initialize fast commit stuff */
> +	atomic_set(&sbi->s_fc_subtid, 0);
> +	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
> +	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
> +	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
> +	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
> +	sbi->s_fc_bytes = 0;
> +	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> +	sbi->s_fc_ineligible_tid = 0;
> +	spin_lock_init(&sbi->s_fc_lock);
> +	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
> +	sbi->s_fc_replay_state.fc_regions = NULL;
> +	sbi->s_fc_replay_state.fc_regions_size = 0;
> +	sbi->s_fc_replay_state.fc_regions_used = 0;
> +	sbi->s_fc_replay_state.fc_regions_valid = 0;
> +	sbi->s_fc_replay_state.fc_modified_inodes = NULL;
> +	sbi->s_fc_replay_state.fc_modified_inodes_size = 0;
> +	sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -5059,24 +5083,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
>  	mutex_init(&sbi->s_orphan_lock);
>  
> -	/* Initialize fast commit stuff */
> -	atomic_set(&sbi->s_fc_subtid, 0);
> -	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
> -	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
> -	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
> -	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
> -	sbi->s_fc_bytes = 0;
> -	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> -	sbi->s_fc_ineligible_tid = 0;
> -	spin_lock_init(&sbi->s_fc_lock);
> -	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
> -	sbi->s_fc_replay_state.fc_regions = NULL;
> -	sbi->s_fc_replay_state.fc_regions_size = 0;
> -	sbi->s_fc_replay_state.fc_regions_used = 0;
> -	sbi->s_fc_replay_state.fc_regions_valid = 0;
> -	sbi->s_fc_replay_state.fc_modified_inodes = NULL;
> -	sbi->s_fc_replay_state.fc_modified_inodes_size = 0;
> -	sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
> +	ext4_fast_commit_init(sb);
>  
>  	sb->s_root = NULL;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

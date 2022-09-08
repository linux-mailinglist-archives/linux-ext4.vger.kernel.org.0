Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880C75B1772
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiIHIps (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiIHIpr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:45:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C9B9FB9
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:45:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so1658581pjm.1
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ri92a546142wxYSAbihL51Q9rFJ0w4sAKy3r2PkwTi4=;
        b=mRdYiB1RmxUr5daKjA9EialZeRTG+buUtJyzkWh3ZvW5hkLbm3cIIrvi+WJ0w4fRZN
         YTW+Gg4rMqCc1vNMvbz1mKqF+PjcZ6ja7ubN9ukOVKTmuimmGG1kWiDqSf8PSJWEqTBM
         sJoqNFwEuJLi0PKBBGhUY3/pOMhxTEcsUA7E/2tgZ4mIhf8H9FlZWKxr65daf+F7Mlmz
         +p6nksc75dUdJWdCYAH14pHVMLJZ/5eWFzsw6rQITyUvfCYzXWobI+viQ6zk1G9b5BSF
         4ymROcRiCt0A/o+cv6rqurFQlpp7E8oZkrKbeL1NRYywrKappeq9+f8Vv64mPUBQ+rnS
         vDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ri92a546142wxYSAbihL51Q9rFJ0w4sAKy3r2PkwTi4=;
        b=nStW1W908eOsluvPIOOgX1bxvyrwn5FZM0uK8nKXfjhFk+x00o/B1t7wmPouq8DH3C
         fch843xTBlunsd6H9s1hm/1DpEJzXcDi0LdSnw/gX6mUyExfP3LaWr2eLTtgdgt3kTik
         Wq/xxXs4HmCrIwDPZMW83tMbw4u0afx5D0k+DMwYeYzxUUjJq1w6sjKx4uRJlUn2upon
         kCcv9zx/ZP3Zc4rRMPVpD0EOuRjAtHhYSypJ5ADaguFPb4flhSLNBL0GhpD3fyYJONw6
         BWW9+cvc8gGF+47VzhDe7np5V8GTufggIY69PMsaRLRSTyAsS7qEPuxnKpAnQxEm+jey
         9UoQ==
X-Gm-Message-State: ACgBeo1Hs6BKx8Ph50VCftayYZufxia9Jn9ceVfainx6gG3QQ2JrB0vh
        LI5Hh0JeeRvdo/jLIXS0EFo=
X-Google-Smtp-Source: AA6agR7CiCZOy3O7tny6BokRAKwDr3SoMuKgJ4tXy63x4d2mpLYMT7/R1V6318y9vn7Q/NRxw0wWhQ==
X-Received: by 2002:a17:902:ce12:b0:172:dc6e:18f6 with SMTP id k18-20020a170902ce1200b00172dc6e18f6mr7877640plg.34.1662626745243;
        Thu, 08 Sep 2022 01:45:45 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b00174849e6914sm14022363plh.191.2022.09.08.01.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:45:44 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:15:39 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/13] ext4: factor out ext4_fast_commit_init()
Message-ID: <20220908084539.4xtpxlwwmaumut5d@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-6-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-6-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> Factor out ext4_fast_commit_init(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)

Nice cleanups. 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 09b3c51d472b..3d58c2d889d5 100644
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

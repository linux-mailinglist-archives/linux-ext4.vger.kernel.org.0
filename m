Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C47680BA8
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jan 2023 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjA3LLm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Jan 2023 06:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjA3LLm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Jan 2023 06:11:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80EA27F
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 03:11:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5714D1FE32;
        Mon, 30 Jan 2023 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675077099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8RRsqT1gFfC5+gRrvDBhtDx+vtcX+aG87AnJ8F7LUc=;
        b=hMGfbJJZZLeHt+M44ToimITJkez2m4JyELWWBPkdBa+aRlEjWQRPsMtK1H30O8MFPHPWbH
        klkVGIJP8nTnLYREhvnvGZVS64xUwcDN9Fc9HCF61VhK44cr2s4znRnXLCeYAXKElbKnDB
        VUhO4a4/svUweRNU3gSdpobcUhJlrTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675077099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8RRsqT1gFfC5+gRrvDBhtDx+vtcX+aG87AnJ8F7LUc=;
        b=tzqfO01BDXRvriOxyuAJAC5dsJmUNVfB0OzZmH1fFBjjR3g9iQrIeHONEu2lIHeU0kvea8
        gUb9t5fG7kQR01Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4806613A06;
        Mon, 30 Jan 2023 11:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXmLEeul12MoHQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 30 Jan 2023 11:11:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6578A0778; Mon, 30 Jan 2023 12:11:38 +0100 (CET)
Date:   Mon, 30 Jan 2023 12:11:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz,
        harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix incorrect options show of original mount_opt
 and extend mount_opt2
Message-ID: <20230130111138.76tp6pij3yhh4brh@quack3>
References: <20230129034939.3702550-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129034939.3702550-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 29-01-23 11:49:39, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current _ext4_show_options() do not distinguish MOPT_2 flag, so it mixed
> extend sbi->s_mount_opt2 options with sbi->s_mount_opt, it could lead to
> show incorrect options, e.g. show fc_debug_force if we mount with
> errors=continue mode and miss it if we set.
> 
>   $ mkfs.ext4 /dev/pmem0
>   $ mount -o errors=remount-ro /dev/pmem0 /mnt
>   $ cat /proc/fs/ext4/pmem0/options | grep fc_debug_force
>     #empty
>   $ mount -o remount,errors=continue /mnt
>   $ cat /proc/fs/ext4/pmem0/options | grep fc_debug_force
>     fc_debug_force
>   $ mount -o remount,errors=remount-ro,fc_debug_force /mnt
>   $ cat /proc/fs/ext4/pmem0/options | grep fc_debug_force
>     #empty
> 
> Fixes: 995a3ed67fc8 ("ext4: add fast_commit feature and handling for extended mount options")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/super.c | 28 +++++++++++++++++++++-------
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..6479146140d2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1529,6 +1529,7 @@ struct ext4_sb_info {
>  	unsigned int s_mount_opt2;
>  	unsigned long s_mount_flags;
>  	unsigned int s_def_mount_opt;
> +	unsigned int s_def_mount_opt2;
>  	ext4_fsblk_t s_sb_block;
>  	atomic64_t s_resv_clusters;
>  	kuid_t s_resuid;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 260c1b3e3ef2..e6fe416a65a3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2894,7 +2894,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_super_block *es = sbi->s_es;
> -	int def_errors, def_mount_opt = sbi->s_def_mount_opt;
> +	int def_errors;
>  	const struct mount_opts *m;
>  	char sep = nodefs ? '\n' : ',';
>  
> @@ -2906,15 +2906,28 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  
>  	for (m = ext4_mount_opts; m->token != Opt_err; m++) {
>  		int want_set = m->flags & MOPT_SET;
> +		int opt_2 = m->flags & MOPT_2;
> +		unsigned int mount_opt, def_mount_opt;
> +
>  		if (((m->flags & (MOPT_SET|MOPT_CLEAR)) == 0) ||
>  		    m->flags & MOPT_SKIP)
>  			continue;
> -		if (!nodefs && !(m->mount_opt & (sbi->s_mount_opt ^ def_mount_opt)))
> -			continue; /* skip if same as the default */
> +
> +		if (opt_2) {
> +			mount_opt = sbi->s_mount_opt2;
> +			def_mount_opt = sbi->s_def_mount_opt2;
> +		} else {
> +			mount_opt = sbi->s_mount_opt;
> +			def_mount_opt = sbi->s_def_mount_opt;
> +		}
> +		/* skip if same as the default */
> +		if (!nodefs && !(m->mount_opt & (mount_opt ^ def_mount_opt)))
> +			continue;
> +		/* select Opt_noFoo vs Opt_Foo */
>  		if ((want_set &&
> -		     (sbi->s_mount_opt & m->mount_opt) != m->mount_opt) ||
> -		    (!want_set && (sbi->s_mount_opt & m->mount_opt)))
> -			continue; /* select Opt_noFoo vs Opt_Foo */
> +		     (mount_opt & m->mount_opt) != m->mount_opt) ||
> +		    (!want_set && (mount_opt & m->mount_opt)))
> +			continue;
>  		SEQ_OPTS_PRINT("%s", token2str(m->token));
>  	}
>  
> @@ -2942,7 +2955,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	if (nodefs || sbi->s_stripe)
>  		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
>  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> -			(sbi->s_mount_opt ^ def_mount_opt)) {
> +			(sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
>  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
>  			SEQ_OPTS_PUTS("data=journal");
>  		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
> @@ -5086,6 +5099,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount;
>  
>  	sbi->s_def_mount_opt = sbi->s_mount_opt;
> +	sbi->s_def_mount_opt2 = sbi->s_mount_opt2;
>  
>  	err = ext4_check_opt_consistency(fc, sb);
>  	if (err < 0)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

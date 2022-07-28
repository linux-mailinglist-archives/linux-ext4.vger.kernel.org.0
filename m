Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF153583B50
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiG1Jfk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jul 2022 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiG1Jfi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Jul 2022 05:35:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99A65D47
        for <linux-ext4@vger.kernel.org>; Thu, 28 Jul 2022 02:35:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48F50345E7;
        Thu, 28 Jul 2022 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659000936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOCCR6VsFaKf7gwfYA1f8qaSGg5iLo750ZQdlSPR91s=;
        b=gT+Fj9ADZy4tDokKk2DFqplzUjLoacbOyY00N0w3hz9HeH4IDk+RVuiLkhAi/Fv8w1hSGo
        SIQK2KWq0LwLBVkU2Ye2RLflmAvsuvAbo3FxiLoSrxb45hOe0RqzZdmXEOdiQF61UkNH7d
        LgmrcVM8g8PX2rRcr2MQWzh2HLbHbKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659000936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOCCR6VsFaKf7gwfYA1f8qaSGg5iLo750ZQdlSPR91s=;
        b=JhodxkBaJXY99npoaZndEYizcAIhiHbTSGKsUQ0W3wCa8/5jW9MRrXLRuB+xJAoCqUY4K/
        WfCKHpfve/y0OdAg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1F0802C141;
        Thu, 28 Jul 2022 09:35:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B2CDA0664; Thu, 28 Jul 2022 11:35:35 +0200 (CEST)
Date:   Thu, 28 Jul 2022 11:35:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, lczerner@redhat.com,
        djwong@kernel.org, jlayton@kernel.org, jack@suse.cz
Subject: Re: [PATCH v1] ext4: Remove deprecated noacl/nouser_xattr options
Message-ID: <20220728093535.6bus4bvkxi3zzs5a@quack3>
References: <1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 28-07-22 11:02:49, Yang Xu wrote:
> These two options should have been removed since 3.5, but none notices it.
> Recently, I and Darrick found this. Also, have some discussion for this[1][2][3].
> 
> So now, let's remove them.
> 
> Link: https://lore.kernel.org/linux-ext4/6258F7BB.8010104@fujitsu.com/T/#u[1]
> Link: https://lore.kernel.org/linux-ext4/20220602110421.ymoug3rwfspmryqg@fedora/T/#t[2]
> Link: https://lore.kernel.org/linux-ext4/08e2ca4c8f6344bdcd76d75b821116c6147fd57a.camel@kernel.org/T/#t[3]
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Yeah, long overdue :) Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 845f2f8aee5f..1eff864069c1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1576,7 +1576,7 @@ enum {
>  	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
>  	Opt_resgid, Opt_resuid, Opt_sb,
>  	Opt_nouid32, Opt_debug, Opt_removed,
> -	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
> +	Opt_user_xattr, Opt_acl,
>  	Opt_auto_da_alloc, Opt_noauto_da_alloc, Opt_noload,
>  	Opt_commit, Opt_min_batch_time, Opt_max_batch_time, Opt_journal_dev,
>  	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
> @@ -1662,9 +1662,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  	fsparam_flag	("oldalloc",		Opt_removed),
>  	fsparam_flag	("orlov",		Opt_removed),
>  	fsparam_flag	("user_xattr",		Opt_user_xattr),
> -	fsparam_flag	("nouser_xattr",	Opt_nouser_xattr),
>  	fsparam_flag	("acl",			Opt_acl),
> -	fsparam_flag	("noacl",		Opt_noacl),
>  	fsparam_flag	("norecovery",		Opt_noload),
>  	fsparam_flag	("noload",		Opt_noload),
>  	fsparam_flag	("bh",			Opt_removed),
> @@ -1814,13 +1812,10 @@ static const struct mount_opts {
>  	{Opt_journal_ioprio, 0, MOPT_NO_EXT2},
>  	{Opt_data, 0, MOPT_NO_EXT2},
>  	{Opt_user_xattr, EXT4_MOUNT_XATTR_USER, MOPT_SET},
> -	{Opt_nouser_xattr, EXT4_MOUNT_XATTR_USER, MOPT_CLEAR},
>  #ifdef CONFIG_EXT4_FS_POSIX_ACL
>  	{Opt_acl, EXT4_MOUNT_POSIX_ACL, MOPT_SET},
> -	{Opt_noacl, EXT4_MOUNT_POSIX_ACL, MOPT_CLEAR},
>  #else
>  	{Opt_acl, 0, MOPT_NOSUPPORT},
> -	{Opt_noacl, 0, MOPT_NOSUPPORT},
>  #endif
>  	{Opt_nouid32, EXT4_MOUNT_NO_UID32, MOPT_SET},
>  	{Opt_debug, EXT4_MOUNT_DEBUG, MOPT_SET},
> @@ -2120,10 +2115,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		else
>  			return note_qf_name(fc, GRPQUOTA, param);
>  #endif
> -	case Opt_noacl:
> -	case Opt_nouser_xattr:
> -		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
> -		break;
>  	case Opt_sb:
>  		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
>  			ext4_msg(NULL, KERN_WARNING,
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

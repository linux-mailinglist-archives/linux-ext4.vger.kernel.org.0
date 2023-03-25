Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37506C8FB3
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Mar 2023 18:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCYRNV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Mar 2023 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYRNU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Mar 2023 13:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16544EC4B
        for <linux-ext4@vger.kernel.org>; Sat, 25 Mar 2023 10:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8946560C86
        for <linux-ext4@vger.kernel.org>; Sat, 25 Mar 2023 17:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C08C433D2;
        Sat, 25 Mar 2023 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679764398;
        bh=q+ORIbz2Assz2rdlyn8GCpkWKvOZ73XapqfkGHfnDBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQXpxZgySK2Fiz5MmzJzAsA1zaC2o1rrb+hN3H2BVWsjMMUEjQRwLrcILRkAGsN+a
         FfUx5VbxSRhE109AmooHpHABNck19uENB3q+eb9HcrfmjFFa4ygMi3MZi30uDHliXH
         9/DuHKdFVuFsaOYjIWGTkjU3GMPbJQZ5TkQQeG05yFW4wvpQBH6Xq+HFeZ4K9IHfq0
         GG6vrVJYbTSN9JrdUX4BruOrWTuQcyqYdX7xVWzkZtbwmggMDCq09eAC89E/3/lFpn
         2VsBy1MOljsN+wtF3w0FqgB7LJ07TKH0u/sip+pcCkyqaV3GAOntnZPoFTdg94kSKn
         rJCPbn57mtxZg==
Date:   Sat, 25 Mar 2023 10:13:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        louhongxiang@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH 2/2] e2fsck: add sync error handle to e2fsck.
Message-ID: <20230325171318.GA16162@frogsfrogsfrogs>
References: <20230325065652.2111384-1-zhanchengbin1@huawei.com>
 <20230325065652.2111384-3-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325065652.2111384-3-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 25, 2023 at 02:56:52PM +0800, zhanchengbin wrote:
> If fsync fails during fsck, it is silent and users will not perceive it, so
> a function to handle fsync failure should be added to fsck.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>  e2fsck/ehandler.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/e2fsck/ehandler.c b/e2fsck/ehandler.c
> index 71ca301c..ae35f3ef 100644
> --- a/e2fsck/ehandler.c
> +++ b/e2fsck/ehandler.c
> @@ -118,6 +118,29 @@ static errcode_t e2fsck_handle_write_error(io_channel channel,
>  	return error;
>  }
>  
> +static errcode_t e2fsck_handle_sync_error(io_channel channel,
> +                                            errcode_t error)
> +{
> +	ext2_filsys fs = (ext2_filsys) channel->app_data;
> +	e2fsck_t ctx;
> +
> +	ctx = (e2fsck_t) fs->priv_data;
> +	if (ctx->flags & E2F_FLAG_EXITING)
> +		return 0;
> +	

Nit: ^^^ unnecessary indentation

> +	if (operation)
> +		printf(_("Error sync (%s) while %s.  "),

I think we should be more explicit that *fsync* failed:

"Error during fsync of dirty metadata while %s: %s",
	operation, error_message(...)?


> +		       error_message(error), operation);
> +	else
> +		printf(_("Error sync (%s).  "),
> +		       error_message(error));
> +	preenhalt(ctx);
> +	if (ask(ctx, _("Ignore error"), 1))

ask_yn()?

Not sure what we're asking about here, or what happens if you answer NO?
Unless we're using a redo file, dirty metadata flush has failed so we
might as well keep going, right?

--D

> +		return 0;
> +
> +	return error;
> +}
> +
>  const char *ehandler_operation(const char *op)
>  {
>  	const char *ret = operation;
> @@ -130,4 +153,5 @@ void ehandler_init(io_channel channel)
>  {
>  	channel->read_error = e2fsck_handle_read_error;
>  	channel->write_error = e2fsck_handle_write_error;
> +	channel->sync_error = e2fsck_handle_sync_error;
>  }
> -- 
> 2.31.1
> 

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C27205C0
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jun 2023 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjFBPTA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jun 2023 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFBPTA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jun 2023 11:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B818C
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jun 2023 08:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5375860AB7
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jun 2023 15:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A795DC433EF;
        Fri,  2 Jun 2023 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719138;
        bh=N8KKtm67jhbNPdeIzSdK7pFIuxNbBcAgHr17j/eAbxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiF9gmt7opm1WpmNSmLocX0uIkdhvlQNPsD0cuwGoMuoVJYkHhbWYECuuS5fhccbB
         cYS5ahMkxI4EVKxi4gHwOWHGmSeemD66gheUUjVusz0JXx2m/h4G33azOMVe+6oYLV
         jQLGOll7KFOp5ldes55bT1Fld+CsEhNpFjCY2fmSFdZT77G/JAME7Tb8Tn3qp0kMOi
         yHP06QM4NVZT3PbGQKJcxuunSNJLAdQllUHI+6gcSLyvWaKpzY786T3oo5I3/8Z3Rc
         gu25k7WtymbLjTM5HLcAH7zogxIc5ScSHQ09UG7rfe/9tMhZD1qyF0SY36h7T2/SwV
         gU36Qz0GNfz+A==
Date:   Fri, 2 Jun 2023 08:18:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        louhongxiang@huawei.com
Subject: Re: [PATCH] e2fsck: restore sb->s_state before journal recover
Message-ID: <20230602151858.GA16844@frogsfrogsfrogs>
References: <20230602082759.4062633-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602082759.4062633-1-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 02, 2023 at 04:27:59PM +0800, zhanchengbin wrote:
> ext4_handle_error
>     EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>     if remount-ro
>         ext4_commit_super(sb);
> As you can see, when the filesystem error in the kernel, the last sb commit
> not record the journal, So sb->s_state will be overwritten by journal recover.
> In some cases , modifying metadata and superblock data are placed in two
> transactions, if the previous transaction is already in the journal, and
> ext4_handle_error occurs when updating sb, the filesystem is still error even
> if the journal is recovered(I know that this situation should not occur in
> theory, but I encountered this error when testing quota. Therefore, I think
> we cannot fully rely on the kernel).
> So when the filesystem is error before the journal recover, keep the error
> state and perform deep check later.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>  e2fsck/journal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index c7868d89..6f49321d 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -1683,6 +1683,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>  	errcode_t	retval, recover_retval;
>  	io_stats	stats = 0;
>  	unsigned long long kbytes_written = 0;
> +	__u16 state = ctx->fs->super->s_state;
>  
>  	printf(_("%s: recovering journal\n"), ctx->device_name);
>  	if (ctx->options & E2F_OPT_READONLY) {
> @@ -1722,6 +1723,9 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>  	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>  	ctx->fs->super->s_kbytes_written += kbytes_written;
>  
> +	if (EXT2_ERROR_FS | state)

Isn't this  ^^^^^^^^^^^^^^^^^^^^^ expression always nonzero?

> +		ctx->fs->super->s_state = state | EXT2_ERROR_FS;

/me doesn't understand this bit logic at all.

--D

> +
>  	/* Set the superblock flags */
>  	e2fsck_clear_recover(ctx, recover_retval != 0);
>  
> -- 
> 2.31.1
> 

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E84EA59B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiC2DAH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 23:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiC2DAB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 23:00:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810A26CD
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 19:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51122B8165A
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 02:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5284C340ED;
        Tue, 29 Mar 2022 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648522695;
        bh=7Ez/p8sr8OTPkSXoW6B3tyvYexBiANSkM4nmCrU52PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o81+ny3O3+HhNT80baMm+t0A0uFfQXBshO7tCHyzrsFmJIH6xCHE/yiJ1eQprNZtF
         0sv0hmttq15ELvPoQCF4w2g57GirVMzzpwS8XBtAyNN3i45lhg6OhkSnHJA8txO0Ew
         q3O9m9RPrMT6+qGJdRs2re1fuZ6WNdUFlPFEYWRfdJyfQ60Z0o9+K82K7umgig9Pdt
         FLF5Acf3MfKiFslkkWiuuAJ6T37lYCNK2HF7l5k4NHRKerdW8IFQghcr67nZVpmjtk
         fwquJJtvdPlEu3lX915yoEmXtGMkDb9XeVRXbuTSyTzHyECLhCbPHxUAAtrgJW95mI
         P3quFp6ZyciDA==
Date:   Mon, 28 Mar 2022 19:58:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/5] ext4: Match the f2fs ci_compare implementation
Message-ID: <YkJ1xmB1wXQ1WCJ7@sol.localdomain>
References: <20220322030004.148560-1-krisman@collabora.com>
 <20220322030004.148560-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322030004.148560-2-krisman@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 21, 2022 at 11:00:00PM -0400, Gabriel Krisman Bertazi wrote:
> ext4_ci_compare originally follows utf8_*_strcmp, which means return
> zero on match.  This means that every usage of that in ext4 negates
> the return.
> 
> Turn it into a predicate function, let it follow the kernel convention
> and return true on match, which means it's now the same as its f2fs
> counterpart and can be extracted into generic code.
> 
> This change also makes it more obvious that we are ignoring error
> handling in ext4_match, which can occur since casefolding support (bad
> utf8 name due to disk corruption on strict mode causes -EINVAL) and
> casefold+encryption (-ENOMEM).  For now, keep the behavior.  It is
> handled by the following patches.
> 
> While we are there, change the comment to the kernel-doc style.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/namei.c | 62 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 8cf0a924a49b..24ea3bb446d0 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1318,13 +1318,20 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
>  }
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -/*
> +/**
> + * ext4_ci_compare() - Match (case-insensitive) a name with a dirent.
> + * @parent: Inode of the parent of the dentry.
> + * @name: name under lookup.
> + * @de_name: Dirent name.
> + * @de_name_len: dirent name length.
> + * @quick: whether @name is already casefolded.
> + *
>   * Test whether a case-insensitive directory entry matches the filename
> - * being searched for.  If quick is set, assume the name being looked up
> - * is already in the casefolded form.
> + * being searched.  If quick is set, the @name being looked up is
> + * already in the casefolded form.
>   *
> - * Returns: 0 if the directory entry matches, more than 0 if it
> - * doesn't match or less than zero on error.
> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
> + * < 0 on error.
>   */
>  static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
>  			   u8 *de_name, size_t de_name_len, bool quick)

Shouldn't this be renamed to ext4_match_ci() as well?  The f2fs equivalent is
called f2fs_match_ci_name(), and this is called from ext4_match().
ext4_match_ci() would better fit the "return 1 on match" behavior, I think.

- Eric

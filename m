Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19AB52C34D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiERT0J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbiERT0D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 15:26:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F602ED70
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 12:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD03AB81F3A
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 19:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567D9C385A9;
        Wed, 18 May 2022 19:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652901959;
        bh=7gr+zzTA/0OSnCbg25nIyqBkSv4XukYotLrz1lhRwlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEAYvsj+AcnJMph7AJPvpIK/uuEcXPLJzb4rygd5A1lAOK8XKUGDeC5eBdUJ076Bq
         ZyPN+eNM2uDM/Q6ERXl2AYzfSSQkYWgI+XSbHgdTX4z+Uj/BWB+Gt5uwU39Qpi61wZ
         LnH4k0H+51S5g9tMB3TUGO7fsVPLCL/xUg7eB0/uwVTgNrPlKYEEm16Ea2cp9T6fDz
         iQHD8CoaHQihox2j0WrJYiZVKTJzNVcmxzw1/IUtHo+7dh2WQrnH9RPftQVXFJkRlR
         nyK4ma/VpVEn6zUFsE3uhqcVDCEn+p4RQuAvF7B4HPVJewxpZ8invUYInYULRn+Qxh
         8bK+HptAv5+oQ==
Date:   Wed, 18 May 2022 12:25:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 7/8] ext4: Move CONFIG_UNICODE defguards into the code
 flow
Message-ID: <YoVIRewDI7EWLdQd@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-8-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:19PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v4:
>   - Create stub for !CONFIG_UNICODE case (eric)
> ---
>  fs/ext4/ext4.h  | 37 ++++++++++++++++++++-----------------
>  fs/ext4/namei.c | 15 ++++++---------
>  fs/ext4/super.c |  4 +---
>  3 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 93a28fcb2e22..c38999ee3627 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2727,8 +2727,24 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
>  extern int ext4_fname_setup_ci_filename(struct inode *dir,
> -					 const struct qstr *iname,
> -					 struct ext4_filename *fname);
> +					const struct qstr *iname,
> +					struct ext4_filename *fname);
> +
> +static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
> +{
> +	kfree(fname->cf_name.name);
> +	fname->cf_name.name = NULL;
> +}
> +#else
> +static inline int ext4_fname_setup_ci_filename(struct inode *dir,
> +					       const struct qstr *iname,
> +					       struct ext4_filename *fname)
> +{
> +	return 0;
> +}
> +static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_FS_ENCRYPTION
> @@ -2758,9 +2774,7 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
>  
>  	ext4_fname_from_fscrypt_name(fname, &name);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> -#endif
>  	return err;
>  }

This can just do 'return ext4_fname_setup_ci_filename(...)'.  No need for the
err variable.

>  
> @@ -2777,9 +2791,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
>  
>  	ext4_fname_from_fscrypt_name(fname, &name);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
> -#endif
>  	return err;
>  }

Similarly, this can just return ext4_fname_setup_ci_filename(...).

>  
> @@ -2794,10 +2806,7 @@ static inline void ext4_fname_free_filename(struct ext4_filename *fname)
>  	fname->usr_fname = NULL;
>  	fname->disk_name.name = NULL;
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	kfree(fname->cf_name.name);
> -	fname->cf_name.name = NULL;
> -#endif
> +	ext4_fname_free_ci_filename(fname);
>  }
>  #else /* !CONFIG_FS_ENCRYPTION */
>  static inline int ext4_fname_setup_filename(struct inode *dir,
> @@ -2810,10 +2819,7 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
>  	fname->disk_name.name = (unsigned char *) iname->name;
>  	fname->disk_name.len = iname->len;
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> -#endif
> -
>  	return err;

Likewise.

- Eric

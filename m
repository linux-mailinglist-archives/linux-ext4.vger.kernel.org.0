Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15D5244D9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 07:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiELFYy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 01:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbiELFYx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 01:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA27B66AF6
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 22:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 822B7B826F5
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 05:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A25C385B8;
        Thu, 12 May 2022 05:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652333089;
        bh=vSdULYbuchXcmCl0qmJRHssrYI4NBtqHEWcUfEuYAsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKpX7lQYDtEIRtY5WTaSKr+byuGEClmCJU6sNHJBXgfIfTXEhbbAYPIiAwUVrdfx+
         Jy94paFDiH0tt9FgpWq0z+ljNzs3Ltu43gO6tDRWSY9HQ2kTKUYz9mEtNZCvlW3ktz
         ng0+lJN6SyCs6g1AltmU1NnfsqP2hUFGEDz4wd3G9UfEhNpa/OqWMyc2U7uc8JZlRF
         CVpSLynZ6IfkXMEH7Xa/a98UFHjy/3Jf+Nmcogx8sfbWyj2YWrdXWZc8PgNx7So8y5
         Yx3SgG3X1I2+WW8tov+lPHpirRyzaMX+7rzQlNdfpVqURvRGcfAnY44RuLD+OTq7/6
         R9FZQn1Mipopg==
Date:   Wed, 11 May 2022 22:24:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v4 07/10] ext4: Move ext4_match_ci into libfs
Message-ID: <YnyaH4WI2TRa/57R@sol.localdomain>
References: <20220511193146.27526-1-krisman@collabora.com>
 <20220511193146.27526-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-8-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:43PM -0400, Gabriel Krisman Bertazi wrote:
> Matching case-insensitive names is a generic operation and can be shared
> with f2fs.  Move it next to the rest of the shared casefold fs code.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/namei.c    | 62 +---------------------------------------------
>  fs/libfs.c         | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  3 +++
>  3 files changed, 65 insertions(+), 61 deletions(-)

It might be a good idea to split this into two patches, one for the libfs part
and one for the ext4 part.  That would make sorting out the dependencies of this
series easier in case it doesn't all go in in one cycle.

> +/**
> + * generic_ci_match() - Match (case-insensitive) a name with a dirent.
> + * @parent: Inode of the parent of the dentry.
> + * @uname: name under lookup.
> + * @de_name: Dirent name.
> + * @de_name_len: dirent name length.
> + *
> + * Test whether a case-insensitive directory entry matches the filename
> + * being searched.
> + *
> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
> + * < 0 on error.
> + */
> +int generic_ci_match(const struct inode *parent,
> +		     const struct unicode_name *uname,
> +		     u8 *de_name, size_t de_name_len)

de_name should be const, like it is in the f2fs version.  It does get cast away
temporarily when it is stored in a fscrypt_str, but it never gets modified (and
must not be) so const is appropriate.

- Eric

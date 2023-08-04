Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D73770A2B
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 22:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHDU6T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Aug 2023 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHDU6Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Aug 2023 16:58:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E266A4C37
        for <linux-ext4@vger.kernel.org>; Fri,  4 Aug 2023 13:58:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 374Kw9OR004360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 16:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691182691; bh=wnz7KnRIhkpMytoqzV6suJ10Lc2cAo8AUMf81bGzEw8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=fH7igL+X/iAt4rEjjN+DyfEGbx9bq5RVBLG0k2hUqlZ6NGR2pRRem0GyIGpJjAREp
         mwzd+irEvvN15Mrx+bRmBDTUlVt+cWmPFR6OCyE86/kcHiDx5cYKKNDaOwvo2F6m8f
         vvYSdFcYHJD4dxwLXUpWieQ5S8Lnv+gBJiby7aUguz6gCuihz1f66viVROUlGpGL0X
         kFd5ow1+NhhbYA7MgQWftqBWpAvagNVBsDd8v0mr4yd53VOHTkxRcWJUDmBi34Qvgx
         clJpuWHi6d94H3w0u6M4mIyPn2LlTUhHCVc/2Ma0cKB35UU3Lvc4xUBiffGKEs4D7F
         kYqwzZ8rz+zgg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9D80315C04F1; Fri,  4 Aug 2023 16:58:09 -0400 (EDT)
Date:   Fri, 4 Aug 2023 16:58:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vitaliy Kuznetsov <vk.en.mail@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger@dilger.ca
Subject: Re: [PATCH] ext4: Add periodic superblock update check
Message-ID: <20230804205809.GE903325@mit.edu>
References: <20230731122526.30158-1-vk.en.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731122526.30158-1-vk.en.mail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 31, 2023 at 04:25:26PM +0400, Vitaliy Kuznetsov wrote:
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6d332dff79dd..9f334de4f636 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -515,7 +515,8 @@ static const struct kobj_type ext4_feat_ktype = {
> 
>  void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
>  {
> -	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
> +	if (sbi->s_add_error_count > 0)
> +		sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
>  }

The problem is that ext4_notify_error_sysfs() is called in
flush_stashed_error_work() **after** that function calls
ext4_update_super() --- and ext4_update_super will zero out
s_add_error_count.  So this will result in the sysfs_notify call
*never* getting called, which would be a regression.  So
unfortunately, I can't accept this patch as currently written.

Fortunately, only flush_stashed_error_work() calls
ext4_notify_error_sysfs(), so it should be easy enough to sample
s_add_error_count before calling ext4_update_super(), and then
conditionally call sysfs_notify() if it is non-zero.

	      	   		     	   - Ted

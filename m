Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D4252449D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 06:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348640AbiELE7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 00:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348062AbiELE7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 00:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01481339D2
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 21:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C82561A78
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 04:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B21DC385B8;
        Thu, 12 May 2022 04:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652331581;
        bh=9lGboVgAvwbA5h9yhNnTQKCZmE6NNW1JPa5DBZ6/QQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvJ1eRrFmojtIGU59ektCRDFQ1TixHnMOHbRpQemKnQ93NOdZntDAWEzSrc6StSE8
         MlnciQGE06ZtUTLG7HYIzKOYmtHJ0u94z1vFKW1Pl8DdCSU0lEzgaAASHISQ4/NLTn
         jSDI8NLwYSlJ8Mqj25YLe3hsI77YtbXU6WcP8DnQmvK5epRgRosgXLkIA8Eyrgatg+
         c7KHfrbpQQZmkLJpggC3pJy56togQgKPqKFvLD18IRO66fzciJ2d8N9s6h3q8PQKW2
         ovryp3btaSIB36nfbLl3/6ha92/+WTv0nj66IksQc24bQ5Dhy8PUMrYy+EGUOQ84kU
         qe9ZZot7j7Yeg==
Date:   Wed, 11 May 2022 21:59:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v4 09/10] ext4: Move CONFIG_UNICODE defguards into the
 code flow
Message-ID: <YnyUOxkr4LaZ9OO5@sol.localdomain>
References: <20220511193146.27526-1-krisman@collabora.com>
 <20220511193146.27526-10-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-10-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:45PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/ext4.h  | 39 +++++++++++++++++++--------------------
>  fs/ext4/namei.c | 15 ++++++---------
>  fs/ext4/super.c |  4 +---
>  3 files changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 93a28fcb2e22..e3c55a8e23bd 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2725,11 +2725,17 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
>  					      struct ext4_group_desc *gdp);
>  ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
>  extern int ext4_fname_setup_ci_filename(struct inode *dir,
> -					 const struct qstr *iname,
> -					 struct ext4_filename *fname);
> +					const struct qstr *iname,
> +					struct ext4_filename *fname);

I think this function should just have a !CONFIG_UNICODE stub that does nothing,
so that the callers can just call it unconditionally and not have to gate their
call on CONFIG_UNICODE themselves.

- Eric

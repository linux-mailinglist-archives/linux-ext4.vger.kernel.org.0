Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357D52CA68
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 05:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiESDfz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 23:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiESDfx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 23:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E5167C3
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 20:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AAA76195C
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 03:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71687C34100;
        Thu, 19 May 2022 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652931348;
        bh=NES1fN52Zk0zMrldfi2XEcba5q9hgSK/AWFsZ5uhd+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9IDVAWlVKhFMx2ww5WFcfUCc8NQnSuhV7A4S/xBsz/3EzqjHRQQBu97zVrN9bqXP
         E4rDCNrP0aoGZLoX4d6TPY9PzqCKobWMtFMGA9t9I7k97nYgXoLPCgOWU5kV7R4zTU
         AaaTcKKgtjb4ymo0DW11d9FQLP0yz9vjAjKHsEKBw3IHm4tCWY88HQ/FSMIyN2UPje
         dUAlLAcOYr852LGHhMjlJwDKSCCeVLq2Iws5mDwVn4TFTHC4F07XfGwwjUKfWMGLKR
         rkTu9QzwlrLPos62heovwUIaUQJOcQ0PEiRJ9anN8kV84yRu8n70/yuJvLQnp5jYxW
         RXeG5zivD1z9g==
Date:   Wed, 18 May 2022 20:35:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v6 3/8] libfs: Introduce case-insensitive string
 comparison helper
Message-ID: <YoW7EhTqz0CPOZCL@sol.localdomain>
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519014044.508099-4-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 09:40:39PM -0400, Gabriel Krisman Bertazi wrote:
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 974125270a42..c8f40ee35743 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1465,6 +1465,74 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
>  };
> +
> +/**
> + * generic_ci_match() - Match a name (case-insensitively) name with a dirent.

The word "name" is duplicated above.

Otherwise this looks good:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3D659BDA
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Dec 2022 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiL3UNa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 15:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiL3UNa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 15:13:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5611AA38;
        Fri, 30 Dec 2022 12:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2B561BCB;
        Fri, 30 Dec 2022 20:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C922C433EF;
        Fri, 30 Dec 2022 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672431207;
        bh=EfI7l5SQjlOPh7QWIN2CUcMKcJaGYutOHFmQnj1qNNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7qtzJQ/OQ2UE66v3GVjpd1OInb1g16GuxQCQ62PBFRbr3U6dJqQfJODjNcAkwreE
         0QHGQ4SwikFyt0hUcM63UfZ1lE+01XPaPV1BLsGSP8m5kb+sMWDl1jGSpLYu0gUZnM
         Ejaiy3j9tiUdQTyX+aZ6pRIAwUTIZWSrC3YCly4RP62ZDSXZLZq6FtzIHOmGG2+V0l
         aq+yCAaiSvtI8bEedexIuA4foBE6sgNtfJLc4xlIL5k/fxU67LnFTLL0pM0S3+I682
         hYP6LhcJjlYOIaIqFQRj4P286blawSrTzUIJdX8aTANFJc+enl2qVgXiKeQkxFn5Tt
         crVxAVI7YXOJQ==
Date:   Fri, 30 Dec 2022 12:13:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tudor.ambarus@linaro.org
Subject: Re: [PATCH 2/2] ext4: refuse to create ea block when umounted
Message-ID: <Y69GZdLcWkCvZhq1@sol.localdomain>
References: <20221230110016.476621-1-jun.nie@linaro.org>
 <20221230110016.476621-2-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230110016.476621-2-jun.nie@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 30, 2022 at 07:00:16PM +0800, Jun Nie wrote:
> The ea block expansion need to access s_root while it is
> already set as NULL when umount is triggered. Refuse this
> request to avoid panic.
> 
> Reported-by: syzbot+2dacb8f015bf1420155f@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=3613786cb88c93aa1c6a279b1df6a7b201347d08
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  fs/ext4/xattr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 235a517d9c17..ac58494e49b6 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1422,6 +1422,12 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
>  	uid_t owner[2] = { i_uid_read(inode), i_gid_read(inode) };
>  	int err;
>  
> +	if (inode->i_sb->s_root == NULL) {
> +		ext4_error(inode->i_sb,
> +			   "refuse to create EA inode when umounting");
> +		return ERR_PTR(-EINVAL);
> +	}
> +

Why is an xattr being set during unmount?

- Eric

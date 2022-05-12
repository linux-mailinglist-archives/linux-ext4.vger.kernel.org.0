Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C9524525
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349988AbiELFs5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 01:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiELFs5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 01:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF133361
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 22:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC0E61CEB
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 05:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E30C34100;
        Thu, 12 May 2022 05:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652334534;
        bh=d08puB5fh8hsuQ35H3WmEybfW309kt4JfYm4wR3DdCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQ49KXR5PTPy0h8HyvgwYK4024ceZHItRofouxcJ+5L8lFGZxOGyONCFg0DYXie9y
         IGbGmEaZVViRdK5Tu93KLwmIiIoK7qie1PmNm7IsuyIJeMGN+23c2w79lwV/GCvTfQ
         DubIYXKytnaAgtL+tKFlqzHlo+taC3uBpCrGfepRjxEc4KwUnxeUx9Zk6FlOXXV/Ni
         igZE33iAYb0vHdHld1BJ7HiIYFEsRh+mLd0puAEkg1nTyHZUvWuvPh/usab+vUCEcd
         mMEVah3l9TlotcamEY1okYWpY3EYpPXcPpMjvRQ9DTeMgw36icUSRjxYJtYeWMBqc3
         oo2+cgbmXiZ2g==
Date:   Wed, 11 May 2022 22:48:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v4 06/10] ext4: Log error when lookup of encoded dentry
 fails
Message-ID: <YnyfxNBxFy0LZfJ7@sol.localdomain>
References: <20220511193146.27526-1-krisman@collabora.com>
 <20220511193146.27526-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-7-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:42PM -0400, Gabriel Krisman Bertazi wrote:
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> 
> Changes since v1:
>   - reword error message "file in directory" -> "filename" (Eric)
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cebbcabf0ff0..708811525411 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1458,6 +1458,9 @@ static bool ext4_match(struct inode *parent,
>  			 * only case where it happens is on a disk
>  			 * corruption or ENOMEM.
>  			 */
> +			if (ret == -EINVAL)
> +				EXT4_ERROR_INODE(parent,
> +						 "Bad encoded filename");

This message is still quite vague; perhaps it should be more specific about what
a "bad" filename is?  Maybe something like: "Directory contains filename that is
not valid UTF-8" (or whatever the encoding being enforced is).

- Eric

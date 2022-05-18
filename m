Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7852C338
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiERTXb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbiERTX3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 15:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3B22DA04
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 12:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF8161912
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 19:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C923C34100;
        Wed, 18 May 2022 19:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652901797;
        bh=4IkUWqt05H3mspNzpAHNA//Q0t9+x8L7venXN8Yy1AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/yMvGVJPqmt1uqdUfqz6l7Row1oRP3Zoc9dBaVlXlzcPlrYGZHdOnFwC/iZXaMF2
         Fcf8wiq4jEfK33r178p3QLU06oHNRQhhQC8YpzBw/QR79cI+dAJ6rr07HKSOqN05g+
         FM5FSfiQ3D4b7duJOsnjqTqfDPArQ97E1cMYCE07cMBi8Y2h+QD9j+lb/zXF0CCEmf
         mhNjjnXVlPje6JstXk9G+/RbmdjOhtFdRsdwt9ZF/nGgvFcP9WSfx8ubz6CjpNXR3K
         xaHPdWWr/gpRlSFB9SA0fZKtW2WGFTt+UcYArDETy1m5ZNAxP3xys1pKQoPloZYpRG
         7lrZPE8Cs0aWg==
Date:   Wed, 18 May 2022 12:23:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 6/8] ext4: Log error when lookup of encoded dentry
 fails
Message-ID: <YoVHo7SXDRsVk8My@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-7-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:18PM -0400, Gabriel Krisman Bertazi wrote:
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> 
> changes since v4:
>   - Reword error message (Eric)
> 
> Changes since v1:
>   - reword error message "file in directory" -> "filename" (Eric)
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 98295b03a57c..8fbb35187f72 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1396,6 +1396,9 @@ static bool ext4_match(struct inode *parent,
>  			 * only case where it happens is on a disk
>  			 * corruption or ENOMEM.
>  			 */
> +			if (ret == -EINVAL)
> +				EXT4_ERROR_INODE(parent,
> +					"Directory contains filename that is invalid UTF-8");
>  			return false;
>  		}
>  		return ret;

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

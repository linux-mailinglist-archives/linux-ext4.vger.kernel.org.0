Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135BD206A42
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jun 2020 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbgFXCkq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Jun 2020 22:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXCkq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Jun 2020 22:40:46 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67858206E2;
        Wed, 24 Jun 2020 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592966445;
        bh=7RLWhFRPme88LM6U8zPTM0WpfAuSprjdk4k8kRDwiyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOt6a5fcr168MVqefLRaN+osouDQI5N/pBjEZNlBiSUC9m3rrXu2hRgp0ajnpmrzt
         t1dTlFyMmPruQrAn0NgR/3pVU2GXNW3lIXS26flLIzQZ/YcGoPyyzt9ETAGbS0aSJy
         fHszpe8VibDIM64aIX9/hEntTscMeFezDzDcu0yA=
Date:   Tue, 23 Jun 2020 19:40:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     sarthakkukreti@chromium.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs: allow remove VERITY
Message-ID: <20200624024043.GA844@sol.localdomain>
References: <20200624023107.182118-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624023107.182118-1-gwendal@chromium.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 23, 2020 at 07:31:07PM -0700, Gwendal Grignou wrote:
> Allow verity flag to be removed from the susperblock:
> Tests:
> - check the signed file is readable by older kernel after flag
> is removed. EXT4_VERITY_FL replaces EXT4_EXT_MIGRATE that has been
> removed in 2009.
> - when a new kernel is reinstalled, check reenabling verity flag
> allow signature to be verified (fsverity measure ...).
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  misc/tune2fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 314cc0d0..724b8014 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -198,7 +198,8 @@ static __u32 clear_ok_features[3] = {
>  		EXT4_FEATURE_RO_COMPAT_QUOTA |
>  		EXT4_FEATURE_RO_COMPAT_PROJECT |
>  		EXT4_FEATURE_RO_COMPAT_METADATA_CSUM |
> -		EXT4_FEATURE_RO_COMPAT_READONLY
> +		EXT4_FEATURE_RO_COMPAT_READONLY |
> +		EXT4_FEATURE_RO_COMPAT_VERITY
>  };
>  

tune2fs doesn't allow removing features like encrypt, casefold, verity, extents,
and ea_inode because it doesn't know whether there are any inodes on the
filesystem that are using these features.  These features can't be removed if
there are any inodes using them.

There was recently a suggestion to make tune2fs scan the inode table to
determine whether it is safe to remove these flags; see
https://lkml.kernel.org/linux-ext4/C0761869-5FCD-4CC7-9635-96C18744A0F8@dilger.ca
and
https://lkml.kernel.org/linux-ext4/20200407053213.GC102437@sol.localdomain

I think you'd need to implement that in order for clearing verity to be safe.

Note that misc/tune2fs.8.in would also need to be updated to remove the sentence
that says that clearing the verity feature is unsuppported.

- Eric

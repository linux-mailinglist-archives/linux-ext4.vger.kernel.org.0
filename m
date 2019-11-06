Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133B7F1A94
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfKFP7D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 10:59:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:40408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfKFP7D (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Nov 2019 10:59:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C6FFB195;
        Wed,  6 Nov 2019 15:59:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C796D1E4353; Wed,  6 Nov 2019 16:59:00 +0100 (CET)
Date:   Wed, 6 Nov 2019 16:59:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/5] ext2: code cleanup for ext2_try_to_allocate()
Message-ID: <20191106155900.GC12685@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-4-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20191104114036.9893-4-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 04-11-19 19:40:35, Chengguang Xu wrote:
> Code cleanup by removing duplicated code.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks for the patch! I've merged it with a small update to switch the
while() loop into a for() loop which is somewhat more natural in that
situation. Resulting patch attached.

								Honza

> ---
>  fs/ext2/balloc.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index a0c22e166682..9a9bd566243d 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -710,29 +710,25 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>  				;
>  		}
>  	}
> -	start = grp_goal;
>  
> -repeat:
> -	if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), grp_goal,
> -			       				bitmap_bh->b_data)) {
> -		/*
> -		 * The block was allocated by another thread, or it was
> -		 * allocated and then freed by another thread
> -		 */
> -		start++;
> -		grp_goal++;
> -		if (start >= end)
> -			goto fail_access;
> -		goto repeat;
> -	}
> -	num++;
> -	grp_goal++;
> -	while (num < *count && grp_goal < end
> -		&& !ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
> +	while (num < *count && grp_goal < end) {
> +		if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
>  					grp_goal, bitmap_bh->b_data)) {
> +			if (num == 0) {
> +				grp_goal++;
> +				continue;
> +			} else {
> +				break;
> +			}
> +		}
> +
>  		num++;
>  		grp_goal++;
>  	}
> +
> +	if (!num)
> +		goto fail_access;
> +
>  	*count = num;
>  	return grp_goal - num;
>  fail_access:
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--DKU6Jbt7q3WqK7+M
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext2-code-cleanup-for-ext2_try_to_allocate.patch"

From d61650c669a6e3c1347cd3b333e4ae8487757f35 Mon Sep 17 00:00:00 2001
From: Chengguang Xu <cgxu519@mykernel.net>
Date: Mon, 4 Nov 2019 19:40:35 +0800
Subject: [PATCH] ext2: code cleanup for ext2_try_to_allocate()

Code cleanup by removing duplicated code.

Link: https://lore.kernel.org/r/20191104114036.9893-4-cgxu519@mykernel.net
Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/balloc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 25bc3a43cd94..d67f7dc1baaa 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -698,29 +698,20 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 				;
 		}
 	}
-	start = grp_goal;
 
-repeat:
-	if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), grp_goal,
-			       				bitmap_bh->b_data)) {
-		/*
-		 * The block was allocated by another thread, or it was
-		 * allocated and then freed by another thread
-		 */
-		start++;
-		grp_goal++;
-		if (start >= end)
-			goto fail_access;
-		goto repeat;
-	}
-	num++;
-	grp_goal++;
-	while (num < *count && grp_goal < end
-		&& !ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
+	for (; num < *count && grp_goal < end; grp_goal++) {
+		if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
 					grp_goal, bitmap_bh->b_data)) {
+			if (num == 0)
+				continue;
+			break;
+		}
 		num++;
-		grp_goal++;
 	}
+
+	if (num == 0)
+		goto fail_access;
+
 	*count = num;
 	return grp_goal - num;
 fail_access:
-- 
2.16.4


--DKU6Jbt7q3WqK7+M--

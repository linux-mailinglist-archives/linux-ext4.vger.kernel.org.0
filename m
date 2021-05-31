Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3380A3969CF
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jun 2021 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhEaWwq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 May 2021 18:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhEaWwo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 31 May 2021 18:52:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 113D26127C;
        Mon, 31 May 2021 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622501462;
        bh=zTMyDTf6O8ME2ypxr5nwxjujvmRLGWs7ngm3FTpWE2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuA/NHXRGw92fg426Wr1Wf9jAWzr4DUQQIy/7sgJn4Afy4zRlyF1NaQ6iuiRaE4X3
         Q7OqzwD6/TNVHSMWIv3SAA9RrDTgX3xgYsAclbXHigp6zsXVe8Ucsbw3SnF1eBuulU
         LOlx8S2UqPzPEGV61KCIGOACh24NO6UVxZqyxMJEXknhuI+G4F3yD5Hyt6F3LmqOd3
         VS/eOaSSw1Ywxv/RNKNL3yIH9piGzWMzoZWGoLw8IYyhNUalOJFcmRjiNFGwMJYgPr
         vmUKLz/WfcKMbeOArEoDcDbYsHVBjGl5X6j6yTeVIaZsfAuRFdOEkdo3VfDZJXiNO3
         slSKq3NeWfwyQ==
Date:   Mon, 31 May 2021 15:51:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] ext4: fsmap: Fix the block/inode bitmap comment
Message-ID: <20210531225101.GA15541@locust>
References: <e79134132db7ea42f15747b5c669ee91cc1aacdf.1622432690.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79134132db7ea42f15747b5c669ee91cc1aacdf.1622432690.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 31, 2021 at 09:19:08AM +0530, Ritesh Harjani wrote:
> While debugging fstest ext4/027 failure, found below comment to be wrong and
> confusing. Hence fix it while we are at it.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Doh.  Thanks for fixing that.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext4/fsmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
> index 68c8001fee85..ac642be2302e 100644
> --- a/fs/ext4/fsmap.h
> +++ b/fs/ext4/fsmap.h
> @@ -50,7 +50,7 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>  #define EXT4_FMR_OWN_INODES	FMR_OWNER('X', 5) /* inodes */
>  #define EXT4_FMR_OWN_GDT	FMR_OWNER('f', 1) /* group descriptors */
>  #define EXT4_FMR_OWN_RESV_GDT	FMR_OWNER('f', 2) /* reserved gdt blocks */
> -#define EXT4_FMR_OWN_BLKBM	FMR_OWNER('f', 3) /* inode bitmap */
> -#define EXT4_FMR_OWN_INOBM	FMR_OWNER('f', 4) /* block bitmap */
> +#define EXT4_FMR_OWN_BLKBM	FMR_OWNER('f', 3) /* block bitmap */
> +#define EXT4_FMR_OWN_INOBM	FMR_OWNER('f', 4) /* inode bitmap */
>  
>  #endif /* __EXT4_FSMAP_H__ */
> -- 
> 2.31.1
> 

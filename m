Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E72235E6
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 09:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgGQH3F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 17 Jul 2020 03:29:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47131 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgGQH3F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 03:29:05 -0400
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D776024000F;
        Fri, 17 Jul 2020 07:29:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200701153404.1647002-1-antoine.tenart@bootlin.com>
References: <20200701153404.1647002-1-antoine.tenart@bootlin.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] create_inode: set xattrs to the root directory as well
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Message-ID: <159497094193.3166.11625094942627698345@kwain>
Date:   Fri, 17 Jul 2020 09:29:02 +0200
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Gentle ping. Does anyone have a comment on this patch?

Thanks!
Antoine

Quoting Antoine Tenart (2020-07-01 17:34:04)
> __populate_fs do copy the xattrs for all files and directories, but the
> root directory is skipped and as a result its extended attributes aren't
> set. This is an issue when using mkfs to build a full system image that
> can be used with SElinux in enforcing mode without making any runtime
> fix at first boot.
> 
> This patch adds logic to set the root directory's extended attributes.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  misc/create_inode.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index e8d1df6b55a5..0a6e4dc23d16 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -820,7 +820,29 @@ static errcode_t __populate_fs(ext2_filsys fs, ext2_ino_t parent_ino,
>  
>         for (i = 0; i < num_dents; free(dent[i]), i++) {
>                 name = dent[i]->d_name;
> -               if ((!strcmp(name, ".")) || (!strcmp(name, "..")))
> +               if (!strcmp(name, ".")) {
> +                       retval = ext2fs_namei(fs, root, parent_ino, ".", &ino);
> +                       if (retval) {
> +                               com_err(name, retval, 0);
> +                                       goto out;
> +                       }
> +
> +                       /*
> +                        * Take special care for the root directory, to copy its
> +                        * extended attributes.
> +                        */
> +                       if (ino == root) {
> +                               retval = set_inode_xattr(fs, ino, ".");
> +                               if (retval) {
> +                                       com_err(__func__, retval,
> +                                               _("while setting xattrs for ."));
> +                                       goto out;
> +                               }
> +                       }
> +
> +                       continue;
> +               }
> +               if (!strcmp(name, ".."))
>                         continue;
>                 if (lstat(name, &st)) {
>                         retval = errno;
> -- 
> 2.26.2
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

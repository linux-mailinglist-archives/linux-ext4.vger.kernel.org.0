Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7963C2236F1
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 10:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGQIY3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 17 Jul 2020 04:24:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33755 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQIY3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 04:24:29 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EB990C000C;
        Fri, 17 Jul 2020 08:24:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <7234E28B-C60F-4AB0-BCD9-4018B1A10B8D@dilger.ca>
References: <20200701153404.1647002-1-antoine.tenart@bootlin.com> <7234E28B-C60F-4AB0-BCD9-4018B1A10B8D@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>, tytso@mit.edu,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] create_inode: set xattrs to the root directory as well
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Message-ID: <159497426579.3166.10315379148562462784@kwain>
Date:   Fri, 17 Jul 2020 10:24:25 +0200
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Andreas,

Quoting Andreas Dilger (2020-07-17 09:46:37)
> On Jul 1, 2020, at 9:34 AM, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
> > 
> > __populate_fs do copy the xattrs for all files and directories, but the
> > root directory is skipped and as a result its extended attributes aren't
> > set. This is an issue when using mkfs to build a full system image that
> > can be used with SElinux in enforcing mode without making any runtime
> > fix at first boot.
> > 
> > This patch adds logic to set the root directory's extended attributes.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> > misc/create_inode.c | 24 +++++++++++++++++++++++-
> > 1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/misc/create_inode.c b/misc/create_inode.c
> > index e8d1df6b55a5..0a6e4dc23d16 100644
> > --- a/misc/create_inode.c
> > +++ b/misc/create_inode.c
> > @@ -820,7 +820,29 @@ static errcode_t __populate_fs(ext2_filsys fs, ext2_ino_t parent_ino,
> > 
> >       for (i = 0; i < num_dents; free(dent[i]), i++) {
> >               name = dent[i]->d_name;
> > -             if ((!strcmp(name, ".")) || (!strcmp(name, "..")))
> > +             if (!strcmp(name, ".")) {
> 
> (style) despite what was previously in the code, I think it is clearer
> to write "if (strcmp(name, ".") == 0)", because it doesn't read like
> "if not string compare" since that incorrectly seems like the strings
> are *not* matching.

I kept what was done elsewhere in the function, but I agree with you,
let's introduce clearer new code :)

> > +                     retval = ext2fs_namei(fs, root, parent_ino, ".", &ino);
> > +                     if (retval) {
> > +                             com_err(name, retval, 0);
> > +                                     goto out;
> > +                     }
> > +
> > +                     /*
> > +                      * Take special care for the root directory, to copy its
> > +                      * extended attributes.
> > +                      */
> > +                     if (ino == root) {
> 
> Rather than checking this for every directory, it would be more efficient
> to copy the root xattrs only at the start of the copy in populate_fs2(),
> before the tree walk has started.  Something like:
> 
>         file_info.path_len = 0;
>         file_info.path_max_len = 255;
>         file_info.path = calloc(file_info.path_max_len, 1);
> 
> +       retval = set_inode_xattr(fs, parent_ino, source_dir);
> +       if (retval) {
> +               com_err(__func__, retval,
> +                       _("while copying xattrs on root directory"));
> +               goto out;
> +       }
> +
>         retval = __populate_fs(fs, parent_ino, source_dir, root, &hdlinks,
>                                &file_info, fs_callbacks);
> 
> That is an even less code added, which is always good.

Thanks for the suggestion, I find it way better. I'll prepare a v2.

Thanks for the review!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

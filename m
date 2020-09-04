Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D525D386
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgIDIXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 4 Sep 2020 04:23:51 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59643 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgIDIXr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 04:23:47 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E0ECA40015;
        Fri,  4 Sep 2020 08:23:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <159609406998.3391.5621985067917886015@kwain>
References: <20200717100846.497546-1-antoine.tenart@bootlin.com> <B2EE7AC5-BEC0-46A8-8C37-D3085645F94C@dilger.ca> <159609406998.3391.5621985067917886015@kwain>
Subject: Re: [PATCH v2] create_inode: set xattrs to the root directory as well
To:     Andreas Dilger <adilger@dilger.ca>, tytso@mit.edu
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Message-ID: <159920782384.787733.9857416604675445355@kwain>
Date:   Fri, 04 Sep 2020 10:23:43 +0200
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Quoting Antoine Tenart (2020-07-30 09:27:50)
> 
> Gentle ping. What's the status of this patch?

Do anyone know if anything else is required to get this merged?

Thanks!
Antoine

> Quoting Andreas Dilger (2020-07-17 13:17:08)
> > 
> > > On Jul 17, 2020, at 4:08 AM, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
> > > 
> > > populate_fs do copy the xattrs for all files and directories, but the
> > > root directory is skipped and as a result its extended attributes aren't
> > > set. This is an issue when using mkfs to build a full system image that
> > > can be used with SElinux in enforcing mode without making any runtime
> > > fix at first boot.
> > > 
> > > This patch adds logic to set the root directory's extended attributes.
> > > 
> > > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > 
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > 
> > > ---
> > > 
> > > Since v1:
> > >  - Moved the set_inode_xattr logic for the root directory
> > >    from __populate_fs to populate_fs2.
> > > 
> > > misc/create_inode.c | 8 ++++++++
> > > 1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/misc/create_inode.c b/misc/create_inode.c
> > > index e8d1df6b55a5..fe66faf1b53d 100644
> > > --- a/misc/create_inode.c
> > > +++ b/misc/create_inode.c
> > > @@ -1050,9 +1050,17 @@ errcode_t populate_fs2(ext2_filsys fs, ext2_ino_t parent_ino,
> > >       file_info.path_max_len = 255;
> > >       file_info.path = calloc(file_info.path_max_len, 1);
> > > 
> > > +     retval = set_inode_xattr(fs, root, source_dir);
> > > +     if (retval) {
> > > +             com_err(__func__, retval,
> > > +                     _("while copying xattrs on root directory"));
> > > +             goto out;
> > > +     }
> > > +
> > >       retval = __populate_fs(fs, parent_ino, source_dir, root, &hdlinks,
> > >                              &file_info, fs_callbacks);
> > > 
> > > +out:
> > >       free(file_info.path);
> > >       free(hdlinks.hdl);
> > >       return retval;
> > > --
> > > 2.26.2
> > > 
> > 
> > 
> > Cheers, Andreas
> > 
> > 
> > 
> > 
> > 
> 
> -- 
> Antoine Ténart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFA3EA714
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhHLPF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 11:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234850AbhHLPF6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Aug 2021 11:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCCBF6103A;
        Thu, 12 Aug 2021 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628780732;
        bh=xB0xau6mobE/BCCOoCDk4Aa0L9ouSA0Uui8dc7NhZCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT6KYmi9kWpByxh0dtNYmJMAb0kdISnL3Cu9mHlbS9m6Aij3KplxUh6/zp/uq/1xs
         tdUo5OIhAEZqKwwYmuuUTokTfmw1dx5iTckGo1YChJg44fukm3tuHqtvrpYPTLKE+j
         ACzi4vg0USw6db3DjNDdpHcmnbEaeOx1CJab3g7TfWzKhxpLovM4RWoznwt3UJLihz
         h1mw5+MLboILfz06Vg1x7970xG/rsRjbr+oJYDNI/IALpr/jhs8OyGWK9tr30yNj1h
         52FGg1NSafyApYHwxrjL6zJELVGbue7v81a35BZY1sGhrP5UJN3oLwmVTT/GY10fB3
         OtSQ2siUaMxgA==
Date:   Thu, 12 Aug 2021 08:05:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] mke2fs: warn about missing y2038 support when formatting
 fresh ext4 fs
Message-ID: <20210812150532.GD3601392@magnolia>
References: <20210811233253.GC3601392@magnolia>
 <YRR4fmg2eQMWf2iO@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRR4fmg2eQMWf2iO@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 11, 2021 at 09:25:18PM -0400, Theodore Ts'o wrote:
> On Wed, Aug 11, 2021 at 04:32:53PM -0700, Darrick J. Wong wrote:
> > +/*
> > + * Returns true if the user is forcing an old format (e.g. ext2, ext3).
> > + *
> > + * If there is no fs_types list, the user invoked us with no explicit type and
> > + * gets the default (ext4) format.  If we find the latest format (ext4) in the
> > + * type list, some combination of program name and -T argument put us in ext4
> > + * mode.  Anything else (ext2, ext3, hurd) and we return false.
> > + */
> 
> So that's not actually quite right.  Even if the user has no explicit
> type, mke2fs will assign a default type --- and it's not necessarily
> ext4.  You can see what the contents of the fs_types list using the -v
> option:

Ok, fair, I'll fix the message.  "If the user invoked us with no
explicit type, mke2fs adds some variant of ext* to the type list by
default."

> % /bin/rm /tmp/foo.img ; mke2fs -vq /tmp/foo.img 8m
> fs_types for mke2fs.conf resolution: 'ext2', 'small'
> % /bin/rm /tmp/foo.img ; mke2fs -vq -T news /tmp/foo.img 8m
> fs_types for mke2fs.conf resolution: 'ext2', 'news'
> % /bin/rm /tmp/foo.img ; mkfs.ext4 -vq /tmp/foo.img 8m
> fs_types for mke2fs.conf resolution: 'ext4', 'small'
> % /bin/rm /tmp/foo.img ; mkfs.ext4 -T huge -vq /tmp/foo.img 8m
> fs_types for mke2fs.conf resolution: 'ext4', 'huge'
> % /bin/rm /tmp/foo.img ; mkfs.ext4 -o hurd -vq /tmp/foo.img 8m
> fs_types for mke2fs.conf resolution: 'ext2', 'small', 'hurd'
> 
> Also note that the ext2/ext3/ext4 fs_type will always be in
> fs_types[0], so it's not necessary to search the entire list, as the
> patch is currently doing:

But that's not quite right either:

# mke2fs -t small -T ext4 -vqn a.img
fs_types for mke2fs.conf resolution: 'small', 'ext4'

So to find the 'ext4' here, you /do/ have to iterate the whole list.

--D

> 
> > +	for (i = 0; fs_types[i]; i++)
> > +		if (!strcmp(fs_types[i], "ext4"))
> > +			found_ext4 = 1;
> 
> 
> Cheers,
> 
> 						- Ted
> 
> P.S.  Although I'm not aware of anyone actually doing this, if there
> mke2fs is installed as mke3fs or mke4fs, that's the equivalent of
> mkfs.ext3 and mkfs.ext4.  (See the logic in the parse_fs_type
> function.)  Although perhaps there is some obscure distro somewhere
> out there that I don't know about....

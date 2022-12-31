Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2765A28A
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Dec 2022 04:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiLaD2H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 22:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiLaD2G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 22:28:06 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C1164AE
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 19:28:01 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BV3RefF015247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 22:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672457272; bh=BTAKOd2LPUGHXwNVn+DXIErixQd93y9EvomSdt1rsN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hJeOMeWOsiAOtZWWnamZKpLO6Su8pL5DMfaddPr+W0iDN6qepkXdkLBwtl3pTyY03
         pQCSJ+0g3ZHVvItEYtPfISiv8OWHYVFOQm0/hHVi8WdI2y7Thmi7uga966OiAipsgs
         cbeQJ0P4Vy5bLdqM/GBIWAH/G17r/FSL8QAVTcVtdTLA995Nlng0/5UM/a+pLLkp/w
         x0mEst6onQj7KqHZlcr4buqShKWRxh1Z+DSIoDXbGiXwRXR79Jtn88fXLrHb56DTMK
         ATYQNIlNF5ohmxDPnmAIdQm+vWnKjopk6Oa8z7Qe2/QvmpUhWHokNm3VdkvWPPhGoI
         25LQ6cUGKj66g==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 7BE608C0A02; Fri, 30 Dec 2022 22:27:37 -0500 (EST)
Date:   Fri, 30 Dec 2022 22:27:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tudor.ambarus@linaro.org
Subject: Re: [PATCH 2/2] ext4: refuse to create ea block when umounted
Message-ID: <Y6+sKX4bgSZ3RNrk@mit.edu>
References: <20221230110016.476621-1-jun.nie@linaro.org>
 <20221230110016.476621-2-jun.nie@linaro.org>
 <Y69GZdLcWkCvZhq1@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y69GZdLcWkCvZhq1@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 30, 2022 at 12:13:25PM -0800, Eric Biggers wrote:
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 235a517d9c17..ac58494e49b6 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1422,6 +1422,12 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
> >  	uid_t owner[2] = { i_uid_read(inode), i_gid_read(inode) };
> >  	int err;
> >  
> > +	if (inode->i_sb->s_root == NULL) {
> > +		ext4_error(inode->i_sb,
> > +			   "refuse to create EA inode when umounting");
> > +		return ERR_PTR(-EINVAL);
> > +	}

This should not be an ext4_error() since this is not a file system
corruption issue, but rather a kernel bug.  (With the one known
example being corrected by the first patch in this patch series.
Thanks Jun for working on a patch to things!)

This should be replaced by an ext4_warning() followed by a WARN_ON(1),
so we can get the stack trace.

> Why is an xattr being set during unmount?

The scenario was discovered by syzbot; the reproducer did the moral
equivalent of this (attached) shell script.  It required the
combination of lazytime and the debug_want_extra_isize mount options,
with a file system with (non-default) ea_inode feature enabled; so it
was highly unlikely to happen in real life.

For the detailed analysis, see [1]

[1] https://lore.kernel.org/all/Y5wGZG05uicAPscI@mit.edu

					- Ted

P.S.  Converting this into an xfstests test script to test for a
regression of this bug (or a failure to backport this into various
stable kernels) is also left as an exercise to the reader.  :-)

#!/bin/bash -vx
#
# This reproduces an ext4 bug caused by an unfortunate interaction
# between lazytime updates happening when a file system is being
# unmounted and expand_extra_isize
#
# Initially discovered via syzkaller:
# https://syzkaller.appspot.com/bug?id=3613786cb88c93aa1c6a279b1df6a7b201347d08
#

img=/tmp/foo.img
dir=/mnt
file=$dir/file0

rm -f $img
mke2fs -Fq -t ext4 -I 256 -O ea_inode -b 1024 $img 200k
mount $img $dir
v=$(dd if=/dev/zero bs=2000 count=1 2>/dev/null | tr '\0' =)
touch $file
attr -q -s test -V $v $file
umount $dir
mount -o debug_want_extra_isize=128,lazytime /tmp/foo.img $dir
cat $file
umount $dir

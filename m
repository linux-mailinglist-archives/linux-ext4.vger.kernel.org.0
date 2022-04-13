Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940344FED67
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Apr 2022 05:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiDMDQd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 23:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiDMDQ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 23:16:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BC5523A
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 20:14:07 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23D3E1MV003624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 23:14:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD4D815C003E; Tue, 12 Apr 2022 23:14:01 -0400 (EDT)
Date:   Tue, 12 Apr 2022 23:14:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andrew <anserper@ya.ru>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: Re: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
Message-ID: <YlY/+TiptLaRum3o@mit.edu>
References: <20220402084023.1841375-1-anserper@ya.ru>
 <20220405095451.kx43cdu2ureywgcq@riteshh-domain>
 <Yk77KMgb4SYuXuUL@mit.edu>
 <697a8e92-513c-c81f-e619-57fa94bad4d0@ya.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697a8e92-513c-c81f-e619-57fa94bad4d0@ya.ru>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 07, 2022 at 09:25:40PM +0300, Andrew wrote:
> 
> dd if=/dev/zero of=/tmp/ldiskfs bs=1M count=100
> mkfs.ext4 -O ea_inode /tmp/ldiskfs -J size=16 -I 512
> 
> mkdir -p /tmp/ldiskfs_m
> mount -t ext4 /tmp/ldiskfs /tmp/ldiskfs_m -o loop,commit=600,no_mbcache
> touch /tmp/ldiskfs_m/file{1..1024}
> 
> V=$(for i in `seq 60000`; do echo -n x ; done)
> V1="1$V"
> V2="2$V"
> 
> for k in 1 2 3 4 5 6 7 8 9; do
>        setfattr -n user.xattr -v $V /tmp/ldiskfs_m/file{1..1024}
>        setfattr -n user.xattr -v $V1 /tmp/ldiskfs_m/file{1..1024} &
>        setfattr -n user.xattr -v $V2 /tmp/ldiskfs_m/file{1024..1} &
>        wait
> done
> 
> umount /tmp/ldiskfs_m

Hi Andrew,

Thanks for the reproducer.  I'll note that with the proposed patch, we
will allocate a *large* number of delayed_iput_work structure, and
most of the time, it is not necessary to do a delayed_iput, since we
won't actually be releasing the ea_inode.  That only happens when the
ea_inode's refcount goes to zero.

So we could significantly reduce the overhead of this patch by
plumbing whether the refcount went to zero in
ext4_xattr_inode_update_ref() up through ext4_xattr_inode_dec_ref() to
ext4_xattr_set_entry(), and have it only call delayed_iput() if the
refcount went to zero.

Alternatively, we could add a function to fs/ext4/orphan.c which
checks whether the old_ea_inode is on the orphan list.  And if it is
on the orphan list, then we know that the refcount must have gone to
zero, and so we need to call delayed_iput().  If the ea_inode isn't on
the orphan list, we can just use iput(), which will be fast, since it
will only be dropping i_count, and we don't need to worry about the
ea_inode getting truncate.

Could you take a look at this optimization, and then update the commit
description to explain what's happening, inlude the kernel stack, and
the reproducer?

Many thanks!

					- Ted

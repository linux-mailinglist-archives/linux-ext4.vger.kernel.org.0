Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1874B4F8238
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Apr 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiDGO4m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbiDGO4k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 10:56:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DE1EE9EC
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 07:54:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 237EsWUG019896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Apr 2022 10:54:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4325215C3EE7; Thu,  7 Apr 2022 10:54:32 -0400 (EDT)
Date:   Thu, 7 Apr 2022 10:54:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     anserper@ya.ru, linux-ext4@vger.kernel.org,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: Re: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
Message-ID: <Yk77KMgb4SYuXuUL@mit.edu>
References: <20220402084023.1841375-1-anserper@ya.ru>
 <20220405095451.kx43cdu2ureywgcq@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405095451.kx43cdu2ureywgcq@riteshh-domain>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 05, 2022 at 03:24:51PM +0530, Ritesh Harjani wrote:
> On 22/04/02 11:40AM, anserper@ya.ru wrote:
> > From: Andrew Perepechko <andrew.perepechko@hpe.com>
> >
> > When changing a large xattr value to a different large xattr value,
> > the old xattr inode is freed. Truncate during the final iput causes
> > current transaction restart. Eventually, parent inode bh is marked
> > dirty and kernel panic happens when jbd2 figures out that this bh
> > belongs to the committed transaction.
> >
> > A possible fix is to call this final iput in a separate thread.
> > This way, setxattr transactions will never be split into two.
> > Since the setxattr code adds xattr inodes with nlink=0 into the
> > orphan list, old xattr inodes will be properly cleaned up in
> > any case.
> 
> Ok, I think there is a lot happening in above description. I think part of the
> problem I am unable to understand it easily is because I haven't spend much time
> with xattr code. But I think below 2 requests will be good to have -
> 
> 1. Do we have the call stack for this problem handy. I think it will be good to
> mention it in the commit message itself. It is sometimes easy to look at the
> call stack if someone else encounters a similar problem. That also gives more
> idea about where the problem is occuring.
> 
> 2. Do we have a easy reproducer for this problem? I think it will be a good
>    addition to fstests given that this adds another context in calling iput on
>    old_ea_inode.

Andrew, would it be possible for you to supply a call stack and a
reproducer?

It sounds like what's going on is if the file system has the ea_inode
feature enabled, and we have a large xattr value which is stored in an
inode, it's possible if that when that inode is truncated, it is
spread across two transactions.  

But the problem is that when the iput(ea_inode) is called from
ext4_xattr_set_entry(), there is a handle which is passed into that
function, since the xattr operation is part of its own transaction,
and so the truncate operation is part of "nested handle".  That's OK,
so long as the initial handle is started with sufficient credits for
the nested start_handle.  But when that handle is closed, and then
re-opened, it has two problems.  The first is that the xattr operation
is no longer atomic (and spread across two transaction).  The second
is that if the write access to the inode table's bh was requested
before the implied truncate from iput(ea_inode), then when we call
handle_dirty_metadata() on that bh, we get a jbd2 assertion.  (Which
is good, because it notifies and catches the first problem.)

So by moving the iput to a separate thread, it avoids this problem,
since the truncate can take place in its own handle.  The other
solution would be to some how pass the inode all the way up through
the call chain, and only call iput(ea_inode) after handle is stopped.
But that would require quite a lot of code surgery, since
ext4_xattr_set_entry is called in a number of places, and the iput()
would have to be plumbed up through two callers to where the handle is
actually stopped.

						- Ted

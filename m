Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE644859BC
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 21:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiAEUEU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 15:04:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57159 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243887AbiAEUDH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 15:03:07 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 205K2wpv004394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 15:02:59 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A6E215C00E1; Wed,  5 Jan 2022 15:02:58 -0500 (EST)
Date:   Wed, 5 Jan 2022 15:02:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     guan@eryu.me, fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl
 directly
Message-ID: <YdX5csi2qZjS1KOt@mit.edu>
References: <Yb9M3aIb9cJGIJaB@desktop>
 <20211220204059.2248577-1-tytso@mit.edu>
 <20220105155743.6knpj4zsbmy62uwj@zlang-mailbox>
 <20220105160619.r66lacgq7b7ucyuk@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105160619.r66lacgq7b7ucyuk@zlang-mailbox>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 06, 2022 at 12:06:19AM +0800, Zorro Lang wrote:
> > This patch looks good to me, I just want to ask if we'd better to try to include
> > ext2fs/ext2fs.h at here? And of course, check it in configure.ac.
> > The EXT4_IOC_RESIZE_FS looks like defined in ext2fs/ext2_fs.h which comes from
> > e2fsprogs-devel package. I can't find this definition from kernel-hearders package.
> > As you're the expert of this part, please correct me if it's wrong :)

We're not depending on ext2fs/ext2_fs.h and hence the e2fsprogs-devel
(or libext2fs-dev package if you're using Debian/Ubuntu) anywhere else
in the xfstests-dev.  It's not like the code points for
EXT4_IOC_RESIZE_FS are going to change, so we just use constructs
like:

#ifndef EXT4_IOC_RESIZE_FS
#define EXT4_IOC_RESIZE_FS           _IOW('f', 16, __u64)
#endif

in xfstests-dev/src/*.c as needed.

There's no real upside in adding a dependency which makes it harder
for developers to compile xfstests.  (Trivia note: I created
xfstests-bld several years ago because back then, Debian didn't
include some of the internal header files from xfsprogs which xfstests
needed.)

Cheers,

						- Ted

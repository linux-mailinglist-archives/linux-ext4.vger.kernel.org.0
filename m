Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9627478B8
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGDTeg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDTef (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 15:34:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529410C9
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 12:34:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-5.bstnma.fios.verizon.net [173.48.102.5])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 364JXvM8016277
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 15:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688499239; bh=a/hYOHJOkSry0UDTQ201cVWuuRSTQMAsl1WqU881mt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=nLNUd2N1VENrRzY6nXkyXkl0YCtj3e73DX4ylJaNuyock4Z+QJouH+Fc6iWau67fG
         5hiEsaodvN7xgqU/2IialuZ93FVlAoltoHiGlD6EveVlU1lxc1kJaxrl+prSC+7m5E
         ZtoKZPs1ACUh0za37FlkDGui5IXeREdOzKMle8CiZ+ozEI+hoDytmEC8PhBDLynf4K
         IjITYY5YaZrmiYEiRq8KQ5D6Vve8OMcWq5ytn1Gyapd5E36Gy+kX7pkS9Tf4LFJJAJ
         l3PldQyypodvfInfnhsfD151/D/9spGfaScOT12FZQ/cwVQgMSjN9PowgDCT6i4IX8
         H/c0OmFzvjxgQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 226AF15C0280; Tue,  4 Jul 2023 15:33:57 -0400 (EDT)
Date:   Tue, 4 Jul 2023 15:33:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        louhongxiang@huawei.com, liuzhiqiang26@huawei.com,
        Ye Bin <yebin@huaweicloud.com>
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
Message-ID: <20230704193357.GG1178919@mit.edu>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
 <20230626021758.GF8954@mit.edu>
 <4e647e9b-4f2f-b89f-6825-838f22c4bf2e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e647e9b-4f2f-b89f-6825-838f22c4bf2e@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 04, 2023 at 04:35:43PM +0800, zhanchengbin wrote:

> 3) Add interface write_super in ext4_ioctl. The mount point is
> obtained through the block device, and open a random file in the
> file system, the superblock is passed to the kernel through ioctl of
> the file, and finally, the superblock is flushed to disk. Due to the
> inherent risks associated with granting user space write permissions
> to the superblock, it is deemed unsafe to utilize the entire
> superblock as provided by user space. Instead, the superblock should
> be validated, followed by selective data writing and recording. Of
> course, it is dangerous to directly modify the data in the super
> block, so I plan to add a flag in the super block to record that
> this modification is from the user state.


> Personally speaking, I favour the third solution the most, what are
> your opinions? If you already have other schemes, I will be more
> than delighted to discuss it with you.  Looking foward to hearing
> from you soon

I agree that the third solution (or some variant thereof) is the best.
The first two involve changes to the block layer, and in addition the
problems you've outlined, different file systems have file systems in
different superblocks in locations on disk, and the superblock may be
differently sized, etc.  The problem we are trying to solve is also
fairly unique to ext2/3/4, since many other file systems either have
their own specialized ioctls, or they may simply not allow any file
system tuning operations while the file system is mounted.

The problem though with a write_super() ioctl though is that while it
solves the problem of false positive complaints from syzbot (at least
according to my opinion, sane threat models --- the syzbot folks seem
to disagree about what a sane threat model ought to be), it doesn't
solve the *other* problem which is that the superblock can also be
modified by the kernel, so there are some inherent race conditions
that can occcur when userspace and kernel are trying to modify the
superblock at the same time.

This can be potentially solved by a lot of checks by the kernel code
handling the hypothetical EXT4_IOC_WRITE_SUPER ioctl.  This could be
improved by a passing in a second superblock so the ioctl handling
code can compare the modified superblocks between the original and
modified superblock, and then apply more sanity checks.  But that's a
lot of extra complexity, and you won't know whether the kernel will
support modifying some pariticular superblock field.

So the better approach is to have multiple new ioctl's for each
superblock field (or set of fields) that you might want modify.  We
have some of these already --- for example, EXT4_IOC_SETFSUUID and
FS_IOC_SETFSLABEL.  For tune2fs, all of additional ioctls for making
configuration changes while the file system is mounted are:

   * EXT4_IOC_SET_FEATURES
	- for tune2fs -O...
   * EXT4_IOC_CLEAR_FEATURES
	- for tune2fs -O^...
   * EXT4_IOC_SET_ERROR_BEHAVIOR
	- for tune2fs -e
   * EXT4_IOC_SET_DEFAULT_MOUNT_FLAGS
        - for tune2fs -o
   * EXT4_IOC_SET_DEFAULT_MOUNT_OPTS
        - for tune2fs -E mount_opts=XXX
   * EXT4_IOC_SET_FSCK_POLICY
	- for tune2fs -[cCiT]
   * EXT4_IOC_SET_RESERVED_ALLOC
	- for tune2fs -[ugm]

(The last two assumes using a structure, since it's probably not worth
creating 7 new ioctls when 2 would probably do).

Some of these ioctls are pretty esoteric, and are rarely used by most
system adminsitrators.  And we don't have to add all of them all at
once; we could gradually add some of them, and most of these are
simple enough that we could assign them as a starter project for a new
college grad that you've hired into your company, or to an intern.

Cheers,

						- Ted

P.S.  I've ignored ioctls to "get" the superblock.  We could just have
a single EXT4_IOC_READ_SUPERBLOCK, or we can solve the problem by
simply having the userspace use an O_DIRECT to read the superblock,
since this will avoid the potential invalid checksum issues the
superblock will only be written out to disk by the kernel when it is
self-consistent.

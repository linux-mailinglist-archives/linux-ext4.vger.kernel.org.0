Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616CD64668D
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLHBhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 20:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHBhP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 20:37:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FB900DE
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 17:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F59DB821A5
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 01:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B7C433D6
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 01:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670463431;
        bh=nFDiteMICbZtbizBzUkdHP0ocrGg0lx4uX06vyDmZA0=;
        h=Date:From:To:Subject:From;
        b=g9m8RStATSYZHhvcK4umH4X6BiXetPWgz3LtbuHv3/S7oDNsuPAams5aHFPxfZmqS
         iLuHHB5VYPpxjDT+oMdKpo9UNz2MfU++/SmaoZXqpyY8nx2IHDslR939WsaXu8FJYQ
         W6f30RMBQ1LwR8mH3YQPKTC60gzU831Cxklfqp4LlJB8Z7qULCQXsRWG0uxyHzdpff
         RCo/i89Dk6aQeu5ZAg5/iDlKUQG2DNnqgN27Wv8BbBA9fRbr0HbejfJzDrC2YbPLpL
         k97WtGXZCN021jYo0oN22salafTEjY3yqes4+KOGOWW29vGjx5NG0/x3yUJ7jb3ndE
         IvMwBJkiZDtcA==
Date:   Wed, 7 Dec 2022 17:37:10 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: uninit variable warnings on gcc 11.3?
Message-ID: <Y5E/xhJyFIXN31oZ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi everyone,

I went on a spree of trying to build things with W=12e this afternoon,
and I noticed that gcc spat out the following warnings.  I can't tell if
these warnings are bogus noise or if they actually could cause problems,
particularly in the extent status tree bits.  That said, IIRC there's
been some mention of weirdness wrt that part of ext4, so I thought I
should mention this in case it's significant to anyone.

--D

In file included from /storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:33:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c: In function ‘ext4_ext_map_blocks’:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/ext4_extents.h:230:15: warning: ‘zero_ex2.ee_start_lo’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  230 |         block = le32_to_cpu(ex->ee_start_lo);
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3426:38: note: ‘zero_ex2.ee_start_lo’ was declared here
 3426 |         struct ext4_extent zero_ex1, zero_ex2;
      |                                      ^~~~~~~~
In file included from /storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:33:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/ext4_extents.h:231:19: warning: ‘zero_ex2.ee_start_hi’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  231 |         block |= ((ext4_fsblk_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3426:38: note: ‘zero_ex2.ee_start_hi’ was declared here
 3426 |         struct ext4_extent zero_ex1, zero_ex2;
      |                                      ^~~~~~~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3140:16: warning: ‘zero_ex2.ee_block’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 3140 |         return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 3141 |                                      EXTENT_STATUS_WRITTEN);
      |                                      ~~~~~~~~~~~~~~~~~~~~~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3426:38: note: ‘zero_ex2.ee_block’ was declared here
 3426 |         struct ext4_extent zero_ex1, zero_ex2;
      |                                      ^~~~~~~~
In file included from /storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:33:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/ext4_extents.h:230:15: warning: ‘zero_ex1.ee_start_lo’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  230 |         block = le32_to_cpu(ex->ee_start_lo);
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3426:28: note: ‘zero_ex1.ee_start_lo’ was declared here
 3426 |         struct ext4_extent zero_ex1, zero_ex2;
      |                            ^~~~~~~~
In file included from /storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:33:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/ext4_extents.h:231:19: warning: ‘zero_ex1.ee_start_hi’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  231 |         block |= ((ext4_fsblk_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3426:28: note: ‘zero_ex1.ee_start_hi’ was declared here
 3426 |         struct ext4_extent zero_ex1, zero_ex2;
      |                            ^~~~~~~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3140:16: warning: ‘zero_ex1.ee_block’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 3140 |         return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 3141 |                                      EXTENT_STATUS_WRITTEN);
      |                                      ~~~~~~~~~~~~~~~~~~~~~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/extents.c:3426:28: note: ‘zero_ex1.ee_block’ was declared here
 3426 |         struct ext4_extent zero_ex1, zero_ex2;
      |                            ^~~~~~~~
  CC [M]  fs/ext4/inode.o
  CC [M]  fs/ext4/ioctl.o
  CC [M]  fs/ext4/mballoc.o
  CC [M]  fs/ext4/migrate.o
  CC [M]  fs/ext4/mmp.o
  CC [M]  fs/ext4/move_extent.o
  CC [M]  fs/ext4/namei.o
  CC [M]  fs/ext4/readpage.o
  CC [M]  fs/ext4/page-io.o
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/inode.c: In function ‘ext4_page_mkwrite’:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/inode.c:6205:23: warning: ‘get_block’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 6205 |                 err = block_page_mkwrite(vma, vmf, get_block);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC [M]  fs/ext4/resize.o
  CC [M]  fs/ext4/super.o
  CC [M]  fs/ext4/symlink.o
  CC [M]  fs/ext4/sysfs.o
  CC [M]  fs/ext4/xattr.o
  CC [M]  fs/ext4/xattr_hurd.o
  CC [M]  fs/ext4/xattr_trusted.o
  CC [M]  fs/ext4/xattr_user.o
  CC [M]  fs/ext4/fast_commit.o
  CC [M]  fs/ext4/orphan.o
  CC [M]  fs/ext4/acl.o
  CC [M]  fs/ext4/xattr_security.o
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/super.c: In function ‘ext4_fill_super’:
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/super.c:5486:15: warning: ‘first_not_zeroed’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 5486 |         err = ext4_register_li_request(sb, first_not_zeroed);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/super.c:5042:22: note: ‘first_not_zeroed’ was declared here
 5042 |         ext4_group_t first_not_zeroed;
      |                      ^~~~~~~~~~~~~~~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/super.c:3253:46: warning: ‘logical_sb_block’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 3253 |                 if (block_bitmap >= sb_block + 1 &&
      |                                     ~~~~~~~~~^~~
/storage/home/djwong/cdev/work/linux-xfs/fs/ext4/super.c:5036:22: note: ‘logical_sb_block’ was declared here
 5036 |         ext4_fsblk_t logical_sb_block;
      |                      ^~~~~~~~~~~~~~~~

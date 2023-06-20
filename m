Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE632736BDD
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jun 2023 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjFTMZe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Jun 2023 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjFTMZd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Jun 2023 08:25:33 -0400
Received: from fulda116.server4you.de (mister-muffin.de [144.76.155.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD0710C2
        for <linux-ext4@vger.kernel.org>; Tue, 20 Jun 2023 05:25:27 -0700 (PDT)
Received: from localhost (ip1f12fe38.dynamic.kabel-deutschland.de [31.18.254.56])
        by mister-muffin.de (Postfix) with ESMTPSA id 1E5C61BF5;
        Tue, 20 Jun 2023 14:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
        s=mail; t=1687263417;
        bh=H73yb/4Nmsq/KDuoAdh0q8PT3PYX8q0B5CbsGy04AJo=;
        h=From:To:Cc:Subject:Date:From;
        b=ln1cL2AREBJc2ExSBkQBwuEg3rFYfvkZtNs6DSIVmEy/EJYzC71N/PccGdUCdgGDA
         +Jp/cJT80u4j8bFhmx7v6+X2nkDDR50muhXEyta9WqTu0hlJkYngtH44JfA5Tu/abj
         3fGvhri6KzUtrgEgb7FcXnlFxLZDrqykPadi832s=
From:   Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To:     linux-ext4@vger.kernel.org
Cc:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Subject: [PATCH 0/1] allow mke2fs to understand tarballs as input
Date:   Tue, 20 Jun 2023 14:16:40 +0200
Message-Id: <20230620121641.469078-1-josch@mister-muffin.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I have already submitted this patch to Theodore Ts'o's github [1] but was
advised that most patch proposals should go to linux-ext4@vger.kernel.org to
get more review. I already got a lot of useful feedback in that github pull
request, so the proposed patch already contains a few improvements over my
initial version. Thanks a lot to Theodore Ts'o for their feedback!

I'm now reaching out to this list to get more input and iterate on this patch
to get it ready for inclusion into e2fsprogs.

I'm not very familiar with sending my patches via git-send-email, so please be
patient with me surrounding this process and involved etiquettes. Please point
out any mistakes so that I can improve myself.

My intend with this patch is to remove my need for genext2fs [1] which is slow
(seems to be O(N²)) and ext2-only, so it's missing important features like
extended attributes and year-2038 support.

The reason I want mke2fs to understand tarballs instead of directories is, that
I want to be able to create filesystems without requiring superuser privileges.
Using unshared user namespaces, this already works most of the way but even
with those I'm unable to create device nodes. My main motivation is tarballs of
Linux systems, so special devices under /dev should get included in the final
ext4 image.

An alternative way to supply device nodes to the final file system are
"spec-files" as they can for example be provided to genext2fs via the
--devtable option. These files are ascii tables, each row containing a path, a
type, a mode, uid, gid and so on. While it would be possible for mke2fs to also
gain a --devtable option, I argue that being able to read the same information
from a tarball is superior because

 a) tools and users interacting with mke2fs do not need to learn about yet
    another file format
 b) using tarballs, all information is contained in a single file instead of
    a directory containing many files plus a spec-file
 c) tarballs are a well-established distribution method for chroot environments
 d) no additional tool would be needed to turn the information stored in a
    tarball into a spec-file

Adding a --devtable=spec-file option might still be useful for platforms
without support for libarchive.

One risk with using libarchive is, that its SOVERSION needs to remain the same.
The last SOBUMP of libarchive happened 10 years ago. I opened an issue with
libarchive asking about the stability of the interface [3].

What are your thoughts?

Thanks!

cheers, josch

[1] https://github.com/tytso/e2fsprogs/pull/118
[2] https://github.com/bestouff/genext2fs
[3] https://github.com/libarchive/libarchive/issues/1854

Johannes Schauer Marin Rodrigues (1):
  mke2fs: the -d option can now handle tarball input

 MCONFIG.in                     |   1 +
 configure                      |  52 +++
 configure.ac                   |   9 +
 debugfs/Makefile.in            |   2 +-
 lib/config.h.in                |   3 +
 lib/ext2fs/Makefile.in         |   2 +-
 misc/Makefile.in               |   2 +-
 misc/create_inode.c            | 621 ++++++++++++++++++++++++++++++++-
 misc/mke2fs.8.in               |  10 +-
 misc/mke2fs.c                  |  12 +-
 tests/m_rootgnutar/expect      | 188 ++++++++++
 tests/m_rootgnutar/output.sed  |   5 +
 tests/m_rootgnutar/script      |  88 +++++
 tests/m_rootpaxtar/expect      |  87 +++++
 tests/m_rootpaxtar/mkpaxtar.pl |  69 ++++
 tests/m_rootpaxtar/output.sed  |   5 +
 tests/m_rootpaxtar/script      |  44 +++
 tests/m_roottar/expect         | 208 +++++++++++
 tests/m_roottar/mktar.pl       |  62 ++++
 tests/m_roottar/output.sed     |   5 +
 tests/m_roottar/script         |  57 +++
 21 files changed, 1513 insertions(+), 19 deletions(-)
 create mode 100644 tests/m_rootgnutar/expect
 create mode 100644 tests/m_rootgnutar/output.sed
 create mode 100644 tests/m_rootgnutar/script
 create mode 100644 tests/m_rootpaxtar/expect
 create mode 100644 tests/m_rootpaxtar/mkpaxtar.pl
 create mode 100644 tests/m_rootpaxtar/output.sed
 create mode 100644 tests/m_rootpaxtar/script
 create mode 100644 tests/m_roottar/expect
 create mode 100644 tests/m_roottar/mktar.pl
 create mode 100644 tests/m_roottar/output.sed
 create mode 100644 tests/m_roottar/script

-- 
2.40.0


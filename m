Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E077A09B
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Aug 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHLPDz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Aug 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLPDy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Aug 2023 11:03:54 -0400
Received: from fulda116.server4you.de (mister-muffin.de [144.76.155.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5DB510FB
        for <linux-ext4@vger.kernel.org>; Sat, 12 Aug 2023 08:03:53 -0700 (PDT)
Received: from localhost (unknown [37.4.231.34])
        by mister-muffin.de (Postfix) with ESMTPSA id AD9FD360;
        Sat, 12 Aug 2023 17:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
        s=mail; t=1691852631;
        bh=3SzlG3W8vAQIDsr2VGMXcD2ThRqWNoQkipHCdzBmIms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo46DmnI5ovvlT5jlbyzZqlhPOvlu7wxVqVNLh0Os4kxweyJBE4zOwY0f+ff9ITMd
         uH5y07Q3XjJzvmsG4SNOVZ3S8sLBGszxgIVRS/xwjM/JFasgMMYHXDUyxwcPTvZ/2R
         yGEswj2Mv3YCcJnaVoiBxyHmbly0GkWWAdROLDEU=
From:   Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To:     linux-ext4@vger.kernel.org
Cc:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>,
        adilger@dilger.ca, djwong@kernel.org
Subject: [PATCH v2 0/1] mke2fs: the -d option can now handle tarball input
Date:   Sat, 12 Aug 2023 17:02:04 +0200
Message-Id: <20230812150204.462962-1-josch@mister-muffin.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: 605DCBDE-A388-4B98-BF5A-38773F15E3F4@dilger.ca
References: <605DCBDE-A388-4B98-BF5A-38773F15E3F4@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andreas,

thank you for your input!

> Having just looked through the patch, I think it could use some cleanup.
> Basic code style issues:
> - wrapping lines at 80-columns
> - avoid use of C++ comments in the code
> - consistent indentation for continued lines
> - consistent one blank line between functions
> - consistent one blank line after variable declarations

I've used clang-format with the `.clang-format` from the linux git to
format the code. I also ran `scripts/checkpatch.pl` from linux to fix
some more issues.

> - split large highly-indented code blocks into helper functions

There was particularly one highly indented switch() which I now put into
its own function.

> In terms of code structure, refactoring it to put libarchive handling 
> in a separate file (e.g. mke2fs-archive.c or similar) would also make 
> the maintenance easier, since it can be added/removed from the build 
> more easily, and (if necessary) removed from the tree if it is no longer 
> working.

I've moved most of the libarchive functions into misc/create_inode_libarchive.c
and hope this improves the situation. I've had to modify a couple of
Makefile.in, make some functions of misc/create_inode.c non-extern and add them
to create_inode.h so that misc/create_inode_libarchive.c can make use of them.
Is this what you had in mind?

> Then have only a couple of small function calls in the main mke2fs.c 
> code that are accessing the libarchive functionality if it is built-in, 
> or being no-ops (or just printing the error message) if libarchive is 
> unavailable.

All the libarchive-specific functionality is behind __populate_fs_from_tar()
which is the only function exposed in misc/create_inode_libarchive.h. If
e2fsprogs was compiled without libarchive, an error message will be shown
if the user tries to pass a regular file instead of a directory. If
e2fsprogs was compiled with libarchive but the user does not have the
shared library installed, another error about this will be displayed.

There are probably still many things about my patch that can be improved.

Thanks a lot for considering this and having a look at it!

cheers, josch



P.S. (more like a record for future-me) I tested that my changes allow
libarchive to be compiled with and without libarchive headers installed
and with and without libarchive shared library installed by running:

mmdebstrap --variant=apt --include=git,ca-certificates,build-essential,autoconf,automake,autoconf-archive,pkg-config,gettext,texinfo,libblkid-dev,uuid-dev,m4,libarchive-dev \
	--chrooted-customize-hook='git clone https://github.com/josch/e2fsprogs.git 
		&& cd e2fsprogs && git checkout libarchive-linux-ext4 && autoreconf -fi
		&& ./configure && make -j4
		&& make check || cat tests/m_rootgnutar.failed tests/m_rootgnutar.log
		&& apt remove --yes libarchive13
		&& tar -C include -c . | ./misc/mke2fs -q -F -o Linux -T ext4 -O metadata_csum,64bit -E lazy_itable_init=1 -b 1024 -d - image.ext4 16384' \
	unstable /dev/null


Johannes Schauer Marin Rodrigues (1):
  mke2fs: the -d option can now handle tarball input

 MCONFIG.in                     |   1 +
 configure                      | 134 ++++---
 configure.ac                   |   9 +
 debugfs/Makefile.in            |  25 +-
 lib/config.h.in                |   3 +
 lib/ext2fs/Makefile.in         |  25 +-
 misc/Makefile.in               |  17 +-
 misc/create_inode.c            |  61 ++-
 misc/create_inode.h            |  10 +
 misc/create_inode_libarchive.c | 677 +++++++++++++++++++++++++++++++++
 misc/create_inode_libarchive.h |  10 +
 misc/mke2fs.8.in               |  10 +-
 misc/mke2fs.c                  |  12 +-
 tests/m_rootgnutar/expect      | 141 +++++++
 tests/m_rootgnutar/output.sed  |   5 +
 tests/m_rootgnutar/script      | 123 ++++++
 tests/m_rootpaxtar/expect      |  87 +++++
 tests/m_rootpaxtar/mkpaxtar.pl |  69 ++++
 tests/m_rootpaxtar/output.sed  |   5 +
 tests/m_rootpaxtar/script      |  44 +++
 tests/m_roottar/expect         | 208 ++++++++++
 tests/m_roottar/mktar.pl       |  62 +++
 tests/m_roottar/output.sed     |   5 +
 tests/m_roottar/script         |  57 +++
 24 files changed, 1714 insertions(+), 86 deletions(-)
 create mode 100644 misc/create_inode_libarchive.c
 create mode 100644 misc/create_inode_libarchive.h
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


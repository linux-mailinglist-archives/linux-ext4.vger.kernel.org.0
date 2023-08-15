Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0523F77D16D
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbjHOR5x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbjHOR5i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 13:57:38 -0400
Received: from fulda116.server4you.de (mister-muffin.de [144.76.155.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C958F1BDB
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 10:57:34 -0700 (PDT)
Received: from localhost (ip2504e722.dynamic.kabel-deutschland.de [37.4.231.34])
        by mister-muffin.de (Postfix) with ESMTPSA id 2871D16C;
        Tue, 15 Aug 2023 19:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
        s=mail; t=1692122253;
        bh=p9p7SZOeZEGuSGGyRDlLrGlx5RTnaTS5p6bjcKgmN0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLd+/dG0Jrt0eSx0jqA6lkQp3zhB5B+wntRU22eyzpeJRb/i95a6lXnRWAaXQNyg9
         gj060RqfXfDseogHPphuIziwreEFNIwFEkF824peWbLQ0ZhUdpIjdid/0yCBM7CYq6
         El1ggm9zqORliIlWHWgwLaF4n0ee3+D7Es+t46FU=
From:   Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To:     linux-ext4@vger.kernel.org
Cc:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Subject: [PATCH v3 0/1] mke2fs: the -d option can now handle tarball input
Date:   Tue, 15 Aug 2023 19:57:16 +0200
Message-Id: <20230815175717.781425-1-josch@mister-muffin.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <1FD4874D-0E9C-442C-9FC1-AC35DCFD0A3C@dilger.ca>
References: <1FD4874D-0E9C-442C-9FC1-AC35DCFD0A3C@dilger.ca>
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

thanks a lot for your second review!! :)

> The big question is whether Ted will accept it.

My hope rests in the fact that Ted did not (yet) absolutely refuse to add such
a feature in their comments to the github pull request [1]. XD

[1] https://github.com/tytso/e2fsprogs/pull/118

> These parts of the change is specific to your system and should probably
> be removed from the patch.

Ah thank you for that clarification. I was a bit puzzled that you have a
generated file tracked by git and was unsure what the policy is for updating
it. This should be fixed now.

> Rather than having an inline #ifdef here, this could be structured like
> the following in create_file_libarchive.c:

I now see that you already tried to tell me how you'd like to see this in an
earlier mail but I didn't understand what you wanted to tell me. Thank you for
spelling it out for me. I hope my changes now look as you expected. I agree
that it looks much better now.

> If we expect larger files, having a 1MB or 16MB buffer is not outrageous
> these days, and would probably improve the performance noticeably.

In my own use-case I want to convert tarballs containing chroot
environments into an ext4 image. I'm on a fairly limited system (ARM
Cortex A53 @ 1.5 GHz and 4 GB RAM) and loading up a YouTube video in
Firefox takes about half a minute until it starts playing. So I'd expect
that if buffer size has any meaningful impact it would show up as a
significant difference on my system with its limited resources. So I
converted a chroot tarball of 429 MB to an ext4 image 10 times for each
buffer size and averaged the runtime as well as recorded the fastest of
the 10 runs. These are the results:

COPY_FILE_BUFLEN  time in s  min in s
65536             145.576    14.240
1048576           144.866    14.098
16777216          147.142    14.317

What else can I test? It seems that a 1 MB buffer is slightly fastest.
But I still didn't finish that part of the patch because I'm not sure
whether my benchmark should be improved or whether it looks different on
other platforms.

Thanks!

cheers, josch



Johannes Schauer Marin Rodrigues (1):
  mke2fs: the -d option can now handle tarball input

 MCONFIG.in                     |   1 +
 configure                      |  52 +++
 configure.ac                   |   9 +
 debugfs/Makefile.in            |  25 +-
 lib/config.h.in                |   3 +
 lib/ext2fs/Makefile.in         |  25 +-
 misc/Makefile.in               |  17 +-
 misc/create_inode.c            |  45 ++-
 misc/create_inode.h            |  10 +
 misc/create_inode_libarchive.c | 699 +++++++++++++++++++++++++++++++++
 misc/create_inode_libarchive.h |  10 +
 misc/mke2fs.8.in               |  10 +-
 misc/mke2fs.c                  |  12 +-
 tests/m_rootgnutar/expect      | 141 +++++++
 tests/m_rootgnutar/output.sed  |   5 +
 tests/m_rootgnutar/script      | 125 ++++++
 tests/m_rootpaxtar/expect      |  87 ++++
 tests/m_rootpaxtar/mkpaxtar.pl |  69 ++++
 tests/m_rootpaxtar/output.sed  |   5 +
 tests/m_rootpaxtar/script      |  44 +++
 tests/m_roottar/expect         | 208 ++++++++++
 tests/m_roottar/mktar.pl       |  62 +++
 tests/m_roottar/output.sed     |   5 +
 tests/m_roottar/script         |  57 +++
 24 files changed, 1691 insertions(+), 35 deletions(-)
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


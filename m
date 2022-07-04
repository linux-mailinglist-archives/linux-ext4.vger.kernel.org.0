Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5F3564E3D
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGDHHS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDHHS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFBEBBA
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d17so8139354pfq.9
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1q9dPoaAmP+szXAXb5fxPpLmLgp6GGIdqEatB8jVaM=;
        b=UrMP/3HE9jgfDtyYneFlSEx4eXyeG6l1ytuce+MtXITy/JNpJPn3SvHSpBuIwO1Dmi
         iQeHeP6t5+hB5h8vY2AER/8Atohi3ZiA9jn4pSTPQ2ZcXsX3X1unxEe4Zpn4YRENo4en
         YY57WLUzF8i1eKVcqQ43wBuwa3/SbwQwn6NSAmDV22g99gWPyaEuoyJdWF1bPFTScdrn
         rVNea7hw4c9kM5Bm1RhDlS75aKRKH5TWpSybIxYCfcWT8/D7vlR4Svq9QZ+eAsZEUbMD
         a8AqORq4J4yOJ/vLNdlnYlyPHIcrSsQbMWeLHBz3npFUd0UiCrdT86vJAOPCR8BClpmy
         DsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1q9dPoaAmP+szXAXb5fxPpLmLgp6GGIdqEatB8jVaM=;
        b=bu8cCU0RoaTOWKIbZMpAjBJCHLeYb+lcpEYXGsdEmvvO4dA13rvon617kGmPT9bWX3
         YlkKfjesJ03GJ4byWjJbU0mMyh1O3rBpufYkiQheFjiAJilsBQSxd4agkeuBuiqhRRpQ
         GuNxvjsaGEKKf8UwXsTqUoxiEXMuYQV7qLHX1HUqmId5W0FYd/uqOZ2PDVyB7weqlHBo
         mU9y0kyeGJ8QUME3MjsnihT2TrGxAikxZ2MzHHENMz+xozztnZ6s/hUVdy2dsQlFPdwv
         4k00vaNmqdxHmPepn/3gclOfdqSjOIq8q6feiNIE13kteMzPbR/C3VmZlCetCy1hLrki
         8NZg==
X-Gm-Message-State: AJIora+pPysyxXfIW8L2sMuCHpp2IX3WSSY5vgj+bg/kNk8EMnojwlNq
        GzboGZoyA9A6aaQn98ONaRI=
X-Google-Smtp-Source: AGRyM1sVNGcH0m4BAwqIGE6ge1g/FNgdqlSVClCg1fYS9N8D8GV9zM7IbOHWRpPgFY1Eh1ehxZk+dw==
X-Received: by 2002:a63:481a:0:b0:411:7951:cbcd with SMTP id v26-20020a63481a000000b004117951cbcdmr23994177pga.66.1656918436482;
        Mon, 04 Jul 2022 00:07:16 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090276c400b0016188a4005asm20219587plt.122.2022.07.04.00.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:16 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 00/13] libext2fs: Add merge/clone abstraction changes
Date:   Mon,  4 Jul 2022 12:36:49 +0530
Message-Id: <cover.1656912918.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Though this series is not yet ready to be merged (due to few more todos), but I atleast
wanted to get this base patch series out with some action items listed of what I
am planning to do next and whether it is inline with the expectation as I last
discussed here [1].
So looking at older review comments, it looks like we wanted a base patch series
with libext2fs clone/merge apis so that anyone wanting to do parallel I/O could utilize
libext2fs abstraction changes API for clone and merge of it's ext2_filsys structure.

Earlier the I/O manager abstraction changes for doing parallel I/O were already merged.
This patch series mainly adds the libext2fs abstraction changes for cloning and merging
libext2fs data structures.

So next few todos that I am planning are (some of which are sitting in my tree but still needs more work)
1. Add dblist unit test - there is nothing that exist today for dblist unit
   tests.
2. Fix the todos listed in libext2fs merge/clone patch since some of those are not required
   while cloning ext2_filsys structure and it's members.
3. Start bringing in the pfsck base changes (work done by others) to this series along with writing
   unit tests for those.
4. Work on making older pfsck patches, work with latest features that have gone in like fastcommit,
   casefolding etc.
5. Make sure that the later bug fixes (and some which I have identified), should be included in the
   original feature patches (rather than as a separate bug fix patches).
6. Make sure to add more tests for pfsck with fuzzed images with e2fuzz.
7. Later we could work on other passes and/or other tools like debugfs etc, to make it parallel.

Please let me know if this is going in the right direction. Also if you could take a look
at this series and kindly let me know whether patches looks ok to you.

I guess this might have taken longer than I earlier estimated. But I will definitely try to
correct that with future revisions.

[1]: https://lore.kernel.org/linux-ext4/20220321164009.dwqmdo7axyyixn2t@riteshh-domain/

-ritesh

NOTE (Background)
===================
As I understand, earlier to make fsck parallel, the patches added io_manager
relationship directly within e2fsck_t struct. Which is a layering violation
which will expose internal library functions and structures to it's clients.
Also if any other client (e.g. debugfs etc.) who would like to add threading
support will also have to do the same work in their structures.

So instead we now have added a parent structure of same type within ext2_filsys
struct for multi-threading support. And libext2fs is responsible for providing
the meaningful apis to it's client for clone/merge of it's data structures/bitmaps
for parallel threading support based on the flags passed by it's clients.

                                +------------------+
                                | DS relationships |
                    %===============================================%
                    % typedef struct struct_io_manager *io_manager; %
                    % typedef struct struct_io_channel *io_channel; %
                    % typedef struct struct_io_stats *io_stats;     %
                    %===============================================%

                                +-----------------+
                                | e2fsck/e2fsck.h |
                                +-------------------------------+
                                | (ctx) struct e2fsck_t  {      |
                         +------|------ ext2_filsys fs          |
                         |      |       io_manager io_manager --|-------------------+  --> layering violation
                         |      |       io_channel	journal_io  |                   |
                         |      | }                             |                   |
                         |      +-------------------------------+                   |
                         +---+                                                      |
        <<<< Libext2fs >>>>  |                                                      |
                    +----------------------+                                        |
                    | lib/ext2fs/ext2fs.h  |                                        |
                    +-----------------------------+                                 |
                    | (fs) struct ext2_filsys {   |                                 |
                    | (struct struct_ext2_filsys) |                                 |
                    |         io_channel io       |                                 |
                    |              |              |                                 |
                    +--------------v--------------+                                 |
                                   |                                                |
         <<<< IO LAYER >>>>>>>     |                                                |
                +----------------------+                                            |
                | lib/ext2fs/ext2_io.h |                                            |
                +-----------------------------------------------+----+              |
                | (io) typedef struct struct_io_channel *io_channel{ |              |
          +---- |                  io_manager manager                |              |
          |     |                  void *private_data                |              |
          |     +----------------------------------------------------+              |
          |                          |                                              |
          |                          | (io_channel-> io_manager)                    v
          |  +--------------------------------------------------------------------------------------------------+
          |  | lib/ext2fs/windows_io.c <global> 1041 io_manager windows_io_manager  = &struct_windows_manager;  |
          |  | lib/ext2fs/sparse_io.c <global> 554 io_manager sparsefd_io_manager   = &struct_sparsefd_manager; |
          |  | lib/ext2fs/sparse_io.c <global> 553 io_manager sparse_io_manager     = &struct_sparse_manager;   |
          |  | lib/ext2fs/unix_io.c <global> 1437 io_manager unixfd_io_manager      = &struct_unixfd_manager;   |
          |  | lib/ext2fs/inode_io.c <global> 79 io_manager inode_io_manager        = &struct_inode_manager;    |
          |  | lib/ext2fs/unix_io.c <global> 1415 io_manager unix_io_manager        = &struct_unix_manager;     |
          |  | lib/ext2fs/undo_io.c <global> 1125 io_manager undo_io_manager        = &struct_undo_manager;     |
          |  | lib/ext2fs/test_io.c <global> 555 io_manager test_io_manager         = &struct_test_manager;     |
          |  | lib/ext2fs/dosio.c <global> 75 io_manager dos_io_manager             = &struct_dos_manager;      |
          |  +--------------------------------------------------------------------------------------------------+
          |
          | (io_channel->private_data)
          |    +-------------------------------------------------------------+
          |    | lib/ext2fs/nt_io.c:206:20:typedef struct _NT_PRIVATE_DATA { |
          |    | lib/ext2fs/windows_io.c:95:16:struct windows_private_data { |
          |    | lib/ext2fs/inode_io.c:34:14:struct inode_private_data {     |        +--------------------------------------+
           --->| lib/ext2fs/unix_io.c:103:13:struct unix_private_data {      |<-------| struct unix_private_data {           |
               | lib/ext2fs/undo_io.c:126:13:struct undo_private_data {      |        |     struct struct_io_stats io_stats; |
               | lib/ext2fs/test_io.c:45:13:struct test_private_data {       |        +--------------------------------------+
               +------------------------^------------------------------------+
                                        |
                    +-------------------|--------------------+
                    | struct undo_private_data {             |
                    |         /* the undo file io channel */ |
                    |         io_channel undo_file;          |
                    |         /* The backing io channel */   |
                    |         io_channel real;               |
                    |         char *tdb_file;                |
                    | }                                      |
                    +----------------------------------------+

	Fig: Depicting that with this patch series, there is no need to add "io_manager" into ext2_filsys which was done by original pfsck implementation.


Li Xi (1):
  dblist: add dblist merge logic

Ritesh Harjani (8):
  gen_bitmaps: Fix ext2fs_compare_generic_bmap/bitmap logic
  badblocks: Remove unused badblocks_flags
  blkmap64_ba: Add common helper for bits size calculation
  blkmap64_ba: Implement initial implementation of merge bitmaps
  tst_bitmaps_standalone: Add copy and merge bitmaps test
  tst_bitmaps_pthread: Add merge bitmaps test using pthreads
  tst_badblocks: Add unit test to verify badblocks list merge api
  tst_libext2fs_pthread: Add libext2fs merge/clone unit tests

Saranya Muruganandam (1):
  libext2fs: dupfs: Add fs clone & merge api

Wang Shilong (3):
  ext2fs/bitmaps: Add merge bitmaps library abstraction changes
  libext2fs: blkmap64_rb: Add rbtree bmap merge logic changes
  badblocks: Add badblocks merge logic

 lib/ext2fs/Makefile.in              |  53 ++++-
 lib/ext2fs/badblocks.c              |  81 ++++++-
 lib/ext2fs/bitmaps.c                |   9 +
 lib/ext2fs/blkmap64_ba.c            |  73 ++++++-
 lib/ext2fs/blkmap64_rb.c            |  65 ++++++
 lib/ext2fs/bmap64.h                 |   5 +
 lib/ext2fs/dblist.c                 |  36 ++++
 lib/ext2fs/dupfs.c                  | 149 +++++++++++++
 lib/ext2fs/ext2fs.h                 |  35 +++
 lib/ext2fs/ext2fsP.h                |   1 -
 lib/ext2fs/gen_bitmap.c             |   9 +-
 lib/ext2fs/gen_bitmap64.c           |  39 +++-
 lib/ext2fs/tst_badblocks.c          |  61 +++++-
 lib/ext2fs/tst_bitmaps_pthread.c    | 247 +++++++++++++++++++++
 lib/ext2fs/tst_bitmaps_standalone.c | 173 +++++++++++++++
 lib/ext2fs/tst_libext2fs_pthread.c  | 322 ++++++++++++++++++++++++++++
 16 files changed, 1330 insertions(+), 28 deletions(-)
 create mode 100644 lib/ext2fs/tst_bitmaps_pthread.c
 create mode 100644 lib/ext2fs/tst_bitmaps_standalone.c
 create mode 100644 lib/ext2fs/tst_libext2fs_pthread.c

--
2.35.3


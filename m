Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE5649867
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Dec 2022 05:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiLLEiX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Dec 2022 23:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiLLEiV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Dec 2022 23:38:21 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0464E9
        for <linux-ext4@vger.kernel.org>; Sun, 11 Dec 2022 20:38:19 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BC4cEff002849
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Dec 2022 23:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670819896; bh=hFdsa1c0zkKYKDCJyLmX99CDkvD/uKnoiK+f21lfZCY=;
        h=Date:From:To:Cc:Subject;
        b=DuoToHFqimY+pacZvjAwYSRGPLPEuHP2cCcLFQVbsrSgQaNf7KE864sA9wTUPPhyG
         6Kt7GfLo+KXLNqbDrln2dY5+lJraro0d7wSKadbiwZCx3qzKrrRwTgOj/MrpXnj4Jx
         ssBvEXVxw5suHSiHF8SNK+ijTO8gVPTUZSI7l0xSq1iF/S7Qk8cPbKDyP4bLwAnsFd
         8i3WqqqVq9rdPHc2A7m18K6l5CYrD06RYazxhqskRyX0R0JW9LizzfIbVqQyPMqH0i
         UoJiwbRDMv2o92Ys5fOPr9wHMBjOU1QyASiCcdiWWzqOfqbKEFmcRJZL4RjzMiOFBH
         ctzPeDO9O7iIQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 423E215C34C5; Sun, 11 Dec 2022 23:38:14 -0500 (EST)
Date:   Sun, 11 Dec 2022 23:38:14 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 6.2
Message-ID: <Y5awNvCXRRyck6LT@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 4e3c51f4e805291b057d12f5dda5aeb50a538dc4:

  fs: do not update freeing inode i_io_list (2022-11-22 17:00:00 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 1da18e38cb97e9521e93d63034521a9649524f64:

  ext4: fix reserved cluster accounting in __es_remove_extent() (2022-12-09 00:58:04 -0500)

----------------------------------------------------------------
A large number of cleanups and bug fixes, with many of the bug fixes
found by Syzbot and fuzzing.  (Many of the bug fixes involve less-used
ext4 features such as fast_commit, inline_data and bigalloc.)

In addition, remove the writepage function for ext4, since the
medium-term plan is to remove ->writepage() entirely.  (The VM doesn't
need or want writepage() for writeback, since it is fine with
->writepages() so long as ->migrate_folio() is implemented.)

----------------------------------------------------------------
Alexander Potapenko (1):
      fs: ext4: initialize fsdata in pagecache_write()

Baokun Li (10):
      ext4: add inode table check in __ext4_get_inode_loc to aovid possible infinite loop
      ext4: fix bug_on in __es_tree_search caused by bad quota inode
      ext4: add helper to check quota inums
      ext4: add EXT4_IGET_BAD flag to prevent unexpected bad inode
      ext4: fix bug_on in __es_tree_search caused by bad boot loader inode
      ext4: fix use-after-free in ext4_orphan_cleanup
      ext4: correct inconsistent error msg in nojournal mode
      ext4: fix bad checksum after online resize
      ext4: fix corrupt backup group descriptors after online resize
      ext4: fix corruption when online resizing a 1K bigalloc fs

Bixuan Cui (1):
      jbd2: use the correct print format

Darrick J. Wong (2):
      ext4: dont return EINVAL from GETFSUUID when reporting UUID length
      ext4: don't fail GETFSUUID when the caller provides a long buffer

Eric Biggers (8):
      ext4: don't allow journal inode to have encrypt flag
      ext4: disable fast-commit of encrypted dir operations
      ext4: don't set up encryption key during jbd2 transaction
      ext4: fix leaking uninitialized memory in fast-commit journal
      ext4: add missing validation of fast-commit record lengths
      ext4: fix unaligned memory access in ext4_fc_reserve_space()
      ext4: fix off-by-one errors in fast-commit block filling
      ext4: simplify fast-commit CRC calculation

Eric Whitney (1):
      ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline

Gaosheng Cui (1):
      ext4: fix undefined behavior in bit shift for ext4_check_flag_values

Guoqing Jiang (1):
      ext4: make ext4_mb_initialize_context return void

Jan Kara (16):
      ext4: avoid BUG_ON when creating xattrs
      ext4: fix deadlock due to mbcache entry corruption
      ext4: handle redirtying in ext4_bio_write_page()
      ext4: move keep_towrite handling to ext4_bio_write_page()
      ext4: remove nr_submitted from ext4_bio_write_page()
      ext4: drop pointless IO submission from ext4_bio_write_page()
      ext4: add support for writepages calls that cannot map blocks
      ext4: provide ext4_do_writepages()
      ext4: move percpu_rwsem protection into ext4_writepages()
      ext4: switch to using ext4_do_writepages() for ordered data writeout
      jbd2: switch jbd2_submit_inode_data() to use fs-provided hook for data writeout
      ext4: switch to using write_cache_pages() for data=journal writeout
      mm: export buffer_migrate_folio_norefs()
      ext4: stop providing .writepage hook
      ext4: initialize quota before expanding inode in setproject ioctl
      ext4: avoid unaccounted block allocation when expanding inode

Jiangshan Yi (1):
      fs/ext4: replace ternary operator with min()/max() and min_t()

Jinpeng Cui (1):
      ext4: remove redundant variable err

JunChao Sun (1):
      ext4: replace kmem_cache_create with KMEM_CACHE

Li Zhong (1):
      ext4: check the return value of ext4_xattr_inode_dec_ref()

Lukas Czerner (2):
      ext4: journal_path mount options should follow links
      ext4: print file system UUID on mount, remount and unmount

Luís Henriques (2):
      ext4: remove trailing newline from ext4_msg() message
      ext4: fix error code return to user-space in ext4_get_branch()

Ye Bin (6):
      ext4: init quota for 'old.inode' in 'ext4_rename'
      ext4: fix uninititialized value in 'ext4_evict_inode'
      ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
      ext4: allocate extended attribute value in vmalloc area
      ext4: fix inode leak in ext4_xattr_inode_create() on an error path
      ext4: fix reserved cluster accounting in __es_remove_extent()

Zhang Yi (2):
      ext4: silence the warning when evicting inode with dioread_nolock
      ext4: check and assert if marking an no_delete evicting inode dirty

changfengnan (1):
      ext4: split ext4_journal_start trace for debug

 Documentation/filesystems/mount_api.rst |   1 +
 fs/ext4/ext4.h                          |  13 +-
 fs/ext4/ext4_jbd2.c                     |  14 ++-
 fs/ext4/ext4_jbd2.h                     |  10 +-
 fs/ext4/extents.c                       |  16 ++-
 fs/ext4/extents_status.c                |  11 +-
 fs/ext4/fast_commit.c                   | 205 ++++++++++++++++---------------
 fs/ext4/fast_commit.h                   |   3 +-
 fs/ext4/ialloc.c                        |   4 +-
 fs/ext4/indirect.c                      |   9 +-
 fs/ext4/inline.c                        |   3 +-
 fs/ext4/inode.c                         | 252 +++++++++++++++++++++++++++------------
 fs/ext4/ioctl.c                         |  24 ++--
 fs/ext4/mballoc.c                       |  10 +-
 fs/ext4/namei.c                         |  47 ++++----
 fs/ext4/orphan.c                        |   2 +-
 fs/ext4/page-io.c                       |  44 ++++---
 fs/ext4/readpage.c                      |   5 +-
 fs/ext4/resize.c                        |  36 +++---
 fs/ext4/super.c                         |  60 +++++++---
 fs/ext4/verity.c                        |   2 +-
 fs/ext4/xattr.c                         |  22 ++--
 fs/fs_parser.c                          |   3 +-
 fs/jbd2/commit.c                        |   5 +-
 fs/mbcache.c                            |  14 ++-
 fs/quota/dquot.c                        |   2 +
 include/linux/fs_parser.h               |   1 +
 include/linux/jbd2.h                    |   2 +-
 include/linux/mbcache.h                 |   9 +-
 include/trace/events/ext4.h             |  64 ++++++++--
 include/trace/events/jbd2.h             |  44 +++----
 mm/migrate.c                            |   1 +
 32 files changed, 571 insertions(+), 367 deletions(-)

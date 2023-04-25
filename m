Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4416EDAE6
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Apr 2023 06:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDYETJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Apr 2023 00:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjDYETD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Apr 2023 00:19:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A927ECE
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 21:18:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33P4IcYp007538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 00:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682396320; bh=YZbPL+yfZ3UvCq6sEE8ugNH4HyKTMjz6JeeTlf68zBk=;
        h=Date:From:To:Cc:Subject;
        b=HJ8qIrr/GthdjDCMCypF336LridIFVPSzOkeBYzcnvHWmTuFqbjw9mGgIUY++uMsV
         SJCzSk5WxgeLbF1JPbn1P/f6jLAeRbXELSLzuN7GdeWD/aWsc+Tmco02vO0arkKacr
         9kbbWGG0UntrkLsrmTehlxgGbg361LwEq+HE+hYVaRoBvJzQAVeDnzwwGkly7L1rWa
         AXeMWTqMJuGvALQhqB7opVI9P8R7my3l0FW0L8z00VdI8cIFPLF6/YOIzRMCzRN4pE
         DDyzwLVMtNCV1BYFAl6Mhl2uTpNkDBcEPt+giuVqIRV7R8jUsczkGwW+eeCI7FJB2D
         YGYTto73g08ZA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A61DB15C5464; Tue, 25 Apr 2023 00:18:38 -0400 (EDT)
Date:   Tue, 25 Apr 2023 00:18:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] ext4 changes for the 6.4 merge window
Message-ID: <20230425041838.GA150312@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 519fe1bae7e20fc4e7f179d50b6102b49980e85d:

  ext4: Add a uapi header for ext4 userspace APIs (2023-04-19 23:39:42 -0400)

-------
Please note that after merging the mm and ext4 trees you will need to
apply the patch found here[1].

[1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infradead.org

This is due to a patch in the mm tree, "mm: return an ERR_PTR from
__filemap_get_folio" changing that function to returning an ERR_PTR
instead of returning NULL on an error.  Because we have a lot of folio
changes flowing in various trees, this patch can't be applied to
either the ext4 or mm trees, but only *after* the two trees are merged
together.  There are also some minor merge conflicts again caused by
other folio changes.  Commit 5854356ab539 from linux-next's
next-20230424 has the merge conflicts resolved as well as the patch in
[1].  For more details/discussion, please see [2] and the prediction
in [3], "I'm sure Linus will love it".  :-P

[2] https://lore.kernel.org/r/ZD6WNSKCjGGEFLB3@casper.infradead.org
[3] https://lore.kernel.org/r/ZD8F3qV6eLHZpagX@casper.infradead.org

----------------------------------------------------------------
There are a number of major cleanups in ext4 this cycle:

* The data=journal writepath has been significantly cleaned up and
  simplified, and reduces a large number of data=journal special cases
  by Jan Kara.

* Ojaswin Muhoo has replaced linked list used to track extents that
  have been used for inode preallocation with a red-black tree in the
  multi-block allocator.  This improves performance for workloads
  which do a large number of random allocating writes.

* Thanks to Kemeng Shi for a lot of cleanup and bug fixes in the
  multi-block allocator.

* Matthew wilcox has converted the code paths for reading and writing
  ext4 pages to use folios.

* Jason Yan has continued to factor out ext4_fill_super() into smaller
  functions for improve ease of maintenance and comprehension.

* Josh Triplett has created an uapi header for ext4 userspace API's.

----------------------------------------------------------------
Jan Kara (21):
      ext4: Update stale comment about write constraints
      ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()
      ext4: Mark page for delayed dirtying only if it is pinned
      ext4: Don't unlock page in ext4_bio_write_page()
      ext4: Move page unlocking out of mpage_submit_page()
      ext4: Move mpage_page_done() calls after error handling
      ext4: Convert data=journal writeback to use ext4_writepages()
      ext4: Fix warnings when freezing filesystem with journaled data
      jdb2: Don't refuse invalidation of already invalidated buffers
      ext4: Mark pages with journalled data dirty
      ext4: Keep pages with journalled data dirty
      ext4: Clear dirty bit from pages without data to write
      ext4: Commit transaction before writing back pages in data=journal mode
      ext4: Drop special handling of journalled data from ext4_sync_file()
      ext4: Drop special handling of journalled data from extent shifting operations
      ext4: Fix special handling of journalled data from extent zeroing
      ext4: Drop special handling of journalled data from ext4_evict_inode()
      ext4: Drop special handling of journalled data from ext4_quota_on()
      ext4: Simplify handling of journalled data in ext4_bmap()
      ext4: Update comment in mpage_prepare_extent_to_map()
      Revert "ext4: Fix warnings when freezing filesystem with journaled data"

Jason Yan (8):
      ext4: factor out ext4_hash_info_init()
      ext4: factor out ext4_percpu_param_init() and ext4_percpu_param_destroy()
      ext4: use ext4_group_desc_free() in ext4_put_super() to save some duplicated code
      ext4: factor out ext4_flex_groups_free()
      ext4: rename two functions with 'check'
      ext4: move s_reserved_gdt_blocks and addressable checking into ext4_check_geometry()
      ext4: factor out ext4_block_group_meta_init()
      ext4: move dax and encrypt checking into ext4_check_feature_compatibility()

Josh Triplett (1):
      ext4: Add a uapi header for ext4 userspace APIs

Kemeng Shi (33):
      ext4: properly handle error of ext4_init_block_bitmap in ext4_read_block_bitmap_nowait
      ext4: correct validation check of inode table in ext4_valid_block_bitmap
      ext4: call ext4_bg_num_gdb_[no]meta directly in ext4_num_base_meta_clusters
      ext4: remove unnecessary check in ext4_bg_num_gdb_nometa
      ext4: remove stale comment in ext4_init_block_bitmap
      ext4: stop trying to verify just initialized bitmap in ext4_read_block_bitmap_nowait
      ext4: improve inode table blocks counting in ext4_num_overhead_clusters
      ext4: remove unused group parameter in ext4_inode_bitmap_csum_verify
      ext4: remove unused group parameter in ext4_inode_bitmap_csum_set
      ext4: remove unused group parameter in ext4_block_bitmap_csum_verify
      ext4: remove unused group parameter in ext4_block_bitmap_csum_set
      ext4: set goal start correctly in ext4_mb_normalize_request
      ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
      ext4: get correct ext4_group_info in ext4_mb_prefetch_fini
      ext4: correct calculation of s_mb_preallocated
      ext4: correct start of used group pa for debug in ext4_mb_use_group_pa
      ext4: protect pa->pa_free in ext4_discard_allocated_blocks
      ext4: add missed brelse in ext4_free_blocks_simple
      ext4: remove unused return value of ext4_mb_try_best_found and ext4_mb_free_metadata
      ext4: Remove unnecessary release when memory allocation failed in ext4_mb_init_cache
      ext4: remove unnecessary e4b->bd_buddy_page check in ext4_mb_load_buddy_gfp
      ext4: remove unnecessary check in ext4_mb_new_blocks
      ext4: remove dead check in mb_buddy_mark_free
      ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits
      ext4: use best found when complex scan of group finishs
      ext4: remove unnecessary exit_meta_group_info tag
      ext4: remove unnecessary count2 in ext4_free_data_in_buddy
      ext4: remove unnecessary goto in ext4_mb_mark_diskspace_used
      ext4: remove repeat assignment to ac_f_ex
      ext4: remove comment code ext4_discard_preallocations
      ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple
      ext4: fix typos in mballoc
      ext4: avoid unnecessary pointer dereference in ext4_mb_normalize_request

Matthew Wilcox (29):
      fs: Add FGP_WRITEBEGIN
      fscrypt: Add some folio helper functions
      ext4: Convert ext4_bio_write_page() to use a folio
      ext4: Convert ext4_finish_bio() to use folios
      ext4: Turn mpage_process_page() into mpage_process_folio()
      ext4: Convert mpage_submit_page() to mpage_submit_folio()
      ext4: Convert mpage_page_done() to mpage_folio_done()
      ext4: Convert ext4_bio_write_page() to ext4_bio_write_folio()
      ext4: Convert ext4_readpage_inline() to take a folio
      ext4: Convert ext4_convert_inline_data_to_extent() to use a folio
      ext4: Convert ext4_try_to_write_inline_data() to use a folio
      ext4: Convert ext4_da_convert_inline_data_to_extent() to use a folio
      ext4: Convert ext4_da_write_inline_data_begin() to use a folio
      ext4: Convert ext4_read_inline_page() to ext4_read_inline_folio()
      ext4: Convert ext4_write_inline_data_end() to use a folio
      ext4: Convert ext4_write_begin() to use a folio
      ext4: Convert ext4_write_end() to use a folio
      ext4: Use a folio in ext4_journalled_write_end()
      ext4: Convert ext4_journalled_zero_new_buffers() to use a folio
      ext4: Convert __ext4_block_zero_page_range() to use a folio
      ext4: Convert ext4_page_nomap_can_writeout to ext4_folio_nomap_can_writeout
      ext4: Use a folio in ext4_da_write_begin()
      ext4: Convert ext4_mpage_readpages() to work on folios
      ext4: Convert ext4_block_write_begin() to take a folio
      ext4: Use a folio in ext4_page_mkwrite()
      ext4: Use a folio iterator in __read_end_io()
      ext4: Convert mext_page_mkuptodate() to take a folio
      ext4: Convert pagecache_read() to use a folio
      ext4: Use a folio in ext4_read_merkle_tree_page

Ojaswin Mujoo (9):
      ext4: Stop searching if PA doesn't satisfy non-extent file
      ext4: Refactor code related to freeing PAs
      ext4: Refactor code in ext4_mb_normalize_request() and ext4_mb_use_preallocated()
      ext4: Move overlap assert logic into a separate function
      ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
      ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()
      ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
      ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
      ext4: Remove the logic to trim inode PAs

Theodore Ts'o (2):
      ext4: fix comment: "start start" -> "start" in mpage_prepare_extent_to_map()
      ext4: convert some BUG_ON's in mballoc to use WARN_RATELIMITED instead

Tom Rix (1):
      ext4: remove unneeded check of nr_to_submit

wuchi (1):
      ext4: remove useless conditional branch code

 Documentation/admin-guide/ext4.rst |   3 -
 MAINTAINERS                        |   1 +
 block/bio.c                        |   1 +
 fs/ext4/balloc.c                   | 124 ++++-----
 fs/ext4/bitmap.c                   |  13 +-
 fs/ext4/ext4.h                     | 114 +-------
 fs/ext4/extents.c                  |  35 +--
 fs/ext4/fsync.c                    |  11 -
 fs/ext4/ialloc.c                   |  14 +-
 fs/ext4/inline.c                   | 171 ++++++------
 fs/ext4/inode.c                    | 810 +++++++++++++++++++++-----------------------------------
 fs/ext4/mballoc.c                  | 691 +++++++++++++++++++++++++++++------------------
 fs/ext4/mballoc.h                  |  17 +-
 fs/ext4/move_extent.c              |  33 +--
 fs/ext4/page-io.c                  | 116 ++++----
 fs/ext4/readpage.c                 |  72 +++--
 fs/ext4/resize.c                   |   7 +-
 fs/ext4/super.c                    | 413 +++++++++++++++--------------
 fs/ext4/sysfs.c                    |   2 -
 fs/ext4/verity.c                   |  30 +--
 fs/iomap/buffered-io.c             |   2 +-
 fs/jbd2/transaction.c              |   3 +
 fs/netfs/buffered_read.c           |   3 +-
 fs/nfs/file.c                      |  12 +-
 include/linux/fscrypt.h            |  21 ++
 include/linux/page-flags.h         |   5 -
 include/linux/pagemap.h            |   2 +
 include/trace/events/ext4.h        |   7 -
 include/uapi/linux/ext4.h          | 117 ++++++++
 mm/folio-compat.c                  |   4 +-
 30 files changed, 1413 insertions(+), 1441 deletions(-)
 create mode 100644 include/uapi/linux/ext4.h

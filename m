Return-Path: <linux-ext4+bounces-11971-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E01EDC78183
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EEB33504AD
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30433F8C0;
	Fri, 21 Nov 2025 09:16:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B32E8B67;
	Fri, 21 Nov 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716609; cv=none; b=nylpx1C0fJXCE6BF+S2oy0/XzHv0vyrkp64QmG2LqoAvuxiIKUr3yjJNkfvu9Ly8FX1PEtVsO2X6J+VisqAdZZm39uw+Xx+QPczghxt+gnQd9rv3Wv4rD0Q2my5sqYwIO6RkeESmgGjT9xMa0O/uNJQ3LaP/ix8UHDZ8fezbsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716609; c=relaxed/simple;
	bh=qkTGZRdHFNHQiuI0y2BS9YHPv7rNWThBX7rXNapYde4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TXQuxk10AH/FpMI6/IdncXewQPeOMfXp8JvNLGllEA/wTg/69Jw9F6rg8HhyauxCYEHO4Kn4XudY9Q522brL8v9uDiMNlza0nwluzsdFhw6SA2qokuPm8dWwa1XuDkRRpyJkAtBhUribuRiJ1l7TLYGq0PsEqzlkI8JZNjoIVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCV272dvyzYQvG2;
	Fri, 21 Nov 2025 17:15:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9DC8E1A084B;
	Fri, 21 Nov 2025 17:16:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S4;
	Fri, 21 Nov 2025 17:16:40 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	ebiggers@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH v4 00/24] ext4: enable block size larger than page size
Date: Fri, 21 Nov 2025 17:06:30 +0800
Message-Id: <20251121090654.631996-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr13tw15tr1rtr4xZw4fKrg_yoW3uw1rpa
	yfJF13Cr45Jr45Canruw1ktr48Wa18GryUXFy7t348ZF1Fyr18tw42yFykZFWjkr9xJF4j
	qF1fJr4xW3WjkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoPEfDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgATBWkf34sfEQAAs4

From: Baokun Li <libaokun1@huawei.com>

Changes since v3:
 * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
    (Thank you for your review!)
 * Patch 21: Fix lock imbalance in ext4_change_inode_journal_flag.
    (Suggested by Dan Carpenter)

[v3]: https://lore.kernel.org/r/20251111142634.3301616-1-libaokun@huaweicloud.com

Changes since v2:
 * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
    (Thank you for your review!)
 * Patch 21: Before switching the inode journalling mode, drop all
    page cache of that inode and invoke filemap_write_and_wait()
    unconditionally. (Suggested by Jan Kara)
 * Patch 22: Extend fs-verity to support large folios in addition to
    large block size. (Suggested by Jan Kara)
 * Patch 24: Add a blocksize_gt_pagesize sysfs interface to help users
    (e.g., mke2fs) determine whether the current kernel supports bs > ps.
    In addition, remove the experimental tag. (Suggested by Theodore Ts'o)

[v2]: https://lore.kernel.org/r/20251107144249.435029-1-libaokun@huaweicloud.com

Changes since v1:
 * Collect RVB from Jan Kara and Zhang Yi. (Thanks for your review!)
 * Patch 4: Just use blocksize in the rounding.(Suggested by Jan Kara)
 * Patch 7: use kvmalloc() instead of allocating contiguous physical
    pages.(Suggested by Jan Kara)
 * Patch 12: Fix some typos.(Suggested by Jan Kara)
 * Use clearer naming: EXT4_LBLK_TO_PG() and EXT4_PG_TO_LBLK().
    (Suggested by Jan Kara)
 * Patch 21: removed. After rebasing on Ted’s latest dev branch, this
    patch is no longer needed.
 * Patch 22-23: removed. The issue was resolved by removing the WARN_ON
    in the MM code, so we now rely on patch [1].(Suggested by Matthew)
 * Add new Patch 21 to support data=journal under LBS. (Suggested by
    Jan Kara)
 * Add new Patch 22 to support fs verity under LBS.
 * New Patch 23: add the s_max_folio_order field instead of introducing
    the EXT4_MF_LARGE_FOLIO flag.
 * New Patch 24: rebase adaptation.

[v1]: https://lore.kernel.org/r/20251025032221.2905818-1-libaokun@huaweicloud.com

======

This series enables block size > page size (Large Block Size) in EXT4.

Since large folios are already supported for regular files, the required
changes are not substantial, but they are scattered across the code.
The changes primarily focus on cleaning up potential division-by-zero
errors, resolving negative left/right shifts, and correctly handling
mutually exclusive mount options.

One somewhat troublesome issue is that allocating page units greater than
order-1 with __GFP_NOFAIL in __alloc_pages_slowpath() can trigger an
unexpected WARN_ON. With LBS support, EXT4 and jbd2 may use __GFP_NOFAIL
to allocate large folios when reading metadata. The issue was resolved by
removing the WARN_ON in the MM code, so we now rely on patch [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ee040cbd6e48

Patch series based on Ted’s latest dev branch.

`kvm-xfstests -c ext4/all -g auto` has been executed with no new failures.
`kvm-xfstests -c ext4/32k -g auto` has been executed with no new failures.
`kvm-xfstests -c ext4/64k -g auto` has been executed with no new failures,
but allocation failures for large folios may trigger warn_alloc() warnings,
tests with 32k or smaller block sizes have not exhibited any page allocation
failures.

Here are some performance test data for your reference:

Testing EXT4 filesystems with different block sizes, measuring
single-threaded dd bandwidth for BIO/DIO with varying bs values.

Before(PAGE_SIZE=4096):

      BIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
--------------|----------|----------|----------|----------|------------
 4k           | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
 8k (bigalloc)| 1.4 GB/s | 2.0 GB/s | 2.6 GB/s | 3.1 GB/s | 3.4 GB/s
 16k(bigalloc)| 1.5 GB/s | 2.0 GB/s | 2.6 GB/s | 3.2 GB/s | 3.6 GB/s
 32k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.7 GB/s | 3.3 GB/s | 3.7 GB/s
 64k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
              
      DIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
--------------|----------|----------|----------|----------|------------
 4k           | 194 MB/s | 366 MB/s | 626 MB/s | 1.0 GB/s | 1.4 GB/s
 8k (bigalloc)| 188 MB/s | 359 MB/s | 612 MB/s | 996 MB/s | 1.4 GB/s
 16k(bigalloc)| 208 MB/s | 378 MB/s | 642 MB/s | 1.0 GB/s | 1.4 GB/s
 32k(bigalloc)| 184 MB/s | 368 MB/s | 637 MB/s | 995 MB/s | 1.4 GB/s
 64k(bigalloc)| 208 MB/s | 389 MB/s | 634 MB/s | 1.0 GB/s | 1.4 GB/s

Patched(PAGE_SIZE=4096):

   BIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
---------|----------|----------|----------|----------|------------
 4k      | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
 8k (LBS)| 1.7 GB/s | 2.3 GB/s | 3.2 GB/s | 4.2 GB/s | 4.7 GB/s
 16k(LBS)| 2.0 GB/s | 2.7 GB/s | 3.6 GB/s | 4.7 GB/s | 5.4 GB/s
 32k(LBS)| 2.2 GB/s | 3.1 GB/s | 3.9 GB/s | 4.9 GB/s | 5.7 GB/s
 64k(LBS)| 2.4 GB/s | 3.3 GB/s | 4.2 GB/s | 5.1 GB/s | 6.0 GB/s

   DIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
---------|----------|----------|----------|----------|------------
 4k      | 204 MB/s | 355 MB/s | 627 MB/s | 1.0 GB/s | 1.4 GB/s
 8k (LBS)| 210 MB/s | 356 MB/s | 602 MB/s | 997 MB/s | 1.4 GB/s
 16k(LBS)| 191 MB/s | 361 MB/s | 589 MB/s | 981 MB/s | 1.4 GB/s
 32k(LBS)| 181 MB/s | 330 MB/s | 581 MB/s | 951 MB/s | 1.3 GB/s
 64k(LBS)| 148 MB/s | 272 MB/s | 499 MB/s | 840 MB/s | 1.3 GB/s


The results show:

 * The code changes have almost no impact on the original 4k write
   performance of ext4.
 * Compared with bigalloc, LBS improves BIO write performance by about 50%
   on average.
 * Compared with bigalloc, LBS shows degradation in DIO write performance,
   which increases as the filesystem block size grows and the test bs
   decreases, with a maximum degradation of about 30%.

The DIO regression is primarily due to the increased time spent in
crc32c_arch() within ext4_block_bitmap_csum_set() during block allocation,
as the block size grows larger. This indicates that larger filesystem block
sizes are not always better; please choose an appropriate block size based
on your I/O workload characteristics.

We are also planning further optimizations for block allocation under LBS
in the future.

Comments and questions are, as always, welcome.

Thanks,
Baokun


Baokun Li (21):
  ext4: remove page offset calculation in ext4_block_truncate_page()
  ext4: remove PAGE_SIZE checks for rec_len conversion
  ext4: make ext4_punch_hole() support large block size
  ext4: enable DIOREAD_NOLOCK by default for BS > PS as well
  ext4: introduce s_min_folio_order for future BS > PS support
  ext4: support large block size in ext4_calculate_overhead()
  ext4: support large block size in ext4_readdir()
  ext4: add EXT4_LBLK_TO_B macro for logical block to bytes conversion
  ext4: add EXT4_LBLK_TO_PG and EXT4_PG_TO_LBLK for block/page
    conversion
  ext4: support large block size in ext4_mb_load_buddy_gfp()
  ext4: support large block size in ext4_mb_get_buddy_page_lock()
  ext4: support large block size in ext4_mb_init_cache()
  ext4: prepare buddy cache inode for BS > PS with large folios
  ext4: support large block size in ext4_mpage_readpages()
  ext4: support large block size in ext4_block_write_begin()
  ext4: support large block size in mpage_map_and_submit_buffers()
  ext4: support large block size in mpage_prepare_extent_to_map()
  ext4: make data=journal support large block size
  ext4: support verifying data from large folios with fs-verity
  ext4: add checks for large folio incompatibilities when BS > PS
  ext4: enable block size larger than page size

Zhihao Cheng (3):
  ext4: remove page offset calculation in ext4_block_zero_page_range()
  ext4: rename 'page' references to 'folio' in multi-block allocator
  ext4: support large block size in __ext4_block_zero_page_range()

 fs/ext4/dir.c       |   8 +--
 fs/ext4/ext4.h      |  26 ++++-----
 fs/ext4/ext4_jbd2.c |   3 +-
 fs/ext4/extents.c   |   2 +-
 fs/ext4/inode.c     | 112 +++++++++++++++---------------------
 fs/ext4/mballoc.c   | 137 +++++++++++++++++++++++---------------------
 fs/ext4/namei.c     |   8 +--
 fs/ext4/readpage.c  |   7 +--
 fs/ext4/super.c     |  61 ++++++++++++++++----
 fs/ext4/sysfs.c     |   6 ++
 fs/ext4/verity.c    |   2 +-
 11 files changed, 197 insertions(+), 175 deletions(-)

-- 
2.46.1



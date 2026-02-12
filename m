Return-Path: <linux-ext4+bounces-13685-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ75CSj2jWlw8wAAu9opvQ
	(envelope-from <linux-ext4+bounces-13685-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 16:47:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6E12F175
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 16:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9840302C150
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2230BF6A;
	Thu, 12 Feb 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VZclZ8Hb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3F54774
	for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911256; cv=none; b=QVorKcZjUHSJg5Z6YW+85Q+wgc5x5kynFPyOICxJNNezQKobVRmpbS3Yra/LqkQqwWnFANPyOIkJghahOnp+7EU/dZLV3LCqsSHu5jFKqJRigrTWNoqXLIVLUA8P5Un4PQR4kReWQ0Pc8bqXzU+YTVwaXyPyWyLjcOh0CJQICWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911256; c=relaxed/simple;
	bh=gSouRqGGMGJfJkTjFwggUnFnWXH9FS9TTqkR7CNmlFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QZLzp/FPR2/QA16kgXhP8x83gZAvbwZ9wxT00PrrqNNH+xtoj8HKpJ+obCWs18K3ExknDScOlSFd3sA6ROSKUTkmzzxpU9RiSTE/ti9xaHXQzcbnTOIBMEe0bfstuKFbCltp3UB7p0jWcQiOFtamfjkGCjMyaPcVpmlBt3gurhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VZclZ8Hb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-166.bstnma.fios.verizon.net [173.48.112.166])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61CFlMa8012922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770911243; bh=fj1LR5KYnol1bkp2fY2fHFuWYq73rU9Qu0SDQjxcytw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=VZclZ8HbC9bZqzFedLFxzwmN2GZVCdrp3LEEh2VO+sfONqyPXZ6nEYix6NtnVAGWc
	 yVinLO8U80ixAmhJ3bCKMe1APFdmIRKDsl7r79ZiVZ5WmB8bDkvxQXQDCzG/3a4rBI
	 vMwrFHYAjjVgzcdnBCrOaOrw9D7IIfp5aQWz/Cxv+gB9BQFehDCZ+UcITS1kYZlqck
	 NCAts9BZtSf98mzeH9n2doOvmJNd3Nxsv2REfDKvqQPx9eQL+TnjeP9w9TBBtHjH05
	 e2TThi5tAq/20E3MF1JP1A/JBht64xRYukWiUlNs+VZZNcVUKIo93LJXGsQJPJR4V/
	 1P3wmevFGZPGA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F14092E00D6; Thu, 12 Feb 2026 10:47:21 -0500 (EST)
Date: Thu, 12 Feb 2026 10:47:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 changes for v7.0-rc1
Message-ID: <20260212154721.GA2430983@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13685-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: 10F6E12F175
X-Rspamd-Action: no action

The following changes since commit d250bdf531d9cd4096fedbb9f172bb2ca660c868:

  ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref (2026-01-18 11:23:10 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-7.0-rc1

for you to fetch changes up to 4f5e8e6f012349a107531b02eed5b5ace6181449:

  et4: allow zeroout when doing written to unwritten split (2026-01-23 16:50:11 -0500)

----------------------------------------------------------------
New features and improvements for the ext4 file system

  * Avoid unnecessary cache invadiation in the extent status cache
    (es_cache) when adding extents to be cached in the es_cache and we
    are not changing the extent tree.
  * Add a sysfs parameter, err_report_sec, to control how frequently
    to log a warning message that file system inconsistency has been
    detected.  (Previously we logged the warning message every 24
    hours.)
  * Avoid unnecessary forced ordered writes when appending to a file
    when delayed allocation is enabled.
  * Defer splitting unwritten extents to I/O completion to improve
    write performance of concurrent direct I/O writes to multiple
    files.
  * Refactor and add kunit tests to the extent splitting and
    conversion code paths.

Various Bug Fixes

  * Fix a panic when the debugging DOUBLE_CHECK macro is defined.
  * Avoid using fast commit for rare and complex file system
    operations to make fast commit easier to reason about.  This can
    also avoid some corner cases that could result in file system
    inconsistency if there is a crash between the fast commit before a
    subsequent full commit.
  * Fix memory leaks in error paths
  * Fix a false positive reports caused when running stress tests
    using mixed huge-page workloads caused by a race between page
    migration and bitmap updates.
  * Fix a potential recursion into file system reclaim when evicting
    an inode when fast commit is enabled.
  * Fix a warning caused by a potential double decrement to the dirty
    clusters counter when executing FS_IOC_SHUTDOWN when running a
    stress test.
  * Enable mballoc optimzied scanning regardless whether the inode is
    using indirect blocks or extent trees to map blocks.

----------------------------------------------------------------
Baokun Li (1):
      ext4: move ext4_percpu_param_init() before ext4_mb_init()

Baolin Liu (2):
      ext4: add sysfs attribute err_report_sec to control s_err_report timer
      ext4: remove redundant NULL check after __GFP_NOFAIL

Brian Foster (1):
      ext4: fix dirtyclusters double decrement on fs shutdown

Jan Kara (2):
      ext4: always allocate blocks only from groups inode can use
      ext4: use optimized mballoc scanning regardless of inode format

Li Chen (6):
      ext4: mark inode format migration fast-commit ineligible
      ext4: mark fs-verity enable fast-commit ineligible
      ext4: mark move extents fast-commit ineligible
      ext4: mark group add fast-commit ineligible
      ext4: mark group extend fast-commit ineligible
      ext4: fast commit: make s_fc_lock reclaim-safe

Ojaswin Mujoo (8):
      ext4: kunit tests for extent splitting and conversion
      ext4: kunit tests for higher level extent manipulation functions
      ext4: add extent status cache support to kunit tests
      ext4: propagate flags to convert_initialized_extent()
      ext4: propagate flags to ext4_convert_unwritten_extents_endio()
      ext4: refactor zeroout path and handle all cases
      ext4: refactor split and convert extents
      et4: allow zeroout when doing written to unwritten split

Yongjian Sun (1):
      ext4: fix e4b bitmap inconsistency reports

Zhang Yi (22):
      ext4: subdivide EXT4_EXT_DATA_VALID1
      ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
      ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
      ext4: correct the mapping status if the extent has been zeroed
      ext4: don't cache extent during splitting extent
      ext4: drop extent cache after doing PARTIAL_VALID1 zeroout
      ext4: drop extent cache when splitting extent fails
      ext4: cleanup zeroout in ext4_split_extent_at()
      ext4: cleanup useless out label in __es_remove_extent()
      ext4: make __es_remove_extent() check extent status
      ext4: make ext4_es_cache_extent() support overwrite existing extents
      ext4: adjust the debug info in ext4_es_cache_extent()
      ext4: replace ext4_es_insert_extent() when caching on-disk extents
      ext4: drop the TODO comment in ext4_es_insert_extent()
      ext4: don't order data when zeroing unwritten or delayed block
      ext4: use reserved metadata blocks when splitting extent on endio
      ext4: don't split extent before submitting I/O
      ext4: avoid starting handle when dio writing an unwritten extent
      ext4: remove useless ext4_iomap_overwrite_ops
      ext4: remove unused unwritten parameter in ext4_dio_write_iter()
      ext4: simplify the mapping query logic in ext4_iomap_begin()
      ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT

Zilin Guan (1):
      ext4: fix memory leak in ext4_ext_shift_extents()

pengdonglin (1):
      ext4: remove unnecessary zero-initialization via memset

 fs/ext4/ext4.h              |   34 +-
 fs/ext4/extents-test.c      | 1027 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c           |  606 ++++++++++++++++-------------
 fs/ext4/extents_status.c    |  125 ++++--
 fs/ext4/fast_commit.c       |   54 +--
 fs/ext4/fast_commit.h       |    3 +
 fs/ext4/file.c              |   24 +-
 fs/ext4/inode.c             |   94 ++---
 fs/ext4/ioctl.c             |    3 +
 fs/ext4/mballoc-test.c      |    2 +-
 fs/ext4/mballoc.c           |   73 ++--
 fs/ext4/migrate.c           |   12 +
 fs/ext4/move_extent.c       |    2 +
 fs/ext4/super.c             |   37 +-
 fs/ext4/sysfs.c             |   36 ++
 fs/ext4/verity.c            |    2 +
 include/trace/events/ext4.h |    8 +-
 17 files changed, 1679 insertions(+), 463 deletions(-)
 create mode 100644 fs/ext4/extents-test.c


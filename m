Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E221B4F0F
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgDVVVO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 17:21:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:54635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgDVVVN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 17:21:13 -0400
IronPort-SDR: W4F/DzAkp5HA+3tf09hnSLmlWRaYV5EztENc3429g0WMDJFxTUWA5dVpa7Kn08ydlWc9X5rLNg
 U4PpaF046OMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:12 -0700
IronPort-SDR: 1V3aydwcj2RFc/ViuLoh/Pg4suCfr/h0jIK5zkCV7nn86S2pikVUlwWtCoNyaKdsG+vxPshR3W
 E/Au24YAYQfQ==
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="292070841"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:11 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH V10 00/11] XFS - Enable per-file/per-directory DAX operations V10
Date:   Wed, 22 Apr 2020 14:20:51 -0700
Message-Id: <20200422212102.3757660-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V9:
	Slight reorder of series to put Documentation sooner
	modify i_state under i_lock
	Change name of xfs_ioctl_setattr_dax_invalidate() ->
		xfs_ioctl_setattr_prepare_dax()
	Do not report default dax=inode mount mode
	Move XFS_IEOFBLOCKS to '9'
	Fixup some doc typos
	Fix xfs style indentation
	Fix commit mispelling

At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
consumption due to their inability to detect whether the kernel will
instantiate page cache for a file, and cases where a global dax enable via a
mount option is too coarse.

The following patch series enables the use of DAX on individual files and/or
directories on xfs, and lays some groundwork to do so in ext4.  It further
enhances the dax mount option to be a tri-state of 'always', 'never', or
'iflag' (default).  Furthermore, it maintians '-o dax' to be equivalent to '-o
dax=always'.

The insight at LSF/MM was to separate the per-mount or per-file "physical"
(FS_XFLAG_DAX) capability switch from an "effective" (S_DAX) attribute for the
file.

At LSF/MM we discussed the difficulties of switching the DAX state of a file
with active mappings / page cache.  It was thought the races could be avoided
by limiting DAX state flips to 0-length files.

However, this turns out to not be true.[3][5] This is because address space
operations (a_ops) may be in use at any time the inode is referenced.

For this reason direct manipulation of the FS_XFLAG_DAX is allowed but the
operation of the file (S_DAX) is not immediately changed.

Details of when and how DAX state can be changed on a file is included in a
documentation patch.

It should be noted that FS_XFLAG_DAX inheritance is not shown in this patch set
as it was maintained from previous work on XFS.  FS_XFLAG_DAX and it's
inheritance will need to be added to other file systems for user control. 


[1] https://lwn.net/Articles/787973/
[2] https://lwn.net/Articles/787233/
[3] https://lkml.org/lkml/2019/10/20/96
[4] https://patchwork.kernel.org/patch/11310511/
[5] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/


To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org

Changes from V8:
	Rebase to 5.7-rc2
	Change ALWAYS/NEVER bits to be 26/27
	Remove XFS_IDONTCACHE -> lift to I_DONTCACHE
		use mark_inode_dontcache() in XFS
	create xfs_dax_mode enum
	use xfs signature styles
	Change xfs_inode_enabe_dax() -> xfs_inode_should_enable()
		Based on feedback to ext4 series
	Fix locking of DCACHE_DONTCACHE
	Change flag_inode_dontcache() -> mark_inode_dontcache()
	Change xfs_ioctl_setattr_dax_invalidate() -> xfs_ioctl_dax_check_set_cache()
	Documentation cleanups
	Clean up all commit messages

Changes from V7:
	Add DCACHE_DONTCACHE
	If mount override don't worry about inode caching
	Change mount flags to NEVER/ALWAYS
	Clean up xfs_inode_enable_dax()
	Clarify comments
	Update documentation

Changes from V6:
	Incorporate feedback on patches
	Add ability to change FS_XFLAG_DAX on files at any time.
		Add a don't cache flag to the VFS layer
		Preserve internal XFS IDONTCACHE behavior for bulkstat
		operations

Changes from V5:
	* make dax mount option a tri-state
	* Reject changes to FS_XFLAG_DAX for regular files
		- Allow only on directories
	* Update documentation

Changes from V4:
	* Open code the aops lock rather than add it to the xfs_ilock()
	  subsystem (Darrick's comments were obsoleted by this change)
	* Fix lkp build suggestions and bugs

Changes from V3:
	* Remove global locking...  :-D
	* put back per inode locking and remove pre-mature optimizations
	* Fix issues with Directories having IS_DAX() set
	* Fix kernel crash issues reported by Jeff
	* Add some clean up patches
	* Consolidate diflags to iflags functions
	* Update/add documentation
	* Reorder/rename patches quite a bit

Changes from V2:

	* Move i_dax_sem to be a global percpu_rw_sem rather than per inode
		Internal discussions with Dan determined this would be easier,
		just as performant, and slightly less overhead that having it
		in the SB as suggested by Jan
	* Fix locking order in comments and throughout code
	* Change "mode" to "state" throughout commits
	* Add CONFIG_FS_DAX wrapper to disable inode_[un]lock_state() when not
		configured
	* Add static branch for which is activated by a device which supports
		DAX in XFS
	* Change "lock/unlock" to up/down read/write as appropriate
		Previous names were over simplified
	* Update comments/documentation

	* Remove the xfs specific lock to the vfs (global) layer.
	* Fix i_dax_sem locking order and comments

	* Move 'i_mapped' count from struct inode to struct address_space and
		rename it to mmap_count
	* Add inode_has_mappings() call

	* Fix build issues
	* Clean up syntax spacing and minor issues
	* Update man page text for STATX_ATTR_DAX
	* Add reviewed-by's
	* Rebase to 5.6

	Rename patch:
		from: fs/xfs: Add lock/unlock state to xfs
		to: fs/xfs: Add write DAX lock to xfs layer
	Add patch:
		fs/xfs: Clarify lockdep dependency for xfs_isilocked()
	Drop patch:
		fs/xfs: Fix truncate up

Ira Weiny (11):
  fs/xfs: Remove unnecessary initialization of i_rwsem
  fs: Remove unneeded IS_DAX() check in io_is_direct()
  fs/stat: Define DAX statx attribute
  Documentation/dax: Update Usage section
  fs/xfs: Change XFS_MOUNT_DAX to XFS_MOUNT_DAX_ALWAYS
  fs/xfs: Make DAX mount option a tri-state
  fs/xfs: Create function xfs_inode_should_enable_dax()
  fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
  fs: Lift XFS_IDONTCACHE to the VFS layer
  fs: Introduce DCACHE_DONTCACHE
  fs/xfs: Update xfs_ioctl_setattr_dax_invalidate()

 Documentation/filesystems/dax.txt | 164 +++++++++++++++++++++++++++++-
 drivers/block/loop.c              |   6 +-
 fs/dcache.c                       |   4 +
 fs/inode.c                        |  15 +++
 fs/stat.c                         |   3 +
 fs/xfs/xfs_icache.c               |   8 +-
 fs/xfs/xfs_inode.h                |   4 +-
 fs/xfs/xfs_ioctl.c                | 141 ++++---------------------
 fs/xfs/xfs_iops.c                 |  72 ++++++++-----
 fs/xfs/xfs_mount.h                |   4 +-
 fs/xfs/xfs_super.c                |  53 ++++++++--
 include/linux/dcache.h            |   2 +
 include/linux/fs.h                |  14 +--
 include/uapi/linux/stat.h         |   1 +
 14 files changed, 319 insertions(+), 172 deletions(-)

-- 
2.25.1


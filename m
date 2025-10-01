Return-Path: <linux-ext4+bounces-10506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73AEBAF074
	for <lists+linux-ext4@lfdr.de>; Wed, 01 Oct 2025 04:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFC1C22FA
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Oct 2025 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374327AC21;
	Wed,  1 Oct 2025 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YKXBgfpj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0835940
	for <linux-ext4@vger.kernel.org>; Wed,  1 Oct 2025 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287255; cv=none; b=RMvNwZrbzzC8+abUIyWzXBM+FjxNSzhbswxQthFDh4G+kUCVxTjFOzn1VosHKA8MjTcGlw1n/IITV6aRxX36iqMVN6fytTWd+uTEKwfiT2Ish+6PejlkbgQociuS4a8dJVaVqRuZoD+0GwO0gfXIl54Pv22xAkipesnnZI4Z1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287255; c=relaxed/simple;
	bh=XcdUOVP2ST66bgN0i3mM03qMLhQASrIrftRuGgxZqFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XwYlrXW8Wcb4idccIcnICAZrz77+bWb2x1eXV4QXQ85nrwgTjlHDndhhAeVYYwQ3druSeG9yIYDdFcyL7QmEyXS4dh4k6N/nkauxCj99NMOpiIm+b3XbanAtI7oQBv/qK1ghb5OqZC3rI27j6tddrwHItyTAgiggUpx/IJfzAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YKXBgfpj; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-189.bstnma.fios.verizon.net [173.48.113.189])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5912s1Ys017031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 22:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759287242; bh=Qf7UtKUlYjyeQyEVGZWBThbfyxqAnNWIuRrsdjjbR9U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YKXBgfpjwyAcEeNkTa3oNpnggEgl0U4YZOXtugodEBZsyrQShJQ8dInFuuPv4Qo+m
	 iuxv8P6XborkhlWxNojqTqgl7JHScR2W4itRevADbiUbOba8HF9ma+vgQRx1pXCQNX
	 af3VQMUr2KRVwu1IUokAqWCHhv9XwSBY/om0LCMKd2XXIsh7kp50J+EEYJ6YSPvoxA
	 Bv/33iPlkq9MWLfJaNynDKLqthb7DqJ5Buz5Qg/MQ5Nei0hDJJDq0gltBP/cpf9A55
	 NszBOnnvuewO7Vj98KGGnHkb3HhFb8VgCcawKIryt9f5JYPpfTi/FBd5vAns76f4/x
	 zzorRAx80Ezuw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D02CF2E00D9; Tue, 30 Sep 2025 22:54:00 -0400 (EDT)
Date: Tue, 30 Sep 2025 22:54:00 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for 6.18-rc1
Message-ID: <20251001025400.GA333371@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.18-rc1

for you to fetch changes up to acf943e9768ec9d9be80982ca0ebc4bfd6b7631e:

  ext4: fix checks for orphan inodes (2025-09-26 08:36:08 -0400)

----------------------------------------------------------------
New ext4 features:

  * Add support so tune2fs can modify/update the superblock using an
    ioctl, without needing write access to the block device.
  * Add support for 32-bit reserved uid's and gid's.

Bug fixes:

  * Fix potential warnings and other failures caused by corrupted / fuzzed
    file systems.
  * Fail unaligned direct I/O write with EINVAL instead of silently
    falling back to buffered I/O
  * Correectly handle fsmap queries for metadata mappings
  * Avoid journal stalls caused by writeback throttling
  * Add some missing GFP_NOFAIL flags to avoid potential deadlocks
    under extremem memory pressure

Cleanups:

  * Remove obsolete EXT3 Kconfigs

----------------------------------------------------------------
Ahmet Eray Karadag (1):
      ext4: guard against EA inode refcount underflow in xattr update

Baokun Li (2):
      ext4: add ext4_sb_bread_nofail() helper function for ext4_free_branches()
      ext4: fix potential null deref in ext4_mb_init()

Deepanshu Kartikey (1):
      ext4: validate ea_ino and size in check_xattrs

Jan Kara (3):
      ext4: fail unaligned direct IO write with EINVAL
      ext4: verify orphan file size is not too big
      ext4: fix checks for orphan inodes

Julian Sun (2):
      jbd2: increase IO priority of checkpoint
      ext4: increase IO priority of fastcommit

Lukas Bulwahn (1):
      ext4: remove obsolete EXT3 config options

Ojaswin Mujoo (1):
      ext4: correctly handle queries for metadata mappings

Theodore Ts'o (3):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
      ext4: add support for 32-bit default reserved uid and gid values
      ext4: implemet new ioctls to set and get superblock parameters

Xichao Zhao (1):
      ext4: replace min/max nesting with clamp()

Yongjian Sun (1):
      ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Zhang Yi (1):
      ext4: fix an off-by-one issue during moving extents

chuguangqing (1):
      fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

 fs/ext4/Kconfig           |  27 -------
 fs/ext4/ext4.h            |  28 ++++++-
 fs/ext4/fast_commit.c     |   2 +-
 fs/ext4/file.c            |   2 +-
 fs/ext4/fsmap.c           |  14 ++--
 fs/ext4/indirect.c        |   2 +-
 fs/ext4/inode.c           |  47 +++---------
 fs/ext4/ioctl.c           | 312 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.c         |  10 +++
 fs/ext4/mmp.c             |   6 +-
 fs/ext4/move_extent.c     |   2 +-
 fs/ext4/orphan.c          |  19 +++--
 fs/ext4/super.c           |  38 +++++-----
 fs/ext4/xattr.c           |  21 ++++--
 fs/jbd2/checkpoint.c      |   2 +-
 include/uapi/linux/ext4.h |  53 +++++++++++++
 16 files changed, 467 insertions(+), 118 deletions(-)


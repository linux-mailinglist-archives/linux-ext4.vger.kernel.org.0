Return-Path: <linux-ext4+bounces-14061-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPYlM1pdoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14061-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:58 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 492301A7DF7
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 303D830A8706
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D43D6483;
	Thu, 26 Feb 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/IfueHe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E83D1CBE;
	Thu, 26 Feb 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116922; cv=none; b=I6fIQWvDBo9r2H/N9Ag2M6BR50znMY9MB7acICnNLK10n1UZJdOkT0TiFUy8XCFIpJZBWWatsJI0Kx3pxOYyTbRCRPBQl6JO98j6nukoSq+qI9T6Mc9GK/ZeC0Vwk6vyFldJLzqi6dE28JRuMTVYmZPFAe/lpQc6fAGJbIRK4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116922; c=relaxed/simple;
	bh=PZEH3868/PTa3lGS3LIKMKOTqR8foArFIj+pwsdzmnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bW9iVgjjyOQGWHGhPqUfDieNrF2mvPUwqfpLhEeGOF1OXchpWt7BMWlXdcw+pHLq1t+ORX3Mn6mBihqcYp/ybOlDB8SAu4aRix1HPoyGwNuynZerft/624NgVJWnzDCc6u2xb83NGH+YkLqSYnNo1Z/QPy9PUtC/TIKXCJpRwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/IfueHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DC7C116C6;
	Thu, 26 Feb 2026 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116921;
	bh=PZEH3868/PTa3lGS3LIKMKOTqR8foArFIj+pwsdzmnY=;
	h=From:To:Cc:Subject:Date:From;
	b=C/IfueHe4JhDFrgbr7y4s0DesCIUIpevAj2G7tL+KvCyuoq7gLyIwZfbT4+E7sNvm
	 DdLBZS5c2D0kC8MyTbdArdISuVHLxz0Xi8bR63FA/933AfpDe/YW4fbaXjq+TttMMH
	 BRUZaiclyFgVXZci2UpGJp+donyiyxkSjUan29TVR9du5SuU4QS9DjKQ7Beb1e9Dkc
	 60H2T0826vaFi5JUBzM8HEkA/NyYyMedy/Nf/Jslauus6PjknrpOT7AJAKWpCxTQ4a
	 uKYNhwa0c6gn1etkdN7+t05hO3hDupwiQoDI1x2Fe1v/NG4CS76ie45hurbLNfcJZg
	 qDeuSOkr2dVxA==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 0/9] fstests: add test coverage for cloned filesystem ids
Date: Thu, 26 Feb 2026 22:41:41 +0800
Message-ID: <cover.1772095513.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14061-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asj@kernel.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 492301A7DF7
X-Rspamd-Action: no action

This series adds fstests infrastructure and test cases to verify correct
filesystem identity behaviour when a filesystem is cloned (e.g. via
block-level copy), covering inotify, fanotify, f_fsid, libblkid, IMA,
and exportfs file handles.

  - SCRATCH_DEV_POOL support extended to non-Btrfs filesystems
  - _mkfs_scratch_sized_clone() helper to create a cloned filesystem
  - _clone_mount_option() helper to apply per-filesystem clone mount options

New tests verify:
  - inotify and fanotify events are isolated between cloned filesystems
  - f_fsid is unique across cloned filesystem instances
  - libblkid correctly resolves duplicate UUIDs to distinct devices
  - IMA distinct identity for each cloned filesystem
  - exportfs file handles resolve correctly on cloned filesystems

Testing:
  Requires kernel patches [1] for all tests to pass.
   [1] https://lore.kernel.org/linux-btrfs/cover.1772095546.git.asj@kernel.org/

Anand Jain (9):
  fstests: allow SCRATCH_DEV_POOL for non-Btrfs filesystems
  fstests: add _mkfs_scratch_clone() helper
  fstests: add _clone_mount_option() helper
  fstests: add test for inotify isolation on cloned devices
  fstests: verify fanotify isolation on cloned filesystems
  fstests: verify f_fsid for cloned filesystems
  fstests: verify libblkid resolution of duplicate UUIDs
  fstests: verify IMA isolation on cloned filesystems
  fstests: verify exportfs file handles on cloned filesystems

 .gitignore            |   1 +
 common/config         |   1 +
 common/rc             |  55 ++++++++++++++++++-----
 src/Makefile          |   2 +-
 src/fanotify.c        |  66 +++++++++++++++++++++++++++
 tests/generic/790     |  78 ++++++++++++++++++++++++++++++++
 tests/generic/790.out |   7 +++
 tests/generic/791     |  86 +++++++++++++++++++++++++++++++++++
 tests/generic/791.out |   7 +++
 tests/generic/792     |  57 ++++++++++++++++++++++++
 tests/generic/792.out |   7 +++
 tests/generic/793     |  73 ++++++++++++++++++++++++++++++
 tests/generic/793.out |  22 +++++++++
 tests/generic/794     | 101 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/794.out |  10 +++++
 tests/generic/795     |  67 ++++++++++++++++++++++++++++
 tests/generic/795.out |   2 +
 17 files changed, 629 insertions(+), 13 deletions(-)
 create mode 100644 src/fanotify.c
 create mode 100644 tests/generic/790
 create mode 100644 tests/generic/790.out
 create mode 100644 tests/generic/791
 create mode 100644 tests/generic/791.out
 create mode 100644 tests/generic/792
 create mode 100644 tests/generic/792.out
 create mode 100644 tests/generic/793
 create mode 100644 tests/generic/793.out
 create mode 100644 tests/generic/794
 create mode 100644 tests/generic/794.out
 create mode 100644 tests/generic/795
 create mode 100644 tests/generic/795.out

-- 
2.43.0



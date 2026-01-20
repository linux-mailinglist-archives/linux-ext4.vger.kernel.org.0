Return-Path: <linux-ext4+bounces-13098-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XKAdLQM4cGmgXAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13098-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 03:20:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE844FA8D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 03:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69B53808023
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339A3D6679;
	Tue, 20 Jan 2026 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="PIHmInI1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20751381710;
	Tue, 20 Jan 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908366; cv=pass; b=mj6ELW5TJTmWgzM4IAxCwqrwfkx5cEjdO/Y5Kbz2c++w2lu+Dq2kjDb3pBuMysDb/Wp1sMccJk7QzgB/zkRTJSoF6t9voMB7Ut1hzGONALOcJQH9lVSqbGpjt/sg6PkjzQAENnY5jH1B9K/yr1qB6lZAXcgHuqRIMjVnX62eJw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908366; c=relaxed/simple;
	bh=AihJugOS3gLP08BL42FR/nxgtKOT4iuoFcgzvHoyuMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTAiaQ7BrvJdAlNctTUUC1t9f3g+tdzIZw2RLl7xc3aLRStGVv/SMQkHArpJaHgKa4MI6y+dobaXpknxNJ1OW87Tihb5judLzMYfhi4uoHzFiUU3DyIuv7reSXulrTCtCuLDzcKCKBqSwb0nPX3M6rWqEKBnGGLVg/K1QymoSSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=PIHmInI1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908354; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kb8gYW3Asb7HGLlCea/xd+6RNcReRYm1DxDbOHxtQ58QKivJiRvxtUSstuPJMe0YZwjimBRZUmhQaCcCHn3DniMmYWNem6ZmnX6Hrm3gObzNtDpQJ5yBEg9RXh2HFsNAV+a/+S1giGzTUT8eOxArCuhJgV+H/gWKiE525QZmxUI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908354; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dMRtyO3IFkZenH++skFdvqhARhJ4aUIDMxaEfng6wAE=; 
	b=G1GIwvrAIh7ORcMOvVBFYxhW2NMYky79sdYJraJEeXzXJ5z+z15FJmD0eqGmPuM7DVbKxYKTIUb9BNxz8bStjXH+dn6o0NPDnWjcB1c7U45vUkohrScQkzjgtdMYr8KrGmi7H1Ef2P3g9mYPUEhRC7cB04i7Lh5V2zuyoe3f5zw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908354;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dMRtyO3IFkZenH++skFdvqhARhJ4aUIDMxaEfng6wAE=;
	b=PIHmInI1eqWmtmQRJTCEId57pupRk4i4nf8HlId/MAfAD9oM62myh1astP30jAq3
	sGQYY0TPdi/c9yqP4cLpXNIrqFWxqvvEFhWXxZv+e0n2I2nRJrXWdi77lGi7A91NQ98
	3anrdK0+/nvcoko+7gF3/sB9D/VMP43VgYRbJOw0=
Received: by mx.zohomail.com with SMTPS id 176890835186879.78263753608076;
	Tue, 20 Jan 2026 03:25:51 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-ext4@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v4 0/7] ext4: fast commit: snapshot inode state for FC log
Date: Tue, 20 Jan 2026 19:25:29 +0800
Message-ID: <20260120112538.132774-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13098-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux.beauty];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DFE844FA8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

(This RFC v4 series is based on linux-next tag next-20260106, plus the
prerequisite patch "ext4: fast commit: make s_fc_lock reclaim-safe" posted at:
https://lore.kernel.org/all/20260106120621.440126-1-me@linux.beauty/)

Zhang Yi in RFC v3 review pointed out that postponing lockdep assertions only
masks the issue, and that sleeping in ext4_fc_track_inode() while holding
i_data_sem can form a real ABBA deadlock if the fast commit writer also needs
i_data_sem while the inode is in FC_COMMITTING.

Zhang Yi suggested two possible directions to address the root cause:

1. "Ha, the solution seems to have already been listed in the TODOs in
fast_commit.c.

  Change ext4_fc_commit() to lookup logical to physical mapping using extent
  status tree. This would get rid of the need to call ext4_fc_track_inode()
  before acquiring i_data_sem. To do that we would need to ensure that
  modified extents from the extent status tree are not evicted from memory."

2. "Alternatively, recording the mapped range of tracking might also be
feasible."

This series implements a hybrid way: it implements approach 2 by snapshotting inode image
and mapped ranges at commit time, and consuming only snapshots during log
writing.

Approach 2 still needs a mapping source while building the snapshot
(logical-to-physical and unwritten/hole semantics). Calling ext4_map_blocks()
there would take i_data_sem and can block inside the
jbd2_journal_lock_updates() window, which risks deadlocks or unbounded stalls.
So the snapshot path uses approach 1's extent status lookups as a best-effort
mapping source to avoid ext4_map_blocks().

I did not fuly implement approach 1 (making extent status lookups
authoritative by preventing reclaim of needed entries) because that would need
additional pinning/integration under memory pressure and a larger correctness
surface. Instead, the extent status tree is treated as a cache and the
snapshot path falls back to full commit on cache misses or unstable mappings
(e.g. delayed allocation).

Lock inversion / deadlock model (before):

CPU0 (metadata update)               CPU1 (fast commit)
--------------------               -----------------
... hold i_data_sem (A)             mutex_lock(s_fc_lock) (B)
    ext4_fc_track_inode()             ext4_fc_write_inode_data()
      mutex_lock(s_fc_lock) (B)         ext4_map_blocks()
      wait FC_COMMITTING (sleep)          down_read(i_data_sem) (A)

This creates i_data_sem (A) -> s_fc_lock (B) on update paths, and
s_fc_lock (B) -> i_data_sem (A) on commit paths. Once CPU0 sleeps while
holding (A), CPU1 can block on (A) while holding (B), completing the ABBA
cycle.

New model (this series):

CPU0 (metadata update)               CPU1 (fast commit)
--------------------               -----------------
... maybe hold i_data_sem (A)        jbd2_journal_lock_updates()
    ext4_fc_track_*()                 snapshot inode + ranges (no map_blocks)
      mutex_lock(s_fc_lock) (B)       jbd2_journal_unlock_updates()
      if FC_COMMITTING: set FC_REQUEUE s_fc_lock (B)
      no sleep                         write FC log from snapshots only
                                    cleanup: clear COMMITTING, requeue if set

The commit path no longer takes i_data_sem while holding s_fc_lock, and
tracking no longer sleeps waiting for FC_COMMITTING. If an inode is updated
during a fast commit, EXT4_STATE_FC_REQUEUE records that fact and the inode
is moved to FC_Q_STAGING for the next commit.
The only remaning FC_COMMITTING waiter is ext4_fc_del(), which drops
s_fc_lock before sleeping.

This series snapshots the on-disk inode and tracked data ranges while journal
updates are locked and existing handles are drained. The log writing phase then
serializes only snapshots, so it no longer needs to call ext4_map_blocks() and
take i_data_sem under s_fc_lock. This is done in two steps: patch 1 drops
ext4_map_blocks() from log writing by introducing commit-time snapshots, and
patch 5 drops ext4_map_blocks() from the snapshot path by using the extent
status cache. The snapshot also records whether a mapped extent is unwritten,
so the ADD_RANGE records (and replay) preserve unwritten semantics.

Snapshotting runs under jbd2_journal_lock_updates(). Since a cache miss in
ext4_get_inode_loc() can start synchronous inode table I/O and stall handle
starts for milliseconds, patch 1 uses ext4_get_inode_loc_noio() and falls back
to full commit if the inode table block is not present or not uptodate.

ext4_fc_track_inode() also stops waiting for FC_COMMITTING. Updates during an
ongoing fast commit are marked with EXT4_STATE_FC_REQUEUE and are replayed in
the next fast commit, while ext4_fc_del() waits for FC_COMMITTING so an inode
cannot be removed while the commit thread is still using it.

The extent status tree is a cache, not an authoritative source, so the snapshot
path falls back to full commit on cache misses or unstable mappings (e.g.
delayed allocation). This includes cases where extent status entries are not
present (or have been reclaimed) under memory pressure. The snapshot path does
not try to rebuild mappings by calling ext4_map_blocks(); instead it simply
marks the transaction fast commit ineligible.

To keep the updates-locked window bounded, the snapshot path caps the number of
snapshotted inodes and ranges per fast commit (currently 1024 inodes and 2048
ranges) and falls back to full commit when the cap is exceeded. The series also
handles the journal inode i_data_sem lockdep false positive via subclassing;
journal inode mapping may still take i_data_sem even when data inode mapping is
avoided.

Patch 6 adds the ext4_fc_lock_updates tracepoint to quantify the updates-locked
window and snapshot fallback reasons. Patch 7 extends
/proc/fs/ext4/<sb_id>/fc_info with best-effort snapshot counters. If the /proc
interface is undesirable, I can drop patch 7 and keep the tracepoint only, or
drop even both.

Testing and mesurement were done on a QEMU/KVM guest with virtio-pmem + dax
(ext4 -O fast_commit, mounted dax,noatime). The workload does python3 500x
{4K write + fsync}, fallocate 256M, and python3 500x {creat + fsync(dir)}.
Over 3 cold boots, ext4_fc_lock_updates reported locked_ns p50 2.88-2.92 us,
p99 <= 6.71 us, and max <= 102.71 us, with snap_err always 0. Under stress-ng
memory pressure (stress-ng --vm 4 --vm-bytes 75% --timeout 60s), locked_ns p50
2.94 us, p99 <= 4.97 us, and max <= 20.07 us. The fc_info snapshot failure
counters stayed at 0.
These hold times are in the low microseconds range, and the caps keep the
worst case bounded.

Comments and guidance are very welcome. Please let me know if there are any
concerns about correctness, corner cases, or better approaches.

RFC v3 -> RFC v4:
- Replace lockdep_assert movement with removing the wait in
  ext4_fc_track_inode() and using EXT4_STATE_FC_REQUEUE to capture updates
  during an ongoing fast commit.
- Replace dropping s_fc_lock around log writing with commit-time snapshots of
  inode image and mapped ranges (recording the mapped range of tracking as
  suggested by Zhang Yi) so log writing consumes only snapshots.
- Avoid inode table I/O under jbd2_journal_lock_updates() via
  ext4_get_inode_loc_noio() and fallback to full commit on cache misses.
- Use the extent status cache for snapshot mappings and fall back to full
  commit on cache misses or unstable mappings (e.g. delayed allocation).
- Add tracepoint and /proc snapshot stats to quantify the updates-locked window
  and snapshot fallback reasons.

RFC v2 -> RFC v3:
- rebase ontop of https://lore.kernel.org/linux-ext4/20251223131342.287864-1-me@linux.beauty/T/#u

RFC v1 -> RFC v2:
- patch 1: move comments to correct place
- patch 2: add it to patchset.
- add missing RFC prefix

RFC v1: https://lore.kernel.org/linux-ext4/20251222032655.87056-1-me@linux.beauty/T/#u
RFC v2: https://lore.kernel.org/linux-ext4/20251222151906.24607-1-me@linux.beauty/T/#t
RFC v3: https://lore.kernel.org/linux-ext4/20251224032943.134063-1-me@linux.beauty/

Thanks,

Li Chen (7):
  ext4: fast commit: snapshot inode state before writing log
  ext4: lockdep: handle i_data_sem subclassing for special inodes
  ext4: fast commit: avoid waiting for FC_COMMITTING
  ext4: fast commit: avoid self-deadlock in inode snapshotting
  ext4: fast commit: avoid i_data_sem by dropping ext4_map_blocks() in
    snapshots
  ext4: fast commit: add lock_updates tracepoint
  ext4: fast commit: export snapshot stats in fc_info

 fs/ext4/ext4.h              |  58 ++-
 fs/ext4/fast_commit.c       | 718 +++++++++++++++++++++++++++++-------
 fs/ext4/inode.c             |  51 +++
 fs/ext4/super.c             |   9 +
 include/trace/events/ext4.h |  33 ++
 5 files changed, 735 insertions(+), 134 deletions(-)

-- 
2.52.0


Return-Path: <linux-ext4+bounces-14034-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID9wDQ0eoGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14034-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:18:53 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A379C1A425D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9948A3003514
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8283A4F3D;
	Thu, 26 Feb 2026 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="jHdmqDft"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047762F7478;
	Thu, 26 Feb 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101080; cv=pass; b=fktZaU7/gMe9O5T5Sl1R2DerpOzUcCaNfLL4r3LDQJr/wCc5VMCFP7oBA2u8yAx4Mrd+FqDMyjTMmFJjGIdNeKIa1znh2731jYuTM9Ic0faXfewqWt3nUAYGYvQr2jl/ETmd1XtuIRIKQ7bmUEfUdqpcnr9LmkK2SBjEHXPVr3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101080; c=relaxed/simple;
	bh=qCpUflaM0C1W0Sc5liaMXRlWL8Yf+74i32PiZ8gJCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaAsEkv8tIS1wkNvniv47nnSxr0CIyCt71zjUjwSJwE6hYm4GT7QS3ZdtZ+/7HlMdEsJkK9/9VL7HncYyBPmaQ33rbGMmsao3AWCHeeZo9FhoiXbcI808Vg80rPb5P4+vFXnk5cNwHwEDdHDAKw56KZ5cgJScXfMZ6A/od9IMZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=jHdmqDft; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772101072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FT73aCCUWuhFbikLcOen+rxgJdE1JCi39lJsKKfYxdcbUG94wDHB5w7Zt/p/iXCtUsOePZVcXXNycqC6jRfUgZDTI58bVB41dOZzc4SWiducIRMgpjl99WA1gFnOWs6CEGZJTWgK87CuFtarzGDe0dIZ+z4xh1CjxyytgYc++3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772101072; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3Vn/ZnAj/GgwLSLz1HBI91JKlz+6aEL8u4OwMFLu7Xo=; 
	b=N4jDttqL7D+Icdh1mva8F/l03abh7UbNuwIHpmlhy/yhU373ttjpRLdHXSDZaRRiD+Xe8BYL06vKmvuTBZfeSaiaiY2gEleZZeL393F1MLBbwSUa8QyuOAIDaXZyu6Y+FGOQXh70RDtu1JUrpMU1Ux7RgpSvGUoONuab3of1lVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772101072;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3Vn/ZnAj/GgwLSLz1HBI91JKlz+6aEL8u4OwMFLu7Xo=;
	b=jHdmqDftvbKeSaja07gZbRe9EakZm734XvOD62kVJ2fMXFXaOx0hxYnb3ro1RlCM
	t6bVbOfQ43P5aGD6oiNv2UqLTq9Eb9ypIxoYhgZ6lUyNURInuSe5ffppQE+kEG+KTNY
	hWMAsYmL5fxJSDmqUpLVz8g2306Dp1jGdvBTb80g=
Received: by mx.zohomail.com with SMTPS id 1772101071104990.6088497131792;
	Thu, 26 Feb 2026 02:17:51 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] ext4: Byte-granular ByteLog optimizes DAX fast commits
Date: Thu, 26 Feb 2026 18:17:28 +0800
Message-ID: <20260226101736.2271952-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14034-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:mid,linux.beauty:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:url]
X-Rspamd-Queue-Id: A379C1A425D
X-Rspamd-Action: no action

This RFC introduces a DAX fast commit ByteLog backend for ext4.

When enabled, ext4 writes fast commit TLVs directly into a DAX-mapped
ByteLog ring, avoiding bufferhead based writes. Replay verifies CRC32C and
replays the ByteLog records before falling back to the traditional FC
block.

Motivation:

The current ext4 fast-commit write path emits TLVs into the fast-commit
area via bufferheads and block I/O. This is inherently block-granular:
small metadata updates still end up writing full blocks, which is a form
of write amplification. On pmem-backed or other DAX-capable setups, this
also keeps bufferhead / block layer overhead on the hot path even though
the medium supports direct access and cacheline writeback.

ByteLog is an attempt to reduce this overhead by writing the common
metadata TLVs directly into a DAX mapping, batching multiple TLVs into a
single record when possible, and persisting data with cacheline/byte-
granular flush (arch_wb_cache_pmem()) rather than block-granular I/O,
while keeping the existing fast-commit on-media format and replay logic
in place.

This idea has been mentioned before. LWN mentioned that Shirwadkar
considered implementing a similar optimization back in 2021:
https://lwn.net/Articles/842385/
It seems there has been no further progress since then. This RFC is an
independent from-scratch attempt to prototype the idea and gather
performance/correctness feedback.

Design:

The ByteLog backend reuses the JBD2 fast-commit area for storage, but
writes the bulk of fast-commit metadata by directly memcpy'ing TLVs into
a DAX mapping, avoiding bufferhead based writes. The conventional
bufferhead based fast-commit stream remains in use for HEAD/TAIL plus a
small anchor TLV that points to the ByteLog window.

ByteLog itself is an append-only stream of records aligned to 64
bytes. Each record starts with a fixed on-media header
(magic/version/tid/tag/seq/lengths) that carries its own CRC; the payload
is protected by CRC32C as well. The payload content is either a single
standard ext4 fast-commit TLV (tl+value) or a batched record containing a
stream of TLVs, allowing multiple TLVs to share one record header and
persist flush.

On the write path, when dax_fc_bytelog is enabled, ext4 routes the
frequently emitted metadata TLVs (range, dentry, inode) into the DAX
mapping. At the end of the fast commit, it flushes the touched range
with arch_wb_cache_pmem() and orders it with pmem_wmb(), then writes an
EXT4_FC_TAG_DAX_BYTELOG_ANCHOR TLV into the conventional fast-commit
stream. The anchor encodes the ByteLog head/tail/seq and a CRC of the
concatenated payload stream so replay can validate what was persisted,
after which the normal TAIL TLV is written.

On replay, the anchor TLV triggers validation of the ByteLog window
(record CRCs, seq continuity and payload-stream CRC) and then replays the
contained TLVs using the existing ext4 fast-commit replay handlers.

Dependencies:
- virtio-pmem request lifetime and broken queue fixes:
  https://lore.kernel.org/all/20260226025712.2236279-1-me@linux.beauty/
- ext4 jinode publish/init fix (prevents crashes in jbd2_wait_inode_data()):
  https://lore.kernel.org/all/20260225082617.147957-1-me@linux.beauty/
- next-20260220

The benchmark results below were collected with the dependency patchset
above applied(otherwise it will trigger issues described in these two patchsets)

Note: This RFC does not yet include e2fsprogs/mke2fs changes to set
INCOMPAT_DAX_FC_BYTELOG at mkfs time, so the benchmarks below were run
with dax_fc_bytelog=force. If there is interest, I will follow up with
an e2fsprogs patchset and switch the recommended usage to
dax_fc_bytelog=on.

Benchmark (virtio-pmem, ext4 DAX + fast_commit):
- fio: runtime=30s, ramp=3s (10s for iouring_randwrite_{fsync,fdatasync}16),
  workers=15, direct=1;
  meta_create_unlink* uses psync (iodepth=1), iouring_* uses io_uring
  (iodepth=64).
- mariadb_txnproc/sysbench_db: time=120s, innodb_buffer_pool_size=8G.
- sqlite: 3 iterations, interleave order, median reported.

Results (baseline vs bytelog; gain%: positive is better):

fio (iops higher better, p99 lower better; p99 in ms)
case                               iopsB iopsBL   iops%  p99Bms p99BLms    p99%
===============================================================================
meta_create_unlink_fsync0         614.8k 618.8k  +0.64%   0.036   0.036  +0.00%
meta_create_unlink_fsync2          11.0k  10.9k  -1.27%   1.876   0.963 +48.69%
meta_create_unlink_fsync4          14.6k  14.6k  -0.20%   2.933   1.548 +47.21%
meta_create_unlink_fsync8          21.4k  21.6k  +1.30%   3.654   1.679 +54.04%
meta_create_unlink_fsync16         34.1k  35.5k  +4.19%   4.178   1.516 +63.73%
meta_create_unlink_fsync32         52.8k  56.3k  +6.71%  12.648   1.860 +85.30%
iouring_create_unlink_fsync16      37.6k  39.1k  +3.97%   3.457   1.434 +58.53%
iouring_create_unlink_fdatasync16  37.4k  39.2k  +4.86%   3.457   1.253 +63.74%
iouring_randwrite_fsync16         2.441M 2.460M  +0.75%   9.110   7.963 +12.59%
iouring_randwrite_fdatasync16     201.6k 264.5k +31.23% 137.363 137.363  +0.00%
iouring_randwrite                 4.572M 4.568M  -0.08%   0.272   0.276  -1.51%
fio_randwrite                     4.591M 4.577M  -0.31%   0.259   0.272  -5.14%
fio_seqwrite                      4.577M 4.574M  -0.07%   0.264   0.272  -3.10%
fio_randread                      5.529M 5.549M  +0.36%   0.210   0.218  -3.90%
fio_seqread                       6.069M 6.073M  +0.06%   0.191   0.196  -2.14%

mariadb_txnproc (+% better; *_us lower better)
metric        baseline     bytelog    gain%
tps          6694.492   6858.725  +2.45%
avg_txn_us   2223.803   2170.499  +2.40%
max_txn_us     269278     189148 +29.76%

sysbench_db (+% better; *_ms lower better; percentile=99)
metric        baseline     bytelog    gain%
tps          3048.920   3075.900  +0.88%
p99_ms         47.470     48.340  -1.83%
avg_ms          4.920      4.880  +0.81%

sqlite (+% better; elapsed_s lower better; n=3 median)
metric          baseline     bytelog    gain%
tps_med       7517.850   7453.100  -0.86%
elapsed_s_med   39.905     40.252  -0.87%

Notes:
- Small regressions were observed in a few read-heavy workloads:
  - sqlite tps_med: -0.86%
  - sysbench_db p99_ms: -1.83%
  - fio_randread p99: -3.90%

They are small and may be affected by limited iterations and run-to-run
variance. ByteLog is opt-in; follow-up series will focus on reducing
ByteLog overhead (CRC32C, cache footprint) and improving the regressing
cases.

This is still an RFC and the current focus is on functionality and
performance. Correctness and crash-consistency coverage is not complete
yet. I would appreciate any guidance on good crash-recovery test setups
(or recommended xfstests cases) for ext4 fast commits (and for DAX-backed
fast-commit storage in particular), so I can strengthen the correctness
and crash-consistency argument in follow-up revisions.

Comments are welcome!

Li Chen (4):
  ext4: introduce DAX fast commit ByteLog backend
  ext4: add dax_fc_bytelog mount option
  ext4: fast_commit: write TLVs into DAX ByteLog
  ext4: fast_commit: replay DAX ByteLog records

 fs/ext4/Makefile              |   2 +-
 fs/ext4/ext4.h                |   9 +-
 fs/ext4/fast_commit.c         | 370 +++++++++++++++-
 fs/ext4/fast_commit.h         |  22 +
 fs/ext4/fast_commit_bytelog.c | 800 ++++++++++++++++++++++++++++++++++
 fs/ext4/fast_commit_bytelog.h | 152 +++++++
 fs/ext4/super.c               |  77 +++-
 7 files changed, 1426 insertions(+), 6 deletions(-)
 create mode 100644 fs/ext4/fast_commit_bytelog.c
 create mode 100644 fs/ext4/fast_commit_bytelog.h

-- 
2.52.0


Return-Path: <linux-ext4+bounces-1853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8BE8985C7
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 13:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD391C20AC0
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD2682864;
	Thu,  4 Apr 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CZYlFAxg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862580BF7
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229042; cv=none; b=mAK1kJiWR7GJ8DkH1rpXGJeHTK1guWsB0dH5gjolqIDYTcF8GC54o8UeUHEdeK7le5+VVoYiXtTD/EfQN3ZGFJnzVUz9zIbGh9OmqmBZUAF2FgVmvL7e91d/j+hUy+GINJ22Dx0A1uA21m7LyOR6rbgxRUtgnPPRDXmUz/76TDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229042; c=relaxed/simple;
	bh=4k8DGJDY7P/Gx02R9MwxXa6TDY6CRaUE8B6PgO7bByA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shZBm2shzVHJ12aE08ZNnmvsBf0MbMDpfxVELp67P2R1lsl52fBxRvZ59v/l3bWeW5O7XKHcYMWXkI36Pso5rWasN6MJ2jiEzv6skbUDi8zlZtJIJLYmwRO8MTc8hm9g2U4bzwk4B2mmeaeQQEUV4YuRDF4RKopRUmkg6hkv2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CZYlFAxg; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712229037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2fKSBK9hqR9y6H7m4T/N9tWpot5JVaN8og88kNoWAHk=;
	b=CZYlFAxgNBEtTqIvMM24dqRP+dQj7X2DTs2guLyleJDfc+K/t3kNw3LjLcohTzU2aZ0yXJ
	9N4mN4Naf3BKrJc9QRZd/RrwHj0NKicGfPpvNstnULlYnuT1PQTKbRSF/YtHlpi8KiytWK
	wLU4xBiCX7Yirk4tppzSCJo2gYIycw4=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH e2fsprogs v2 0/4] quota-related e2fsck fixes and tests
Date: Thu,  4 Apr 2024 12:10:28 +0100
Message-ID: <20240404111032.10427-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

I'm (re)sending two fixes to e2fsck that are related with quota handling.
The fixes are the first two patches, the other two are test cases for these
fixes.

As I mentioned in v1, the issues were found using fstests ext4/014 and
ext4/019.  And the only thing in this series that changed from v1 was the
first test ("tests: new test to check quota after directory optimization"),
which is now using a much simplified version of the testcase.

Note that, since the first two patches didn't change, they have already a

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

which I'm not including in the patches themselves.  Should I?  Or is that
better left for the maintainer (eventually) applying them?

Cheers,
-- 
Luis

Luis Henriques (SUSE) (4):
  e2fsck: update quota accounting after directory optimization
  e2fsck: update quota when deallocating a bad inode
  tests: new test to check quota after directory optimization
  tests: new test to check quota after a bad inode deallocation

 e2fsck/pass2.c                          |  33 +++++++++++++++++-------
 e2fsck/rehash.c                         |  27 ++++++++++++++-----
 tests/f_quota_deallocate_inode/expect.1 |  18 +++++++++++++
 tests/f_quota_deallocate_inode/expect.2 |   7 +++++
 tests/f_quota_deallocate_inode/image.gz | Bin 0 -> 11594 bytes
 tests/f_quota_deallocate_inode/name     |   1 +
 tests/f_quota_shrinkdir/expect.1        |  18 +++++++++++++
 tests/f_quota_shrinkdir/expect.2        |   7 +++++
 tests/f_quota_shrinkdir/image.gz        | Bin 0 -> 10761 bytes
 tests/f_quota_shrinkdir/name            |   1 +
 10 files changed, 96 insertions(+), 16 deletions(-)
 create mode 100644 tests/f_quota_deallocate_inode/expect.1
 create mode 100644 tests/f_quota_deallocate_inode/expect.2
 create mode 100644 tests/f_quota_deallocate_inode/image.gz
 create mode 100644 tests/f_quota_deallocate_inode/name
 create mode 100644 tests/f_quota_shrinkdir/expect.1
 create mode 100644 tests/f_quota_shrinkdir/expect.2
 create mode 100644 tests/f_quota_shrinkdir/image.gz
 create mode 100644 tests/f_quota_shrinkdir/name



Return-Path: <linux-ext4+bounces-1899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C56B899F75
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 16:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C6E284099
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1326116EBF9;
	Fri,  5 Apr 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OWn1TK++"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFE16EBE4
	for <linux-ext4@vger.kernel.org>; Fri,  5 Apr 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327052; cv=none; b=EptVsfwox16KrqhEDrpN0cB3lRla3BQkCGXigYvkAOyLuZjoLXhgLm8ihJuBSOUKUyDvrW3CmlOcA7kTvWb5yT6sjCCVU18g/YbKJY+MCpaxm85uCsTwMAs8+aiTqhxoe9PhYqXv/rirG08Ak3RGyMIn/uLYoz1DbTg946FQEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327052; c=relaxed/simple;
	bh=bSxDohV6I9Ag7iM0mRoQhr/kHjXdQz6A8jb69OmR5gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1lzI9G5IZDBrFUqML7BVjLtMld8TG6xSKh35Wi5L74J+cs1QRej95rss623lNOW80gvZn9YMn+8DN+W6WiVaFw+u47n0RMlz/qu7RgHsb3AW99V8R26iIEZTxk7bp/U08P0dyzP/3VnqV+Bb5YfJz7OaYOcP3xKJkwOsmOQTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OWn1TK++; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712327049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ZOhTJGJDPoNxUxhoO+bOJZmD1tGctAf1VAwvjRojXU=;
	b=OWn1TK++ik3GxPVtWyD+K0HB1BWspDb4937u6+AcB9F7edkPIdADTbK2gHpmotHn74JpYL
	I/XnkSODqggONlo9n998tGMfN6bAPq4eJiA3q9cLQKiB6LmgGALYkffGDNSLeABlh9lA2X
	c7VSrjWhotGqHuwjKej6dD1Vy+FPSXA=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH e2fsprogs v3 0/4] quota-related e2fsck fixes and tests
Date: Fri,  5 Apr 2024 15:24:01 +0100
Message-ID: <20240405142405.12312-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

Changes since v2:

Added deallocate_inode() documentation, as suggested by Andreas Dilger
(and using text he provided).

And, for reference, here's the cover-letter from v2:

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

 e2fsck/pass2.c                          |  43 ++++++++++++++++++------
 e2fsck/rehash.c                         |  27 +++++++++++----
 tests/f_quota_deallocate_inode/expect.1 |  18 ++++++++++
 tests/f_quota_deallocate_inode/expect.2 |   7 ++++
 tests/f_quota_deallocate_inode/image.gz | Bin 0 -> 11594 bytes
 tests/f_quota_deallocate_inode/name     |   1 +
 tests/f_quota_shrinkdir/expect.1        |  18 ++++++++++
 tests/f_quota_shrinkdir/expect.2        |   7 ++++
 tests/f_quota_shrinkdir/image.gz        | Bin 0 -> 10761 bytes
 tests/f_quota_shrinkdir/name            |   1 +
 10 files changed, 105 insertions(+), 17 deletions(-)
 create mode 100644 tests/f_quota_deallocate_inode/expect.1
 create mode 100644 tests/f_quota_deallocate_inode/expect.2
 create mode 100644 tests/f_quota_deallocate_inode/image.gz
 create mode 100644 tests/f_quota_deallocate_inode/name
 create mode 100644 tests/f_quota_shrinkdir/expect.1
 create mode 100644 tests/f_quota_shrinkdir/expect.2
 create mode 100644 tests/f_quota_shrinkdir/image.gz
 create mode 100644 tests/f_quota_shrinkdir/name



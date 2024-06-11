Return-Path: <linux-ext4+bounces-2853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB103903EB6
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F0E28483D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5117D37F;
	Tue, 11 Jun 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m262/9sl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99A1EF01
	for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116044; cv=none; b=jyftAWR5HIAyG/DmeataXHqK9cIBeeXivrqK+pUK9yqcmm251kroadaZ6/Dh7F+wpPtTHTXHUQm+17itbGZ5TqUj8geIe4Tr7NOtIdqPipaXSUlPoSzrArW0ZmLs11ewlvlV0oUxSoriJ5Xb/SdjN1XYXxZBgx+U+lWGXT/c4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116044; c=relaxed/simple;
	bh=2wlg3HAlXd7S/yxnc+Sib64U7sEorK1Wfd7dYbPngS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dATpUtHBrJ7KDqoy8gP69rH0toYXjTOlMm6GkyX1prFUCXcPFeLtw0nC710rZuSGLTYCAuiaf5tPpcZPocx4Abx3J4jsHkUlGUVvJC6WQIUC+qjvn3TAkgH8NlNmwmmNMUgkWkXtRc/kfak79rZd7TXUO20KMhdQAERCDrMERRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m262/9sl; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718116039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wlG1SN0b1hxQ/cokbPhb9eVLnXAwuAEB2+ggs6fgaD4=;
	b=m262/9slUMoSJz2/H3tfBxiT5OLCpV6LO7HsOHYHw0LitPdeCWXThd3QcCBohKlmM7siMC
	fNZoqJNJTdrVMVSy11na3/gIwRpQKbALUSLqDmyjgpyun51djcFojImQ30V3LsiTEGE0Ei
	z7o23ICRO4tI2StlwAnDNDrF5XVNh7A=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: linux-ext4@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 0/2] e2fsck: make sure orphan files are cleaned-up
Date: Tue, 11 Jun 2024 15:27:02 +0100
Message-ID: <20240611142704.14307-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

I'm sending a fix to e2fsck that forces the filesystem checks to happen
when the orphan file is present in the filesystem.  This patch resulted from
a bug reported in openSUSE Tumbleweed[1] where e2fsck doesn't clean-up this
file and later the filesystem  fails to be mounted read-only (because it
still requires recovery).

I'm also sending a new test to validate this scenario.

[1] https://bugzilla.suse.com/show_bug.cgi?id=1226043

Luis Henriques (SUSE) (2):
  e2fsck: don'k skip checks if the orphan file is present in the
    filesystem
  tests: new test to check that the orphan file is cleaned up

 e2fsck/unix.c                      |   4 ++++
 tests/f_clear_orphan_file/expect.1 |  35 +++++++++++++++++++++++++++++
 tests/f_clear_orphan_file/expect.2 |   7 ++++++
 tests/f_clear_orphan_file/image.gz | Bin 0 -> 12449 bytes
 tests/f_clear_orphan_file/name     |   1 +
 tests/f_clear_orphan_file/script   |   2 ++
 6 files changed, 49 insertions(+)
 create mode 100644 tests/f_clear_orphan_file/expect.1
 create mode 100644 tests/f_clear_orphan_file/expect.2
 create mode 100644 tests/f_clear_orphan_file/image.gz
 create mode 100644 tests/f_clear_orphan_file/name
 create mode 100644 tests/f_clear_orphan_file/script



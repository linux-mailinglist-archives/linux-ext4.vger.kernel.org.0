Return-Path: <linux-ext4+bounces-11736-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D75E6C48913
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84A7B34A5F1
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2A32AACD;
	Mon, 10 Nov 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjSqDXg3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC431B138;
	Mon, 10 Nov 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799172; cv=none; b=pysKj+0J0bfwtl9RyDI97gHl2Ci3Utk9t4RVlBwn12c1v+v2DxCt1XbYNQobTcVDMJWUVGSenSokNkmKUS/XUCljp0XmTp3Lo9Gn8DSbJ8pl+O073S7hopfGgLROxemY+nr4d8QlqDFjCFg7UrTQ3HbgMFfM/qAK12k5p+C2QZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799172; c=relaxed/simple;
	bh=I2iwtD7Ks2dzjla5uN3AazDhdRhcq1wCCKl+BsC3e/o=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=E7k1CDsoJh1w2FW2ZWkSVAwEiRJJe3bB+CJIZ/bkX2sIFcADyzqxl2N0A8zTlVma0eWaAbD2386SdC7KfWEFztMNolE9bb1jLN2NusaeVyzopSnJLtYyP9VdHSgvzlfPjbwL9b/B8L3FO57WfB9xFY4HSgz5hSkiFDSjskwtb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjSqDXg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08861C4CEF5;
	Mon, 10 Nov 2025 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799172;
	bh=I2iwtD7Ks2dzjla5uN3AazDhdRhcq1wCCKl+BsC3e/o=;
	h=Date:Subject:From:To:Cc:From;
	b=IjSqDXg3oJKzA2+e8dP3T/VZeL8P1r3hNMiFM2skoeQqQVJahl6r297MPyr4s/dmB
	 PO363+SFWt4LdRlRFpwGpmIkawkqu0jO4Nq4xrCT8cSzjMPgVyoH9lGey4BtYPsaBf
	 QfD62/8GiFNgSK057FdJn97hCsLHCFbj2eVfuqOJsZ6UAcvT459DwEbcGOJUDzsEbM
	 XRE0y/pyKVX7+NWYc6SXn08syAuZn65EoF0kvcjkMnjA7ZM0ss3UlPPgapKG3sFx/b
	 J1zDVSQBE6p1YkKnRNjf5eY8DpMnZeiB6MokeD48HAJb8u1rzhTNnogY1Ahk2+HWn+
	 EgSYP1hd6WjgQ==
Date: Mon, 10 Nov 2025 10:26:11 -0800
Subject: [PATCHSET] fstests: more random fixes for v2025.11.04
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's the usual odd fixes for fstests.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=random-fixes

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=random-fixes

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=random-fixes
---
Commits in this patchset:
 * common: leave any breadcrumbs when _link_out_file_named can't find the output file
 * generic/778: fix severe performance problems
 * generic/778: fix background loop control with sentinel files
 * generic/019: skip test when there is no journal
 * xfs/837: fix test to work with pre-metadir quota mount options
 * generic/774: reduce file size
 * generic/774: turn off lfsr
---
 common/rc                  |    1 
 tests/generic/019          |    1 
 tests/generic/774          |    6 ---
 tests/generic/778          |   95 ++++++++++++++++++++++++++++++++------------
 tests/xfs/837              |   28 +++++++++----
 tests/xfs/837.cfg          |    1 
 tests/xfs/837.out.default  |    0 
 tests/xfs/837.out.oldquota |    6 +++
 8 files changed, 100 insertions(+), 38 deletions(-)
 create mode 100644 tests/xfs/837.cfg
 rename tests/xfs/{837.out => 837.out.default} (100%)
 create mode 100644 tests/xfs/837.out.oldquota



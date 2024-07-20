Return-Path: <linux-ext4+bounces-3340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B39381FF
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6FD1F20F0B
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A151474D3;
	Sat, 20 Jul 2024 16:04:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571412C48A;
	Sat, 20 Jul 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491481; cv=none; b=L7M0mO1eVj6uggJU4atx2MRXOAA1/5WNobY8R1sd7279Z023vz7fHJ7Zhy3SCW9isx7goyMTHND7MH162BzAqWU7FZVkq8hLoMYWi+c8LLoKqeu4ddq+gMKd5EF0LU1DHQi7iVMn7GUOXC/uD5w3TGBPrVkyGThfZ/p2cT+mNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491481; c=relaxed/simple;
	bh=mpp+4vjREuKWx7Lv8rFQ77O9zbAN6tBq2dKxfKnErHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxvHSAr/bAAVDHehThK79sJjI2RgS7hU2/94vKouzmV8CpfNZebJyV/jjGH5wFuACHcFLijkuoO+6cX2dGSFPENfGeSRCFZeRQM9x+oU2RVdi9SGKTIYcLZaWYlLkTccS/1/la4nTabc9F9zIrFtZxDSwepEoCtN0Khsbd1p4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp81t1721491464twyjqvm1
X-QQ-Originating-IP: lJSXl2BmmlnX0O0hOMAd2J/SUflnUbXnLTy4psbDlXw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 21 Jul 2024 00:04:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9311491502483072868
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yi.zhang@huawei.com
Cc: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	niecheng1@uniontech.com,
	zhangdandan@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v2 4.19 0/4] ext4: improve delalloc buffer write performance
Date: Sun, 21 Jul 2024 00:04:06 +0800
Message-ID: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Changes since v1:
  Fixed some formatting errors to make the patchset less confusing.

A patchset from linux-5.15 should be backported to 4.19 that can
significantly improve ext4 fs read and write performance. Unixbench test
results for linux-4.19.318 on Phytium D2000 CPU are shown below.

Test cmd: (Phytium D2000 only has 8 cores)
  ./Run fs -c 8

Before this patch set:
  File Copy 1024 bufsize 2000 maxblocks		1124181
  File Copy 256 bufsize 500 maxblocks		281885
  File Copy 4096 bufsize 8000 maxblocks		3383785
  File Read 1024 bufsize 2000 maxblocks		8702173
  File Read 256 bufsize 500 maxblocks		3869384
  File Read 4096 bufsize 8000 maxblocks		13043151
  File Write 1024 bufsize 2000 maxblocks	1107185
  File Write 256 bufsize 500 maxblocks 		270493
  File Write 4096 bufsize 8000 maxblocks	4018084

After this patch set:
  File Copy 1024 bufsize 2000 maxblocks         2026206
  File Copy 256 bufsize 500 maxblocks           829534
  File Copy 4096 bufsize 8000 maxblocks         4066659
  File Read 1024 bufsize 2000 maxblocks         8877219
  File Read 256 bufsize 500 maxblocks           3997445
  File Read 4096 bufsize 8000 maxblocks         13179885
  File Write 1024 bufsize 2000 maxblocks        4256929
  File Write 256 bufsize 500 maxblocks          1305320
  File Write 4096 bufsize 8000 maxblocks	10721052

We can observe a quantum leap in the test results as a consequence of
applying this patchset

Link: https://lore.kernel.org/all/20210716122024.1105856-1-yi.zhang@huawei.com/



Original description:

This patchset address to improve buffer write performance with delalloc.
The first patch reduce the unnecessary update i_disksize, the second two
patch refactor the inline data write procedure and also do some small
fix, the last patch do improve by remove all unnecessary journal handle
in the delalloc write procedure.

After this patch set, we could get a lot of performance improvement.
Below is the Unixbench comparison data test on my machine with 'Intel
Xeon Gold 5120' CPU and nvme SSD backend.

Test cmd:

  ./Run -c 56 -i 3 fstime fsbuffer fsdisk

Before this patch set:

  System Benchmarks Partial Index           BASELINE       RESULT   INDEX
  File Copy 1024 bufsize 2000 maxblocks       3960.0     422965.0   1068.1
  File Copy 256 bufsize 500 maxblocks         1655.0     105077.0   634.9
  File Copy 4096 bufsize 8000 maxblocks       5800.0    1429092.0   2464.0
                                                                    ========
  System Benchmarks Index Score (Partial Only)                      1186.6

After this patch set:

  System Benchmarks Partial Index           BASELINE       RESULT   INDEX
  File Copy 1024 bufsize 2000 maxblocks       3960.0     732716.0   1850.3
  File Copy 256 bufsize 500 maxblocks         1655.0     184940.0   1117.5
  File Copy 4096 bufsize 8000 maxblocks       5800.0    2427152.0   4184.7
                                                                    ========
  System Benchmarks Index Score (Partial Only)                      2053.0




Zhang Yi (4):
  ext4: check and update i_disksize properly
  ext4: correct the error path of ext4_write_inline_data_end()
  ext4: factor out write end code of inline file
  ext4: drop unnecessary journal handle in delalloc write

 fs/ext4/ext4.h   |   3 -
 fs/ext4/inline.c | 120 ++++++++++++++++++-------------------
 fs/ext4/inode.c  | 150 ++++++++++++-----------------------------------
 3 files changed, 99 insertions(+), 174 deletions(-)

-- 
2.31.1


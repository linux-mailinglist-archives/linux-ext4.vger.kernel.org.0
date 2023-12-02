Return-Path: <linux-ext4+bounces-269-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB33801B9A
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Dec 2023 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149B21C20B4B
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Dec 2023 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433210A3C;
	Sat,  2 Dec 2023 09:10:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C38FD9;
	Sat,  2 Dec 2023 01:10:47 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sj3w71gq7z1P8b8;
	Sat,  2 Dec 2023 17:07:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 2 Dec
 2023 17:10:44 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-mm@kvack.org>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <ritesh.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending DIO write race with buffered read
Date: Sat, 2 Dec 2023 17:14:30 +0800
Message-ID: <20231202091432.8349-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

Hello everyone!

Recently, while running some pressure tests on MYSQL, noticed that
occasionally a "corrupted data in log event" error would be reported.
After analyzing the error, I found that extending DIO write and buffered
read were competing, resulting in some zero-filled page end being read.
Since ext4 buffered read doesn't hold an inode lock, and there is no
field in the page to indicate the valid data size, it seems to me that
it is impossible to solve this problem perfectly without changing these
two things.

In this series, the first patch reads the inode size twice, and takes the
smaller of the two values as the copyout limit to avoid copying data that
was not actually read (0-padding) into the user buffer and causing data
corruption. This greatly reduces the probability of problems under 4k
page. However, the problem is still easily triggered under 64k page.

The second patch waits for the existing dio write to complete and
invalidate the stale page cache before performing a new buffered read
in ext4, avoiding data corruption by copying the stale page cache to
the user buffer. This makes it much less likely that the problem will
be triggered in a 64k page.

Do we have a plan to add a lock to the ext4 buffered read or a field in
the page that indicates the size of the valid data in the page? Or does
anyone have a better idea?

Comments and questions are, as always, welcome.

Baokun Li (2):
  mm: avoid data corruption when extending DIO write race with buffered
    read
  ext4: avoid data corruption when extending DIO write race with
    buffered read

 fs/ext4/file.c | 3 +++
 mm/filemap.c   | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.31.1



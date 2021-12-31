Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7099348229E
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Dec 2021 08:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbhLaHni (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Dec 2021 02:43:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29314 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLaHni (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Dec 2021 02:43:38 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JQHDp4yHszbjlM;
        Fri, 31 Dec 2021 15:43:06 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:43:36 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:43:36 +0800
Message-ID: <d0632bbc-9713-38a9-c914-137b702f6ae1@huawei.com>
Date:   Fri, 31 Dec 2021 15:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH v2 6/6] lib/ext2fs: call ext2fs_free_mem() to free &io->name,
 in exception branch
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
References: <52a2a39d-617f-2f27-a8a4-34da6103e44c@huawei.com>
In-Reply-To: <52a2a39d-617f-2f27-a8a4-34da6103e44c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100004.china.huawei.com (7.185.36.247) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the exception branch,if we donot call ext2fs_free_mem() to
free &io->name, memory leak will occur.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  lib/ext2fs/test_io.c | 2 ++
  lib/ext2fs/undo_io.c | 2 ++
  2 files changed, 4 insertions(+)

diff --git a/lib/ext2fs/test_io.c b/lib/ext2fs/test_io.c
index 480e68fc..6843edbc 100644
--- a/lib/ext2fs/test_io.c
+++ b/lib/ext2fs/test_io.c
@@ -248,6 +248,8 @@ static errcode_t test_open(const char *name, int 
flags, io_channel *channel)
  	return 0;

  cleanup:
+	if (io && io->name)
+		ext2fs_free_mem(&io->name);
  	if (io)
  		ext2fs_free_mem(&io);
  	if (data)
diff --git a/lib/ext2fs/undo_io.c b/lib/ext2fs/undo_io.c
index eb56f53d..0d4915cb 100644
--- a/lib/ext2fs/undo_io.c
+++ b/lib/ext2fs/undo_io.c
@@ -788,6 +788,8 @@ cleanup:
  		free(data->tdb_file);
  	if (data && data->real)
  		io_channel_close(data->real);
+	if (io && io->name)
+		ext2fs_free_mem(&io->name);
  	if (data)
  		ext2fs_free_mem(&data);
  	if (io)
-- 
2.27.0


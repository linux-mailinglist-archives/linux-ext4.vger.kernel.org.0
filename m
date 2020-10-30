Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A529FB29
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 03:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ3CY7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 22:24:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7101 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3CY7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 22:24:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMmNp1RF9zLqQR;
        Fri, 30 Oct 2020 10:24:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 10:24:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] MAINTAINERS: add missing file in ext4 entry
Date:   Fri, 30 Oct 2020 10:24:35 +0800
Message-ID: <20201030022435.1136-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

include/trace/events/ext4.h belongs to ext4 module, add the file path into
ext4 entry in MAINTAINERS.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..d1d4e49a695a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6618,6 +6618,7 @@ Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
+F:	include/trace/events/ext4.h
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.ibm.com>
-- 
2.26.2


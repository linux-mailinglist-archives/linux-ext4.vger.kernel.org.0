Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4643FFA4C
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 08:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbhICGSo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 02:18:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9400 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbhICGSn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 02:18:43 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H16tF68Vyz8wbb;
        Fri,  3 Sep 2021 14:13:25 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 14:17:42 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 3 Sep 2021 14:17:41 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 0/3] bugfix for insert/collapse fallocate
Date:   Fri, 3 Sep 2021 14:27:45 +0800
Message-ID: <20210903062748.4118886-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

yangerkun (3):
  ext4: correct the left/middle/right debug message for binsearch
  ext4: ensure enough credits in ext4_ext_shift_path_extents
  ext4: stop use path once restart journal in
    ext4_ext_shift_path_extents

 fs/ext4/extents.c | 77 ++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03E13F6D57
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 04:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhHYCNv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 22:13:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8924 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhHYCNu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Aug 2021 22:13:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GvTtH272vz8v3X;
        Wed, 25 Aug 2021 10:08:55 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 10:13:03 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 25 Aug 2021 10:13:03 +0800
To:     Jan Kara <jack@suse.cz>
CC:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Subject: [QUESTION] question for commit 2d01ddc86606 ("ext4: save error info
 to sb through journal if available")
Message-ID: <05ff3a17-6559-9317-a382-f0a02fa59926@huawei.com>
Date:   Wed, 25 Aug 2021 10:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

There is a question about 2d01ddc86606 ("ext4: save error info to sb 
through journal if available"). This commit describe that we can have 
checksum failure with follow case:

1. ext4_handle_error will call ext4_commit_super which write directly to 
the superblock
2. At the same time, jounalled update of the superblock is ongoing

However, after commit 05c2c00f3769 ("ext4: protect superblock 
modifications with a buffer lock"), all the update for superblock and 
the csum will be protected with buffer lock. It seems we won't get a 
csum error after that commit and the journal logic in 
flush_stashed_error_work seems useless.

Maybe there is something missing... Can you help to explain more for that...


Thanks,
Kun.

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DD73D1EB
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jun 2023 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjFYQAh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Jun 2023 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFYQAc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Jun 2023 12:00:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02409E70
        for <linux-ext4@vger.kernel.org>; Sun, 25 Jun 2023 09:00:16 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qpwdj55QVzTlt8;
        Sun, 25 Jun 2023 23:59:21 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:00:09 +0800
Message-ID: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
Date:   Mon, 26 Jun 2023 00:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [bug report] tune2fs: filesystem inconsistency occurs by concurrent
 write
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500019.china.huawei.com (7.185.36.137) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Tytso,
Tune2fs does not recognize writes to the manipulated filesystem in another
namespace, there will be two simultaneous write operations on a
block, resulting in filesystem inconsistencies.

The operation is as follows:
first terminal                                      second terminal
mkfs.ext4 /dev/sdb;
mount /dev/sdb /test-sdb;
dd if=/dev/zero of=/test-sdb/test1 bs=1M count=100;
                                                     unshare -m;
umount;
gdb tune2fs;
b io_channel_write_byte
r -e remount-ro /dev/sdb
c(Write a byte of old data into the cache)
                                                     exit;
(gdb finish)
tune2fs -l /dev/sdb;
tune2fs 1.46.4 (18-Aug-2021)
tune2fs: Superblock checksum does not match superblock while trying to 
open /dev/sdb
Couldn't find valid filesystem superblock.

  - bin.

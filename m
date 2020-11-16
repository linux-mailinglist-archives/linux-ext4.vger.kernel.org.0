Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781672B4360
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Nov 2020 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgKPMK4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Nov 2020 07:10:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7248 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgKPMK4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Nov 2020 07:10:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZSZR24ghzkZDp;
        Mon, 16 Nov 2020 20:10:23 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Nov 2020
 20:10:37 +0800
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: [Bug report] Jbd2 is hung on kernel 5.10-rc3
CC:     <harshadshirwadkar@gmail.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
To:     <linux-ext4@vger.kernel.org>
Message-ID: <4d18326e-9ca2-d0cb-7cb8-cb56981280da@hisilicon.com>
Date:   Mon, 16 Nov 2020 20:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,
With kernel 5.10-rc3, there is a hung with follow steps:
- mount /dev/sda1 (ext4 filesystem) to directory /mnt;
- run "if=/dev/zero of=test1 bs=1M count=2000" on directory /mnt;
- run "sync"

Hung occurs when sync, at the same time we can see thread jbd2 becomes 
"D" state. It is very easy to reproduce, and the issue also
occurs on kernel 5.10-rc1/rc2 (but there is no issue on kernel 5.9-rc4). 
When this issue occur, there is sometimes a Call trace with the hung on 
kernel 5.10-rc1 as follows:

[  367.912761] INFO: task jbd2/sdb1-8:3602 blocked for more than 120 
seconds.
[  367.919618]       Not tainted 5.10.0-rc1-109488-g32ded76956b6 #948
[  367.925776] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  367.933579] task:jbd2/sdb1-8     state:D stack:    0 pid: 3602 
ppid:     2 flags:0x00000028
[  367.941901] Call trace:
[  367.944351] __switch_to+0xb8/0x168
[  367.947840] __schedule+0x30c/0x670
[  367.951326] schedule+0x70/0x108
[  367.954550] io_schedule+0x1c/0xe8
[  367.957948] bit_wait_io+0x18/0x68
[  367.961346] __wait_on_bit+0x78/0xf0
[  367.964919] out_of_line_wait_on_bit+0x8c/0xb0
[  367.969356] __wait_on_buffer+0x30/0x40
[  367.973188] jbd2_journal_commit_transaction+0x1370/0x1958
[  367.978661] kjournald2+0xcc/0x260
[  367.982061] kthread+0x150/0x158
[  367.985288] ret_from_fork+0x10/0x34
[  367.988860] INFO: task sync:3823 blocked for more than 120 seconds.
[  367.995102]       Not tainted 5.10.0-rc1-109488-g32ded76956b6 #948
[  368.001265] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  368.009067] task:sync            state:D stack:    0 pid: 3823 ppid:  
3450 flags:0x00000009
[  368.017397] Call trace:
[  368.019841] __switch_to+0xb8/0x168
[  368.023320] __schedule+0x30c/0x670
[  368.026804] schedule+0x70/0x108
[  368.030025] jbd2_log_wait_commit+0xbc/0x158
[  368.034290] ext4_sync_fs+0x188/0x1c8
[  368.037947] sync_fs_one_sb+0x30/0x40
[  368.041606] iterate_supers+0x9c/0x138
[  368.045350] ksys_sync+0x64/0xc0
[  368.048569] __arm64_sys_sync+0x10/0x20
[  368.052398] el0_svc_common.constprop.3+0x68/0x170
[  368.057177] do_el0_svc+0x24/0x90
[  368.060482] el0_sync_handler+0x118/0x168
[  368.064478]  el0_sync+0x158/0x180


Do you have any idea about the issue? Please let me know if you want 
more info or debug.

Best regard,
Shawn



Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20B146421
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 10:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAWJFR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 04:05:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:39816 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgAWJFR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 04:05:17 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuYQF-0006p9-JC; Thu, 23 Jan 2020 12:05:07 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/1] jbd2: seq_file .next functions should increase position
 index
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.com>
Message-ID: <da4e493a-c6e4-c406-452c-6c2771a25fc3@virtuozzo.com>
Date:   Thu, 23 Jan 2020 12:05:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In Aug 2018 NeilBrown noticed 
commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
"Some ->next functions do not increment *pos when they return NULL...
Note that such ->next functions are buggy and should be fixed. 
A simple demonstration is
   
dd if=/proc/swaps bs=1000 skip=1
    
Choose any block size larger than the size of /proc/swaps.  This will
always show the whole last line of /proc/swaps"

Described problem is still actual. If you make lseek into middle of last output line 
following read will output end of last line and whole last line once again.

$ dd if=/proc/swaps bs=1  # usual output
Filename				Type		Size	Used	Priority
/dev/dm-0                               partition	4194812	97536	-2
104+0 records in
104+0 records out
104 bytes copied

$ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
dd: /proc/swaps: cannot skip to specified offset
v/dm-0                               partition	4194812	97536	-2
/dev/dm-0                               partition	4194812	97536	-2 
3+1 records in
3+1 records out
131 bytes copied

There are lot of other affected files, I've found 30+ including
/proc/net/ip_tables_matches and /proc/sysvipc/*

Following patch fixes ext4-related file, script below generates endless output
 $ q=;while read -r r;do echo "$((++q)) $r";done </proc/fs/jbd2/DEV/info

https://bugzilla.kernel.org/show_bug.cgi?id=206283

Vasily Averin (1):
  jbd2_seq_info_next should increase position index

 fs/jbd2/journal.c | 1 +
 1 file changed, 1 insertion(+)

-- 
1.8.3.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB07449ACE
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Nov 2021 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhKHRiJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 12:38:09 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:63613 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhKHRiI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Nov 2021 12:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1636392924; x=1667928924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jDzzbzEVmLRFZ7pTarUrV0elr5JQR8X2uLSrHErjG34=;
  b=v8LfpYp38AA7y/vSM/Awzl7p4G/FD7PuZznv4L9UweuQ69p6kq9+iGDb
   abKo/SM52xq+gCZmqbVOdDzIv2dbcS7XxnL67hZxMmnGIUqKLisuPi7gs
   mZB+J5/QRzaMbufhqUL+Son/51rQt0TUJfN6D/jNwFIjcAdbHJPXZgkwZ
   g=;
X-IronPort-AV: E=Sophos;i="5.87,218,1631577600"; 
   d="scan'208";a="970181184"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-204be258.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 08 Nov 2021 17:35:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-204be258.us-east-1.amazon.com (Postfix) with ESMTPS id A675B41608;
        Mon,  8 Nov 2021 17:35:21 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.24; Mon, 8 Nov 2021 17:35:21 +0000
Received: from localhost (10.43.160.225) by EX13d01UWA002.ant.amazon.com
 (10.43.160.74) with Microsoft SMTP Server (TLS) id 15.0.1497.24; Mon, 8 Nov
 2021 17:35:20 +0000
Date:   Mon, 8 Nov 2021 09:35:20 -0800
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
CC:     <benh@amazon.com>
Subject: Debugging ext4 corruption with nojournal & extents
Message-ID: <20211108173520.xp6xphodfhcen2sy@u87e72aa3c6c25c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.43.160.225]
X-ClientProxiedBy: EX13D39UWB004.ant.amazon.com (10.43.161.148) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Recently I've been digging into a corruption issue which I think is just about
pinned, but I'd appreciate some more expert EXT4 eyes to confirm we're on the
right path.

What we have boils down to a system with
- An ext4 filesystem with the journal disabled
- A workload[0] which in a loop
  - Creates a lot of small files
  - Occasionally deletes these files and collects them into a single larger "compound" file
  - Checks the header of all of these files periodically to ensure they're correct

After a while this check fails, and when inspecting the "bad" file, the contents of that file are actually an EXT4 extent structure, for example:

[ec2-user@ip-172-31-0-206 ~]$ hexdump -C _2w.si
00000000  0a f3 05 00 54 01 00 00  00 00 00 00 00 00 00 00  |....T...........|
00000010  01 00 00 00 63 84 08 05  01 00 00 00 ff 01 00 00  |....c...........|
00000020  75 8a 1c 02 00 02 00 00  00 02 00 00 00 9c 1c 02  |u...............|
00000030  00 04 00 00 dc 00 00 00  00 ac 1c 02 dc 04 00 00  |................|
00000040  08 81 00 00 dc ac 1c 02  00 00 00 00 00 00 00 00  |................|
00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000170  00 00 00                                          |...|
00000173

This has EXT4_EXT_MAGIC (cpu_to_le16(0xf30a)), and when parsed as extent header
plus array has 5 extent entries at 0 depth.
By the time the file is checked, the file that these extents presumably pointed
to appears to have been deleted, but reading the physical blocks looks like the
data of one of the larger files this test creates.


Based on that what I think is happening is
- A file with separate (i.e. non-inline) extents is synced / written to disk
  (in this case, one of the large "compound" files)
- ext4_end_io_end() kicks off writeback of extent metadata
  - AIUI this marks the related buffers dirty but does not wait on them in the
    no-journal case
- The file is deleted, causing the extents to be "removed" and the blocks where
  they were stored are marked unused
- A new file is created (any file, separate extents not required)
- The new file is allocated the block that was just freed (the physical block
  where the old extents were located)

Some time between this point and when the file is next read, the dirty extent
buffer hits the disk instead of the intended data for the new file.
A big-hammer hack in __ext4_handle_dirty_metadata() to always sync metadata
blocks appears to avoid the issue but isn't ideal - most likely a better
solution would be to ensure any dirty metadata buffers are synced before the
inode is dropped.

Overall does this summary sound valid, or have I wandered into the weeds somewhere?

Cheers,
Sam Mendoza-Jonas

[0] This is an Elastisearch/Lucene workload, running the esrally tests to hit the issue.


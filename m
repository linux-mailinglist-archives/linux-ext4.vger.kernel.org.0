Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7BA451A
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Aug 2019 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfHaPoW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Aug 2019 11:44:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33258 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfHaPoW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Aug 2019 11:44:22 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so20425827iog.0;
        Sat, 31 Aug 2019 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ohorzUHq4fR5QI0aCkIZzsVnCzNXq2up1MIejCCdXtU=;
        b=j/A8tGkZTsw68BurXTRjuqgIpKVts9NowNu9EKC8iciTKJIWVhS/8BSG7aKEoGeBh1
         iZMdPJCz3Jza8JgpNOWraWq9nj5wdc/Ypa/+NW8MaLIfy/XHeuB8TnQZNh5GP6ABo0to
         uE0OzCAQzG/7cA7c0cVatB1uYHn1TzuyAgnIqS6RZ7PVfqWUxZVwkAZ6jvACUKFaitjq
         wRTYtTK61C5Vak9TAVqfUhkheLfAe+LORRIWRiOTZpRXAu8fo1HBMwxkf6Px5PZxdspC
         ujjnyKSjfbM3wB8qW7lhH+mQgCa8rxB9aUGjcp0KBczoR+1Wi9knwyj/eisybcfX20U6
         frtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ohorzUHq4fR5QI0aCkIZzsVnCzNXq2up1MIejCCdXtU=;
        b=tmhaQHds2Nhc/j7Kr8NIisCwAScO2NVCe/wkQ1NHCOHqEigNWk6Ntupq3EpM8DLNKW
         4EzDY7OofI94Vg8Q/VF8FImLTsWK3SQxSOVad7KVSaAgA4TWIVa0qzYCrGIF6VtpD776
         KjLXKmSuGfEBFc4KGpbvVgh4okJ2MRGR4UfFRCR0SiEvCBDfNPM/9UMlV1xccLibUZdf
         QYdbkmLBCijNbUqJc4eXhTeDGc8CP7NbGfPK2zCvyTQKVXioit5ICAgXHfcH00Rm0ALJ
         cftNYF1/YKpTCWpbuogZNlmH2Di2qY1UonPoRsurJIxlTJK9+tIxn8MOF43VoBX6SG/i
         rKow==
X-Gm-Message-State: APjAAAU4OEEqm7S+C08AB4GGE5DF3nVahE7J0yD9mpOA+AFZFcAXPyxc
        bqdNRgb9oYXOjdVuRK20R6lVP3gMiUdDSA==
X-Google-Smtp-Source: APXvYqwbeXBTBtNmAdK9zN53hqq3hsnCg5BDnQ+17n8ws6WrLkoSY62zoyno8xmjZWk+ZnwdfVwTxg==
X-Received: by 2002:a5d:9aca:: with SMTP id x10mr23722874ion.11.1567266260718;
        Sat, 31 Aug 2019 08:44:20 -0700 (PDT)
Received: from fa19-cs241-404 ([192.17.168.68])
        by smtp.gmail.com with ESMTPSA id i9sm8207846ioe.35.2019.08.31.08.44.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 Aug 2019 08:44:20 -0700 (PDT)
From:   Ayush Ranjan <ayush.ranjan98@gmail.com>
X-Google-Original-From: Ayush Ranjan <ayushr2@illinois.edu>
Date:   Sat, 31 Aug 2019 10:44:19 -0500
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Ext4 Docs: Add missing bigalloc documentation.
Message-ID: <20190831154419.GA30357@fa19-cs241-404.cs.illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There was a broken link for bigalloc. The page
https://ext4.wiki.kernel.org/index.php/Bigalloc was not migrated into
the current documentation sources. This patch adds the contents of that
missing page into the section for Bigalloc itself.

Signed-off-by: Ayush Ranjan <ayushr2@illinois.edu>
---
Please note that I have not included changes from the "Kernel Support"
and "E2fsprogs Support" sections of the original page because the
comments there seemed outdated.

 Documentation/filesystems/ext4/bigalloc.rst | 32 ++++++++++++++-------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/ext4/bigalloc.rst b/Documentation/filesystems/ext4/bigalloc.rst
index c6d885575..72075aa60 100644
--- a/Documentation/filesystems/ext4/bigalloc.rst
+++ b/Documentation/filesystems/ext4/bigalloc.rst
@@ -9,14 +9,26 @@ ext4 code is not prepared to handle the case where the block size
 exceeds the page size. However, for a filesystem of mostly huge files,
 it is desirable to be able to allocate disk blocks in units of multiple
 blocks to reduce both fragmentation and metadata overhead. The
-`bigalloc <Bigalloc>`__ feature provides exactly this ability. The
-administrator can set a block cluster size at mkfs time (which is stored
-in the s\_log\_cluster\_size field in the superblock); from then on, the
-block bitmaps track clusters, not individual blocks. This means that
-block groups can be several gigabytes in size (instead of just 128MiB);
-however, the minimum allocation unit becomes a cluster, not a block,
-even for directories. TaoBao had a patchset to extend the “use units of
-clusters instead of blocks” to the extent tree, though it is not clear
-where those patches went-- they eventually morphed into “extent tree v2”
-but that code has not landed as of May 2015.
+bigalloc feature provides exactly this ability.
+
+The bigalloc feature (EXT4_FEATURE_RO_COMPAT_BIGALLOC) changes ext4 to
+use clustered allocation, so that each bit in the ext4 block allocation
+bitmap addresses a power of two number of blocks. For example, if the
+file system is mainly going to be storing large files in the 4-32
+megabyte range, it might make sense to set a cluster size of 1 megabyte.
+This means that each bit in the block allocation bitmap now addresses
+256 4k blocks. This shrinks the total size of the block allocation
+bitmaps for a 2T file system from 64 megabytes to 256 kilobytes. It also
+means that a block group addresses 32 gigabytes instead of 128 megabytes,
+also shrinking the amount of file system overhead for metadata.
+
+The administrator can set a block cluster size at mkfs time (which is
+stored in the s\_log\_cluster\_size field in the superblock); from then
+on, the block bitmaps track clusters, not individual blocks. This means
+that block groups can be several gigabytes in size (instead of just
+128MiB); however, the minimum allocation unit becomes a cluster, not a
+block, even for directories. TaoBao had a patchset to extend the “use
+units of clusters instead of blocks” to the extent tree, though it is
+not clear where those patches went-- they eventually morphed into
+“extent tree v2” but that code has not landed as of May 2015.
 
-- 
2.23.0


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5009F79BB37
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 02:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbjIKVVD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbjIKSjN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 14:39:13 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81491AB
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 11:39:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 310EB81FDA
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 18:39:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C82ED81F25
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 18:39:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694457547; a=rsa-sha256;
        cv=none;
        b=L17qfVnso+ZR5miGFIaWWPHsVl/Tjem9f97RG0vw3MucCk9KRLBfvG6eVRn4+XW4BGPUyA
        qVou5gMPR0O97Pp+RuaweI8Y1XMUU1Ub7FmT1X/O0UTKitddg4++MlCILByaMo9exKlfC5
        CpuQ7tJKbH0KLZsdeeYDJO6M08BQ6ZhuYtSCMxRcIeje+mG6NYDqCZWGvuqvt9GuBMoTO3
        WIWWJ4jkROLbvz7pI46yEkOTMnIqdW6XzSGgLBg4nz3ZvnOixpnTkMyRIdpBVkbGetTr9n
        Bpg0OwJM3WK5ihlgtDqSXDiHjLdSwUKMmt6XfBDezWDK9e6fIb5Qn9KAPxqORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694457547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=KqErp+7yH/TJ++tZeIgWcbbjc25MuwuQoW00c8yltXs=;
        b=Q4PuS9Cqp6lbQ+Mflx0s5OS0XLpT1XECnsMRMuaDwPn2J2KoN6pE1usOdwT/eQ6bLrcVdl
        GoTujuga76fdhrFHTjuD0tX0wlyatwrofCirhIkOtXmAg7D3tLc2PIdx9K8eWSnl1WbQly
        B9VPrvIJIkM3rehIKgB008OQVWybjWi+Tzt9gF0+CvvhOd7tU4qcOHyHqI2E+CjXakb722
        1jAWY9uHFRvZXQNlRapmxrjj5qHy5MX7+heP9AnFZbAWE/KAjwEdnxQt4Ubuxkk+YecrPT
        GjhD2XNAq2ZvxnFfCztwBCeiNEiQXdgpDfJX0hwTMvnIEwL9FKT2QXdVraGnSA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-drktx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Tank: 3dc5b0cd46b5aaf3_1694457548026_2545463914
X-MC-Loop-Signature: 1694457548026:2878511528
X-MC-Ingress-Time: 1694457548026
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.198.214 (trex/6.9.1);
        Mon, 11 Sep 2023 18:39:08 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4RkwV33sdlzHF
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694457547;
        bh=KqErp+7yH/TJ++tZeIgWcbbjc25MuwuQoW00c8yltXs=;
        h=Date:From:To:Subject:Content-Type;
        b=oo0y7D15y2tPfVrVqXGfc4YvsMpq+RTAYfvakWsxbiaYjpE9nVf0QUgAwWOzLaPbJ
         C7cLmN5t6j4ni9A6RQDrQ9dflySBbh9KqkcONwPq6vcGLcvaua7lCm3rvVBjRe5SYq
         ZCSD7CSOThP3Ko+fEI2Ywkqbb5k3uiXukH0LSe26olE/ul0IKWXaJjwpps0AnQXgjk
         XX0WUOtuSrzrZXqpmHhu8miG5+mezdm1A2RufESekE/Nm+BhRC6odTuWmbTHaFRcTK
         k7hhhLAEBryAvCiIOl4vL9KV1l9ZDFMR2PWjBYSAkmXZXFTACzCIW6j5adzUgHd/DV
         WGzgWBoPuB0gg==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00c8
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 11 Sep 2023 11:39:05 -0700
Date:   Mon, 11 Sep 2023 11:39:05 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH v2] resize2fs: use directio when reading superblock
Message-ID: <20230911183905.GA1960@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Invocations of resize2fs intermittently report failure due to superblock
checksum mismatches in this author's environment.  This might happen a few
times a week.  The following script can make this happen within minutes.
(It assumes /dev/nvme1n1 is available and not in use by anything else).

   #!/usr/bin/bash
   set -euxo pipefail
   
   while true
   do
           parted /dev/nvme1n1 mklabel gpt mkpart primary 2048s 2099200s
           sleep .5
           mkfs.ext4 /dev/nvme1n1p1
           mount -t ext4 /dev/nvme1n1p1 /mnt
           stress-ng --temp-path /mnt -D 4 &
           STRESS_PID=$!
           sleep 1
           growpart /dev/nvme1n1 1
           resize2fs /dev/nvme1n1p1
           kill $STRESS_PID
           wait $STRESS_PID
           umount /mnt
           wipefs -a /dev/nvme1n1p1
           wipefs -a /dev/nvme1n1
   done

After trying a few possible solutions, adding an O_DIRECT read to the open
path in resize2fs eliminated the occurrences on test systems. ext2fs_open2
uses a negative count value when calling io_channel_read_blk to get the
superblock.  According to unix_read_block, negative offsets are to be read
direct.  However, when strace-ing a program without this fix, the
underlying device was opened without O_DIRECT.  Adding the flags in the
patch ensures the device is opend with O_DIRECT and that the superblock
read appears consistent.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
v2:
  - Only set DIRECT_IO flag when resizing a mounted filesystem. (Feedback from
    Theodore Ts'o)
---
 resize/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/resize/main.c b/resize/main.c
index 94f5ec6d..f914c050 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -409,6 +409,8 @@ int main (int argc, char ** argv)
 
 	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
 		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
+	if (mount_flags & EXT2_MF_MOUNTED)
+		io_flags |= EXT2_FLAG_DIRECT_IO;
 
 	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
 	if (undo_file) {
-- 
2.25.1

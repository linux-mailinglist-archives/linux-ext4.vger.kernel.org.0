Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108B772338F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 01:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjFEXLJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjFEXLI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 19:11:08 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 16:11:05 PDT
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69CBD2
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 16:11:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6F0063E1912
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 22:52:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 04AA13E191E
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 22:52:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686005543; a=rsa-sha256;
        cv=none;
        b=DRk+oxqJ0kXLE/R8+JupQvS/YOcGOc49KG8PgQV4MVD7pBCmVTl/SYunvLQnKvteX9xRek
        I52srKrtu8qvIWY0cfMQRmdGeX2Eh2BCG+5pHwRvPQ/ewyPEaDv16AgIRwtkI3LynFY1WX
        9kb7W+fS13PUNYAtVbvVclWmfPDmS06GswhwqjeF7HruioU3YhFedeCH5DAX6inyJOj7Js
        ffuW1UzyZQVJcVdnZAYdspAu0/LTQMTNdCNRnHRttHLdGffqBcFSaOQuIa0gLZ+jOOI2wL
        Yb4jqc6DOmR5Ijgg0VBtUNluHw/6DXtkWWluorqcomvBu/Mn9wwEdzVr1wTxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686005543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=qCaaQL9zkZwlRN/OdJMSGj1R5nuYpmOQzTYu1ZqcMi8=;
        b=WFGQw1NgIwasH7y4S4ZlRozV0BIFdvx/r9PTb+bow9FrlLSlrdeEDNKhOSoMAVb/KP/b/W
        D4bHjHvdnhv4F5hFXKBBSuzUTxMbEvR9PKEw8W+aFZ/J4g2zTfQxYYG59uuM75JTzYPrMB
        UgsU2cPoKMxokY2JL9zzVih0SDgR1/uB1lgTUl2AXtNC3zE07qxASArJowNV/PzO04++1D
        yq2qsZSVVLrhVGvWXvtJtqKpPm+Mi/rrekLYwyUBYZWFH1Ar23fjYMJdnjxVrp4XQCTvRF
        eMk0Xu0VKQooldljAsmAnjsGaZr/P4cMY6gm+BwrEdanG+lYzB0V/tWGoZvGYQ==
ARC-Authentication-Results: i=1;
        rspamd-5f966895c-qqbg2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Dime: 1346dcf02aba688d_1686005543231_421817254
X-MC-Loop-Signature: 1686005543231:2940660432
X-MC-Ingress-Time: 1686005543231
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.241 (trex/6.8.1);
        Mon, 05 Jun 2023 22:52:23 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4QZplV5ndlzZR
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686005542;
        bh=qCaaQL9zkZwlRN/OdJMSGj1R5nuYpmOQzTYu1ZqcMi8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bkQmSLHv0r6PRo5xMi/wqgKwDe06QMq+AOz/66glzLMDShrvz/D4aZT32B/9uncQR
         UyhvNnMdyCC8Irkxxs1MJglotuwmoHouZTwVFhV09k10J0S0HpdWR+J58RNUkUimQk
         vNwtlxcLr73DJIaWsjtRvp11mjAa7akupTxRsx+w=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0062
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 05 Jun 2023 15:52:21 -0700
Date:   Mon, 5 Jun 2023 15:52:21 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>
Subject: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230605225221.GA5737@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
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
 resize/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/resize/main.c b/resize/main.c
index 94f5ec6d..b98af384 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -410,7 +410,7 @@ int main (int argc, char ** argv)
 	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
 		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
 
-	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
+	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_DIRECT_IO;
 	if (undo_file) {
 		retval = resize2fs_setup_tdb(device_name, undo_file, &io_ptr);
 		if (retval)
-- 
2.25.1


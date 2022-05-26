Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACF5347D8
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 03:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiEZBIp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 21:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbiEZBIn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 21:08:43 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA529156B
        for <linux-ext4@vger.kernel.org>; Wed, 25 May 2022 18:08:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BEF5F5C0228;
        Wed, 25 May 2022 21:08:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 May 2022 21:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653527316; x=1653613716; bh=SqF5QSpaBVtVEfvF5JkY9Egr38hO4j1Qhbc
        EDmIbtfc=; b=eazS9SgkfkkmS0BEbpJ5OnZeKjfZqgmqYypCV6J0jz1Qwq6yV8a
        +pKIVoN8pb9ahR7XlyEcKmOJ1WA5pBLK9M2n3A7LPTKRMt3ZCBcBrZSOF5Azff2q
        uhRG66EPE2uflZB8IxWo4Hxcs7JW+JnJx8yDn+Ktgqx1suM7bPNOYV4bUkAGIZeK
        Lm1Zcl/bnmNImb59mFO+S4oTlda4xZ2bh8ISDzzcLfhDHZuyrYWqi9hoE6dZbWEX
        b/uomvo1XSeblWRWwJ1Ae2fDgqs21TDmutYpRuYKmQgsrYrswkzRcnaSluAalm0t
        WbzvrZsRGVuE8jx88qI4MB8xLVqQL7iz54Q==
X-ME-Sender: <xms:FNOOYs852_BQ0N4X0Aw-lPvZM0AEOxbVh_xKrO9VJKLTAwOSvr74Og>
    <xme:FNOOYkuzEZhEh0dnDhPsFjKv30ueafdefiQZV3zUJVtSw-X_bRncD1e4CylA9d1Vx
    A40nnAnhPyXOX8i0g>
X-ME-Received: <xmr:FNOOYiARI_Fwg3PEv3SBpt00hNMTNkrlRHSX606kUvdfG7t5cY3G-7MJ7xlPnaDKxsMuQ9H26cn_vaF32Hfmj3TMyXLf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepofhitghhrggvlhcujfhuughsohhnqdffohihlhgvuceomhhitghh
    rggvlhdrhhhuughsohhnsehusghunhhtuhdrtghomheqnecuggftrfgrthhtvghrnhepve
    egtdeugfduvdegffegvefgtdduheehkeduuddtgeeigffggeelgeejheethefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhifhhhuughsoh
    hnsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:FNOOYsd2tPuXuRFYrKtBaLFRkUP5zs52rsbPgycu0e7IfqYRwcAkOA>
    <xmx:FNOOYhMhRZy8R8E9akiEOq_EXgH0wQuy-rgigfJGnIPuo4ioiJ-I9Q>
    <xmx:FNOOYmnDkB1EDFnFJQH7BnH9z6feYsT59ILQHwwvaZh4AA7coi7M1g>
    <xmx:FNOOYjUyFV-aaveQMgblqGCh78WRJ2RfhcpGZ6L7gSdF1wrzQBNymA>
Feedback-ID: i58b94259:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 21:08:35 -0400 (EDT)
From:   Michael Hudson-Doyle <michael.hudson@ubuntu.com>
To:     linux-ext4@vger.kernel.org
Cc:     Michael Hudson-Doyle <michael.hudson@ubuntu.com>
Subject: [PATCH] resize2fs: open device read-only when -P is passed
Date:   Thu, 26 May 2022 13:08:28 +1200
Message-Id: <20220526010828.1462397-1-michael.hudson@ubuntu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We ran into this because we noticed that resize2fs -P $device was
triggering udev events.

I added a very simple test that just checks resize2fs -P on a file
lacking the w bit succeeds.

Signed-off-by: Michael Hudson-Doyle <michael.hudson@ubuntu.com>
---
 resize/main.c             | 8 ++++++--
 tests/scripts/resize_test | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/resize/main.c b/resize/main.c
index bceaa1677..073c0bc7c 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -256,6 +256,7 @@ int main (int argc, char ** argv)
 	int		force_min_size = 0;
 	int		print_min_size = 0;
 	int		fd, ret;
+	int		open_flags = O_RDWR;
 	blk64_t		new_size = 0;
 	blk64_t		max_size = 0;
 	blk64_t		min_size = 0;
@@ -363,7 +364,10 @@ int main (int argc, char ** argv)
 		len = 2 * len;
 	}
 
-	fd = ext2fs_open_file(device_name, O_RDWR, 0);
+	if (print_min_size)
+		open_flags = O_RDONLY;
+
+	fd = ext2fs_open_file(device_name, open_flags, 0);
 	if (fd < 0) {
 		com_err("open", errno, _("while opening %s"),
 			device_name);
@@ -401,7 +405,7 @@ int main (int argc, char ** argv)
 #endif
 		io_ptr = unix_io_manager;
 
-	if (!(mount_flags & EXT2_MF_MOUNTED))
+	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
 		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
 
 	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
diff --git a/tests/scripts/resize_test b/tests/scripts/resize_test
index fc9d1c246..a000c85e5 100755
--- a/tests/scripts/resize_test
+++ b/tests/scripts/resize_test
@@ -60,6 +60,14 @@ rm -f $OUT_TMP
 echo $FSCK -fy $TMPFILE >> $LOG 2>&1 
 $FSCK -fy $TMPFILE >> $LOG 2>&1 
 
+chmod u-w $TMPFILE
+echo $RESIZE2FS -P $TMPFILE >> $LOG 2>&1
+if ! $RESIZE2FS -P $TMPFILE >> $LOG 2>&1
+then
+	return 1
+fi
+chmod u+w $TMPFILE
+
 echo $RESIZE2FS $RESIZE2FS_OPTS -d $DBG_FLAGS $TMPFILE $SIZE_2 >> $LOG 2>&1
 if ! $RESIZE2FS $RESIZE2FS_OPTS -d $DBG_FLAGS $TMPFILE $SIZE_2 >> $LOG 2>&1
 then
-- 
2.34.1


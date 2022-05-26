Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D996534781
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 02:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiEZAdm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 20:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiEZAdl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 20:33:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D4A5ABD
        for <linux-ext4@vger.kernel.org>; Wed, 25 May 2022 17:33:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0530F5C018A;
        Wed, 25 May 2022 20:33:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 May 2022 20:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653525216; x=1653611616; bh=x/Bhfo8l1ZcvM71ntfMlGkPmH2TUWAOUrZJ
        5/CWsyZ0=; b=B8i59q+4f9dPIhdhnQvgBh8YT/KgXi0Fg6zAFqflgyDyZ+2a3fK
        CuirLh1IUk+67yXQXDXuCKMrX2i7Qddp/7sp9iiGthVIB70qQIRTe5HfI2j0VE/z
        GVrZBIoIvzElqOtb2lbvgSgVsUo1PYAHjRh2AM1muPOkK7ecOwwUDl+NQfiCUias
        Xs/IlW/pxICdi769IAWIWegL4hXsWRrVmjYvWe1jgMTO3Lt0GQUxRuDRA63u8QGN
        0+gK+4W4ZNpYv4pTG78tX7Py0kjqZUa6fwBWumiYjm13tMubLUAwJiq1Qv3QQkr5
        /4OaeFMKKLxAwrld7CC9pAp6TFOYAIUbC6w==
X-ME-Sender: <xms:38qOYsVpW4EBGTJOf3ry7Fk7sFWlnpoZgQDF4agL_syXXjbwD3hVxg>
    <xme:38qOYgkjhdSkglqHw2Ej3GLc4-q6AgmntIp4Tf8SqtIlfFdND59x_rHDAh2D6jq2a
    ecsw96A9Yb6KJOlaw>
X-ME-Received: <xmr:38qOYgZZ1isq06WHmxF7KnjzS3q1C4K4J4bFxU47N9qsIR0rmFI1LuAXXkpHIPj2jM9ydAzOExWeyxo6aMQ0GOGTfXkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepofhitghhrggvlhcujfhuughsohhnqdffohihlhgvuceomhhitghh
    rggvlhdrhhhuughsohhnsegtrghnohhnihgtrghlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeggeeutdeiuefggeduveefieeifedthffhgeekleekvdfhiefhveejjeehhffgkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmfihhuh
    gushhonhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:38qOYrW3qsgXULsC857zCTYvg4WA0s1duYqyrhVkE1NtLve-sjyOgQ>
    <xmx:38qOYmma3F5qx7eMfEYMFEj0A2EyGneFUURQOBg_5bYggwSZXoQUfA>
    <xmx:38qOYgexWn4OcfrYE49AUkDGAGA_gFP2gIIVqxbKOyxe_dsR0MbtAQ>
    <xmx:4MqOYttQF4h0GjSTRC1SwEf0uYh0lakJEuEIO-lTHAygnbnEArIYbQ>
Feedback-ID: i833146b3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 20:33:35 -0400 (EDT)
From:   Michael Hudson-Doyle <michael.hudson@canonical.com>
To:     linux-ext4@vger.kernel.org
Cc:     Michael Hudson-Doyle <michael.hudson@canonical.com>
Subject: [PATCH] resize2fs: open device read-only when -P is passed
Date:   Thu, 26 May 2022 12:33:18 +1200
Message-Id: <20220526003318.1450760-1-michael.hudson@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We ran into this because we noticed that resize2fs -P $device was
triggering udev events.

I added a very simple test that just checks resize2fs -P on a file
lacking the w bit succeeds.

Signed-off-by: Michael Hudson-Doyle <michael.hudson@canonical.com>
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


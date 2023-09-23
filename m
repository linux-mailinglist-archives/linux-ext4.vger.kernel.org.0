Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD87AC199
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Sep 2023 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjIWMAq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Sep 2023 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjIWMAp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Sep 2023 08:00:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82A136;
        Sat, 23 Sep 2023 05:00:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1973647a12.3;
        Sat, 23 Sep 2023 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695470438; x=1696075238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7+cBpujNUS3XYFWbitFbs4F9jMbA+6Zty15gUpWh5E=;
        b=bkQ7f5uFZvI21bm45J36jhjNiinCYA3UxXWjiimOoIfqmCCBoR1PY743Av1ydMAkww
         poV7fH+4b7S4BUkwcFrh8X+FA/jPPCfzOkRoHZsFE88m2WE5XMbchtvSWmsZ/E0GW8gZ
         oK9GjaGpuDdlpdcGe4D3zPNACbJKsCF6ThsRTzHgWBiaStrgVDwu8figcJ5BK+Fwyaw8
         Ws7DzePpzYHJleJjIpeDKFXeR1UV6HyuuWIV/mk84sfAx3BgIvOFSKVMn8UljVcbWGkX
         TaKDgGt4JTzmLZa8IHgX1Iv7IJrVxdYnKrm3Y3F9ZIw5d02CkC9goL+6D8rd/i5gCECt
         BcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470438; x=1696075238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7+cBpujNUS3XYFWbitFbs4F9jMbA+6Zty15gUpWh5E=;
        b=GtKns5dh69inNM43VGJEtAFTBYXcAQ0kewkTq95IqDSk+Oh6b0gDatr4DwjKqs/tMG
         fSTag3QKxjYSY58l1Prh3Yo4NqMvlqSowdiujoGlixI7redINmwgAMiYDdV0W8ZNwDcI
         1fDNwIuO0y5kFk+a1xnVWc+FVVkl/YerT49PdHeehfALaQrVy6zKTEFZd+E2rGkRBh9m
         8AvEKDfAePF2IwQGLxZvZHFYgMQZnmvV10HfeSxQm04V5p0jIkaIslWkjc8au+pIV1sF
         ceMCZ/W/WZtY3SpUI37GQd9txDf/zDD11CbXbjxT2hggNwcsxFQBBUQ1VWXE/xoJWqZu
         3HgA==
X-Gm-Message-State: AOJu0YzK/ST4+fmJtUFecGjLBY/uTkov+TzlDti/IOr44iQ0d5R8h8c2
        v2cJ5CFmCJtdTDJL/TO7We2+2Dt5TUc=
X-Google-Smtp-Source: AGHT+IF/OJL5fYvto9s8bnEyaPTUC5xJB7WdWCwS9DLXhaIAwv9W9ptLhBBlBKIzYWsy7qgLuW0JNA==
X-Received: by 2002:a05:6a20:101a:b0:14b:3681:567e with SMTP id gs26-20020a056a20101a00b0014b3681567emr1502920pzc.29.1695470438278;
        Sat, 23 Sep 2023 05:00:38 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001bba669a7eesm5194981plb.52.2023.09.23.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 05:00:37 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 1/2] aio-dio-write-verify: Add sync and noverify option
Date:   Sat, 23 Sep 2023 17:30:23 +0530
Message-ID: <3b86ab1f1447f0b6db88d4dfafe304fd04ae2b11.1695469920.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87y1gy5s9c.fsf@doe.com>
References: <87y1gy5s9c.fsf@doe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds -S for O_SYNC and -N for noverify option to
aio-dio-write-verify test. We will use this for integrity
verification test for aio-dio.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 src/aio-dio-regress/aio-dio-write-verify.c | 29 ++++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
index 302b8fe4..61519f6e 100644
--- a/src/aio-dio-regress/aio-dio-write-verify.c
+++ b/src/aio-dio-regress/aio-dio-write-verify.c
@@ -34,13 +34,16 @@

 void usage(char *progname)
 {
-	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  filename\n"
+	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  [-S] [-N] filename\n"
 	        "\t-t truncsize: truncate the file to a special size before AIO wirte\n"
 	        "\t-a: specify once AIO write size and startoff, this option can be specified many times, but less than 128\n"
 	        "\t\tsize=N: AIO write size\n"
 	        "\t\toff=M:  AIO write startoff\n"
-	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n",
-	        progname, progname);
+			"\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
+			"\t-N: no_verify: means no write verification. By default noverify is false\n"
+	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
+	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
+	        progname, progname, progname);
 	exit(1);
 }

@@ -281,8 +284,10 @@ int main(int argc, char *argv[])
 	char *filename = NULL;
 	int num_events = 0;
 	off_t tsize = 0;
+	int o_sync = 0;
+	int no_verify = 0;

-	while ((c = getopt(argc, argv, "a:t:")) != -1) {
+	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
 		char *endp;

 		switch (c) {
@@ -297,6 +302,12 @@ int main(int argc, char *argv[])
 		case 't':
 			tsize = strtoul(optarg, &endp, 0);
 			break;
+		case 'S':
+			o_sync = O_SYNC;
+			break;
+		case 'N':
+			no_verify = 1;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -313,7 +324,7 @@ int main(int argc, char *argv[])
 	else
 		usage(argv[0]);

-	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR, 0600);
+	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR | o_sync, 0600);
 	if (fd == -1) {
 		perror("open");
 		return 1;
@@ -331,9 +342,11 @@ int main(int argc, char *argv[])
 		return 1;
 	}

-	if (io_verify(fd) != 0) {
-		fprintf(stderr, "Data verification fails\n");
-		return 1;
+	if (no_verify == 0) {
+		if (io_verify(fd) != 0) {
+			fprintf(stderr, "Data verification fails\n");
+			return 1;
+		}
 	}

 	close(fd);
--
2.41.0


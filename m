Return-Path: <linux-ext4+bounces-38-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C451A7F11CB
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 12:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9911F23C72
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59E1429A;
	Mon, 20 Nov 2023 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9IqkQb2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32319AD;
	Mon, 20 Nov 2023 03:19:43 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso4387839b3a.2;
        Mon, 20 Nov 2023 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700479182; x=1701083982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMufP4ayA3BAkJDGecSSzOF4cEhWy6XzcnwpQLTl9Sw=;
        b=T9IqkQb2kFE6Jcteup1kGmMe6VcmTbB9a24KCALPKlofSq5HaXZNPPcYOkzxfDRCwv
         WO3JwqeAwAUmTj1+CdCEjT9ZZXDyRLU6zPAaoFE7wxRqPszABdDjlaGn6tsCKSqbzVvv
         iPAtBttn4DtHhwaNiKP8MIzUp8PTfDVLKN/3NAx6JzN956nXkuUtE73QNecXfD2ksnqZ
         dc7g6PiHQn7jZxu+P9o28a1thIHgl3nIOGTkEmYQS4ghGVo6wO+mc2aGkN6It1iastpH
         7d48EwjIgCQo+WDHt2UDe+5ze5NGfeMD5NT+59G06Lgyh8oEnt0dGkU5orPQCCmN1F3M
         gIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479182; x=1701083982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMufP4ayA3BAkJDGecSSzOF4cEhWy6XzcnwpQLTl9Sw=;
        b=Hc0xuaD7NSo8sVRBsaKlGvuiYKjITuUrzmerNjawGLh9rVjwrTe7XbKJ/ln4g0+pPh
         JEQyU9alqgfiXI4+FiYLThh37rbzV4PJNUW/dRi1qJ8YqcV7rpGCsnuyMAo4wJAkM59p
         9MKmSTOThoXIPanBY9FrjvUbfS6W/ANH0IqHJKbj5a0LS14Y9kqZr5g+7VjJtQAGZNWR
         W6VberO1iZ8podZTrxyNK3fP8zaP0M3nhOMMqF7jVSDpV2Cv4mL0j+VPi9Png7ddjSVL
         qnhrAxwPO7NDPeytwLONbSY6ig82ylvs+mPDuRuPFbYQLlLBvz3RS3QhVSJPyHrWGD84
         zoEg==
X-Gm-Message-State: AOJu0Yw9DXMDibB9dgIDd/D/Mt2xOXYl9Nan/PIDlUfDZ/ZyZNluOLgi
	ucq7a0zhqcuTLpmPYycyDY6Yo93YIJg=
X-Google-Smtp-Source: AGHT+IEV+j3IUU4TzRMFm8kGa3AamcLUbuO44RhMRE9gMMxPHUvwVPsOk9JKdpWLY7AbudQE5VJnqw==
X-Received: by 2002:a05:6a00:1c94:b0:6c3:5f49:6da7 with SMTP id y20-20020a056a001c9400b006c35f496da7mr8219474pfw.2.1700479181866;
        Mon, 20 Nov 2023 03:19:41 -0800 (PST)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id k10-20020aa788ca000000b006cb6ba5fe72sm3056158pff.122.2023.11.20.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:19:41 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 1/2] aio-dio-write-verify: Add sync and noverify option
Date: Mon, 20 Nov 2023 16:49:33 +0530
Message-ID: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds -S for O_SYNC and -N for noverify option to
aio-dio-write-verify test. We will use this for integrity
verification test for aio-dio.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 src/aio-dio-regress/aio-dio-write-verify.c | 29 ++++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
index dabbfacd..a7ca8307 100644
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
 
@@ -292,8 +295,10 @@ int main(int argc, char *argv[])
 	char *filename = NULL;
 	int num_events = 0;
 	off_t tsize = 0;
+	int o_sync = 0;
+	int no_verify = 0;
 
-	while ((c = getopt(argc, argv, "a:t:")) != -1) {
+	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
 		char *endp;
 
 		switch (c) {
@@ -308,6 +313,12 @@ int main(int argc, char *argv[])
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
@@ -324,7 +335,7 @@ int main(int argc, char *argv[])
 	else
 		usage(argv[0]);
 
-	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR, 0600);
+	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR | o_sync, 0600);
 	if (fd == -1) {
 		perror("open");
 		return 1;
@@ -342,9 +353,11 @@ int main(int argc, char *argv[])
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



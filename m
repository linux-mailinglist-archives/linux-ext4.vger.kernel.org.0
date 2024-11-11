Return-Path: <linux-ext4+bounces-5016-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB39C41C3
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000E5B2305D
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDE12DD88;
	Mon, 11 Nov 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tSKeK+FZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D51BC58
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338493; cv=none; b=or4CukdD/pQ0i4R5yt8Q43xUD7nWMNNY+RV4XiEgg5a/q6wG4Ij1e+tMwnekSr83EDXi4ixYqKmnq0p8a2QNrFvGEHszp/ezCf6joDp2Zz3++Cq/czJdMrTRiVnzl7cg4Tjh3DtR9t/thOaeBSxTyZF7f8sYuagJowxJTMnKZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338493; c=relaxed/simple;
	bh=IIBE5r7JHTxOV7+82WCt+7FC5WUNqQra//neAiJO398=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRwFHv0PTwPdx+bkhnTPfBKUe5CuIS2mbf9rRJ6eYgOpt9FbVjjx2EADeOkXTVxBRRMzDGB4Xrz0FhP2Wx2Siz9Et/g5gB2bC4LNVdsgg0HTVIt74moqQXY3/EIGrdaQod3WjOj1GTnyVbKrVBy3h1HEBShq+Gh35xtbXFxunCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tSKeK+FZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 80A183F215
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731338481;
	bh=UxsVF8hSpJ29Z9qLUkQUCmyF9bhH0xObTONhJfT8CBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=tSKeK+FZdCdF3F/O77H7mni9n4gzNQh6BlJSTfdXVwAgyP8dfJKXXS6F5g8+QUquX
	 96hSzqglaPludZEG2rl7ugDKhZxoGsVAlXW85POAVYe0WLtJscH7y2IDwUpQz3FV/x
	 sGyncOxnBfpm3GFlDvV6uofjlAriJUgAwyG3MdmYQetA1wTAZpYayS+/J+4uN84jRt
	 35e3uImKB3DVsqtrkAZi4Go4MEs/HJ58QhothRLiqoPM0hZsD8CPlLXhe1buDgKrhN
	 XHjO8Yg/Mrs0zLu4sC3BrFcCgK9laoOA263KK8lSbnxeTurLgSV17w8XBCv8iQVS50
	 MvBnlKbF35RXA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a22a62e80so357126366b.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 07:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338481; x=1731943281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxsVF8hSpJ29Z9qLUkQUCmyF9bhH0xObTONhJfT8CBw=;
        b=FIwgY2cXGlRzA+fYl9wxcfp7W7/DKCP9IUbrK6cat/EKpT6TFucR4IfdA0ssme5Gu2
         Q9zSRPnPFye54SAQ97Cfsl6QUj+z5E1zP1s+SQKrV3CGCmJ5pN4zq34b24uIIylNcJIc
         4RcaoYQHGrdn+LCdl2n7IBJaPUJ9WNytqBuyO315OpqCxTPe9iilr7L1ttMUuIeoudnC
         VAnrwy4IPxKb/zOPNa3nGPe2kSCyNT+Pf1RJQHiwmjf0+VB/SCK5UOvrUoaaAuknZrPE
         3qDd6tjTmxWxSU0YxkqIMITlPj70BcdQuZlTfRCa0mONXTdqqXRf4lRwmKFJSy6JVOA4
         G+/A==
X-Gm-Message-State: AOJu0Yy/mYAf1P93FR+bKcBRa4INxR9Eeo7XneLwtYzYru/eG7VYKl2u
	sQ8Gq9HCj2XABTzAGPiA/YHuFYaV0WRBpZ1LaG470BzE8QnSl7+/RknibKkSxnCWpRlW7KuBdG3
	YquUSUMTg4y+3228PdII6aQnyync134sOO3Wk8QouJhluFha9f/8H7Qh4XseMynSL83yC7+aR19
	I=
X-Received: by 2002:a17:907:9483:b0:a99:fe71:bd76 with SMTP id a640c23a62f3a-a9eeff44678mr1452424266b.34.1731338481006;
        Mon, 11 Nov 2024 07:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQQuKSVIyFlgrG9ZavwCUBdqj175JxVD/+sPLv0IoGvA4iD0GIZwCfNeviMBaHTbVNFQpWHA==
X-Received: by 2002:a17:907:9483:b0:a99:fe71:bd76 with SMTP id a640c23a62f3a-a9eeff44678mr1452421366b.34.1731338480675;
        Mon, 11 Nov 2024 07:21:20 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dedc3dsm600736566b.133.2024.11.11.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:21:20 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	libaokun1@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	zlang@redhat.com,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v2] ext4/032: add a new testcase in online resize tests
Date: Mon, 11 Nov 2024 16:21:00 +0100
Message-ID: <20241111152100.152924-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new testcase for [1] commit in ext4 online resize testsuite.

Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tests/ext4/032     |  6 ++++++
 tests/ext4/032.out | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 6bc3b61b..238ab178 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -10,6 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick ioctl resize
 
+_fixed_by_kernel_commit 6121258c2b33 \
+	"ext4: fix off by one issue in alloc_flex_gd()"
+
 BLK_SIZ=4096
 CLUSTER_SIZ=4096
 
@@ -136,6 +139,9 @@ for CLUSTER_SIZ in 4096 16384 65536; do
 
 	## Extending a 2/3rd block group to 1280 block groups.
 	ext4_online_resize $(c2b 24576) $(c2b 41943040)
+
+	# tests for "ext4: fix off by one issue in alloc_flex_gd()"
+	ext4_online_resize $(c2b 6400) $(c2b 786432)
 done
 
 status=0
diff --git a/tests/ext4/032.out b/tests/ext4/032.out
index b372b014..d5d75c9e 100644
--- a/tests/ext4/032.out
+++ b/tests/ext4/032.out
@@ -60,6 +60,12 @@ QA output created by 032
 +++ resize fs to 41943040
 +++ umount fs
 +++ check fs
++++ truncate image file to 786432
++++ create fs on image file 6400
++++ mount image file
++++ resize fs to 786432
++++ umount fs
++++ check fs
 ++ set cluster size to 16384
 +++ truncate image file to 98304
 +++ create fs on image file 65536
@@ -115,6 +121,12 @@ QA output created by 032
 +++ resize fs to 167772160
 +++ umount fs
 +++ check fs
++++ truncate image file to 3145728
++++ create fs on image file 25600
++++ mount image file
++++ resize fs to 3145728
++++ umount fs
++++ check fs
 ++ set cluster size to 65536
 +++ truncate image file to 393216
 +++ create fs on image file 262144
@@ -170,3 +182,9 @@ QA output created by 032
 +++ resize fs to 671088640
 +++ umount fs
 +++ check fs
++++ truncate image file to 12582912
++++ create fs on image file 102400
++++ mount image file
++++ resize fs to 12582912
++++ umount fs
++++ check fs
-- 
2.43.0



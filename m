Return-Path: <linux-ext4+bounces-4177-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367F979937
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2024 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D030280CB5
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC25FB9C;
	Sun, 15 Sep 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qp6c0uwN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31849101EE
	for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726436363; cv=none; b=P8DZEC3Fn6r0EoXkvzpg0X/Yl8QYmnHCvX7YQkybImMRA+lZJMgHAr95pzE7hkoJlxbYZX5+pIZmEHtaK6dRfNYaFSicM/bWk6S0Iv+uvYzVEtcoL4prqrppL2Xz7T2Rko5F6a8U+11qW9hn2JUuA4Sscna4mDCq0vMYXUbWcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726436363; c=relaxed/simple;
	bh=o1XxbQfwSDUrRTuCvDG/WseWFlWhVKkDGgS7heZiW4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJH6D1rh3OxmJv+pNRuO21L6IMtGyFZgqNBlf+79FzerF3//JTGuMb/U0gSy222nuCaTLh938EWkwgBetWQE63Kg+2ui4MA2CmE0RIF7YmHWlY97xzZ77jPpuuk06tyO8Qd4J82qiRT0Yf/tOvW1Z/tAGZ2GxUX++HLh14kyOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qp6c0uwN; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FEA7bx004647
	for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2024 17:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pps01; bh=XB2XYFipVU6h0mxDBwF8rDTB4Kwlpw74676rrEkJKZg=;
 b=qp6c0uwNa2M8A9HjfUCuRBmpxRU6SP1SYs0ezoJWUIu2yDVt+Wl3pbpoWZFyL7AdnxSM
 qUIwo3ozkHMN8KcLUYY4UtlG5LyS6Q+B0Fgfm7TzwQyrzZcQKJ6G04tQTNMOCtFW+33y
 iCkDheivIXlEbzgGVtG5tO4fDqCrtfBxb6G0XNV8YsKIcz5AMwFMEjCcfkLkEm8fJPsp
 yIC/zBi5R++0dq+mKCm0QAPgpLrICwqKTkEHvL/lIKkGBpKP6B0NbG3dhcDHyhKqh1At
 4ZyjLym29j8uv5qjee4UF7uHTSqEH8T1/RS94EVJAo2PD1Kc9qb5j3839WzdZMLmXxHm HA== 
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 41n3gpjh4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2024 17:10:11 -0400
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c35b3a220aso116498476d6.0
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2024 14:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726434610; x=1727039410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XB2XYFipVU6h0mxDBwF8rDTB4Kwlpw74676rrEkJKZg=;
        b=J44Cw0MDlDnIzh1J3O9YOFolutG1uCQ4c0aKfKiGxnfzXmhh/QoNmFa5gQlCgbE5Tl
         sorX1Z6eTJWLo9/9bMEyEUKfVsmOrTcZbiAGFv7sBnGkp7S9P/TFjU1OpwuAIr0Gct97
         ulIbC/g3ezRT23xBrjHwK6rhplnItmp6mOmyIgbp+drJL0rEp3yevP9CA1VUUT7ZbF1p
         IyjpxqsPANER8a959W9nMUONp7Ar4+jkUtWamgAOD1Oq+R1bw22ruNyWQisd4TVT0I6P
         mQTpOpUWvp/vSqAJqpA6Ui2M6U/1AQGk04tQdCn5NCMxBOP7M03fkgqSCgPCZiSZEX9E
         V5UQ==
X-Gm-Message-State: AOJu0YwB1UZKzS8rSSCVVEpmc7yHAVNC05oQDyFd9panfnEVJcNym9y4
	7LkYhtxGrLALM3eHZhJ/8WkV3JZfKmUVB5UZbjQdlJuOOdgLlQHtpIUNtfw++Ln1iwNStC0RL6X
	i9qgB7mi9ZmLZ+iAgH8LQNnybUU7/FPlDcEWsO8tqkJogMFEABVzpI5c=
X-Received: by 2002:a05:6214:4199:b0:6c5:54e4:be44 with SMTP id 6a1803df08f44-6c573ac38fdmr215047236d6.8.1726434610046;
        Sun, 15 Sep 2024 14:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbC1EuwkzKvdclX7dcRz0f2R9+kmHy8rSLSfpPRmuPL7VqI7Vl9MWAFoTs8ITaEHiJGCHH/A==
X-Received: by 2002:a05:6214:4199:b0:6c5:54e4:be44 with SMTP id 6a1803df08f44-6c573ac38fdmr215046946d6.8.1726434609651;
        Sun, 15 Sep 2024 14:10:09 -0700 (PDT)
Received: from ub.cs.columbia.edu (dhcp-20-245.cs.columbia.edu. [128.59.20.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c627cb2sm18369716d6.1.2024.09.15.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 14:10:09 -0700 (PDT)
From: Fanqi Yu <fanqi.yu@columbia.edu>
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fanqi Yu <fanqi.yu@columbia.edu>
Subject: [PATCH] ext4: Prevent successful remount as r/w after filesystem abort
Date: Sun, 15 Sep 2024 17:08:04 -0400
Message-Id: <20240915210802.3835698-1-fanqi.yu@columbia.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ucInPzfO3uMpnx_ZSRfhQ7GjHDDIXxY2
X-Proofpoint-GUID: ucInPzfO3uMpnx_ZSRfhQ7GjHDDIXxY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_13,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=10 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=10
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2408220000 definitions=main-2409150162

While the order of writing to the shutdown and read-only flags has been
enforced by a write memory barrier, the read side in remount does not
have a pairing read barrier.

In the event of a fs forced shutdown remounting as read-only,
remounting it again as read-write can succeed when the flag reads are
reordered such that sb_rdonly() returns true and
ext4_forced_shutdown() returns false.

Commit 4418e14112e3 ("ext4: Fix fsync error handling after filesystem
abort") has added the other barriers related to these two flags but
seems to have missed this one.

Signed-off-by: Fanqi Yu <fanqi.yu@columbia.edu>
---
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 044135796f2b..c5d3f8969dec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6542,6 +6542,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	flush_work(&sbi->s_sb_upd_work);
 
 	if ((bool)(fc->sb_flags & SB_RDONLY) != sb_rdonly(sb)) {
+
+		/*
+		 * Make sure we read the updated s_ext4_flags.
+		 * Pairs with smp_wmb() in ext4_handle_error().
+		 */
+		smp_rmb();
+
 		if (ext4_forced_shutdown(sb)) {
 			err = -EROFS;
 			goto restore_opts;
-- 
2.34.1



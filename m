Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AEB9914
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfITVbV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbfITVbV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F282208C3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569015080;
        bh=YH4TaYjOTPbLGovkabK5U8fbZw6xwZC5tFyC27QQ4Lc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FL2KOdIJMByjhCHPD8M2eDTKXUq48meVIG+7OA4WrzDwYSjMdyEb6EEMVqRhSw3gT
         6l3ztZCEpPJN96LdMhJ6bXfUDUu/TtqOliWBiBRfESpT+N8Ygq0R6dhpuXsDAhap+r
         r4vHr+sjCAifm/putDZ5ONSeFECPSgx1HJE6cVpM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/6] ext4.5: document first kernel version to support casefold feature
Date:   Fri, 20 Sep 2019 14:29:50 -0700
Message-Id: <20190920212954.205789-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920212954.205789-1-ebiggers@kernel.org>
References: <20190920212954.205789-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/ext4.5.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc/ext4.5.in b/misc/ext4.5.in
index 0a93c35e..40e75f81 100644
--- a/misc/ext4.5.in
+++ b/misc/ext4.5.in
@@ -772,6 +772,8 @@ ext4, 4.5
 ext4, 4.13
 .IP "\fBlarge_dir\fR" 2i
 ext4, 4.13
+.IP "\fBcasefold\fR" 2i
+ext4, 5.2
 .SH SEE ALSO
 .BR mke2fs (8),
 .BR mke2fs.conf (5),
-- 
2.23.0.351.gc4317032e6-goog


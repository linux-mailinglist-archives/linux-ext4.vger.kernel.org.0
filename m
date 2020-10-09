Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83603288108
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 06:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgJIEMH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 00:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgJIEMH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 00:12:07 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A5522240;
        Fri,  9 Oct 2020 04:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602216727;
        bh=GIokG9xbIYZmwlattsuu940oZZW0HcRnjhHlJWVtTe8=;
        h=From:To:Cc:Subject:Date:From;
        b=WRtM0vGDeslVDsWq1tag8tJzn1uLhs63V5ACK9MwK0X0zG36pdJTlSnQHyumCgWLL
         uJ50TmmEAVFpUMnMabaL7FI1VXzGo/w4JdiVqe6SDUdVaga9MHoSyDRu9Wjud3OkON
         xZSIb4mMQtvngcvHungcvTr51HET4xKqXt5ECpRk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [xfstests-bld PATCH] config: upgrade xfsprogs to v5.8.0
Date:   Thu,  8 Oct 2020 21:11:43 -0700
Message-Id: <20201009041143.244304-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This is needed to run some of the newer encryption tests.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config b/config
index f302234..34eb6e6 100644
--- a/config
+++ b/config
@@ -20,7 +20,7 @@ BLKTESTS_GIT=https://github.com/osandov/blktests.git
 
 FIO_COMMIT=fio-3.15
 QUOTA_COMMIT=6e631074330a
-XFSPROGS_COMMIT=v5.2.0
+XFSPROGS_COMMIT=v5.8.0
 
 # TOOLCHAIN_DIR=/u1/arm64-toolchain
 # CROSS_COMPILE=aarch64-linux-android
-- 
2.28.0


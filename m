Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CA3A90DA
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFPE6y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhFPE6s (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2323661351
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819403;
        bh=ZCK26L0vvIQBHiKDlLRE36jToio1MfvK3lWJxLR4lRM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l3+I2wRW0wPqhwKIdI9N+YqgX9mageYjnWvBLg62uFHSVCJpUMWBR4YMNXAZgWOy7
         gntE+wp35jSPvD/SXoLeaFUy3MnCxdlMlM3FD+4fVWVRrDA/+SwWFGlE2DgtTbXRbV
         nFCv4l7k6PcNfofweb8Qi6f1F6+I0hurHPxWQeK4ps/kYA8zALHSnvc535Vmxqcld1
         rXpkEVhRfSol+iCUkKPbZFq/0YsrirZq7VWQBUMcX8CrsNvfUnsxwUZoemeHjZE21m
         H436tQjkNfYxHlcunx/y88LCvpc6kYBNUo2AxQtzcMsotDoTz6lFzOs5HjVgOHb2yO
         iKCXEV8xK6NeQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/6] libext2fs: fix a -Wunused-label warning
Date:   Tue, 15 Jun 2021 21:53:34 -0700
Message-Id: <20210616045334.1655288-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616045334.1655288-1-ebiggers@kernel.org>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Remove a label which isn't used.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/unix_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 64eee342..3bb8d238 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -329,7 +329,6 @@ success_unlock:
 
 error_unlock:
 	mutex_unlock(data, BOUNCE_MTX);
-error_out:
 	if (actual >= 0 && actual < size)
 		memset((char *) buf+actual, 0, size-actual);
 	if (channel->read_error)
-- 
2.32.0.272.g935e593368-goog


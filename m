Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9F43F4DA8
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhHWPmh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37250 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F4472001C;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQudeOtPpOQU10n2t9sdKRU9X63g+6tUA5xUgDthv/8=;
        b=EZl0yPDWy7gq45gqN0Q8MgysQPJiyiCBqSE+X0hWF09oempgt/9BcPdHm6BA+JagLIDQqx
        ZPmsAhjlo92dXjXWhvJXc9AVGJ3E9rLrLmhpd05NoRpeAhC09taZhvPP9mBYQjAsYUKIDP
        TqaAchViUnROzqG5qA5NLwnfL725cpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQudeOtPpOQU10n2t9sdKRU9X63g+6tUA5xUgDthv/8=;
        b=MuozMJ/GDR2/iiGKwtrvLw1Aj29aj/dbIY+cnR7KIKeLsdWTuWAUo1pKt8yNxVYZNC3prI
        f/BRTv/AQH1lQNDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 02FAFA3BB8;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD8F11F2CD1; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/8] tune2fs: Fix conversion of quota files
Date:   Mon, 23 Aug 2021 17:41:24 +0200
Message-Id: <20210823154128.16615-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; h=from:subject; bh=Lx1UJPZNLgsKBmmbN+0GUP40hOyhJD5D9kEVqqVigg4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GkUaN9eZsgn0XvL7BSjbTu57jpbJHkTGpEei61 KG+q9pGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBpAAKCRCcnaoHP2RA2Z7NB/ 4osbGPQGrmAwHVUJEqkXAxOBazQE/W3qiykm9uUmzeBGC++5nQzo1J05nb479mQY84Lu8j1Mhbloh8 vtdLdJ0HVHxHQrY058HIXBQfAYlLV0pN6/qRNCVelyjdqQVTjri8oD+TVCjsu4aaTu9ZLZCYM41w5s gweKqj260PJ93IL025nGha6ZL2BsenQy/tKRG7/I9O/c6YUAFKSvXDJ0M/L4XtgMTKxzROSiKDmy8h gEw2Gc9oCZLISL2ulhLJ6ppxQ7jcbvoTuZmdFxhbQIfs8gQnmxlGcQLWs5fDMIKfux5qBwQGnYIC1u jZOGndUvcOaDO3Zexb1ik8pxnpIi+F
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When tune2fs is enabling quota feature, it looks for old-style quota
files and tries to transfer limits stored in these files into newly
created hidded quota files. However the code doing the transfer setups
the quota scan wrongly and instead of transferring limits we transfer
usage. So not only quota limits are lost (at least they can still be
recovered from the old quota files) but also usage information may be
wrong if the accounting in e2fsprogs does not exactly match the
accounting in quota-tools (which is actually the case). Fix the setup of
the quota scan.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/tune2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index bb08f8026918..0f6ef3d6df6b 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1673,7 +1673,7 @@ static int handle_quota_options(ext2_filsys fs)
 			if ((qf_ino = quota_file_exists(fs, qtype)) > 0) {
 				retval = quota_read_all_dquots(qctx, qf_ino,
 							       qtype,
-							       QREAD_USAGE);
+							       QREAD_LIMITS);
 				if (retval) {
 					com_err(program_name, retval,
 						_("while updating quota limits (%d)"),
-- 
2.26.2


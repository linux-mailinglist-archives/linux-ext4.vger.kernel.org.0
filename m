Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A273C5F8B
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhGLPqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42878 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhGLPqK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C64C81FFBA;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzNcke28CCdvhGi1On7m4Wh58678UhE+mdrTdbKpFgs=;
        b=XgJoLUZCH22fhjvTVmsvxdcEFa1DzacX6rrPIbVH3AHnEmoDl8JAWRQ6fKNrtGF1SKQV/0
        GMPWH/zXEVnHeC+COhMXTF41a6/qilywG8QgAt1Y+5kOvdWAyf+RdbtGreY7y39XlHmPsJ
        RoNPsVcW0AD/keyzqAeG4Xcbko5iKYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzNcke28CCdvhGi1On7m4Wh58678UhE+mdrTdbKpFgs=;
        b=MpdUaU5/UvhftNUvBmiZWgMzrvhqNJhQRi2OROscWViJKjX5/rxwPX0EMV6Cy62OOVHxPB
        Uh7bD97D1GpGWqDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id BBD90A3B90;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A41B51F2CD9; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] mke2fs: Add orphan_file feature into mke2fs.conf
Date:   Mon, 12 Jul 2021 17:43:14 +0200
Message-Id: <20210712154315.9606-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=0w35l9dFu1s9CYf3V6lZw/wjE4AlG1mAg7wc3ow94TQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GMRUg2tGnCQyryDP1oT7EONT0RZj5va74Pl0k4s 5OPZ+hCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjEQAKCRCcnaoHP2RA2TUuB/ 45oUemiHrz2njwqmLuvVwcGDb0R90NZ5Fk6yiIBhF7FOlNNylcR5f6tlGwWrb+q96aoQkRvSnr1s1M mbkVw8c4bH15GYt37xypz5JjCr7M5C0Belkxnp2nGBhVNlsWQpCAwYMXaFJnl55TC6UvfxsxYbBU95 imuUMEgHZlX2mk2gaNDq57DU9PCg/PDCLq+VfYQtPzBgPo+ApJWOKquNcbYAdTeJp3AzZnwtLr+Zen ZA6Lq58KBzyIR040mKhb7M/qhDqzorTNBIvky5512Uw8X3v9EI6U8rz4BiT1fChfEDQSllIlme2sZY FmpgZVjEAWE5qWM0vudnwDYCkNzCoo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Enable orphan_file feature by default in larger filesystems. Since the
feature is COMPAT, older kernels will just ignore it and happily work
with the filesystem as well.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/mke2fs.conf.in | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc/mke2fs.conf.in b/misc/mke2fs.conf.in
index 01e35cf83150..d97d8d643d1d 100644
--- a/misc/mke2fs.conf.in
+++ b/misc/mke2fs.conf.in
@@ -11,15 +11,17 @@
 		features = has_journal
 	}
 	ext4 = {
-		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
+		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,orphan_file
 		inode_size = 256
 	}
 	small = {
+		default_features = ^orphan_file
 		blocksize = 1024
 		inode_size = 128
 		inode_ratio = 4096
 	}
 	floppy = {
+		default_features = ^orphan_file
 		blocksize = 1024
 		inode_size = 128
 		inode_ratio = 8192
-- 
2.26.2


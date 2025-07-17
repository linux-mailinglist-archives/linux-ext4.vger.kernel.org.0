Return-Path: <linux-ext4+bounces-9033-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D64FB0850C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 08:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691523BEB9C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1494202987;
	Thu, 17 Jul 2025 06:37:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta004.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FA72635;
	Thu, 17 Jul 2025 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734239; cv=none; b=Zbjsd39jN2mTldcmHj69FR2kTzCgDGBTZiGw8KIw37V5HrW+Uy/KYd2+oNxPfWLXWVHyU1/oIxu/vaszqqZopsm7ezgcXRtRkjXBiJBqhckTXTpLWWLvDlAB2I/SgqRse3QzqGd9HVoiaHFRtRXxMWekr1qKQF+aUuKH+3Wi2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734239; c=relaxed/simple;
	bh=ODV4nJdX+2MsFScVMvC33dHwiLaFre1ZckRuBj+AoMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doHzcgbIvO444zBW34XPCYU82vWuUgXz9QIzaw9gorkLeOpNBmktllFSfakIn8ONtDWJU+Y/p+THR9poG91uG1kI50qrhPM2oAY8wVZBqrGSvtvkhoIwdAQ+QCU11QjtGql2X1g9rKjSoNYGUWDmS2MJOIWTeBjgerKAEpvINaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id c7Owup9Sm5MqycIEwu9ZV0; Thu, 17 Jul 2025 06:37:10 +0000
Received: from cabot.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id cIEvuSZdbl5eGcIEvuPqtw; Thu, 17 Jul 2025 06:37:10 +0000
X-Authority-Analysis: v=2.4 cv=EO6l0EZC c=1 sm=1 tr=0 ts=68789a16
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=ySfo2T4IAAAA:8
 a=VwQbUJbxAAAA:8 a=lB0dNpNiAAAA:8 a=xm_l5cv5EaLj5gwVjToA:9
 a=ZUkhVnNHqyo2at-WnAgH:22 a=c-ZiYqmG3AbHTdtsH08C:22
From: Andreas Dilger <adilger@dilger.ca>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>,
	stable@vger.kernel.org,
	Andreas Dilger <adilger@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>,
	Alex Zhuravlev <bzzz@whamcloud.com>,
	Oleg Drokin <green@whamcloud.com>
Subject: [PATCH] ext4: check fast symlink for ea_inode correctly
Date: Wed, 16 Jul 2025 19:36:42 -0600
Message-ID: <20250717063709.757077-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI2EipW+YCw82/5tUvBpg6PlosruTMEO03/zZi2iDazN3hBg5lFYgySuPoHuKnlUkOFCr0V1u21iOKFljLVgCC97uOLFM1SoJZnrYPYJapWmrB5hgoUF
 D+AdDsQaPAArnitRlF3BpNnQ4HzS/kTwVvtmyrzVmqLaGFcRXDP9DlCu9H+pnlBXRQ+5fZJksJ+XZlYkr+xmoHKxiTZSzjbFzekvBD0GIcVqEEeMC67dXlep
 bkXLEG7Nz8Ld8oOnTDriXBjPWdVhFZ/NZtiXS2w9iL5Y0IhUBSdm3WqmuJ6+ZERCveOYMoXpgvVMRFt/MwRUH+yVGHqN9s0pfoNEkEvD4u4zNK7JqW+2NFBn
 8vGUOcFAICq7zEMsU00X0FkwtJa2LAf9C8pYKus1rgSrCK//Pxk=

The check for a fast symlink in the presence of only an
external xattr inode is incorrect.  If a fast symlink does
not have an xattr block (i_file_acl == 0), but does have
an external xattr inode that increases inode i_blocks, then
the check for a fast symlink will incorrectly fail and
__ext4_iget()->ext4_ind_check_inode() will report the inode
is corrupt when it "validates" i_data[] on the next read:

    # ln -s foo /mnt/tmp/bar
    # setfattr -h -n trusted.test \
               -v "$(yes | head -n 4000)" /mnt/tmp/bar
    # umount /mnt/tmp
    # mount /mnt/tmp
    # ls -l /mnt/tmp
    ls: cannot access '/mnt/tmp/bar': Structure needs cleaning
    total 4
     ? l?????????? ? ?    ?        ?            ? bar
    # dmesg | tail -1
    EXT4-fs error (device dm-8): __ext4_iget:5098:
        inode #24578: block 7303014: comm ls: invalid block

(note that "block 7303014" = 0x6f6f66 = "foo" in LE order).

ext4_inode_is_fast_symlink() should check the superblock
EXT4_FEATURE_INCOMPAT_EA_INODE feature flag, not the inode
EXT4_EA_INODE_FL, since the latter is only set on the xattr
inode itself, and not on the inode that uses this xattr.

Cc: stable@vger.kernel.org
Fixes: fc82228a5e38 ("ext4: support fast symlinks from ext3 file systems")
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Oleg Drokin <green@whamcloud.com>
Reviewed-on: https://review.whamcloud.com/59879
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-19121
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..caca88521c75 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -146,7 +146,7 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+	if (!ext4_has_feature_ea_inode(inode->i_sb)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
 				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
 
-- 
2.43.5



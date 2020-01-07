Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8613303A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 21:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgAGUDL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 15:03:11 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35737 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUDL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 15:03:11 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2wCi-1iq23L2cxw-003JkJ; Tue, 07 Jan 2020 21:02:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix ext4 unused-variable warning
Date:   Tue,  7 Jan 2020 21:02:12 +0100
Message-Id: <20200107200233.3244877-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nfqDsO3LApBgvoCI17Vt2kujvHVXqGUNcSRj3x/2fTZrCNeqX1M
 F9zM+mnkHdTWrc8g19vcpdlPTdaeQMGctnjAd/ioxofcHU1qTbwnfFeP/MrcEfKmHgnbhlA
 LITm7qBEBt3FmbD1j5qsxPgLTKoMbehLkBXEuegwnGIdKpbvcBlEk71cfB/ZsbNaguQPf2y
 au9r1NadicA1lx67tXQvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HP6fxNg0DoQ=:mI6FjMO2CLchjmhCaimz1O
 RvTpLvCYslXOk8SOGfIozC7UAaSd/0Fn3FwOPA6hXFie7ds6cDrUOQc4AxWD6tW2DGhcgBDK0
 Prf7AER5VGkDDU5zBCr4ybsNdi3+p4EbqmauBQCozrgYoEO9sOO5zr4nSqREqC2HE5wB8lXla
 Vwkx1JnVXOf83lqGdxhidkj5eQH1a3mMGpLa2hoI/R+Lr/rXtHGK9ZM6sPKQ/wunLQrIRetC1
 uEOjyC4UP8aBwuUTTtYpRWkorXX4dwUztGThaOaOje7OuQFa9sBldp2FiuY0KFlf35EwOQnZx
 utCFCNe8GAvk0iZA8xQRswEHHmldFrUb/valpP15os0S1ZA4bcLiL5nLhdU4QpAse4elN6Kfj
 jLxdPq199nk/KlA5EvUumBn4WC8qXlGL9843ZFKSdJd5+WIXXn1AaDrCGZK2lkVZgsflxVT0Y
 zn0kQueq3XYE1+QMbaWJ9FR2WoQKHc7lTQBpZq1RcppU4AYZfmY9JMcUQX4w0Hio8K/AEzr7F
 Rls7K+DW9Avm7lvoaMFI9zDfApDHV6iJPs+DFMlPilKg+O/EfM8xzF/icbp1fHsZYJC/M0HcE
 fBXJnBgZqBYJKpVhy7g/bU7ySnFEzh78m9gA7HxEoSqSxRW9vfYTCRBHknVvdbIrPzVF/FRf6
 UOrnPBaZiMCzeDclWVndxSTByA1n3S6X2W+ibi6T60PTjejvbpP4e0ZCs6CPd32Jefl5wakFd
 OB3+Ov2Ky45B709gjWM4HZ/3wO7i7/reyh/1JWo/HpvOjS1B/ur/6srUfXsDcq1/PTDcc3LwX
 wpvFjxaxwZi5cvYONTKaACbl+37cfjD6txwLtxjUHx1patvnun/UxaKmAogwFOtK4hYLC5VHC
 xB286Hgxy1QD2NDpi7ow==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A bugfix introduce a harmless warning:

fs/ext4/inode.c: In function 'ext4_page_mkwrite':
fs/ext4/inode.c:5910:24: error: unused variable 'mapping' [-Werror=unused-variable]

Remove the now-unused variable.

Fixes: 4a58d8158f6d ("fs: Fix page_mkwrite off-by-one errors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9a3e8d075cd0..d0049fd0bfd4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5907,7 +5907,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	vm_fault_t ret;
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
-	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
 	int retries = 0;
-- 
2.20.0


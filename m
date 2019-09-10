Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17ACAEEEF
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436513AbfIJPuB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 11:50:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7496 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404484AbfIJPuB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Sep 2019 11:50:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AFleNk008160;
        Tue, 10 Sep 2019 11:49:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcvdkudx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:49:46 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8AFlfvK008177;
        Tue, 10 Sep 2019 11:49:43 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcvdkuak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:49:42 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8AFjO1v009935;
        Tue, 10 Sep 2019 15:49:36 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2uv4672w9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:49:36 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8AFnZYL49217796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 15:49:36 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF4BC11206B;
        Tue, 10 Sep 2019 15:49:35 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44234112062;
        Tue, 10 Sep 2019 15:49:32 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.89])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 15:49:31 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH RESEND V5 0/7] Consolidate FS read I/O callbacks code
Date:   Tue, 10 Sep 2019 21:21:08 +0530
Message-Id: <20190910155115.28550-1-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100149
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patchset moves the "FS read I/O callbacks" code into a file of its
own (i.e. fs/read_callbacks.c) and modifies the generic
do_mpage_readpge() to make use of the functionality provided.

"FS read I/O callbacks" code implements the state machine that needs
to be executed after reading data from files that are encrypted and/or
have verity metadata associated with them.

With these changes in place, the patchset changes Ext4 to use
mpage_readpage[s] instead of its own custom ext4_readpage[s]()
functions. This is done to reduce duplication of code across
filesystems. Also, "FS read I/O callbacks" source files will be built
only if CONFIG_FS_ENCRYPTION is enabled.

The patchset also modifies fs/buffer.c to get file
encryption/decryption to work with subpage-sized blocks.

The patches can also be obtained from
https://github.com/chandanr/linux.git at branch subpage-encryption-v5.

Changelog:
V4 -> V5:
   1. Since F2FS uses its own workqueue and also since its
      decompression logic isn't an fs independent entity like fscrypt or
      fsverity, this patchset drops support for F2FS.
      The patchset still helps in removing a copy of
      do_mpage_readpage() from Ext4 (i.e. ext4_readpage()) and also
      prevents a copy of block_read_full_page() from being added into
      Ext4 by adding support to "read callbacks" API invocations into
      block_read_full_page().

V3 -> V4:
   1. A new buffer_head flag (i.e. BH_Read_Cb) is introduced to reliably
      check if a buffer head's content has to be decrypted.
   2. Fix layering violation. Now the code flow for decryption happens as shown below,
      FS => read callbacks => fscrypt
   3. Select FS_READ_CALLBACKS from FS specific kconfig file if FS_ENCRYPTION
      is enabled.
   4. Make 'struct read_callbacks_ctx' an opaque structure.
   5. Make use of FS' endio function rather than implementing one in read
      callbacks.
   6. Make read_callbacks.h self-contained.
   7. Split patchset to separate out ext4 and f2fs changes.
   
V2 -> V3:
1. Split the V2 patch "Consolidate 'read callbacks' into a new file" into
   three patches,
   - Introduce the read_callbacks functionality.
   - Convert encryption to use read_callbacks.
   - Remove union from struct fscrypt_context.
2. fs/Kconfig
   Do not explicitly set the default value of 'n' for FS_READ_CALLBACKS.
3. fs/crypto/Kconfig
   Select CONFIG_FS_READ_CALLBACKS only if CONFIG_BLOCK is selected.
4. Remove verity associated code in read_callbacks code.
5. Introduce a callback argument to read_callbacks_setup() function
   which gets invoked for each page for bio. F2FS uses this to perform
   custom operations like decrementing the value of f2fs_sb_info->nr_pages[].
6. Encapsulate the details of "read callbacks" (e.g. Usage of "struct
   read_callbacks *ctx") within its own functions. When CONFIG_FS_READ_CALLBACKS
   is set to 'n', the corresponding stub functions return approriate error
   values.
7. Split fscrypt_decrypt() function into fscrypt_decrypt_bio() and
   fscrypt_decrypt_bh().
8. Split end_read_callbacks() function into end_read_callbacks_bio() and
   end_read_callbacks_bh().

V1 -> V2:
1. Removed the phrase "post_read_process" from file names and
   functions. Instead we now use the phrase "read_callbacks" in its
   place.
2. When performing changes associated with (1), the changes made by
   the patch "Remove the term 'bio' from post read processing" are
   made in the earlier patch "Consolidate 'read callbacks' into a new
   file". Hence the patch "Remove the term 'bio' from post read
   processing" is removed from the patchset.

RFC V2 -> V1:
1. Test and verify FS_CFLG_OWN_PAGES subset of fscrypt_encrypt_page()
   code by executing fstests on UBIFS.
2. Implement F2fs function call back to check if the contents of a
   page holding a verity file's data needs to be verified.

RFC V1 -> RFC V2:
1. Describe the purpose of "Post processing code" in the cover letter.
2. Fix build errors when CONFIG_FS_VERITY is enabled.

Chandan Rajendra (7):
  buffer_head: Introduce BH_Read_Cb flag
  FS: Introduce read callbacks
  fs/mpage.c: Integrate read callbacks
  fs/buffer.c: add decryption support via read_callbacks
  ext4: Wire up ext4_readpage[s] to use mpage_readpage[s]
  ext4: Enable encryption for subpage-sized blocks
  fscrypt: remove struct fscrypt_ctx

 Documentation/filesystems/fscrypt.rst |   4 +-
 fs/Kconfig                            |   3 +
 fs/Makefile                           |   1 +
 fs/buffer.c                           |  33 ++-
 fs/crypto/bio.c                       |  18 --
 fs/crypto/crypto.c                    |  89 +-------
 fs/crypto/fscrypt_private.h           |   3 -
 fs/ext4/Kconfig                       |   1 +
 fs/ext4/Makefile                      |   2 +-
 fs/ext4/inode.c                       |   5 +-
 fs/ext4/readpage.c                    | 295 --------------------------
 fs/ext4/super.c                       |   7 -
 fs/f2fs/Kconfig                       |   1 +
 fs/mpage.c                            |  24 ++-
 fs/read_callbacks.c                   | 285 +++++++++++++++++++++++++
 include/linux/buffer_head.h           |   2 +
 include/linux/fscrypt.h               |  32 ---
 include/linux/read_callbacks.h        |  48 +++++
 18 files changed, 391 insertions(+), 462 deletions(-)
 delete mode 100644 fs/ext4/readpage.c
 create mode 100644 fs/read_callbacks.c
 create mode 100644 include/linux/read_callbacks.h

-- 
2.19.1

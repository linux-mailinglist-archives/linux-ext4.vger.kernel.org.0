Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1B5BF849
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiIUHwi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiIUHwf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 03:52:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B485ABD
        for <linux-ext4@vger.kernel.org>; Wed, 21 Sep 2022 00:52:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC4AA21B40;
        Wed, 21 Sep 2022 07:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663746750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvd578GdpN3jyxtB3xeb2lnScEIJC4uJ/44ZVKejsys=;
        b=OE1qcNXikM5m2iolrxGjOm/rSby4IWKd6UtNRNgoBbROzbHfdtxBNnSAOYLR1Dezwqbdo2
        DnBnp7KC/AyVBq4/8D141vKlfvR0WRGrQVpasSElADJc99aHMsTqp9UcqfP7Z36Oe/5xaM
        gbr4G++HVV+X/YXrKicLUhqJX0pxmUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663746750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvd578GdpN3jyxtB3xeb2lnScEIJC4uJ/44ZVKejsys=;
        b=CuI6OcmOmKGsna+3j1o7cxas3qzT6O+sN4EvR/41SfJxTCeiq9IXpKdJQHf6M2Cm49KXvK
        sOoM280DH9QQqICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB66F13A00;
        Wed, 21 Sep 2022 07:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uTOyLb7CKmN6FwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 07:52:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 51968A0684; Wed, 21 Sep 2022 09:52:27 +0200 (CEST)
Date:   Wed, 21 Sep 2022 09:52:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] ext2: Add sanity checks for group and filesystem size
Message-ID: <20220921075227.iyhfsdnulzhtfbzd@quack3>
References: <20220914154450.26562-1-jack@suse.cz>
 <20220914154728.20280-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wyerawh53wcjjmyr"
Content-Disposition: inline
In-Reply-To: <20220914154728.20280-1-jack@suse.cz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--wyerawh53wcjjmyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 14-09-22 17:47:22, Jan Kara wrote:
> Add sanity check that filesystem size does not exceed the underlying
> device size and that group size is big enough so that metadata can fit
> into it. This avoid trying to mount some crafted filesystems with
> extremely large group counts.
> 
> Reported-by: syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
...
> +	/* At least inode table, bitmaps, and sb have to fit in one group */
> +	if (sbi->s_blocks_per_group <= sbi->s_inodes_per_group + 3) {

Indeed this should have been comparing against number of inode *table
blocks*, not number of inodes... I've fixed the patch locally, the result
is attached for reference.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--wyerawh53wcjjmyr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext2-Add-sanity-checks-for-group-and-filesystem-size.patch"

From b6490b29942fed4366c45e2fe72ae8701f6a1415 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 14 Sep 2022 17:24:42 +0200
Subject: [PATCH 1/2] ext2: Add sanity checks for group and filesystem size

Add sanity check that filesystem size does not exceed the underlying
device size and that group size is big enough so that metadata can fit
into it. This avoid trying to mount some crafted filesystems with
extremely large group counts.

Reported-by: syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
Reported-by: kernel test robot <oliver.sang@intel.com> # Test fixup
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/super.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 252c742379cf..afb31af9302d 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1052,6 +1052,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
+	/* At least inode table, bitmaps, and sb have to fit in one group */
+	if (sbi->s_blocks_per_group <= sbi->s_itb_per_group + 3) {
+		ext2_msg(sb, KERN_ERR,
+			"error: #blocks per group smaller than metadata size: %lu <= %lu",
+			sbi->s_blocks_per_group, sbi->s_inodes_per_group + 3);
+		goto failed_mount;
+	}
 	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,
 			"error: #fragments per group too big: %lu",
@@ -1065,9 +1072,14 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
+	if (sb_bdev_nr_blocks(sb) < le32_to_cpu(es->s_blocks_count)) {
+		ext2_msg(sb, KERN_ERR,
+			 "bad geometry: block count %u exceeds size of device (%u blocks)",
+			 le32_to_cpu(es->s_blocks_count),
+			 (unsigned)sb_bdev_nr_blocks(sb));
+		goto failed_mount;
+	}
 
-	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
-		goto cantfind_ext2;
 	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
 				le32_to_cpu(es->s_first_data_block) - 1)
 					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
-- 
2.35.3


--wyerawh53wcjjmyr--

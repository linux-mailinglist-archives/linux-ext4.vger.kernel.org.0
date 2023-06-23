Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3673BA41
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjFWOfH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jun 2023 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFWOfC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jun 2023 10:35:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819221997
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jun 2023 07:34:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-116.bstnma.fios.verizon.net [108.7.220.116])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35NEYB11019448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687530854; bh=nfPT2eLMr/0sOkUnV1cXIY36koGAX7wUmsS0AMoS1h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Qhh07P+j0C6oIjpOI5o0saWC0T4FhQ+qraY8jOlheCRgN1x56yw8RstZFrgnxPzYR
         M5BGb2B65PtDkZASkYyHJrbBB1f2iMSUtI3+6uK/g4RBRL5sIyEigRMBhJmvMAwQPh
         ksRGMeZJJ9mUtAuuQR72xqU0GQFRxf8NcXLTwydE6Zaf4A4fJoSObdA6Zrlv6teGgk
         zSTekh8K0O1kjzAdxDkzksI/FnEPrnaGLqrkStarIyaJl3XvstVoSe9Aasw6ZSGt61
         OpMSZlFsz6a69ouEowpc/eeor83vvFaixv2EkGuL6Niijqkxsvp9jLe30sM4u3wQNh
         Ve8+N5kePvWQQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0B80B15C027E; Fri, 23 Jun 2023 10:34:11 -0400 (EDT)
Date:   Fri, 23 Jun 2023 10:34:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sean Greenslade <sean@seangreenslade.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <20230623143411.GF34229@mit.edu>
References: <ZIauBR7YiV3rVAHL@glitch>
 <ZIa5P1HqE62rmzqu@debian.me>
 <ZJTv+it2x/glkmpp@debian.me>
 <20230623044611.GD34229@mit.edu>
 <ZJU5HN3bmXR3FvzE@glitch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJU5HN3bmXR3FvzE@glitch>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 22, 2023 at 11:18:04PM -0700, Sean Greenslade wrote:
> I perhaps should have been more explicit in my report. The issue is not
> that the image is any different after the mount; indeed, the md5sums are
> identical before and after on my machine as well. The issue is that
> something is issuing writes to the backing image, which bumps the mtime
> of the backing image. When handling the images with rsync, a difference
> in mtime causes the whole image to need to be read.

Ah, yes, your initial report said "small writes", but it didn't
specify whether the issue was that writes were modifying the image, or
just simply touching the mtime field of the backing file.  I assume
these must be largish fs images, since it must have made the increased
rsync time noticeable?

This appears to fix the problem for me, given the clarified
reproduction information.  Could you please try it on your end?

	     		   	     	    - Ted

From 6bb438fa0aac4c08acd626d408cb6d4b745df7fd Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 23 Jun 2023 10:18:51 -0400
Subject: [PATCH] ext4: avoid updating the superblock on a r/o mount if not
 needed

This was noticed by a user who noticied that the mtime of a file
backing a loopback device was getting bumped when the loopback device
is mounted read/only.  Note: This doesn't show up when doing a
loopback mount of a file directly, via "mount -o ro /tmp/foo.img
/mnt", since the loop device is set read-only when mount automatically
creates loop device.  However, this is noticeable for a LUKS loop
device like this:

% cryptsetup luksOpen /tmp/foo.img test
% mount -o ro /dev/loop0 /mnt ; umount /mnt

or, if LUKS is not in use, if the user manually creates the loop
device like this:

% losetup /dev/loop0 /tmp/foo.img
% mount -o ro /dev/loop0 /mnt ; umount /mnt

The modified mtime causes rsync to do a rolling checksum scan of the
file on the local and remote side, incrementally increasing the time
to rsync the not-modified-but-touched image file.

Fixes: eee00237fa5e ("ext4: commit super block if fs record error when journal record without error")
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/ZIauBR7YiV3rVAHL@glitch
Reported-by: Sean Greenslade <sean@seangreenslade.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b3819e70093e..c638b0db3b2b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5997,19 +5997,27 @@ static int ext4_load_journal(struct super_block *sb,
 		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err) {
 		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
+		__le16 orig_state;
+		bool changed = false;
 
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
 		err = jbd2_journal_load(journal);
-		if (save)
+		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
+				   save, EXT4_S_ERR_LEN)) {
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
+			changed = true;
+		}
 		kfree(save);
+		orig_state = es->s_state;
 		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
 					   EXT4_ERROR_FS);
+		if (orig_state != es->s_state)
+			changed = true;
 		/* Write out restored error information to the superblock */
-		if (!bdev_read_only(sb->s_bdev)) {
+		if (changed && !really_read_only) {
 			int err2;
 			err2 = ext4_commit_super(sb);
 			err = err ? : err2;
-- 
2.31.0


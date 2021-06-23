Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCFB3B1163
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 03:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFWBkt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 21:40:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49753 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229751AbhFWBks (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 21:40:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15N1cSFl032416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 21:38:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB9E215C3CD6; Tue, 22 Jun 2021 21:38:28 -0400 (EDT)
Date:   Tue, 22 Jun 2021 21:38:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Message-ID: <YNKQlKHGLoa8kcO0@mit.edu>
References: <20210518151327.130198-1-leah.rumancik@gmail.com>
 <20210518151327.130198-2-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518151327.130198-2-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 18, 2021 at 03:13:26PM +0000, Leah Rumancik wrote:
> ioctl EXT4_IOC_CHECKPOINT checkpoints and flushes the journal. This
> includes forcing all the transactions to the log, checkpointing the
> transactions, and flushing the log to disk. This ioctl takes u32 "flags"
> as an argument. Three flags are supported. EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
> can be used to verify input to the ioctl. It returns error if there is any
> invalid input, otherwise it returns success without performing
> any checkpointing. The other two flags, EXT4_IOC_CHECKPOINT_FLAG_DISCARD
> and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT, can be used to issue requests to
> discard or zeroout the journal logs blocks, respectively. At this
> point, EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT is primarily added to enable
> testing of this codepath on devices that don't support discard.
> EXT4_IOC_CHECKPOINT_FLAG_DISCARD and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT
> cannot both be set.
> 
> Systems that wish to achieve content deletion SLO can set up a daemon
> that calls this ioctl at a regular interval such that it matches with the
> SLO requirement. Thus, with this patch, the ext4_dir_entry2 wipeout
> patch[1], and the Ext4 "-o discard" mount option set, Ext4 can now
> guarantee that all file contents, file metatdata, and filenames will not
> be accessible through the filesystem and will have had discard or
> zeroout requests issued for corresponding device blocks.
> 
> The __jbd2_journal_erase function could also be used to discard or
> zero-fill the journal during journal load after recovery. This would
> provide a potential solution to a journal replay bug reported earlier this
> year[2]. After a successful journal recovery, e2fsck can call this ioctl to
> discard the journal as well.
> 
> [1] https://lore.kernel.org/linux-ext4/YIHknqxngB1sUdie@mit.edu/
> [2] https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

FYI, I've made the following change to this commit in the ext4 tree,
in order to fix a test failure of ext4/050 when running on a block
device that don't support discard --- for example, when running the
ext4/dax test config.

Cheers,

					- Ted

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1290fbda1399..5730aeca563c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -805,6 +805,7 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	__u32 flags = 0;
 	unsigned int flush_flags = 0;
 	struct super_block *sb = file_inode(filp)->i_sb;
+	struct request_queue *q;
 
 	if (copy_from_user(&flags, (__u32 __user *)arg,
 				sizeof(__u32)))
@@ -822,6 +823,15 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	if (!EXT4_SB(sb)->s_journal)
 		return -ENODEV;
 
+	if (flags & ~JBD2_JOURNAL_FLUSH_VALID)
+		return -EINVAL;
+
+	q = bdev_get_queue(EXT4_SB(sb)->s_journal->j_dev);
+	if (!q)
+		return -ENXIO;
+	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
 	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
 		return 0;
 

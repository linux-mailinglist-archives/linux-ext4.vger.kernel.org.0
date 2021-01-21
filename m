Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5C2FF239
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 18:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbhAURnk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 12:43:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52931 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388945AbhAURls (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 12:41:48 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LHeuhJ016496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 12:40:57 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A130115C35F5; Thu, 21 Jan 2021 12:40:56 -0500 (EST)
Date:   Thu, 21 Jan 2021 12:40:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: ext4 regression panic
Message-ID: <YAm8qH/0oo2ofSMR@mit.edu>
References: <20210121101547.fwh35hov3hshogbz@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121101547.fwh35hov3hshogbz@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 21, 2021 at 06:15:47PM +0800, Murphy Zhou wrote:
> Hi Jack,
> 
> A panic was introduced by this commit. It's easy and reliable to
> reproduce.
> 
> commit 2d01ddc86606564fb08c56e3bc93a0693895f710
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Dec 16 11:18:40 2020 +0100
> 
>     ext4: save error info to sb through journal if available

Hi Murphy,

Thanks for the bug report.  What's happening is that we haven't yet
initialized mballoc yet --- that happens in line 4943 of
fs/ext4/super.c, in ext4_fill_super().

But in line 4903 (in the case of the BZ #199275 reproducer), we
attempt to fetch the root inode, which is fails because it is
unallocated.  That then triggers a call to ext4_error(), which now
results in a journalled change, since the journal is initialized
starting in line 4793, and in line 4838, we set up the
j_commit_callback, which is what ends up calling
ext4_process_freed_data(), but since the multiblock allocator hasn't
been set up yet, that causes the NULL pointer dereference.

So what we need to do is to *not* set up the callback until after the
call to ext4_mb_init().

We should probably create an ext4-specific test in xfstests which
tries mounting a small, deliberately corrupted file system, to make
sure we handle this case correctly in the future.

						- Ted

commit 6c2f9a8247273cf1108ff71c99680b7457f48318
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jan 21 12:33:20 2021 -0500

    ext4: don't try to processed freed blocks until mballoc is initialized
    
    If we try to make any changes via the journal between when the journal
    is initialized, but before the multi-block allocated is initialized,
    we will end up deferencing a NULL pointer when the journal commit
    callback function calls ext4_process_freed_data().
    
    The proximate cause of this failure was commit 2d01ddc86606 ("ext4:
    save error info to sb through journal if available") since file system
    corruption problems detected before the call to ext4_mb_init() would
    result in a journal commit before we aborted the mount of the file
    system.... and we would then trigger the NULL pointer deref.
    
    Cc: Jan Kara <jack@suse.cz>
    Reported by: Murphy Zhou <jencce.kernel@gmail.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f0db49031dc..802ef55f0a55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4876,7 +4876,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 
-	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
 	sbi->s_journal->j_submit_inode_data_buffers =
 		ext4_journal_submit_inode_data_buffers;
 	sbi->s_journal->j_finish_inode_data_buffers =
@@ -4993,6 +4992,14 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount5;
 	}
 
+	/*
+	 * We can only set up the journal commit callback once
+	 * mballoc is initialized
+	 */
+	if (sbi->s_journal)
+		sbi->s_journal->j_commit_callback =
+			ext4_journal_commit_callback;
+
 	block = ext4_count_free_clusters(sb);
 	ext4_free_blocks_count_set(sbi->s_es, 
 				   EXT4_C2B(sbi, block));

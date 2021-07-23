Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A83D4095
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jul 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhGWSbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jul 2021 14:31:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36705 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229761AbhGWSbJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jul 2021 14:31:09 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16NJBXlc008045
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 15:11:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 577A715C37C0; Fri, 23 Jul 2021 15:11:33 -0400 (EDT)
Date:   Fri, 23 Jul 2021 15:11:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: flush s_error_work before journal destroy in
 ext4_fill_super
Message-ID: <YPsUZX+PF5HASRkK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb962c26-b013-957b-7931-feda7f8bf5b5@huawei.com>
 <c0c8619d-3d9b-a184-3cd1-0cd88447fdcd@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 23, 2021 at 09:11:08PM +0800, yangerkun wrote:
> 
> For example, before wo goto failed_mount_wq, we may meet some error and will
> goto ext4_handle_error which can call
> schedule_work(&EXT4_SB(sb)->s_error_work). So the work may start concurrent
> with ext4_fill_super goto failed_mount_wq. There does not have any lock to
> protect the concurrent read and modifies for sbi->s_journal.

Yes, and I'm asking *how* is this actually happening in practice?
I've been going through the code paths and I don't see any place where
ext4_error*() would be called.  That's why I wanted to see your test
case which was reproducing it.  (Not just where you added the msleep,
but how the error was getting triggered in the first place.)


On Fri, Jul 23, 2021 at 09:25:12PM +0800, yangerkun wrote:
> 
> > Can you share with me your test case?  Your patch will result in the
> > shrinker potentially not getting released in some error paths (which
> > will cause other kernel panics), and in any case, once the journal is
> 
> The only logic we have changed is that we move the flush_work before we call
> jbd2_journal_destory. I have not seen the problem you describe... Can you
> help to explain more...

Sorry, I was mistaken.  I thought you were moving the
ext4_es_unregister_shrinker() and flush_work() before the label for
failed_mount_wq; that was a misreading of your patch.

The other way we could fix this might be something like this:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..d663d11fa0de 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -693,7 +693,7 @@ static void flush_stashed_error_work(struct work_struct *work)
 {
 	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
 						s_error_work);
-	journal_t *journal = sbi->s_journal;
+	journal_t *journal = READ_ONCE(sbi->s_journal);
 	handle_t *handle;
 
 	/*
@@ -1184,9 +1184,11 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_sysfs(sb);
 
 	if (sbi->s_journal) {
-		aborted = is_journal_aborted(sbi->s_journal);
-		err = jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		journal_t *journal = sbi->s_journal;
+
+		WRITE_ONCE(sbi->s_journal, NULL);
+		aborted = is_journal_aborted(journal);
+		err = jbd2_journal_destroy(journal);
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
@@ -5175,8 +5177,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
-		jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		journal_t *journal = sbi->s_journal;
+
+		WRITE_ONCE(sbi->s_journal, NULL);
+		jbd2_journal_destroy(journal);
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
@@ -5487,7 +5491,7 @@ static int ext4_load_journal(struct super_block *sb,
 	EXT4_SB(sb)->s_journal = journal;
 	err = ext4_clear_journal_err(sb, es);
 	if (err) {
-		EXT4_SB(sb)->s_journal = NULL;
+		WRITE_ONCE(EXT4_SB(sb)->s_journal, NULL);
 		jbd2_journal_destroy(journal);
 		return err;
 	}

... and here's another possible fix:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..e9e122e52ce8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -704,7 +704,8 @@ static void flush_stashed_error_work(struct work_struct *work)
 	 * We use directly jbd2 functions here to avoid recursing back into
 	 * ext4 error handling code during handling of previous errors.
 	 */
-	if (!sb_rdonly(sbi->s_sb) && journal) {
+	if (!sb_rdonly(sbi->s_sb) && journal &&
+	    !(journal->j_flags & JBD2_UNMOUNT)) {
 		struct buffer_head *sbh = sbi->s_sbh;
 		handle = jbd2_journal_start(journal, 1);
 		if (IS_ERR(handle))



But I would be interested in understanding how we could be triggering
this problem in the first place before deciding what's the best fix.

Cheers,

					- Ted

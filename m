Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5112C128C3B
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Dec 2019 03:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLVCGe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Dec 2019 21:06:34 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49257 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbfLVCGe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Dec 2019 21:06:34 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBM26RD8031625
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Dec 2019 21:06:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5878C420822; Sat, 21 Dec 2019 21:06:27 -0500 (EST)
Date:   Sat, 21 Dec 2019 21:06:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: ensure revoke credits when set xattr
Message-ID: <20191222020627.GA108990@mit.edu>
References: <20191221105508.nrvonawwtz5a6bfz@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221105508.nrvonawwtz5a6bfz@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 21, 2019 at 07:34:28PM +0800, Murphy Zhou wrote:
> It is possible that we need to release and forget blocks
> during set xattr block, especially with 128 inode size,
> so we need enough revoke credits to do that. Or we'll
> hit WARNING since commit:
> 	[83448bd] ext4: Reserve revoke credits for freed blocks
> 
> This can be triggered easily in a kinda corner case...

Thanks for reporting the problem.  However, your fix isn't quite
correct.  The problem is that ext4_journal_ensure_credits() ultimately
calls jbd2_journal_extend(), which has the following documentation.

/**
 * int jbd2_journal_extend() - extend buffer credits.
 * @handle:  handle to 'extend'
 * @nblocks: nr blocks to try to extend by.
 * @revoke_records: number of revoke records to try to extend by.
 *
 * Some transactions, such as large extends and truncates, can be done
 * atomically all at once or in several stages.  The operation requests
 * a credit for a number of buffer modifications in advance, but can
 * extend its credit if it needs more.
 *
 * jbd2_journal_extend tries to give the running handle more buffer credits.
 * It does not guarantee that allocation - this is a best-effort only.
 * The calling process MUST be able to deal cleanly with a failure to
 * extend here.

> +		error = ext4_journal_ensure_credits(handle, credits,
> +				ext4_trans_default_revoke_credits(inode->i_sb));
> +		if (error < 0) {
> +			EXT4_ERROR_INODE(inode, "ensure credits (error %d)", error);
> +			goto cleanup;
> +		}

Calling ext4_error() is not dealing cleanly with failure; doing this
is tricky (see how we do it for truncate) since some change may have
already been made to the file system via the current handle, and
keeping the file system consistent requires a lot of careful design
work.

Fortunately, there's a simpler way to do this.  All we need to do is
to do is to start the handle with the necessary revoke credits:

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8966a5439a22..c4ae268d5dcb 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2475,7 +2475,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 	if (error)
 		return error;
 
-	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
+	handle = ext4_journal_start_with_revoke(inode, EXT4_HT_XATTR, credits,
+			ext4_trans_default_revoke_credits(inode->i_sb));
 	if (IS_ERR(handle)) {
 		error = PTR_ERR(handle);
 	} else {

The other problem is that I'm not able to reproduce the failure using
your shell script.  What version of the kernel were you using, and was
there any thing special needed to trigger the complaint?

      	  		       	  	  - Ted

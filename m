Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3213A767
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgANKbZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 05:31:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:41612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANKbY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 05:31:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E3F33ACE0;
        Tue, 14 Jan 2020 10:31:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CDB791E0D0E; Tue, 14 Jan 2020 11:31:19 +0100 (CET)
Date:   Tue, 14 Jan 2020 11:31:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kai Li <li.kai4@h3c.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        gechangwei@live.cn, wang.yongd@h3c.com, wang.xibo@h3c.com
Subject: Re: [PATCH] jbd2: clear JBD2_ABORT flag before journal_reset to
 update log tail info when load journal
Message-ID: <20200114103119.GE6466@quack2.suse.cz>
References: <20200111022542.5008-1-li.kai4@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111022542.5008-1-li.kai4@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the patch! Just some small comments below:

On Sat 11-01-20 10:25:42, Kai Li wrote:
> Fixes: 85e0c4e89c1b "jbd2: if the journal is aborted then don't allow update of the log tail"

This tag should come at the bottom of the changelog (close to your
Signed-off-by).

> If journal is dirty when mount, it will be replayed but jbd2 sb
> log tail cannot be updated to mark a new start because
> journal->j_flags has already been set with JBD2_ABORT first
> in journal_init_common.
> When a new transaction is committed, it will be recorded in block 1
> first(journal->j_tail is set to 1 in journal_reset). If emergency
> restart again before journal super block is updated unfortunately,
> the new recorded trans will not be replayed in the next mount.
> It is danerous which may lead to metadata corruption for file system.

I'd slightly rephrase the text here so that it is more easily readable and
correct some grammar mistakes. Something like:

If the journal is dirty when the filesystem is mounted, jbd2 will replay
the journal but the journal superblock will not be updated by
journal_reset() because JBD2_ABORT flag is still set (it was set in
journal_init_common()). This is problematic because when a new transaction
is then committed, it will be recorded in block 1 (journal->j_tail was set
to 1 in journal_reset()). If unclean shutdown happens again before the
journal superblock is updated, the new recorded transaction will not be
replayed during the next mount (because of stale sb->s_start and
sb->s_sequence values) which can lead to filesystem corruption.

Otherwise the patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

(again this is added to the bottom of the changelog like the 'Fixes' tag or
'Signed-off-by' tag).

								Honza

> 
> Signed-off-by: Kai Li <li.kai4@h3c.com>
> ---
>  fs/jbd2/journal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 5e408ee24a1a..069b22eba795 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1710,6 +1710,11 @@ int jbd2_journal_load(journal_t *journal)
>  		       journal->j_devname);
>  		return -EFSCORRUPTED;
>  	}
> +	/*
> +	 * clear JBD2_ABORT flag initialized in journal_init_common
> +	 * here to update log tail information with the newest seq.
> +	 */
> +	journal->j_flags &= ~JBD2_ABORT;
>  
>  	/* OK, we've finished with the dynamic journal bits:
>  	 * reinitialise the dynamic contents of the superblock in memory
> @@ -1717,7 +1722,6 @@ int jbd2_journal_load(journal_t *journal)
>  	if (journal_reset(journal))
>  		goto recovery_error;
>  
> -	journal->j_flags &= ~JBD2_ABORT;
>  	journal->j_flags |= JBD2_LOADED;
>  	return 0;
>  
> -- 
> 2.24.0.windows.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

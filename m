Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B652426CD05
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIPUwo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 16:52:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgIPQyY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF740B011;
        Wed, 16 Sep 2020 16:22:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 283551E12E1; Wed, 16 Sep 2020 18:22:40 +0200 (CEST)
Date:   Wed, 16 Sep 2020 18:22:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: Re: [RFC PATCH v3 2/3] jbd2, ext4, ocfs2: introduce/use journal
 callbacks j_submit|finish_inode_data_buffers()
Message-ID: <20200916162240.GM3607@quack2.suse.cz>
References: <20200910193127.276214-1-mfo@canonical.com>
 <20200910193127.276214-3-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910193127.276214-3-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-09-20 16:31:26, Mauricio Faria de Oliveira wrote:
> Introduce journal callbacks to allow different behaviors
> for an inode in journal_submit|finish_inode_data_buffers().
> 
> The existing users of the current behavior (ext4, ocfs2)
> are adapted to use the previously exported functions
> that implement the current behavior.
> 
> Users are callers of jbd2_journal_inode_ranged_write|wait(),
> which adds the inode to the transaction's inode list with
> the JI_WRITE|WAIT_DATA flags. Only ext4 and ocfs2 in-tree.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c      | 14 ++++++++++++++
>  fs/jbd2/commit.c     | 30 ++++++++++++++++++------------
>  fs/ocfs2/super.c     | 15 +++++++++++++++
>  include/linux/jbd2.h | 25 ++++++++++++++++++++++++-
>  4 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ea425b49b345..7303839d7ad9 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -472,6 +472,16 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
>  	spin_unlock(&sbi->s_md_lock);
>  }
>  
> +static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	return jbd2_journal_submit_inode_data_buffers(jinode);
> +}
> +
> +static int ext4_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	return jbd2_journal_finish_inode_data_buffers(jinode);
> +}
> +

No need for these ext4 wrappers. They just obfuscate code... Ditto for
ocfs2 below.

> @@ -1111,6 +1113,27 @@ struct journal_s
>  	void			(*j_commit_callback)(journal_t *,
>  						     transaction_t *);
>  
> +	/**
> +	 * @j_submit_inode_data_buffers:
> +	 *
> +	 * This function is called for all inodes associated with the
> +	 * committing transaction marked with JI_WRITE_DATA flag
> +	 * before we start to write out the transaction to the journal.
> +	 */
> +	int			(*j_submit_inode_data_buffers)
> +					(struct jbd2_inode *);
> +
> +	/**
> +	 * @j_finish_inode_data_buffers:
> +	 *
> +	 * This function is called for all inodes associated with the
> +	 * committing transaction marked with JI_WAIT_DATA flag
> +	 * after we have written the transaction to the journal
> +	 * but before we write out the commit block.
> +	 */
> +	int			(*j_finish_inode_data_buffers)
> +					(struct jbd2_inode *);
> +

Having the callbacks in the journal_s will not work if we have inodes with
data journalling on a filesystem mounted in data=ordered mode. The
callbacks really need to be a per-inode thing so I'd add them to struct
jbd2_inode.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

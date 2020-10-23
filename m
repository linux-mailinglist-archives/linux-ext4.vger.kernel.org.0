Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37153297564
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750741AbgJWQ5Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 12:57:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:32800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461853AbgJWQ5Z (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Oct 2020 12:57:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 486C7AC48;
        Fri, 23 Oct 2020 16:57:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EB3C91E1348; Fri, 23 Oct 2020 18:57:22 +0200 (CEST)
Date:   Fri, 23 Oct 2020 18:57:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/56] jbd2: fix kernel-doc markups
Message-ID: <20201023165722.GH9119@quack2.suse.cz>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <ef76f7a51fbb1ff7d9d1ff36f5ce65f1c3e5e3c2.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef76f7a51fbb1ff7d9d1ff36f5ce65f1c3e5e3c2.1603469755.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 23-10-20 18:33:22, Mauro Carvalho Chehab wrote:
> Kernel-doc markup should use this format:
>         identifier - description
> 
> They should not have any type before that, as otherwise
> the parser won't do the right thing.
> 
> Also, some identifiers have different names between their
> prototypes and the kernel-doc markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks for the patch. It looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c     | 34 ++++++++++++++++++----------------
>  fs/jbd2/transaction.c | 31 ++++++++++++++++---------------
>  include/linux/jbd2.h  |  2 +-
>  3 files changed, 35 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 0c7c42bd530f..f71848367ab6 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -566,12 +566,14 @@ static int __jbd2_journal_force_commit(journal_t *journal)
>  }
>  
>  /**
> - * Force and wait upon a commit if the calling process is not within
> - * transaction.  This is used for forcing out undo-protected data which contains
> - * bitmaps, when the fs is running out of space.
> + * jbd2_journal_force_commit_nested - Force and wait upon a commit if the
> + * calling process is not within transaction.
>   *
>   * @journal: journal to force
>   * Returns true if progress was made.
> + *
> + * This is used for forcing out undo-protected data which contains
> + * bitmaps, when the fs is running out of space.
>   */
>  int jbd2_journal_force_commit_nested(journal_t *journal)
>  {
> @@ -582,7 +584,7 @@ int jbd2_journal_force_commit_nested(journal_t *journal)
>  }
>  
>  /**
> - * int journal_force_commit() - force any uncommitted transactions
> + * jbd2_journal_force_commit() - force any uncommitted transactions
>   * @journal: journal to force
>   *
>   * Caller want unconditional commit. We can only force the running transaction
> @@ -1899,7 +1901,7 @@ static int load_superblock(journal_t *journal)
>  
>  
>  /**
> - * int jbd2_journal_load() - Read journal from disk.
> + * jbd2_journal_load() - Read journal from disk.
>   * @journal: Journal to act on.
>   *
>   * Given a journal_t structure which tells us which disk blocks contain
> @@ -1972,7 +1974,7 @@ int jbd2_journal_load(journal_t *journal)
>  }
>  
>  /**
> - * void jbd2_journal_destroy() - Release a journal_t structure.
> + * jbd2_journal_destroy() - Release a journal_t structure.
>   * @journal: Journal to act on.
>   *
>   * Release a journal_t structure once it is no longer in use by the
> @@ -2050,7 +2052,7 @@ int jbd2_journal_destroy(journal_t *journal)
>  
>  
>  /**
> - *int jbd2_journal_check_used_features() - Check if features specified are used.
> + * jbd2_journal_check_used_features() - Check if features specified are used.
>   * @journal: Journal to check.
>   * @compat: bitmask of compatible features
>   * @ro: bitmask of features that force read-only mount
> @@ -2085,7 +2087,7 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
>  }
>  
>  /**
> - * int jbd2_journal_check_available_features() - Check feature set in journalling layer
> + * jbd2_journal_check_available_features() - Check feature set in journalling layer
>   * @journal: Journal to check.
>   * @compat: bitmask of compatible features
>   * @ro: bitmask of features that force read-only mount
> @@ -2117,7 +2119,7 @@ int jbd2_journal_check_available_features(journal_t *journal, unsigned long comp
>  }
>  
>  /**
> - * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
> + * jbd2_journal_set_features() - Mark a given journal feature in the superblock
>   * @journal: Journal to act on.
>   * @compat: bitmask of compatible features
>   * @ro: bitmask of features that force read-only mount
> @@ -2201,7 +2203,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  }
>  
>  /*
> - * jbd2_journal_clear_features () - Clear a given journal feature in the
> + * jbd2_journal_clear_features() - Clear a given journal feature in the
>   * 				    superblock
>   * @journal: Journal to act on.
>   * @compat: bitmask of compatible features
> @@ -2230,7 +2232,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  EXPORT_SYMBOL(jbd2_journal_clear_features);
>  
>  /**
> - * int jbd2_journal_flush () - Flush journal
> + * jbd2_journal_flush() - Flush journal
>   * @journal: Journal to act on.
>   *
>   * Flush all data for a given journal to disk and empty the journal.
> @@ -2305,7 +2307,7 @@ int jbd2_journal_flush(journal_t *journal)
>  }
>  
>  /**
> - * int jbd2_journal_wipe() - Wipe journal contents
> + * jbd2_journal_wipe() - Wipe journal contents
>   * @journal: Journal to act on.
>   * @write: flag (see below)
>   *
> @@ -2346,7 +2348,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
>  }
>  
>  /**
> - * void jbd2_journal_abort () - Shutdown the journal immediately.
> + * jbd2_journal_abort () - Shutdown the journal immediately.
>   * @journal: the journal to shutdown.
>   * @errno:   an error number to record in the journal indicating
>   *           the reason for the shutdown.
> @@ -2437,7 +2439,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
>  }
>  
>  /**
> - * int jbd2_journal_errno () - returns the journal's error state.
> + * jbd2_journal_errno() - returns the journal's error state.
>   * @journal: journal to examine.
>   *
>   * This is the errno number set with jbd2_journal_abort(), the last
> @@ -2461,7 +2463,7 @@ int jbd2_journal_errno(journal_t *journal)
>  }
>  
>  /**
> - * int jbd2_journal_clear_err () - clears the journal's error state
> + * jbd2_journal_clear_err() - clears the journal's error state
>   * @journal: journal to act on.
>   *
>   * An error must be cleared or acked to take a FS out of readonly
> @@ -2481,7 +2483,7 @@ int jbd2_journal_clear_err(journal_t *journal)
>  }
>  
>  /**
> - * void jbd2_journal_ack_err() - Ack journal err.
> + * jbd2_journal_ack_err() - Ack journal err.
>   * @journal: journal to act on.
>   *
>   * An error must be cleared or acked to take a FS out of readonly
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 43985738aa86..4cf88191b025 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -517,7 +517,7 @@ EXPORT_SYMBOL(jbd2__journal_start);
>  
>  
>  /**
> - * handle_t *jbd2_journal_start() - Obtain a new handle.
> + * jbd2_journal_start() - Obtain a new handle.
>   * @journal: Journal to start transaction on.
>   * @nblocks: number of block buffer we might modify
>   *
> @@ -564,7 +564,7 @@ void jbd2_journal_free_reserved(handle_t *handle)
>  EXPORT_SYMBOL(jbd2_journal_free_reserved);
>  
>  /**
> - * int jbd2_journal_start_reserved() - start reserved handle
> + * jbd2_journal_start_reserved() - start reserved handle
>   * @handle: handle to start
>   * @type: for handle statistics
>   * @line_no: for handle statistics
> @@ -618,7 +618,7 @@ int jbd2_journal_start_reserved(handle_t *handle, unsigned int type,
>  EXPORT_SYMBOL(jbd2_journal_start_reserved);
>  
>  /**
> - * int jbd2_journal_extend() - extend buffer credits.
> + * jbd2_journal_extend() - extend buffer credits.
>   * @handle:  handle to 'extend'
>   * @nblocks: nr blocks to try to extend by.
>   * @revoke_records: number of revoke records to try to extend by.
> @@ -743,7 +743,7 @@ static void stop_this_handle(handle_t *handle)
>  }
>  
>  /**
> - * int jbd2_journal_restart() - restart a handle .
> + * jbd2__journal_restart() - restart a handle .
>   * @handle:  handle to restart
>   * @nblocks: nr credits requested
>   * @revoke_records: number of revoke record credits requested
> @@ -813,7 +813,7 @@ int jbd2_journal_restart(handle_t *handle, int nblocks)
>  EXPORT_SYMBOL(jbd2_journal_restart);
>  
>  /**
> - * void jbd2_journal_lock_updates () - establish a transaction barrier.
> + * jbd2_journal_lock_updates () - establish a transaction barrier.
>   * @journal:  Journal to establish a barrier on.
>   *
>   * This locks out any further updates from being started, and blocks
> @@ -872,7 +872,7 @@ void jbd2_journal_lock_updates(journal_t *journal)
>  }
>  
>  /**
> - * void jbd2_journal_unlock_updates (journal_t* journal) - release barrier
> + * jbd2_journal_unlock_updates () - release barrier
>   * @journal:  Journal to release the barrier on.
>   *
>   * Release a transaction barrier obtained with jbd2_journal_lock_updates().
> @@ -1180,7 +1180,8 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
>  }
>  
>  /**
> - * int jbd2_journal_get_write_access() - notify intent to modify a buffer for metadata (not data) update.
> + * jbd2_journal_get_write_access() - notify intent to modify a buffer
> + *				     for metadata (not data) update.
>   * @handle: transaction to add buffer modifications to
>   * @bh:     bh to be used for metadata writes
>   *
> @@ -1224,7 +1225,7 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
>   * unlocked buffer beforehand. */
>  
>  /**
> - * int jbd2_journal_get_create_access () - notify intent to use newly created bh
> + * jbd2_journal_get_create_access () - notify intent to use newly created bh
>   * @handle: transaction to new buffer to
>   * @bh: new buffer.
>   *
> @@ -1304,7 +1305,7 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
>  }
>  
>  /**
> - * int jbd2_journal_get_undo_access() -  Notify intent to modify metadata with
> + * jbd2_journal_get_undo_access() -  Notify intent to modify metadata with
>   *     non-rewindable consequences
>   * @handle: transaction
>   * @bh: buffer to undo
> @@ -1381,7 +1382,7 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
>  }
>  
>  /**
> - * void jbd2_journal_set_triggers() - Add triggers for commit writeout
> + * jbd2_journal_set_triggers() - Add triggers for commit writeout
>   * @bh: buffer to trigger on
>   * @type: struct jbd2_buffer_trigger_type containing the trigger(s).
>   *
> @@ -1423,7 +1424,7 @@ void jbd2_buffer_abort_trigger(struct journal_head *jh,
>  }
>  
>  /**
> - * int jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
> + * jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
>   * @handle: transaction to add buffer to.
>   * @bh: buffer to mark
>   *
> @@ -1591,7 +1592,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  }
>  
>  /**
> - * void jbd2_journal_forget() - bforget() for potentially-journaled buffers.
> + * jbd2_journal_forget() - bforget() for potentially-journaled buffers.
>   * @handle: transaction handle
>   * @bh:     bh to 'forget'
>   *
> @@ -1760,7 +1761,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  }
>  
>  /**
> - * int jbd2_journal_stop() - complete a transaction
> + * jbd2_journal_stop() - complete a transaction
>   * @handle: transaction to complete.
>   *
>   * All done for a particular handle.
> @@ -2078,7 +2079,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
>  }
>  
>  /**
> - * int jbd2_journal_try_to_free_buffers() - try to free page buffers.
> + * jbd2_journal_try_to_free_buffers() - try to free page buffers.
>   * @journal: journal for operation
>   * @page: to try and free
>   *
> @@ -2409,7 +2410,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
>  }
>  
>  /**
> - * void jbd2_journal_invalidatepage()
> + * jbd2_journal_invalidatepage()
>   * @journal: journal to use for flush...
>   * @page:    page to flush
>   * @offset:  start of the range to invalidate
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 3c5f76ce88f1..17bed9684cba 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -397,7 +397,7 @@ static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
>  #define JI_WAIT_DATA (1 << __JI_WAIT_DATA)
>  
>  /**
> - * struct jbd_inode - The jbd_inode type is the structure linking inodes in
> + * struct jbd2_inode - The jbd_inode type is the structure linking inodes in
>   * ordered mode present in a transaction so that we can sync them during commit.
>   */
>  struct jbd2_inode {
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

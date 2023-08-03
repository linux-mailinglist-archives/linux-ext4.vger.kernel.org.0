Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2076EBDC
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjHCOJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHCOHm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:07:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8C2685
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:07:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26C3021983;
        Thu,  3 Aug 2023 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691071628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eywDx/JFqchyRe7zvzDmrttSmNLl3zUkUJky/9NS34E=;
        b=VrQ+hoKwT1fI0mba+bsIhOVGuUwgS/SKgUHxsYArs47nywgspSkhAgsmVcZyEqYVUmwC8u
        QRmC0FNO+R6WMU8Uvtumz3y3okWNkRS/0QFU71kmYy4BJKHGlOD196CeSVeoJ2EoUPHbMe
        6FYPb4CbbEgnQy93hS8oskyDk8D2QSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691071628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eywDx/JFqchyRe7zvzDmrttSmNLl3zUkUJky/9NS34E=;
        b=wnHYCeupPIVKHD/UQOEKhNSDtLOnsPMIe7VJ+MV0AKKt0jHXQusfUVrH/A57IkrTPBy/6K
        D9iMqvU6XlMnVFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15A1E1333C;
        Thu,  3 Aug 2023 14:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XUc9BYy0y2QEBgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:07:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A5203A076B; Thu,  3 Aug 2023 16:07:07 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:07:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 01/12] jbd2: move load_superblock() dependent functions
Message-ID: <20230803140707.avrvyookvhotwrw7@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-2-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:22, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Moving load_superblock() dependent functions before
> journal_init_common(), just preparing for moving the call to
> load_superblock() from jbd2_journal_load() and jbd2_journal_wipe() to
> journal_init_common(), no functional changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I'd just slightly rephrase the changelog:

Move load_superblock() declaration and the functions it calls before
journal_init_common(). This is a preparation for moving a call to
load_superblock() from jbd2_journal_load() and jbd2_journal_wipe() to
journal_init_common(). No functional changes.

Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 337 +++++++++++++++++++++++-----------------------
>  1 file changed, 168 insertions(+), 169 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index fbce16fedaa4..48c44c7fccf4 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1336,6 +1336,174 @@ static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
>  	return count;
>  }
>  
> +/*
> + * If the journal init or create aborts, we need to mark the journal
> + * superblock as being NULL to prevent the journal destroy from writing
> + * back a bogus superblock.
> + */
> +static void journal_fail_superblock(journal_t *journal)
> +{
> +	struct buffer_head *bh = journal->j_sb_buffer;
> +	brelse(bh);
> +	journal->j_sb_buffer = NULL;
> +}
> +
> +/*
> + * Read the superblock for a given journal, performing initial
> + * validation of the format.
> + */
> +static int journal_get_superblock(journal_t *journal)
> +{
> +	struct buffer_head *bh;
> +	journal_superblock_t *sb;
> +	int err;
> +
> +	bh = journal->j_sb_buffer;
> +
> +	J_ASSERT(bh != NULL);
> +	if (buffer_verified(bh))
> +		return 0;
> +
> +	err = bh_read(bh, 0);
> +	if (err < 0) {
> +		printk(KERN_ERR
> +			"JBD2: IO error reading journal superblock\n");
> +		goto out;
> +	}
> +
> +	sb = journal->j_superblock;
> +
> +	err = -EINVAL;
> +
> +	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
> +	    sb->s_blocksize != cpu_to_be32(journal->j_blocksize)) {
> +		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
> +		goto out;
> +	}
> +
> +	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
> +	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
> +		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
> +		goto out;
> +	}
> +
> +	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
> +		printk(KERN_WARNING "JBD2: journal file too short\n");
> +		goto out;
> +	}
> +
> +	if (be32_to_cpu(sb->s_first) == 0 ||
> +	    be32_to_cpu(sb->s_first) >= journal->j_total_len) {
> +		printk(KERN_WARNING
> +			"JBD2: Invalid start block of journal: %u\n",
> +			be32_to_cpu(sb->s_first));
> +		goto out;
> +	}
> +
> +	if (jbd2_has_feature_csum2(journal) &&
> +	    jbd2_has_feature_csum3(journal)) {
> +		/* Can't have checksum v2 and v3 at the same time! */
> +		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
> +		       "at the same time!\n");
> +		goto out;
> +	}
> +
> +	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
> +	    jbd2_has_feature_checksum(journal)) {
> +		/* Can't have checksum v1 and v2 on at the same time! */
> +		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
> +		       "at the same time!\n");
> +		goto out;
> +	}
> +
> +	if (!jbd2_verify_csum_type(journal, sb)) {
> +		printk(KERN_ERR "JBD2: Unknown checksum type\n");
> +		goto out;
> +	}
> +
> +	/* Load the checksum driver */
> +	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
> +		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> +		if (IS_ERR(journal->j_chksum_driver)) {
> +			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
> +			err = PTR_ERR(journal->j_chksum_driver);
> +			journal->j_chksum_driver = NULL;
> +			goto out;
> +		}
> +		/* Check superblock checksum */
> +		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
> +			printk(KERN_ERR "JBD2: journal checksum error\n");
> +			err = -EFSBADCRC;
> +			goto out;
> +		}
> +	}
> +	set_buffer_verified(bh);
> +	return 0;
> +
> +out:
> +	journal_fail_superblock(journal);
> +	return err;
> +}
> +
> +static int journal_revoke_records_per_block(journal_t *journal)
> +{
> +	int record_size;
> +	int space = journal->j_blocksize - sizeof(jbd2_journal_revoke_header_t);
> +
> +	if (jbd2_has_feature_64bit(journal))
> +		record_size = 8;
> +	else
> +		record_size = 4;
> +
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		space -= sizeof(struct jbd2_journal_block_tail);
> +	return space / record_size;
> +}
> +
> +/*
> + * Load the on-disk journal superblock and read the key fields into the
> + * journal_t.
> + */
> +static int load_superblock(journal_t *journal)
> +{
> +	int err;
> +	journal_superblock_t *sb;
> +	int num_fc_blocks;
> +
> +	err = journal_get_superblock(journal);
> +	if (err)
> +		return err;
> +
> +	sb = journal->j_superblock;
> +
> +	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
> +	journal->j_tail = be32_to_cpu(sb->s_start);
> +	journal->j_first = be32_to_cpu(sb->s_first);
> +	journal->j_errno = be32_to_cpu(sb->s_errno);
> +	journal->j_last = be32_to_cpu(sb->s_maxlen);
> +
> +	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
> +		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
> +	/* Precompute checksum seed for all metadata */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
> +						   sizeof(sb->s_uuid));
> +	journal->j_revoke_records_per_block =
> +				journal_revoke_records_per_block(journal);
> +
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> +		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
> +		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
> +			journal->j_last = journal->j_fc_last - num_fc_blocks;
> +		journal->j_fc_first = journal->j_last + 1;
> +		journal->j_fc_off = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  /*
>   * Management for journal control blocks: functions to create and
>   * destroy journal_t structures, and to initialise and read existing
> @@ -1521,18 +1689,6 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  	return journal;
>  }
>  
> -/*
> - * If the journal init or create aborts, we need to mark the journal
> - * superblock as being NULL to prevent the journal destroy from writing
> - * back a bogus superblock.
> - */
> -static void journal_fail_superblock(journal_t *journal)
> -{
> -	struct buffer_head *bh = journal->j_sb_buffer;
> -	brelse(bh);
> -	journal->j_sb_buffer = NULL;
> -}
> -
>  /*
>   * Given a journal_t structure, initialise the various fields for
>   * startup of a new journaling session.  We use this both when creating
> @@ -1889,163 +2045,6 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
>  }
>  EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
>  
> -static int journal_revoke_records_per_block(journal_t *journal)
> -{
> -	int record_size;
> -	int space = journal->j_blocksize - sizeof(jbd2_journal_revoke_header_t);
> -
> -	if (jbd2_has_feature_64bit(journal))
> -		record_size = 8;
> -	else
> -		record_size = 4;
> -
> -	if (jbd2_journal_has_csum_v2or3(journal))
> -		space -= sizeof(struct jbd2_journal_block_tail);
> -	return space / record_size;
> -}
> -
> -/*
> - * Read the superblock for a given journal, performing initial
> - * validation of the format.
> - */
> -static int journal_get_superblock(journal_t *journal)
> -{
> -	struct buffer_head *bh;
> -	journal_superblock_t *sb;
> -	int err;
> -
> -	bh = journal->j_sb_buffer;
> -
> -	J_ASSERT(bh != NULL);
> -	if (buffer_verified(bh))
> -		return 0;
> -
> -	err = bh_read(bh, 0);
> -	if (err < 0) {
> -		printk(KERN_ERR
> -			"JBD2: IO error reading journal superblock\n");
> -		goto out;
> -	}
> -
> -	sb = journal->j_superblock;
> -
> -	err = -EINVAL;
> -
> -	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
> -	    sb->s_blocksize != cpu_to_be32(journal->j_blocksize)) {
> -		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
> -		goto out;
> -	}
> -
> -	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
> -	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
> -		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
> -		goto out;
> -	}
> -
> -	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
> -		printk(KERN_WARNING "JBD2: journal file too short\n");
> -		goto out;
> -	}
> -
> -	if (be32_to_cpu(sb->s_first) == 0 ||
> -	    be32_to_cpu(sb->s_first) >= journal->j_total_len) {
> -		printk(KERN_WARNING
> -			"JBD2: Invalid start block of journal: %u\n",
> -			be32_to_cpu(sb->s_first));
> -		goto out;
> -	}
> -
> -	if (jbd2_has_feature_csum2(journal) &&
> -	    jbd2_has_feature_csum3(journal)) {
> -		/* Can't have checksum v2 and v3 at the same time! */
> -		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
> -		       "at the same time!\n");
> -		goto out;
> -	}
> -
> -	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
> -	    jbd2_has_feature_checksum(journal)) {
> -		/* Can't have checksum v1 and v2 on at the same time! */
> -		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
> -		       "at the same time!\n");
> -		goto out;
> -	}
> -
> -	if (!jbd2_verify_csum_type(journal, sb)) {
> -		printk(KERN_ERR "JBD2: Unknown checksum type\n");
> -		goto out;
> -	}
> -
> -	/* Load the checksum driver */
> -	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
> -		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> -		if (IS_ERR(journal->j_chksum_driver)) {
> -			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
> -			err = PTR_ERR(journal->j_chksum_driver);
> -			journal->j_chksum_driver = NULL;
> -			goto out;
> -		}
> -		/* Check superblock checksum */
> -		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
> -			printk(KERN_ERR "JBD2: journal checksum error\n");
> -			err = -EFSBADCRC;
> -			goto out;
> -		}
> -	}
> -	set_buffer_verified(bh);
> -	return 0;
> -
> -out:
> -	journal_fail_superblock(journal);
> -	return err;
> -}
> -
> -/*
> - * Load the on-disk journal superblock and read the key fields into the
> - * journal_t.
> - */
> -
> -static int load_superblock(journal_t *journal)
> -{
> -	int err;
> -	journal_superblock_t *sb;
> -	int num_fc_blocks;
> -
> -	err = journal_get_superblock(journal);
> -	if (err)
> -		return err;
> -
> -	sb = journal->j_superblock;
> -
> -	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
> -	journal->j_tail = be32_to_cpu(sb->s_start);
> -	journal->j_first = be32_to_cpu(sb->s_first);
> -	journal->j_errno = be32_to_cpu(sb->s_errno);
> -	journal->j_last = be32_to_cpu(sb->s_maxlen);
> -
> -	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
> -		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
> -	/* Precompute checksum seed for all metadata */
> -	if (jbd2_journal_has_csum_v2or3(journal))
> -		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
> -						   sizeof(sb->s_uuid));
> -	journal->j_revoke_records_per_block =
> -				journal_revoke_records_per_block(journal);
> -
> -	if (jbd2_has_feature_fast_commit(journal)) {
> -		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> -		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
> -		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
> -			journal->j_last = journal->j_fc_last - num_fc_blocks;
> -		journal->j_fc_first = journal->j_last + 1;
> -		journal->j_fc_off = 0;
> -	}
> -
> -	return 0;
> -}
> -
> -
>  /**
>   * jbd2_journal_load() - Read journal from disk.
>   * @journal: Journal to act on.
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

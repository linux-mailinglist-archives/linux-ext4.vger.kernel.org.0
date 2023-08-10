Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF1777557
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjHJKEi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjHJKEA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 06:04:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819126B7
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 03:02:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BF181F45B;
        Thu, 10 Aug 2023 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691661725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQNGZd0XV1CTthxwFmhkoeXlpsjtnNQUvyodjHU0210=;
        b=KqsYDDvbYFyyO0VBFcj8pN/WM3EbjlNzE8YVkmF1T/3WuJfBAqdUXOkx6pQ0K38+fwuX8j
        igyvZ5kj4TMZ6cRF2QIAzV1HA90yZcDSfOigI971fMP5Z1lOElp9KZX9YU9GVybuEBLMtH
        5dS6K50RLKGU/6Y+76FIKk2oI4vkbcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691661725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQNGZd0XV1CTthxwFmhkoeXlpsjtnNQUvyodjHU0210=;
        b=6neQ1NqXidoLcYTBS7ab8E/ahbKHYlyjqJeFBNojgZQn9QdNIJ8nPo8w/HMv3wVaNspsxN
        mq6DfqO4oOz5orBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A550138E0;
        Thu, 10 Aug 2023 10:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i7zyGZ211GSnDwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 10:02:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EB5F1A076F; Thu, 10 Aug 2023 12:02:04 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:02:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 06/12] jbd2: cleanup load_superblock()
Message-ID: <20230810100204.t4ywtzzl3pawno5o@quack3>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
 <20230810085417.1501293-7-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810085417.1501293-7-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-08-23 16:54:11, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Rename load_superblock() to journal_load_superblock(), move getting and
> reading superblock from journal_init_common() and
> journal_get_superblock() to this function, and also rename
> journal_get_superblock() to journal_check_superblock(), make it a pure
> check helper to check superblock validity from disk.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 85 +++++++++++++++++++----------------------------
>  1 file changed, 35 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 46ab47b4439e..a8d17070073b 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1341,45 +1341,29 @@ static void journal_fail_superblock(journal_t *journal)
>  }
>  
>  /*
> - * Read the superblock for a given journal, performing initial
> + * Check the superblock for a given journal, performing initial
>   * validation of the format.
>   */
> -static int journal_get_superblock(journal_t *journal)
> +static int journal_check_superblock(journal_t *journal)
>  {
> -	struct buffer_head *bh;
> -	journal_superblock_t *sb;
> -	int err;
> -
> -	bh = journal->j_sb_buffer;
> -
> -	J_ASSERT(bh != NULL);
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
> +	journal_superblock_t *sb = journal->j_superblock;
> +	int err = -EINVAL;
>  
>  	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
>  	    sb->s_blocksize != cpu_to_be32(journal->j_blocksize)) {
>  		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
> -		goto out;
> +		return err;
>  	}
>  
>  	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
>  	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
>  		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
> -		goto out;
> +		return err;
>  	}
>  
>  	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
>  		printk(KERN_WARNING "JBD2: journal file too short\n");
> -		goto out;
> +		return err;
>  	}
>  
>  	if (be32_to_cpu(sb->s_first) == 0 ||
> @@ -1387,7 +1371,7 @@ static int journal_get_superblock(journal_t *journal)
>  		printk(KERN_WARNING
>  			"JBD2: Invalid start block of journal: %u\n",
>  			be32_to_cpu(sb->s_first));
> -		goto out;
> +		return err;
>  	}
>  
>  	/*
> @@ -1402,7 +1386,7 @@ static int journal_get_superblock(journal_t *journal)
>  	    (sb->s_feature_incompat &
>  			~cpu_to_be32(JBD2_KNOWN_INCOMPAT_FEATURES))) {
>  		printk(KERN_WARNING "JBD2: Unrecognised features on journal\n");
> -		goto out;
> +		return err;
>  	}
>  
>  	if (jbd2_has_feature_csum2(journal) &&
> @@ -1410,7 +1394,7 @@ static int journal_get_superblock(journal_t *journal)
>  		/* Can't have checksum v2 and v3 at the same time! */
>  		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
>  		       "at the same time!\n");
> -		goto out;
> +		return err;
>  	}
>  
>  	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
> @@ -1418,14 +1402,14 @@ static int journal_get_superblock(journal_t *journal)
>  		/* Can't have checksum v1 and v2 on at the same time! */
>  		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
>  		       "at the same time!\n");
> -		goto out;
> +		return err;
>  	}
>  
>  	/* Load the checksum driver */
>  	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
>  		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
>  			printk(KERN_ERR "JBD2: Unknown checksum type\n");
> -			goto out;
> +			return err;
>  		}
>  
>  		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> @@ -1433,20 +1417,17 @@ static int journal_get_superblock(journal_t *journal)
>  			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
>  			err = PTR_ERR(journal->j_chksum_driver);
>  			journal->j_chksum_driver = NULL;
> -			goto out;
> +			return err;
>  		}
>  		/* Check superblock checksum */
>  		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
>  			printk(KERN_ERR "JBD2: journal checksum error\n");
>  			err = -EFSBADCRC;
> -			goto out;
> +			return err;
>  		}
>  	}
> -	return 0;
>  
> -out:
> -	journal_fail_superblock(journal);
> -	return err;
> +	return 0;
>  }
>  
>  static int journal_revoke_records_per_block(journal_t *journal)
> @@ -1468,17 +1449,31 @@ static int journal_revoke_records_per_block(journal_t *journal)
>   * Load the on-disk journal superblock and read the key fields into the
>   * journal_t.
>   */
> -static int load_superblock(journal_t *journal)
> +static int journal_load_superblock(journal_t *journal)
>  {
>  	int err;
> +	struct buffer_head *bh;
>  	journal_superblock_t *sb;
>  	int num_fc_blocks;
>  
> -	err = journal_get_superblock(journal);
> -	if (err)
> -		return err;
> +	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
> +			      journal->j_blocksize);
> +	if (bh)
> +		err = bh_read(bh, 0);
> +	if (!bh || err < 0) {
> +		pr_err("%s: Cannot read journal superblock\n", __func__);
> +		brelse(bh);
> +		return -EIO;
> +	}
>  
> -	sb = journal->j_superblock;
> +	journal->j_sb_buffer = bh;
> +	sb = (journal_superblock_t *)bh->b_data;
> +	journal->j_superblock = sb;
> +	err = journal_check_superblock(journal);
> +	if (err) {
> +		journal_fail_superblock(journal);
> +		return err;
> +	}
>  
>  	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
>  	journal->j_tail = be32_to_cpu(sb->s_start);
> @@ -1524,7 +1519,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	static struct lock_class_key jbd2_trans_commit_key;
>  	journal_t *journal;
>  	int err;
> -	struct buffer_head *bh;
>  	int n;
>  
>  	journal = kzalloc(sizeof(*journal), GFP_KERNEL);
> @@ -1577,16 +1571,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (!journal->j_wbuf)
>  		goto err_cleanup;
>  
> -	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
> -	if (!bh) {
> -		pr_err("%s: Cannot get buffer for journal superblock\n",
> -			__func__);
> -		goto err_cleanup;
> -	}
> -	journal->j_sb_buffer = bh;
> -	journal->j_superblock = (journal_superblock_t *)bh->b_data;
> -
> -	err = load_superblock(journal);
> +	err = journal_load_superblock(journal);
>  	if (err)
>  		goto err_cleanup;
>  
> -- 
> 2.34.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4563A5BE
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiK1KLM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 05:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK1KLL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 05:11:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994827A
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 02:11:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23A0521B60;
        Mon, 28 Nov 2022 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669630269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e44F0cthQUS6jnB3oV3B8xa1s3+/X1d9BUhVKJT+zR0=;
        b=Dqjr5KADYvBmeKEcxAnRbc2RLPwb4+CMfq95FJV4BdFbfLEqQHzWBT4waaZEOZSNJw566I
        h1eGoi4fkaP2skxt05RLqC5tr/Jjud410Tnek/xUH43Z1UX3mL9HvAL73Rs26KVwPXUCKj
        d3q+51GONlTkco3F0+E3eAsYx5/aG6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669630269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e44F0cthQUS6jnB3oV3B8xa1s3+/X1d9BUhVKJT+zR0=;
        b=UqjlYHOcjH1CdoSUH4zTLKFj/3MBWhj+bpyztHWMalZ4ZPP6iKPaU0eYIKQUVN9sRy+u0v
        HgsyHMf7earFpqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09BB31326E;
        Mon, 28 Nov 2022 10:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MjZMAj2JhGP4FQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Nov 2022 10:11:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 830E6A070F; Mon, 28 Nov 2022 11:11:08 +0100 (CET)
Date:   Mon, 28 Nov 2022 11:11:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: add barrier info if journal device write cache is
 not enabled
Message-ID: <20221128101108.nslkglhz7pmflyoa@quack3>
References: <20221124135744.1488959-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124135744.1488959-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-11-22 21:57:44, Zhang Yi wrote:
> The block layer will check and suppress flush bio if the device write
> cache is not enabled, so the journal barrier will not go into effect
> even if uer specify 'barrier=1' mount option. It's dangerous if the
> write cache state is false negative, and we cannot distinguish such
> case easily. So just give an info and an inquire interface to let
> sysadmin know the barrier is suppressed for the case of write cache is
> not enabled.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Hum, so have you seen a situation when write cache information is incorrect
in the block layer? Does it happen often enough that it warrants extra
sysfs file?

After all you should be able to query what the block layer thinks about the
write cache - you definitely can for SCSI devices, I'm not sure about
others. So you can have a look there. Providing this info in the filesystem
seems like doing it in the wrong layer - I don't see anything jbd2/ext4
specific here...

								Honza

> ---
>  fs/ext4/super.c |  3 +++
>  fs/ext4/sysfs.c | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7cdd2138c897..916f756ebbca 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5920,6 +5920,9 @@ static int ext4_load_journal(struct super_block *sb,
>  
>  	if (!(journal->j_flags & JBD2_BARRIER))
>  		ext4_msg(sb, KERN_INFO, "barriers disabled");
> +	else if (!bdev_write_cache(journal->j_dev))
> +		ext4_msg(sb, KERN_INFO, "journal device write cache disabled, "
> +					"barriers suppressed");
>  
>  	if (!ext4_has_feature_journal_needs_recovery(sb))
>  		err = jbd2_journal_wipe(journal, !really_read_only);
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index d233c24ea342..67f619c1202e 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -37,6 +37,7 @@ typedef enum {
>  	attr_pointer_string,
>  	attr_pointer_atomic,
>  	attr_journal_task,
> +	attr_journal_barrier,
>  } attr_id_t;
>  
>  typedef enum {
> @@ -135,6 +136,20 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>  			task_pid_vnr(sbi->s_journal->j_task));
>  }
>  
> +static ssize_t journal_barrier_show(struct ext4_sb_info *sbi, char *buf)
> +{
> +	journal_t *journal = sbi->s_journal;
> +
> +	if (!journal)
> +		return sysfs_emit(buf, "none\n");
> +
> +	if (!(journal->j_flags & JBD2_BARRIER))
> +		return sysfs_emit(buf, "disabled\n");
> +	if (!bdev_write_cache(sbi->s_journal->j_dev))
> +		return sysfs_emit(buf, "suppressed\n");
> +	return sysfs_emit(buf, "enabled\n");
> +}
> +
>  #define EXT4_ATTR(_name,_mode,_id)					\
>  static struct ext4_attr ext4_attr_##_name = {				\
>  	.attr = {.name = __stringify(_name), .mode = _mode },		\
> @@ -243,6 +258,7 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_func, 32);
>  EXT4_ATTR(first_error_time, 0444, first_error_time);
>  EXT4_ATTR(last_error_time, 0444, last_error_time);
>  EXT4_ATTR(journal_task, 0444, journal_task);
> +EXT4_ATTR(journal_barrier, 0444, journal_barrier);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>  EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>  EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
> @@ -291,6 +307,7 @@ static struct attribute *ext4_attrs[] = {
>  	ATTR_LIST(first_error_time),
>  	ATTR_LIST(last_error_time),
>  	ATTR_LIST(journal_task),
> +	ATTR_LIST(journal_barrier),
>  #ifdef CONFIG_EXT4_DEBUG
>  	ATTR_LIST(simulate_fail),
>  #endif
> @@ -438,6 +455,8 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  		return print_tstamp(buf, sbi->s_es, s_last_error_time);
>  	case attr_journal_task:
>  		return journal_task_show(sbi, buf);
> +	case attr_journal_barrier:
> +		return journal_barrier_show(sbi, buf);
>  	}
>  
>  	return 0;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

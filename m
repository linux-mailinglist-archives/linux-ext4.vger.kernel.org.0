Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224976EC83
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjHCO3A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjHCO26 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:28:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC1F0
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:28:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80F6D2198F;
        Thu,  3 Aug 2023 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691072934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doPWI6cJjEBE1FupixHcj3IhtoPbpJvHZ1GTlm8WBQM=;
        b=OsDHD++CM9g4TEdUOF9KvabyfxF73I3ZOkd7murJP9t5NAOvjyUmnb/kul8552VLrzD6WL
        jfx5peAfOzoes3RmLQC4A2/6yGzHyeJn/yD2qLo3mHClmeklct1UuYdY6sahu68yobdcM+
        csjScw+sl/ensGlZOWpbsiUEXl/P0yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691072934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doPWI6cJjEBE1FupixHcj3IhtoPbpJvHZ1GTlm8WBQM=;
        b=oOckwG31Ip8V+ssOcpehbTxyGOGlC3/vfvhTpEPs/rfXNzJPmpaNVR1P9zl58NEoutHYCH
        u/YAf03CkmNbaFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7251A1333C;
        Thu,  3 Aug 2023 14:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KBHkG6a5y2QmEQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:28:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 034DDA076B; Thu,  3 Aug 2023 16:28:53 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:28:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 06/12] jbd2: cleanup load_superblock()
Message-ID: <20230803142853.jdiijcez7gtpcot7@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-7-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-7-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:27, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Rename load_superblock() to journal_load_superblock(), move getting and
> reading superblock from journal_init_common() and
> journal_get_superblock() to this function, and also rename
> journal_get_superblock() to journal_check_superblock(), make it a pure
> check helper to check superblock validity from disk.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Two comments below:

> -/*
> - * Read the superblock for a given journal, performing initial
> +/**
> + * journal_check_superblock()
> + * @journal: journal to act on.
> + *
> + * Check the superblock for a given journal, performing initial
>   * validation of the format.
>   */

We rarely use kerneldoc style comments for local functions. In particular
in this place where there's only one user, it seems a bit superfluous. But
if you want to keep it, I'm not against it but then the proper kerneldoc
format should be used. In particular, it should be like:

/**
 * journal_check_superblock - check validity of journal superblock
 * @journal: journal to act on.
 *
 * ... description ... and include here also description of return values
 */


The same comment applies to journal_load_superblock() below.

								Honza

> -/*
> +/**
> + * journal_load_superblock()
> + * @journal: journal to act on.
> + *
>   * Load the on-disk journal superblock and read the key fields into the
>   * journal_t.
>   */
> -static int load_superblock(journal_t *journal)
> +static int journal_load_superblock(journal_t *journal)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

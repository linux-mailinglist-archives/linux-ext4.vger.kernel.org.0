Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970D77100A4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 May 2023 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEXWMc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEXWMa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 18:12:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6729135
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 15:12:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75affb4d0f9so17965985a.2
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684966349; x=1687558349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1l/0qie4req/UQOwYfmZHsuT9joQERFp9mtBgi/+Sw=;
        b=kzGFFuKKMv1z86PsXNNkYryChfRTphcbuWNHNVkz3R6lAcch1+7gBETZMR9o38Tuee
         sD2G6QJlCAHU5qiKQKniZ3nw5RIMowXPiP1Ng2lF7KriLKBJppYjfY95uecdT2BQqSyG
         +BpWFAowI7S0RQ+d8x3ks1ijVBoLWdcZBJNlq2AkzCrqAsvGMGa9d0Pm31Wjcs3jekzp
         xO15/I72IuK3EWOJV3IsxTuu0X8+mpKvj+7YbtSFlfdkPENT/MH1WBxco6D2e54h6lIJ
         02SDfJ/HLu8CbMU7xVpEv1DkZTVKFz87NTLLvUlO1vo6YmPKChswf5S8q4LzI8pd3Sq4
         LvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966349; x=1687558349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1l/0qie4req/UQOwYfmZHsuT9joQERFp9mtBgi/+Sw=;
        b=N2nVX6dFroXbH9t2ZEDEzKhfNrA8ChJzMf/K4+M9Fjk8q6aJ7XmjO+1OGBHvZ9GGy4
         5fyc/+SRvo2LjhYIzYsXyz/KQhlee9rkuNlZlTtzTZbvqG6nAZ8uTanV230MYhJDwyE3
         2rdszdT1KN0sIDom041Ot1JNgARrHJqcnwzRa/torq4wh6C+PhSAcCJUVrNROsFm29qB
         L3kbC97wWoczGxHma8zvNGSNG6NA4b+EpWrjE0fVPtKNwK/i6D1JZd7wkUttCknn6C8q
         9HIm2a3L99v9gseFZcXS/C/7WZntwmFBkL9Pbgga96xHCrCFtbe4Nb7hsaSTP25a0yoI
         s9ig==
X-Gm-Message-State: AC+VfDwUSkeo5dAkp0Ma52tc1x3MZ5LyzV30BGDU2bz7c/Hye4Kt3ThR
        K25RGQ63INvbxOFDyEZCuUU=
X-Google-Smtp-Source: ACHHUZ4LQl+sMom57SWJGat+dzZZHusXYWow4q9mi5ixXb7ZlaxbQEy8LL0FryAMBB6fCDIPDIoN5Q==
X-Received: by 2002:a05:620a:3d89:b0:75b:23a0:e7b8 with SMTP id ts9-20020a05620a3d8900b0075b23a0e7b8mr7648120qkn.25.1684966348958;
        Wed, 24 May 2023 15:12:28 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id u13-20020ae9c00d000000b0075783f6c2b4sm3550775qkk.128.2023.05.24.15.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:12:28 -0700 (PDT)
Date:   Wed, 24 May 2023 18:12:26 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] ext4: Fix fsync for non-directories
Message-ID: <ZG6Lyq4iq/HnBvPu@debian-BULLSEYE-live-builder-AMD64>
References: <20230524104453.8734-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524104453.8734-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Jan Kara <jack@suse.cz>:
> Commit e360c6ed7274 ("ext4: Drop special handling of journalled data
> from ext4_sync_file()") simplified ext4_sync_file() by dropping special
> handling of journalled data mode as it was not needed anymore. However
> that branch was also used for directories and symlinks and since the
> fastcommit code does not track metadata changes to non-regular files, the
> change has caused e.g. fsync(2) on directories to not commit transaction
> as it should. Fix the problem by adding handling for non-regular files.
> 
> Fixes: e360c6ed7274 ("ext4: Drop special handling of journalled data from ext4_sync_file()")
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Link: https://lore.kernel.org/all/ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/fsync.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> index f65fdb27ce14..2a143209aa0c 100644
> --- a/fs/ext4/fsync.c
> +++ b/fs/ext4/fsync.c
> @@ -108,6 +108,13 @@ static int ext4_fsync_journal(struct inode *inode, bool datasync,
>  	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>  	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
>  
> +	/*
> +	 * Fastcommit does not really support fsync on directories or other
> +	 * special files. Force a full commit.
> +	 */
> +	if (!S_ISREG(inode->i_mode))
> +		return ext4_force_commit(inode->i_sb);
> +
>  	if (journal->j_flags & JBD2_BARRIER &&
>  	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
>  		*needs_barrier = true;
> -- 
> 2.35.3
>

Hi Jan:

100/100 trials of both the original test regressions - generic/065 and
generic/535 - passed when I used kvm-xfstests to run them on a 6.4-rc3 kernel
modified with this patch.  A complete run of the adv test case also passed
without new regressions.

So,
Tested-by: Eric Whitney <enwlinux@gmail.com>

Thanks!
Eric


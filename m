Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D346472E1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 16:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLHP2T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 10:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLHP2S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 10:28:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698D11A02
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 07:28:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 130so1547910pfu.8
        for <linux-ext4@vger.kernel.org>; Thu, 08 Dec 2022 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZWhXfzDqYBvo0ufup8AdhAVNHX91O5QW/XRQGUfO5Y=;
        b=afMyvAVJK0sxO2NnckeJV6cuWUBbEyL+tglzLajt1A3laHimF/r3quUhPxFFURdLDQ
         xfek5h3su3lQhxbC9ykmrVSqqv5v/uU9RYkRl9VcZSooCKjcPdayJxN61qaNFt/SOHfz
         U5XGgoJ9V8Sb5ysarKXO4UIlJGnUJaarmpiVhVCji3Z8zkz8wuK17L62RkBXJFf5Z/5x
         I4UyRWiCK+ixaUMXO9EzdC2uD9T95LBcbupnEFSDikwWLPFPk2GrKpKptpJWvNUXN93T
         POL+uIQCsuWNTA/kxTnG50TlueYK6CEmTd+Zqhs9YK/5QK0q1xQjqX2bIxdtjYHzizsV
         zDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZWhXfzDqYBvo0ufup8AdhAVNHX91O5QW/XRQGUfO5Y=;
        b=YcHzKieUmtukRo9GSw1FYGSoCB4MlwdQnv2OZbkIRMg7d70m72oOgMSvSs2jwWOfHJ
         3SeAtD4jfd+Sa9XMQxjuJVgwH/ZM04aL3/Gudax7HNRlz0a1+WsoVrZqU+dPNAceU7rI
         csv6DgK3HYyuBfGbXRJP6dc0EFIlN7BLcKZUTJZvJJ60pyjHdbipSkn1a+drjJ/Z5APq
         d1VFetCoXSPgW9fsjiSX//NdD7yoE+DFHu3js7Otf91f/+TkMoM+RhKy7Amjq/X84MPR
         G3KrR1x+PH3ceTAQK6p3Tgb5XyinLQyFeNQCfwsldFJ9DmczzV9AzTgVB9siSpQ1KdGJ
         5VUQ==
X-Gm-Message-State: ANoB5pn/AtHiizUbd32N+gJH9jNDD7jKLZ8n8vHfoHNJIuMOi4RY9dJJ
        AYTd4/vIMY4UqoOilOaBxf8=
X-Google-Smtp-Source: AA0mqf60ACE872G38JMHCHRG0i1J2XCbLO/e1wq2ZMu64DGOcUD1HxzHPqgv7YFvMRGTrsEOAdQ6/A==
X-Received: by 2002:a62:524c:0:b0:576:b277:2cd with SMTP id g73-20020a62524c000000b00576b27702cdmr2408134pfb.34.1670513297065;
        Thu, 08 Dec 2022 07:28:17 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id g23-20020aa796b7000000b00575d1ba0ecfsm7243719pfk.133.2022.12.08.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:28:16 -0800 (PST)
Date:   Thu, 8 Dec 2022 20:58:11 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 09/13] jbd2: Switch jbd2_submit_inode_data() to use
 fs-provided hook for data writeout
Message-ID: <20221208152811.ftcepqs5x54nqtzo@riteshh-domain>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207112722.22220-9-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/07 12:27PM, Jan Kara wrote:
> jbd2_submit_inode_data() hardcoded use of
> jbd2_journal_submit_inode_data_buffers() for submission of data pages.
> Make it use j_submit_inode_data_buffers hook instead. This effectively
> switches ext4 fastcommits to use ext4_writepages() for data writeout
> instead of generic_writepages().

Very neat!! I agree, that jbd2_submit_inode_data() should have always used
journal->j_submit_inode_data_buffers().

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/fast_commit.c | 2 +-
>  fs/jbd2/commit.c      | 5 ++---
>  include/linux/jbd2.h  | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 0f6d0a80467d..7c6694593497 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -986,7 +986,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
>  			finish_wait(&ei->i_fc_wait, &wait);
>  		}
>  		spin_unlock(&sbi->s_fc_lock);
> -		ret = jbd2_submit_inode_data(ei->jinode);
> +		ret = jbd2_submit_inode_data(journal, ei->jinode);
>  		if (ret)
>  			return ret;
>  		spin_lock(&sbi->s_fc_lock);
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 885a7a6cc53e..4810438b7856 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -207,14 +207,13 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  }
>
>  /* Send all the data buffers related to an inode */
> -int jbd2_submit_inode_data(struct jbd2_inode *jinode)
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
>  {
> -
>  	if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
>  		return 0;
>
>  	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> -	return jbd2_journal_submit_inode_data_buffers(jinode);
> +	return journal->j_submit_inode_data_buffers(jinode);
>
>  }
>  EXPORT_SYMBOL(jbd2_submit_inode_data);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 0b7242370b56..2170e0cc279d 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1662,7 +1662,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
>  int jbd2_fc_end_commit(journal_t *journal);
>  int jbd2_fc_end_commit_fallback(journal_t *journal);
>  int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
> -int jbd2_submit_inode_data(struct jbd2_inode *jinode);
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
>  int jbd2_fc_release_bufs(journal_t *journal);
> --
> 2.35.3
>

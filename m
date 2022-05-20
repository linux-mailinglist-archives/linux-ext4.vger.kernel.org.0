Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0152E39C
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 06:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiETEYM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 May 2022 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242612AbiETEYL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 May 2022 00:24:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926F146775
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 21:24:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u15so6738072pfi.3
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 21:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Pi+8cfH6DfsGEdcum04TfEtI+zPbFA5e5bZDARN49U=;
        b=XT7M+hbhbVT8LLYnLtiurNtqa3Cw5FmvF0lYvklLwy6rC3qS4suvilT8yExDqKcy2R
         nBGgdKmDuKfkzGzGiQ+qFDzEirpXGm/OeqOCvyjzmh1ulT17RgGZ2uQGuc+0It50xvoo
         Xz+DB2fgRn1Ir0VeT41lKHz0V80H5b5k4Y6BBF0X6BynvIK6wqSJWaA3yHpdUmkxbN+K
         jR1H8qnl13/cQv0snptAPy0S3f1QxlFHZOR0ZsIYFWipCI9orejGfon58t2oggYQGJ2K
         DPyTwDXGb1Yu5BouiKLwYAQ1VHGD+Hczhs0KIYVF0M6c4lGlTG/WrSA+h8KWZGohgnOx
         ySgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Pi+8cfH6DfsGEdcum04TfEtI+zPbFA5e5bZDARN49U=;
        b=MjIkMKNifwmVY+QKslwJILV1LFhjWKEyFNbtByRX+DweirOtYe4ITqacOg9c3UCJ37
         Dq4T0XvY8FlyMcIlRLPUDFou1osZP+MaIRWkAGy5KYzSzd/CBoEU10vV32P66m8E+z+w
         OMzi83gnmceFiM1EhGEnkusFFKhyyfptGtX7qYkpnEVR/u1hyErgpKe2AG9jPZTgcxiC
         ZWzTMWccVwbqsSHgF8Upu00CnlMe9DtyFctt95Dvdjn66vFDeDD/NX5xDOThTaqO091J
         bLY6UHGaS9HZF4YtyYH0NPhknvU5Ul7WNhS1hYxqdoaquz8NN0U2pLGjeRe60Y5/odA+
         JBrw==
X-Gm-Message-State: AOAM5300I/RMbRZlfkoBMZZWHaykXoT2egigAExugj4QMWt3BvVfuq9L
        KGMQfmrj4tc+W2W2RNhcN4c=
X-Google-Smtp-Source: ABdhPJz0I5qwTXD3R8612WGynsRfsrvEvWt/3bRm1eiOjUZiyrmOBh4+IYk+7GwWZhd2o9eZBhoRnA==
X-Received: by 2002:a65:6205:0:b0:3f5:d436:5446 with SMTP id d5-20020a656205000000b003f5d4365446mr6694645pgv.532.1653020650414;
        Thu, 19 May 2022 21:24:10 -0700 (PDT)
Received: from localhost ([2406:7400:63:532d:c4bb:97f7:b03d:2c53])
        by smtp.gmail.com with ESMTPSA id b67-20020a636746000000b003f5eb31fc4bsm4321585pgc.11.2022.05.19.21.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:24:10 -0700 (PDT)
Date:   Fri, 20 May 2022 09:54:05 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: fix warning when submitting superblock in
 ext4_commit_super()
Message-ID: <20220520042405.xncu55ceekgrzhyu@riteshh-domain>
References: <20220520023216.3065073-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520023216.3065073-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/20 10:32AM, Zhang Yi wrote:
> We have already check the io_error and uptodate flag before submitting
> the superblock buffer, and re-set the uptodate flag if it has been
> failed to write out. But it was lockless and could be raced by another
> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> marking buffer dirty. Fix it by submit buffer directly.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v1:
>  - Add clear_buffer_dirty() before submit_bh().

Thanks for the patch.

Reviewed lock_buffer()/unlock_buffer(), get_bh/put_bh() and other possible error
paths, looks good to me.

Feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

-ritesh

>
>  fs/ext4/super.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1466fbdbc8e3..9f6892665be4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6002,7 +6002,6 @@ static void ext4_update_super(struct super_block *sb)
>  static int ext4_commit_super(struct super_block *sb)
>  {
>  	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
> -	int error = 0;
>
>  	if (!sbh)
>  		return -EINVAL;
> @@ -6011,6 +6010,13 @@ static int ext4_commit_super(struct super_block *sb)
>
>  	ext4_update_super(sb);
>
> +	lock_buffer(sbh);
> +	/* Buffer got discarded which means block device got invalidated */
> +	if (!buffer_mapped(sbh)) {
> +		unlock_buffer(sbh);
> +		return -EIO;
> +	}
> +
>  	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
>  		/*
>  		 * Oh, dear.  A previous attempt to write the
> @@ -6025,17 +6031,21 @@ static int ext4_commit_super(struct super_block *sb)
>  		clear_buffer_write_io_error(sbh);
>  		set_buffer_uptodate(sbh);
>  	}
> -	BUFFER_TRACE(sbh, "marking dirty");
> -	mark_buffer_dirty(sbh);
> -	error = __sync_dirty_buffer(sbh,
> -		REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
> +	get_bh(sbh);
> +	/* Clear potential dirty bit if it was journalled update */
> +	clear_buffer_dirty(sbh);
> +	sbh->b_end_io = end_buffer_write_sync;
> +	submit_bh(REQ_OP_WRITE,
> +		  REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0), sbh);
> +	wait_on_buffer(sbh);
>  	if (buffer_write_io_error(sbh)) {
>  		ext4_msg(sb, KERN_ERR, "I/O error while writing "
>  		       "superblock");
>  		clear_buffer_write_io_error(sbh);
>  		set_buffer_uptodate(sbh);
> +		return -EIO;
>  	}
> -	return error;
> +	return 0;
>  }
>
>  /*
> --
> 2.31.1
>

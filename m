Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4F63EF52
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLALUh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiLALUA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:20:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6CB68D4
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:16:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c15so1529404pfb.13
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHcYwxURcU3ptqMvibv/XNj5WHlLXMu0oI4DCB+Lfkg=;
        b=cKhQgwwKm+a0qiXQHlQlMAm0KkB5gEUfnsPI0U76yXkPysxRcguqhWDw2iNdua8Qaa
         7rYtaoZje+iZ1sZLJDxhZBAVHeZIZFu7FnvvZGtcpbwKV3E2t8Xcz3aEUSG7jFW1inGQ
         v/MlEg0oE+Mu5tS3MVNpaZXRci1rzOA70lYnQb8Uee9UyWO9Jh4dOBfr4tLmA4/AUoZa
         l3J/BdXNQQ8C3V8SO2Kg2fh806Wtoy1d5QqU8mif+VYa+C7sPQA/i4Oui7bUW6G3pgB4
         tJrO18frdxx/PnP6Wxz+QYAQUV90jLOmbqNrhKQntNMGkyg4JLj1ZM1hQGgklb4W3Lzx
         6VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHcYwxURcU3ptqMvibv/XNj5WHlLXMu0oI4DCB+Lfkg=;
        b=xNmlhY6+RXm/hXq/68TZql2qwCe4kyRtA8Qwqhf4PMMnYZPIEz2OndhuVzFl6c6ZKm
         8r7j9Pt/DidtAyemM7T6TNQUbG17sN5N6xfcK+te9wh8+PailUVGm9bsHI0dQT4Ocdtq
         6othVpznxO2suGogDyRsqqRTW1u09GwO7MN7Ad5qtnTEihr8ywgVEAs5MSlF6FHdYeD6
         oU1tbcC/s4NB2A9SOH76aBa/8FJX/RJZsmYAIyeEfjzzWLA8TsNFg+xkQRnY3hwdf9VT
         XJaHTAlxUTE4tRcssnQD5rzXvKNKyip/KZKvml5P9qV2Jhk88qcQsBqn6K/FK5mRc2D/
         4PlA==
X-Gm-Message-State: ANoB5pny8zyuUT/U4m8fqM1xXlgNYx7/hHLqfxqq2Ev3nyGmCNMScYz6
        41Dz1TErdR1+qN8mVo8gUvlfiuNMNBI=
X-Google-Smtp-Source: AA0mqf6dbAcC1mhPEumslbtlaygIoHoRG2mUHW/9bFXmUU6NYaS7EZaLAPjCjHhAsP3Nkigo+3OvrA==
X-Received: by 2002:a62:3245:0:b0:575:4413:308a with SMTP id y66-20020a623245000000b005754413308amr17878242pfy.32.1669893414035;
        Thu, 01 Dec 2022 03:16:54 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709027c9500b00186985198a4sm3352258pll.169.2022.12.01.03.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:16:53 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:46:48 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 7/9] ext4: Move percpu_rwsem protection into
 ext4_writepages()
Message-ID: <20221201111648.ifuumk2m244yx2mr@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-7-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/30 05:35PM, Jan Kara wrote:
> Move protection by percpu_rwsem from ext4_do_writepages() to
> ext4_writepages(). We will not want to grab this protection during
> transaction commits as that would be prone to deadlocks and the
> protection is not needed. Move the shutdown state checking as well since
> we want to be able to complete commit while the shutdown is in progress.

Yup. Sounds good. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fbea77ab470f..00c4d12f8270 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2718,10 +2718,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  	struct blk_plug plug;
>  	bool give_up_on_write = false;
>
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> -		return -EIO;
> -
> -	percpu_down_read(&sbi->s_writepages_rwsem);
>  	trace_ext4_writepages(inode, wbc);
>
>  	/*
> @@ -2930,20 +2926,28 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  out_writepages:
>  	trace_ext4_writepages_result(inode, wbc, ret,
>  				     nr_to_write - wbc->nr_to_write);
> -	percpu_up_read(&sbi->s_writepages_rwsem);
>  	return ret;
>  }
>
>  static int ext4_writepages(struct address_space *mapping,
>  			   struct writeback_control *wbc)
>  {
> +	struct super_block *sb = mapping->host->i_sb;
>  	struct mpage_da_data mpd = {
>  		.inode = mapping->host,
>  		.wbc = wbc,
>  		.can_map = 1,
>  	};
> +	int ret;
> +
> +	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
> +		return -EIO;
>
> -	return ext4_do_writepages(&mpd);
> +	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
> +	ret = ext4_do_writepages(&mpd);
> +	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
> +
> +	return ret;
>  }
>
>  static int ext4_dax_writepages(struct address_space *mapping,
> --
> 2.35.3
>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E1523329
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiEKMba (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiEKMba (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 08:31:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA09A0BCA;
        Wed, 11 May 2022 05:31:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c9so1762588plh.2;
        Wed, 11 May 2022 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjzOeWrxTpq1GmqSeFDQGiycbPYhik+3zIQ7m/MZAPI=;
        b=Rg19OR7srAQTS284Ntvs2UQoBum2j6UFTuNAe2Oju5MTsg7BZ48eXQ83OYdW9aeY6B
         iYMn/TKdBNNJ7qfv74EO6cGU8YRpPcd9eNeCdGyn2NHHw21qGahc2wyNis8dCYtu9X2e
         WOU2oGiU+5pp4X+UkbmgKx4IA/vWnCVWzVPckSqRB7wwgGnBaVw0PTYT9lnHu1WSOpuW
         OzHJE6LqSaZpsvvYiaOFuh2VP9ZyUyDvu4CKfdxeIh1MeN7RLOmBgBydYGavjkztLlXP
         IHmnWR3sAEQMNseJ/hs+Oxn0O6xh3hDUnDquYTNHIvaOvz0+JLy8t9c38Vw9IrJSXs+A
         O5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjzOeWrxTpq1GmqSeFDQGiycbPYhik+3zIQ7m/MZAPI=;
        b=q99MMNdn+wKafIL8oNdqib52WUYelCR2xBZ5pgY+fiR+2FAoVG7QjX9fbY8BCBYWH/
         EonHIB6LFuVr37z73YTQd2mV9BkbSKZzPJXpkRt2WGV1oPV8hywCFlWXPnClYG2BGRXr
         oos8WHYQOtwAfZ77G7SGVkDM608V6ykX8g3eAdgiVAHv8o6g9XuZhEjqgEl0FEEX7YVk
         oo6TcmScsO/LOn+LyQP7XyJpt1S3K44HIj61oCx/rR5WEjWPoxnthPQ12IHIl96/PUCp
         hgSQsvDIIFNQ1NEuTV5S1jnNFuAfwlmZq8Qe//j4Rqkl8JchLpDf6sfI1J0U4jtvIPX0
         mcvw==
X-Gm-Message-State: AOAM530UZxA7cgrNXeVEp1HHyMhGLikaFQMm6PvLpXQdu70Mfyv89Npp
        h3/rRohUM+qD/zLpEIP3LB0=
X-Google-Smtp-Source: ABdhPJycTQsxAcxbPU8JYSK1lFpoi5BwoFx80k16SyXudGpjZPyygTl4+HJhy6Jkn5as2VOhjNr84Q==
X-Received: by 2002:a17:902:82c8:b0:15c:f7c7:ef9d with SMTP id u8-20020a17090282c800b0015cf7c7ef9dmr25109043plz.44.1652272288153;
        Wed, 11 May 2022 05:31:28 -0700 (PDT)
Received: from localhost ([2406:7400:63:532d:2759:da01:e9ea:1584])
        by smtp.gmail.com with ESMTPSA id h10-20020a65468a000000b003c14af505f4sm1664877pgr.12.2022.05.11.05.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:31:27 -0700 (PDT)
Date:   Wed, 11 May 2022 18:01:22 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH] ext4: reject the 'commit' option on ext2 filesystems
Message-ID: <20220511123122.x3k5zb5txbk6cqrn@riteshh-domain>
References: <20220510183232.172615-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510183232.172615-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/10 11:32AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> The 'commit' option is only applicable for ext3 and ext4 filesystems,
> and has never been accepted by the ext2 filesystem driver, so the ext4
> driver shouldn't allow it on ext2 filesystems.

Yes indeed.

Although with -o commit=1 it doesn't mount due to extra checks when commit is not
equal to it's default value where it also checks if the fs has journal or not.

[19084.421413] EXT4-fs (loop2): mounting ext2 file system using the ext4 subsystem
[19084.422679] EXT4-fs (loop2): can't mount with commit=1, fs mounted w/o journal


But when mounted with -o commit=5, ext2 gets mounted w/o this patch ;)

[19146.337981] EXT4-fs (loop2): mounting ext2 file system using the ext4 subsystem
[19146.345082] EXT4-fs (loop2): mounted filesystem without journal. Quota mode: none.

Feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

-ritesh

>
> This fixes a failure in xfstest ext4/053.
>
> Fixes: 8dc0aa8cf0f7 ("ext4: check incompatible mount options while mounting ext2/3")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/super.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1847b46af8083..69d67724df24f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1913,6 +1913,7 @@ static const struct mount_opts {
>  	 MOPT_EXT4_ONLY | MOPT_CLEAR},
>  	{Opt_warn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_SET},
>  	{Opt_nowarn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_CLEAR},
> +	{Opt_commit, 0, MOPT_NO_EXT2},
>  	{Opt_nojournal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
>  	 MOPT_EXT4_ONLY | MOPT_CLEAR},
>  	{Opt_journal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
>
> base-commit: 23e3d7f7061f8682c751c46512718f47580ad8f0
> --
> 2.36.1
>

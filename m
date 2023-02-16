Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE96A6994F9
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBPM4Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBPM4Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 07:56:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6773B847;
        Thu, 16 Feb 2023 04:56:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso2033889pjr.4;
        Thu, 16 Feb 2023 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5uLxxAt1ljwWqmXONXKUPp+QdMkYHsgDw8e0EV5+AU=;
        b=m4pNmWr7rds7BV7QB0xxpZus62p6R7ILZN+h+harWtql5hJOJpuKYw4vfjQABQlLYu
         LHY4DiPW9+hRDenhX4Jxb0d0Oio8nERRiKfgXRVYZbhNqjkdFiwe/CncnHKPfJnleFXc
         S7c3maENz9Z4CdTpWLpvECKgQHczp1OY/0WwxelalFGPrvBJh/1cSQHi2NNu6dURItT7
         Fk/DysIOnHdagmMbQm/K6+JMVNJciVrrYFSzt8sYg52M2RmNXH6gtsgTaOycprBYHlfC
         xcE/FWC0EXowWWLSq+7UWeCX1f+JLLuHWf3gtjxD2ODqp6GLfZvpy4cR5pVH29LBxpDI
         jv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5uLxxAt1ljwWqmXONXKUPp+QdMkYHsgDw8e0EV5+AU=;
        b=d/Kz+ZlRpVy8Zzwh4R1miHBL66wfrbzPGiu1vYwrmy4cYspoyGVVZn5+0U1kp7QhA8
         Qd/hXXYTUpyIYx+OYMiSAsxFkwKW2W5UIebrSYQIMHoE1GG26iKSPDGAuLxVca50X88R
         RgHwYR0ysbU7IsEzS27vrUW35enxfZJqzgzRjsHeHeT80Zevd6Ui/abW1DIqIoGoQylG
         Q3IBDSYeMk/kH3JQJgUBjIWvb19L/oogWqvserNrZcJ4mAk1UAb4MVE3cN6+iZcPsVto
         T0MNIPsfhI+oGGQC6/wPJDlt4x+QOEUkYGMgnPHcqLg3kZJb0mpm2nfP1JvQs0QS3eRX
         JcYA==
X-Gm-Message-State: AO0yUKXdh7V3eClitiXmMPiaXfns/xIQSFZR0SLGNUhaLOplIHse6rRJ
        NSTfOVc5+F3lWZ5g+JOJUIfmH8+VdQK/Mg==
X-Google-Smtp-Source: AK7set+GaqUZgWcghReafNaeoZKhSynIUfvF9gk9GajRQDSqWNqWIdLCYpBajxbMqtfaLucfYxp+dg==
X-Received: by 2002:a17:902:c944:b0:196:88b8:8616 with SMTP id i4-20020a170902c94400b0019688b88616mr6996275pla.5.1676552173342;
        Thu, 16 Feb 2023 04:56:13 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id cp18-20020a170902e79200b001990713589csm1259651plb.80.2023.02.16.04.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:56:12 -0800 (PST)
Date:   Thu, 16 Feb 2023 18:26:07 +0530
Message-Id: <87k00hn508.fsf@doe.com>
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Li kunyu <kunyu@nfschina.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] ext4: ialloc: Remove variables defined more than once in a function
In-Reply-To: <20230207233632.4723-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Li kunyu <kunyu@nfschina.com> writes:

> The grp pointer variable has been defined at the beginning of the
> function. It is not necessary to define it here, so remove the variable
> definition here.
>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  fs/ext4/ialloc.c | 1 -
>  1 file changed, 1 deletion(-)

Looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 63f9bb6e8851..be9f742f9415 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1181,7 +1181,6 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  	/* Update the relevant bg descriptor fields */
>  	if (ext4_has_group_desc_csum(sb)) {
>  		int free;
> -		struct ext4_group_info *grp = NULL;
>
>  		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
>  			grp = ext4_get_group_info(sb, group);
> --
> 2.18.2

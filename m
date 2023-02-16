Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3B6993EA
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 13:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBPMJn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 07:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBPMJm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 07:09:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF755E40
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 04:09:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x13so1086269pfu.7
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 04:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+krQSA7TTnpJ7d2VCvrm06Gx5EGKU4czsXu7Rn6KGw=;
        b=ZbdrCNiRlm4gnzMAracif8uFx+9gpo6buuqr8XRndfJfcKAMOX+A1MkbeZPDgpsJVm
         LDybHci+kVcEzAsNIqNCzphv0r752/8Jzd30C3ew/p+8Yy+WHz2GiPBePskruW/DjRiJ
         0f9mjnwRHpBZKfVV7KJlyNIWZ5YYhV+T2S3bFCIG1PQezTKEWRUjRa+So2YTKTSgVo4d
         HKZGwFOl6r0574Gr8Uvhqk/7hRBsSXbkKY2mkxxPQmZmhhVozcsN87sX9XpavtQdFolj
         tOd9nwhIjF13sCHZilPcc1/2WQyh1wtX7gKcd0lnzN4ma/cEHknGMDrcry7A/jM+oiFT
         UK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+krQSA7TTnpJ7d2VCvrm06Gx5EGKU4czsXu7Rn6KGw=;
        b=i3udtk29tid/6VlSKBPkTDtG3UE03lBoeo9ZnbBDVB0Pf3rl9wVZUeGpqNw6ezgx5I
         3NDc0yxOZZqC94RfgS1ux6rNs5ihL4Z+E3mUevFV2EN/RcNiPXnwZvCh4sUCNcMh917A
         NDCKY1jdMzRfh3BYpiwIL/kqgYCKqkUyPKE0Ez0VTrBLf24+EMlHO2eWmaDVIsz2oCwu
         /RRFXt0CfjTurkFLfuvUwsKW66tCgOfo7DUROc6LpJVEk2vhs9nIv2D+s9VHQlbesYqU
         2EUwRqc/ODxflcpyLuIkEuaRVNMuOoAeTfr184UesfdM/3VSYP2ttvBALR6IcP4QvTz9
         oztQ==
X-Gm-Message-State: AO0yUKUCtbwpWAhRvTp8SnCHaO8PdQyrxX2pLoX5GRu+t9Dj3dCZ1EKJ
        ZtCZ/7ZE8aQrOQOG0w/FqHVBX/Fxy1k6nA==
X-Google-Smtp-Source: AK7set/R0xNU9Ty+7JzUET3AdxeivuDSpScJ+b34zh1uklOgX5t0/hZn5ZLEowxTpQfMtMaHB9RgiA==
X-Received: by 2002:a62:52c6:0:b0:5a8:bdc8:3d0e with SMTP id g189-20020a6252c6000000b005a8bdc83d0emr5027098pfb.19.1676549380534;
        Thu, 16 Feb 2023 04:09:40 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78dc3000000b005a8c92f7c27sm1142750pfr.212.2023.02.16.04.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:09:40 -0800 (PST)
Date:   Thu, 16 Feb 2023 17:39:02 +0530
Message-Id: <87mt5dn76p.fsf@doe.com>
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: fix RENAME_WHITEOUT handling for inline directories
In-Reply-To: <20230210173244.679890-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Whitney <enwlinux@gmail.com> writes:

> A significant number of xfstests can cause ext4 to log one or more
> warning messages when they are run on a test file system where the
> inline_data feature has been enabled.  An example:
>
> "EXT4-fs warning (device vdc): ext4_dirblock_csum_set:425: inode
>  #16385: comm fsstress: No space for directory leaf checksum. Please
> run e2fsck -D."
>
> The xfstests include: ext4/057, 058, and 307; generic/013, 051, 068,
> 070, 076, 078, 083, 232, 269, 270, 390, 461, 475, 476, 482, 579, 585,
> 589, 626, 631, and 650.

So, I guess since these were only ext4 warnings hence maybe these were
getting ignored? Because the tests were never failing?
Should we do something for such cases? Maybe adding this warning
detection in xfstests to fail the test case when these warnings are not
intended? e.g. such warnings should make the test fail by saying
something detected in dmesg. Except when these are expected for I/O error
injection tests, etc...

>
> In this situation, the warning message indicates a bug in the code that
> performs the RENAME_WHITEOUT operation on a directory entry that has
> been stored inline.  It doesn't detect that the directory is stored
> inline, and incorrectly attempts to compute a dirent block checksum on
> the whiteout inode when creating it.  This attempt fails as a result
> of the integrity checking in get_dirent_tail (usually due to a failure
> to match the EXT4_FT_DIR_CSUM magic cookie), and the warning message
> is then emitted.
>
> Fix this by simply collecting the inlined data state at the time the
> search for the source directory entry is performed.  Existing code
> handles the rest, and this is sufficient to eliminate all spurious
> warning messages produced by the tests above.  Go one step further
> and do the same in the code that resets the source directory entry in
> the event of failure.  The inlined state should be present in the
> "old" struct, but given the possibility of a race there's no harm
> in taking a conservative approach and getting that information again
> since the directory entry is being reread anyway.

Thanks for the detailed explaination. This makes sense to me.

>
> Fixes: b7ff91fd030d ("ext4: find old entry again if failed to rename whiteout")

So for your changes in ext4_resetent(), your above fixes tags make sense.
But what about the changes in ext4_rename() function. That was always
passing NULL as the last argument since the begining no?
Thinking from the backport perspective if and when required ;)


>
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> ---
>  fs/ext4/namei.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index dd28453d6ea3..924e16b239e0 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1595,11 +1595,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
>  		int has_inline_data = 1;
>  		ret = ext4_find_inline_entry(dir, fname, res_dir,
>  					     &has_inline_data);
> -		if (has_inline_data) {
> -			if (inlined)
> -				*inlined = 1;
> +		if (inlined)
> +			*inlined = has_inline_data;
> +		if (has_inline_data)
>  			goto cleanup_and_exit;
> -		}
>  	}

This looks like a nice cleanup!!

>
>  	if ((namelen <= 2) && (name[0] == '.') &&
> @@ -3646,7 +3645,8 @@ static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
>  	 * so the old->de may no longer valid and need to find it again
>  	 * before reset old inode info.
>  	 */
> -	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
> +				 &old.inlined);
>  	if (IS_ERR(old.bh))
>  		retval = PTR_ERR(old.bh);
>  	if (!old.bh)
> @@ -3813,7 +3813,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			return retval;
>  	}
>
> -	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
> +				 &old.inlined);
>  	if (IS_ERR(old.bh))
>  		return PTR_ERR(old.bh);
>  	/*
> --
> 2.30.2

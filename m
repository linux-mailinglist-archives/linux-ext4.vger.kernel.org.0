Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1287AFEFE
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjI0Iww (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 04:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjI0Iwv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 04:52:51 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE2A3;
        Wed, 27 Sep 2023 01:52:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ae5eec2a89so1112595b6e.3;
        Wed, 27 Sep 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695804768; x=1696409568; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bURqcdHJsNIwzVa6YJPI+rjQkbntkKFJfbgKAVXssiM=;
        b=iRHtsaGFbIWJwG7mZVSZb6MuWbaHPTsGTinmCDIxBMXtQfUs6rJc7otW6koO1Nzhm2
         EHA5T9z6x8u6ScxjkDTaF7nZkyaY/L2yQImDJlYUBtIGzasJdQPluzfYJPpcdpBJtf9I
         FHjGBI5xuxUvAnn2KdzaPqCyR20YSfOi6PQs9rWS7LUq9DQpfDv9mNxXwhVosTnpWVtD
         oi9M13Q+t9z+/arXSHeh/AI+PjP8neKa5ipyZL80wGC8onw1mMmcQUMsyZfudcaYTkEQ
         honzrtjjPpYGdHQvkbn2rPw6rehxvAEj9NEUrp9VO2w87Ez2BA6GMfG5JjFesZwewVqq
         Srng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804768; x=1696409568;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bURqcdHJsNIwzVa6YJPI+rjQkbntkKFJfbgKAVXssiM=;
        b=QHbBjKQ5lM+BtfyZFk/6DW0NJihRXyzFSKf3RriA0hOPozpsw5IKz+/m5oufYulkyF
         5lH76JkzSTbFqPJ7KJWfqSgkGuH4YI1XRNzRynvHJzQIyTKDOCeNU0Yym5amOIcwdJ9W
         hF/zWJ8h58+sjrQQWAXAMQjNUASGWvyqjW5uiB42l/VIvcxBbt8EjSf6r1kZyXs5UmtC
         OyNM22qCKVzvnQV4IHUU3ly6UBYZdUQ7XhKGxFpY/gdvrOx/spZO+g61xydj1CFtNtrW
         JA395JKl8p+KGIsBOi1/fjmBPFpQ/cL90tiH1tA83HPD0HdVjFckDASJXKKk66k/YeCJ
         txjA==
X-Gm-Message-State: AOJu0Yx/5IlMDxFjTeItya1avPox3z6HMrx3BlwXrzGtZ5cN2WszX3n4
        3BOT1bdeR4XDUA8VJ6KO/O0uZ8jX358=
X-Google-Smtp-Source: AGHT+IHfXYF4x2bhlaj5FqkJYnvnLh+hSJZ/V/+zrHtG282CAjL8gJ6/GcMU/dgjJ3WX/pPDdhVMoA==
X-Received: by 2002:a05:6808:2a44:b0:3a8:5133:482d with SMTP id fa4-20020a0568082a4400b003a85133482dmr1409769oib.35.1695804768192;
        Wed, 27 Sep 2023 01:52:48 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id i17-20020aa78b51000000b0066a4e561beesm11720242pfd.173.2023.09.27.01.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:52:47 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:22:43 +0530
Message-Id: <87wmwcf15w.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/12] ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
In-Reply-To: <20230919201532.310085-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> call ext4_mb_mark_context in ext4_free_blocks_simple to:
> 1. remove repeat code
> 2. pair update of free_clusters in ext4_mb_new_blocks_simple.
> 3. add missing ext4_lock_group/ext4_unlock_group protection.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e1320eea46e9..cd2fd5dbfcdd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6393,43 +6393,12 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  					unsigned long count)

This might need some auditing later (need not be as part of this series)
on why it is an unsigned long. I think it is just a left over and an
unsigned int should be sufficient.

But either ways this patch looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

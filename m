Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E864D75CC49
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGUPpT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGUPpS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:45:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C96DE6F;
        Fri, 21 Jul 2023 08:45:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6689430d803so1362383b3a.0;
        Fri, 21 Jul 2023 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954317; x=1690559117;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVdGCA8NgKdzDjnSykaUKAP1UPdOYKobVXohrzvoh4g=;
        b=FxPsOEuMjqZ3o2q82EBr2WD3SAdhAE8/mbitwFxBdbcy8rhcgxTP5SWa3+rHCyJyJs
         /F0/5V/tHfLnDYxTPc4blxR/hJgc+BJSi0gQWbePZbO526Mwp52QYrkDhf1QE7LHQCYy
         k0iKaSc9H+0DmAw0yDhgpe08yRwMIvCLnA9sCVqj4BvupZwWwsRJg5W9jIe8qfviB0OT
         GkDoF7S/7zRFyrvWVWH0hH0saTjdcbUCGPQjskxcw2wckeRJivVWd58nRnfUCC0DMM9Q
         nVvkh+M+AwzxJDHmoS1PtqA1ww9SS/Za378caFUtHz0aMG3UTs0na+elIJL+LO0drz/C
         ac6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954317; x=1690559117;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVdGCA8NgKdzDjnSykaUKAP1UPdOYKobVXohrzvoh4g=;
        b=i2LCAwnN//sq7A5cXQeZtBB224Ok3EOoMo8upb9KQ6JKomDEi/XZ1t+RJKz4gje9Rv
         KhWvKIB5miLOcj7CD0MNOjAR7r+aBYtGhhdJiAKcQdtXA4hCh+CSFBrUA2sEkG2kARXl
         auq89wkldVFgx3nPTF8ROGMI+tFTtaQk8xpnJunDnxeC3LFtlSTAeQbozFMyasjSYgd7
         FG3/0Fl1BmGNfKE3uoTkhfxAV282APdgTLD+ooRoG8JfHwcymY9ObCv6yyjNrFtp7XH4
         psAvaFFY//KKXn9zr52ljd3VIzI8+yaAik+aiNhdGss22R+3Vn3zPggwxU0jpzZzMGwx
         VG0A==
X-Gm-Message-State: ABy/qLaqDEj44vH54aMRi0plaTuS2LMOg+9IluPACw6RETeXGBOdpg/6
        9GeIJUvb6C3CCQEHIwRfbl1onatIAUg=
X-Google-Smtp-Source: APBJJlF4ggg9Mt4oG1vy1AHPXHLaszoAHfyMvPmsAinNMUSDqQ97lk8P7BwsOJRWxSDv+cSnyDv1Tg==
X-Received: by 2002:a05:6a20:2451:b0:12d:a04c:7e8b with SMTP id t17-20020a056a20245100b0012da04c7e8bmr2302419pzc.40.1689954317115;
        Fri, 21 Jul 2023 08:45:17 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709028a8100b001b3ce619e2esm3626905plo.179.2023.07.21.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:45:16 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:15:13 +0530
Message-Id: <871qh1l14m.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 07/10] ext4: remove unused ext4_{set}/{clear}_bit_atomic
In-Reply-To: <20230721171007.2065423-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Remove ext4_set_bit_atomic and ext4_clear_bit_atomic which are defined but not
> used.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/ext4.h | 2 --
>  1 file changed, 2 deletions(-)
>

Looks good to me, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh


> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0a2d55faa095..7166edb2e4a7 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1252,10 +1252,8 @@ struct ext4_inode_info {
>  
>  #define ext4_test_and_set_bit		__test_and_set_bit_le
>  #define ext4_set_bit			__set_bit_le
> -#define ext4_set_bit_atomic		ext2_set_bit_atomic
>  #define ext4_test_and_clear_bit		__test_and_clear_bit_le
>  #define ext4_clear_bit			__clear_bit_le
> -#define ext4_clear_bit_atomic		ext2_clear_bit_atomic
>  #define ext4_test_bit			test_bit_le
>  #define ext4_find_next_zero_bit		find_next_zero_bit_le
>  #define ext4_find_next_bit		find_next_bit_le
> -- 
> 2.30.0

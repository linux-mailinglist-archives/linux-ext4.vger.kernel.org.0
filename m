Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586FB5B7595
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Sep 2022 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiIMPve (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiIMPvO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 11:51:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D18C027
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 07:53:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 9so897731pfz.12
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ztOqYv4ndjlIzKClXMEq9+9leEx2gKczJi6c9lLCyWE=;
        b=OsSZvp4rlCdiEE0mY6RTuErweKMSAFcTNXaltcl5FBUKkuBAIA/MiF3A/HE+fOYtPg
         tHYaMq5qhYNOOIitvmarUwG+Imzb8Qfnaa8AugVQaHhnm+rFCPh8TYsq0ZhOyn7JSRxa
         iaU0+v4qS0WhTswYRnJiW28VxCU8PQ8OGBWcfT/OPTAflQCQwd1pHYxKOSTgNd0HH1oR
         URJh1SJMN2M1OveW30iTGbKrAtiLI4HTciL31Ke5pUIC1TmXQN/1nIPg3ZdEGhTUfjfE
         z5DN3fYlJ+bPyr9s3r+H6nv56F28RbtHUFtEwdng0QjqYLoyG4mMeJmZxX8ihtQieWJL
         u/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ztOqYv4ndjlIzKClXMEq9+9leEx2gKczJi6c9lLCyWE=;
        b=BZjmpcBfU2zKXjpZ0+f+2Fzcntrgj0gLfeLO8yDbAAI2G+7Kbdbvm3m2IqaDibikya
         wnW3Jdc0jMWpbAopsmSab9q4zNyhcJWB81tFe0iyfPgbDVextYR0BTF/0vMLjAG1brb6
         wkhX5RRtxS47et8+w/dfn4iEDsoigCyXwdh2pTDT8Hv4BfQr3xs8gfRH2n/jRYd7Xd/f
         OyE3HjofP7nPuAkiinYkBF1HKFoqOLI8yyNKx2PtxEAh1sT31Y3ReTapyPA80Yfx+/vK
         4wum/7K9CcNCpZKI1fstdSRyPZkDneRafLO+IcbgoIiU5TY5KLaYiibjJd3fGTDoVXVR
         WCIA==
X-Gm-Message-State: ACgBeo0uSu7BXjQHV2miPiljlIz162oVAuCMRG8CPStJ4THBN3TdZZhn
        /qArq55FxMFFJflqlsYgsl0mHbvVKos=
X-Google-Smtp-Source: AA6agR7QD6yMj3Xm7C13HV8CgeaV+59eGuqr/B6Q84tyyqWP4dowsKBb4Fp1NLCBC5sqk2fZBKGIhA==
X-Received: by 2002:a05:6a00:24d4:b0:544:abd7:c944 with SMTP id d20-20020a056a0024d400b00544abd7c944mr8074116pfv.44.1663080656534;
        Tue, 13 Sep 2022 07:50:56 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c09a0ef87sm8314684plg.255.2022.09.13.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:50:56 -0700 (PDT)
Date:   Tue, 13 Sep 2022 20:20:50 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/ext2: remove unused variable es
Message-ID: <20220913145050.6si6rhpdtsem6vwl@riteshh-domain>
References: <20220913071141.94082-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913071141.94082-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/13 07:11AM, Yuan Can wrote:
> The variable es is never used, remove it.
> No functional change.
> 
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  fs/ext2/ialloc.c | 2 --
>  1 file changed, 2 deletions(-)

Hi Yuan,

Thanks for the patch - 

However while reviewing this, I also looked at ext2_count_free_blocks(). 
And then I felt maybe the right thing to do is to print more info when
EXT2FS_DEBUG is enabled which would be to dump both stored counters in the debug message 
i.e. (from ext2_super_block -> s_free_**_count, and from ext2_sb_info -> s_free**_counter)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c17ccc19b938..87c57ddcd2ed 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1475,8 +1475,10 @@ unsigned long ext2_count_free_blocks (struct super_block * sb)
                bitmap_count += x;
                brelse(bitmap_bh);
        }
-       printk("ext2_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
-               (long)le32_to_cpu(es->s_free_blocks_count),
+       printk("ext2_count_free_blocks: stored = %lu, %lu, computed = %lu, %lu\n",
+               (unsigned long) le32_to_cpu(es->s_free_blocks_count),
+               (unsigned long)
+               percpu_counter_read(&EXT2_SB(sb)->s_freeblocks_counter),
                desc_count, bitmap_count);
        return bitmap_count;
 #else
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 998dd2ac8008..436d5c4d61c0 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -643,7 +643,8 @@ unsigned long ext2_count_free_inodes (struct super_block * sb)
                bitmap_count += x;
        }
        brelse(bitmap_bh);
-       printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
+       printk("ext2_count_free_inodes: stored = %lu, %lu, computed = %lu, %lu\n",
+               (unsigned long) le32_to_cpu(es->s_free_inodes_count),
                (unsigned long)
                percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter),
                desc_count, bitmap_count);

@Jan, 
Please do let me know your thoughts on this. This doesn't changes the functionality, 
since the return value remains the same. But it dumps both stored counter values
in debug output, which is what I think the intended behaviour of the print
should be in the first place. 

If this looks correct to you - I can send an official patch fixing this.

-ritesh

> 
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index 998dd2ac8008..951b80a7f7d2 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -620,11 +620,9 @@ unsigned long ext2_count_free_inodes (struct super_block * sb)
>  	int i;	
>  
>  #ifdef EXT2FS_DEBUG
> -	struct ext2_super_block *es;
>  	unsigned long bitmap_count = 0;
>  	struct buffer_head *bitmap_bh = NULL;
>  
> -	es = EXT2_SB(sb)->s_es;
>  	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
>  		unsigned x;
>  
> -- 
> 2.17.1
> 

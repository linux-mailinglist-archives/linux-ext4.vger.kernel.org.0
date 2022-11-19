Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3259630B4F
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Nov 2022 04:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiKSDrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 22:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiKSDq6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 22:46:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40697BF823
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 19:46:48 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c203so6622812pfc.11
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 19:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02Dgr7M/H8CKyAVlztKKJ0BZUJ7H9+BSz6Rkfh0BD50=;
        b=VBcBsFS/aB8yXwkr31/t11Oh2grfVVq63nL8nM/Qwhi63tzH824KVPJTfWWdXxZF9T
         N8yKpRC4QpdVEeVC6xjAzjt5xD+lsBOIhQSvxQuXtV+Hwm96ba5/zZNC8PlLmS+oTy1W
         bqKKj2JT3L0sPRW7HzSLd5yeh6vGkzNQzjdGtsrTqWos2L79wPSXWLiTluwA4wdDwdJI
         5WXVBhvcgiE+m/Dkh7LApwsmAYYOnJ8ICQKd1nKPWYd2OWCEG0LdkikrZsfGZDUfaFcp
         19+tR8U3+C7oTzM/xKOn9jIONOtBP7sf9K5F+igZzz1i11SV9UvQt0z/2Czhw4Mo5q/2
         8Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02Dgr7M/H8CKyAVlztKKJ0BZUJ7H9+BSz6Rkfh0BD50=;
        b=KqxtJLBsw7KXnFre/ldabswlsCjUzlNFuUX398c1ulbZFFo9krYDWWuZZm4St6woO4
         4GFPSjXhYa016iVKyn1p9MHRuUMkMyHfzHrJPMRSvI1Ygd7bJ+pKD16GOzBlPCFUYIjO
         Bdx+6BLsa93GeQchdnNg36EW4Bo1xTJUJoiUhKDbOrUCAK/22J5fybl+CpMMcW4pJ/Ou
         1DN1dsES6EUoNvz6qpLI3fyCJLJ2A8cIAbtbEmKIPijmVdbvrpfvcYBDKNYwe1FoA3u6
         ug2HdrKfjKmvwM3xUs2jzc+cMfPP2GOuzXj6j/Yt5rkPxhVUQojKAafIZ2juCz6NatfI
         IYow==
X-Gm-Message-State: ANoB5pldetWqT7jj7UnRfTN0A8/Gh2EymYuQVxmtN3hblCor14z0nj3l
        JNCg0P6NFvy3aIh6Lsh+toY=
X-Google-Smtp-Source: AA0mqf5d8pP3b4qCdsf8FgT6AMR/kaz3FeF+7/SwrHjwrPQc85i15a6sD+1uIF1ZjASiOs2WCOsULA==
X-Received: by 2002:a63:ff64:0:b0:476:fc21:a0a2 with SMTP id s36-20020a63ff64000000b00476fc21a0a2mr9562039pgk.371.1668829607623;
        Fri, 18 Nov 2022 19:46:47 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id s12-20020a63f04c000000b0047681fa88d1sm3538330pgj.53.2022.11.18.19.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:46 -0800 (PST)
Date:   Sat, 19 Nov 2022 09:16:41 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Message-ID: <20221119034641.umvdsnwlhykb3gpv@riteshh-domain>
References: <20221118113711.qby7gtky5k36f7vd@riteshh-domain>
 <1BEDD834-2D4A-4E8E-936C-90DB5E322F9C@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1BEDD834-2D4A-4E8E-936C-90DB5E322F9C@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/18 07:20AM, Andreas Dilger wrote:
> On Nov 18, 2022, at 05:37, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> > ﻿On 22/11/18 04:34AM, Andreas Dilger wrote:
> >>> On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> >>> 
> >>> f_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=yes due to unbalanced
> >>> mutex unlock in below path.
> >>> 
> >>> This patch fixes it.
> >>> 
> >>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >>> ---
> >>> lib/ext2fs/unix_io.c | 1 -
> >>> 1 file changed, 1 deletion(-)
> >>> 
> >>> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> >>> index e53db333..5b894826 100644
> >>> --- a/lib/ext2fs/unix_io.c
> >>> +++ b/lib/ext2fs/unix_io.c
> >>> @@ -305,7 +305,6 @@ bounce_read:
> >>>   while (size > 0) {
> >>>       actual = read(data->dev, data->bounce, align_size);
> >>>       if (actual != align_size) {
> >>> -            mutex_unlock(data, BOUNCE_MTX);
> >> 
> >> This patch doesn't show enough context, but AFAIK this is jumping before mutex_down()
> >> is called, so this *should* be correct as is?
> > 
> > Thanks for the review, Andreas.
> > 
> > Yeah, the patch diff above is not sufficient since it doesn't share enuf
> > context.
> > But essentially when "actual" is not equal to "align_size", then in this if
> > condition it goes to label "short_read:", which always goto error_unlock,
> > where we anyways call mutex_unlock()
> > 
> > Looking at a lot of labels in this function, this definitely looks like 
> > something which can be cleaned up ("raw_read_blk()"). 
> > I will add that to my list of todos. 
> 
> You are correct, and it means this code is just not very clear to the reader. I think it
> would make more sense to move the "short_read:" label to the end of the code:
> 
>                   actual = read(...);
>                   if (actual != size)
>                           goto error_short_read;
>                   goto success_unlock;
>         :
>                  actual = read(...);
>                  if (actual != align_size) {
>                            actual = really_read;
>                            buf -= really_read;
>                            size += really_read;
>                            goto error_short_read;
>                  }
>         :
> success_unlock:
>         mutex_unlock(...);
>         return 0;
> 
> error_short_read:
>         if (actual < 0) {
>                  retval = errno;
>                  actual = 0;
>         } else {
>                  retval = EXT2_ET_SHORT_READ;
>         }
> error_unlock:
>         mutex_unlock(...);
> 
> That way the code follows the normal error handling convention and is less likely to be
> surprising to the reader. 

Yes, you are right. I will do the change in the next rev.

-ritesh

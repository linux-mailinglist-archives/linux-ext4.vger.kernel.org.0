Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38664795AB
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 21:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbhLQUnk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 15:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbhLQUnh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Dec 2021 15:43:37 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F0C061574;
        Fri, 17 Dec 2021 12:43:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x15so2459886plg.1;
        Fri, 17 Dec 2021 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzF2K+h5qN2ZKg57L3Jl/NPujrt/Z7Sn0uzHRx3vkfI=;
        b=clqixurw3dd30qG7zJP4H8qpg/KHd3hoLHMtn0Tn41SS6W9ie2WCsPxF9Y9fU+AxAW
         ITiVSLMOhxAK8vEU1FSFWUbUz28Pp0GezoLZyMvMxlhlLPYahUfC57NCguUo1Aca6S7D
         IZrXU832kjazUKZhGSPr1uB/5anRVJMBytb9EIpN/64HLCLdhBtXy9df1QLAyKXcmyLp
         +QAJHLLSLxdsWiX+t67rR/xBFNgaSmiN7FuU1mCMOc8fMEmfEq5xhwXMkD53uXcQaHj+
         4dogA5YNkgrnv25SklkWjVG2lxte9L505/RIEOVKR25z0nr2B19Yt/JM++ZPLETfSfu0
         Z8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzF2K+h5qN2ZKg57L3Jl/NPujrt/Z7Sn0uzHRx3vkfI=;
        b=D+EBKwOMIVYWh6D9psshoEzeKVbwg2I/s/Vq4LRjDNlKSeRL/dLytYwub3puevhhoi
         EOEKHmJ34ZQKqiGTHLBD/pm7Vc+G9EDtWv337hGDzbJogXobkfDyi+hpvEesJzo5gl4v
         1Uxr5F91Zwuo8Gs8RISUqqX4vP56upS0VeM8iNyqBuDERDDe+ZcgY0OSmI47Qep/g0W3
         linRpjA+2NEniT0HoNM7iAzdNeL1rI5bMyEd2a0sCSNEUcVp/9XdCXnomb+2BjADIzO+
         yR9oy3g3c5TfD2X/oXH/US16W44h2XxGj3MSZqjTqXUOBHCihZWKcKrFCtMgMH+AZMm9
         pEHA==
X-Gm-Message-State: AOAM532DNvaVroOj1oIf1janYNuD1/V11J6CzpD4N2W+BanmMR2Ck/S5
        O9hKG4JyPeQPptz2FuNEzqo=
X-Google-Smtp-Source: ABdhPJx67mz6abqUAoW51RJzBuAugPPYys5Q7XQqY5N4zvj1kl6+mIT4uTD61xRNKm3TU2KENTEkHg==
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr5651725pjb.163.1639773816854;
        Fri, 17 Dec 2021 12:43:36 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a224:b9d3:bea:8ca1])
        by smtp.googlemail.com with ESMTPSA id gi20sm9895488pjb.1.2021.12.17.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 12:43:36 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     yinxin.x@bytedance.com
Cc:     adilger.kernel@dilger.ca, harshadshirwadkar@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
Date:   Fri, 17 Dec 2021 12:43:22 -0800
Message-Id: <20211217204322.1000035-1-harshads@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211201095258.1966-1-yinxin.x@bytedance.com>
References: <20211201095258.1966-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> fs/ext4/extents.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>index 9229ab1f99c5..4108896d471b 100644
>--- a/fs/ext4/extents.c
>+++ b/fs/ext4/extents.c
>@@ -4433,6 +4433,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
> 			ret2 = ext4_journal_stop(handle);
> 			break;
> 		}
>+		ext4_fc_track_range(handle, inode, map.m_lblk,
>+					map.m_lblk + map.m_len - 1);

ext4_alloc_file_blocks() calls ext4_map_blocks(), inside which we do
call ext4_fc_track_range(). However, we are doing that only if
map.m_flags & EXT4_MAP_MAPPED is true. So, unwritten flag is set we
are not calling track_range there. Perhaps the right fix is to call
ext4_fc_track_range() from ext4_map_blocks() if MAPPED or UNWRITTEN
flag is set?

> 		map.m_lblk += ret;
> 		map.m_len = len = len - ret;
> 		epos = (loff_t)map.m_lblk << inode->i_blkbits;
>@@ -4599,8 +4601,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> 	ret = ext4_mark_inode_dirty(handle, inode);
> 	if (unlikely(ret))
> 		goto out_handle;
>-	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
>-			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
> 	/* Zero out partial block at the edges of the range */
> 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
> 	if (ret >= 0)
>-- 

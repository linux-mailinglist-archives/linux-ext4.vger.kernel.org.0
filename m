Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CB52C043
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbiERRG0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiERRGZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 13:06:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A637A0D
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 10:06:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c14so2732345pfn.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CjTJ3p6aCRmVinOxweum1QDs81Fl9FfzslrIAeweBkM=;
        b=d8M7V9cwiXEtE3YHN0uzALLtO4e1UZ0wvHi72ZhwoC0v3xkvp8tUokEpkbQmTJcnue
         hZgBtuVd25W6kYZOfNseqpSqG7ae6O3eoMiQFqWwQRpWvJ6kHTO5halCTEScQpHEsqtP
         t/AkHfVVd6M1xaOE2sD8O7wqj5mNmM7Asrrh0ssQD4p43wD49nKXBV48Aa4AkkoQxatA
         ykGShPYTY83ECMtVMoNNak1EnhaNBUxXZ5u4sOpqpu34+iUdd2ndtRkkdHC3t4Byffjx
         jWNrq8fOFXSRo/r3J6E0uohgfGHxQnqvrsWOJaeW7XltH6RaXAwFvB9a58y1uCsvQY9x
         0Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CjTJ3p6aCRmVinOxweum1QDs81Fl9FfzslrIAeweBkM=;
        b=YVnwSq4e2Gq+Tqb7MGCPaul4a4ueNWHoMK8PZF+CBvoXESxalQEKeaXLteQ8z8XtPA
         YND4RbRXCSxtLsN/EmUbQsKNMiJgfGgBjoKL06GzatU65ghhoMVCQxrspxuyvH6s/GDI
         tozFPI9oqtaFDJImFt9rZz9CpyKrXYjDulGMeIRAMFZBlKTKUBn/l0IdXcVolSci9cXa
         OYo1AFt25DRcDCnmghd+QoRCy2r01ZsH/lm7FrY5RQAMmfEgeRpo3g2D4F9AJoxy+bi9
         toM7IpMGq0Ot8372apIvX2XYMTcDl+1NwDi8yQPt8zpigICuohZE2I9G1LAuPEXFcipS
         rC/w==
X-Gm-Message-State: AOAM5314eXalQZYpzek0Wa1zA2VAax9GAEpfuU0uB556vEQjK/RZg91f
        r8dRMTcl0pIKMIrKpkQXq6O2BtzFLxs=
X-Google-Smtp-Source: ABdhPJyk8Nq9q87Yy7axEC/yi9lHhygcJrjCBM8fJl7yie8/i+8jDTwwetGyvq2EVCZIFaYhgLDEAQ==
X-Received: by 2002:a63:5a5a:0:b0:3c2:8205:17a6 with SMTP id k26-20020a635a5a000000b003c2820517a6mr321741pgm.609.1652893583273;
        Wed, 18 May 2022 10:06:23 -0700 (PDT)
Received: from localhost ([2406:7400:63:532d:aa10:b33a:cf83:4737])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090ad08300b001d75aabe050sm1817406pju.34.2022.05.18.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 10:06:22 -0700 (PDT)
Date:   Wed, 18 May 2022 22:36:17 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix warning when submitting superblock in
 ext4_commit_super()
Message-ID: <20220518170617.vooz4ycfe73xsszx@riteshh-domain>
References: <20220518141020.2432652-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518141020.2432652-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/18 10:10PM, Zhang Yi wrote:
> We have already check the io_error and uptodate flag before submitting
> the superblock buffer, and re-set the uptodate flag if it has been
> failed to write out. But it was lockless and could be raced by another
> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> marking buffer dirty. Fix it by submit buffer directly.

I agree that there could be a race with multiple processes trying to call
ext4_commit_super(). Do you have a easy reproducer for this issue?

Also do you think something like below should fix the problem too?
So if you lock the buffer from checking until marking the buffer dirty, that
should avoid the race too that you are reporting.
Thoughts?


diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6900da973ce2..3447841fe654 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6007,6 +6007,7 @@ static int ext4_commit_super(struct super_block *sb)

        ext4_update_super(sb);

+       lock_buffer(sbh);
        if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
                /*
                 * Oh, dear.  A previous attempt to write the
@@ -6023,6 +6024,7 @@ static int ext4_commit_super(struct super_block *sb)
        }
        BUFFER_TRACE(sbh, "marking dirty");
        mark_buffer_dirty(sbh);
+       unlock_buffer(sbh);
        error = __sync_dirty_buffer(sbh,
                REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
        if (buffer_write_io_error(sbh)) {

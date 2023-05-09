Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB506FCD9D
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEISUX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEISUS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 14:20:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314785BB7
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 11:20:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef302a642eso31920611cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683656417; x=1686248417;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3g0XQ3x4VGJdNa4nMwcdmB30hjGHjxkBcyP7yTgU6Q=;
        b=KfAsb1VE1QEFbtQlC9HkvY25jQbnNlbfMpSVs0m5dHuvwaPWkixyP5A8pSdvW3qvtg
         pWEJYHIauIuOUDPb+T+TvpQkshDlcd6uTfXOCvsVE9dlFrEHJGi8BquHqrGi+Yzpt2tm
         HExK+WF6Q4q3pL/P83nkuORZXTKS0oCVTFxb9BvKAsiUdy31B47BBHH0UOZwHTU0g4b0
         H9AmcvkS0g6CYF3lGBzAjSQC+Fvdoal+Sp5CiPf0ow7j3HW+yAhUU9pGm/La7kNWZMCu
         hd1cWS6QhvrtKbSTtoonyFSUZGjZf5m+PM+D5+9GaY91JiC+H2pNNYAHJqXXhs+1eG79
         8oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656417; x=1686248417;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3g0XQ3x4VGJdNa4nMwcdmB30hjGHjxkBcyP7yTgU6Q=;
        b=SkjOIS9rRk2Kcjw5WFLTZTkny/EyGou6FDsG5Yqpg4QZTYz9R8g7zQZB5elfWB0qXU
         eztoaqM7c5Bu9DdWrfVloTkJqEDX8YTQKJEbzFxdS6uUYY1JgIbDoQ2bVLAJpzjLL5Y1
         l/DlEr9XXrk4Jnp7E8gZ8w2RFHza8oCRHJacZ0d5SClIY3v0xCiI0VitBpInfX/5JguK
         28FxJsVOxnHruPv3WaPXhusNrFwEElrspkuy35rcJfdwJl1Qqq1l3OLfXK0MqW4ECH0o
         ax5xOIJjHt6U+wbt1YlFPSKL4B7tMbk0uwylJ7lgdXI1jddANRPNI/Dt+lZIWgGejB2g
         bVCw==
X-Gm-Message-State: AC+VfDw02P0VDyRjWdP9k5L89PljlYmNjkamTzULwlKhOWSVIPsY6qvG
        9KG/HUHLhGCd48E+1s7KvHw=
X-Google-Smtp-Source: ACHHUZ733/gLKIf+phs+boeT+UBEv7u34ABXRZKk0ke7WFOOi0Gyv3Xptww8Fj8b+qZShzZjoAcC7w==
X-Received: by 2002:ac8:5f89:0:b0:3f2:2fee:5fd5 with SMTP id j9-20020ac85f89000000b003f22fee5fd5mr17811362qta.25.1683656417172;
        Tue, 09 May 2023 11:20:17 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id fy26-20020a05622a5a1a00b003f0af201a2dsm686441qtb.81.2023.05.09.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:20:16 -0700 (PDT)
Date:   Tue, 9 May 2023 14:20:15 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     jack@suse.cz
Cc:     linux-ext4@vger.kernel.org
Subject: 6.4-rc1 xfstests-bld adv regressions
Message-ID: <ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan:

I'm seeing two test regressions on 6.4-rc1 while running the adv test case
with kvm-xfstests.  Both tests fail with 100% reliability in 100 trial runs,
and the failures appear to depend solely upon the fast commit mount option.

The first is generic/065, where the relevant info from 065.full is:

_check_generic_filesystem: filesystem on /dev/vdc is inconsistent
*** fsck.ext4 output ***
fsck from util-linux 2.36.1
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Directories count wrong for group #16 (4294967293, counted=0).


The second is generic/535, where the test output is:

     QA output created by 535
     Silence is golden
    +Before: 755
    +After : 777

Both test failures bisect to:  e360c6ed7274 ("ext4: Drop special handling of
journalled data from ext4_sync_file()").  Reverting this patch eliminates the
test failures.  So, I thought I'd bring these to your attention.

Eric

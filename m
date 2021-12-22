Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2607647D51B
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Dec 2021 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhLVQ2d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 11:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbhLVQ2d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Dec 2021 11:28:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E923FC061574
        for <linux-ext4@vger.kernel.org>; Wed, 22 Dec 2021 08:28:32 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so2386844qtj.9
        for <linux-ext4@vger.kernel.org>; Wed, 22 Dec 2021 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dOnFNCm8yH5utW/0+zKDtsHuV2oy5uKeV8mlHRJwuY0=;
        b=YOBKU8qSqfljzSNAuad0Kg2kz/PviS4mWFRJVoYn7ZBtBZH7DeBHZVT5NXvM+IM4yL
         GBDSdJHwqo4KBKYO0LaXKsljmN/R2PMq2GcLuxfoTVpBGzHQSvdif+6PwNI7u/sDlrPo
         VqzLzDr2V7VVJnZJxmU7LWqqUjmFEoj8Jd+lE8xGZ799uYFtaCR4YMF+BpypHGeMv0Wx
         GsW+A1hZRudH4zZKIYUgLjXBBrDASSjfW2t/lUCIAK9CBMt7J5ZiscYIM16aBgw1LlW3
         t0KSPnOkJqMvRVmg5uS1pJil1Xb4ct63bX5q0oDrlXDE5sepACtfdacH/ckTHtPhNStW
         N9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOnFNCm8yH5utW/0+zKDtsHuV2oy5uKeV8mlHRJwuY0=;
        b=cpSVqsXMzW3yQtvJOOgwJLiE56yN6XJefPa9xR+CbedjSgZ82JOoJIBbtMfcPKduXR
         HWiAtsBW0CoLSpizuOCGsI2URUn3oVVmFf7pfkwT1fyikg/LKVojZy/IBvhgyO7Ua/PW
         xkmBBSVVIPnAWLGfOAGdUfTXsTeckZbVIG/8D2EqszSvnA5P83z69ePtoQrQ3Ki29hdh
         sy1edCBp2mNIoda6KSioP7/8hZ1J1Udu7HGiItFSNHph1auxUKMpL2OAzC+oJj4TyvqQ
         k4NG3wzQDXptX4gS/fuw0hoS2Ku49sXjDrgPbBiO96mbjk/o3RvoBx4yuSvcJzfF2EPM
         uOzw==
X-Gm-Message-State: AOAM533NPsR3A2upcu778rMHrs/Z7YYaTIJvJBkMVa2RWzLaU4W0ePGJ
        IP3yo2fAIQxZ8H68W5ainSaVTyxh2oE=
X-Google-Smtp-Source: ABdhPJwKI6qarn9dTWSru59A8CpDtyT/eP50EfI6FRFq7kO+Chgu4PMABJWOIMHk77JHLtGRs0NWQw==
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr2749208qta.442.1640190512119;
        Wed, 22 Dec 2021 08:28:32 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id o20sm2190179qkp.114.2021.12.22.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 08:28:31 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:28:29 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, yinxin.x@bytedance.com,
        enwlinux@gmail.com, Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH 0/3] ext4 fast commit API cleanup
Message-ID: <20211222162829.GA12835@localhost.localdomain>
References: <20211220031704.441727-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220031704.441727-1-harshads@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Harshad Shirwadkar <harshadshirwadkar@gmail.com>:
> ext4: fast commit API cleanup
> 
> This patch series fixes up fast commit APIs. There are NO on-disk
> format changes introduced in this series. The main contribution of the
> series is that it drops fast commit specific transaction APIs and
> makes fast commits work with journal transaction APIs of JBD2
> journalling system. With these changes, a fast commit eligible
> transaction is simply enclosed in calls to "jbd2_journal_start()" and
> "jbd2_journal_stop()". If the update that is being performed is fast
> commit ineligible, one must simply call ext4_fc_mark_ineligible()
> after starting a transaction using "jbd2_journal_start()". The last
> patch in the series simplifies fast commit stats recording by moving
> it to a different function.
> 
> I verified that the patch series introduces no regressions in "quick"
> and "log" groups when "fast_commit" feature is enabled.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Harshad Shirwadkar (3):
>   ext4: drop transaction start stop APIs for fast commit
>   ext4: drop ineligible txn start stop APIs
>   ext4: simplify updating of fast commit stats
> 
>  fs/ext4/acl.c         |   2 -
>  fs/ext4/ext4.h        |  12 +-
>  fs/ext4/extents.c     |   9 +-
>  fs/ext4/fast_commit.c | 250 ++++++++++++------------------------------
>  fs/ext4/fast_commit.h |  27 ++---
>  fs/ext4/file.c        |   4 -
>  fs/ext4/inode.c       |   7 +-
>  fs/ext4/ioctl.c       |  13 +--
>  fs/ext4/super.c       |   1 -
>  fs/jbd2/journal.c     |   2 +
>  10 files changed, 96 insertions(+), 231 deletions(-)
> 
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
>

Hi Harshad:

I applied this patch series to 5.16-rc6, and then ran 500 trials of generic/083
using xfstests-bld's adv test case (where I'd consistently encountered kernel
hangs after 16 or 17 runs) without failures and a full -g auto run over all the
default test cases without regressions.

Thanks for the patches!

Tested-by: Eric Whitney <enwlinux@gmail.com>

Eric


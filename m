Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0765331FD6
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Mar 2021 08:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCIHbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Mar 2021 02:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCIHbH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Mar 2021 02:31:07 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DECC06174A;
        Mon,  8 Mar 2021 23:31:07 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u20so12849182iot.9;
        Mon, 08 Mar 2021 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJEB67q4wGbs1lwvW2UR1w3WtSUkq1M8L5MbsL95Ca0=;
        b=eYaUoF5Rfitl0ysE6X9SS4uCbxnJc4nZlDz4+LZG/bJzj3+LSUUU9FlDDoCaFNaLAq
         Co/lQAJAv1s5A1SH9ziKniwpN3a+av1L8WMLSbAZd5jZvoWUgqvtdgXYxsossZmpJP8/
         TP1fE4IuykQ9pAVLPKfUVMPHiWtc55u6TkHoNcj8uw3rRdG3iZjQ0cYn7ivyZ8NXI5C+
         k6A+gpEp5s/oex8Hkm0EQG40VZQlf/Wo06bz1iq6NGfkqkNNnZWj0jWki0NQQXp+9wOd
         ARuyxFD4EYJjdgMqENJmj4R7qqKp7r+y++qw5q9wy1mfGcLqXA+US36MX+cn9nTY0P7L
         jL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJEB67q4wGbs1lwvW2UR1w3WtSUkq1M8L5MbsL95Ca0=;
        b=U9SNHIK7VUxg66MrlhsHFfXswNZ4jGUsKaufsK/EKAPHkuAYTFKdByJMye8e9HY84o
         n5opp/rU9nuZ30fAOMkr+LgvfriO3/Tn9HKF5m6Lkmz+yRl9PfgNNpCIALXKNRpcisZ/
         XpdyClaREkWRhDRWER9PZ8FqTlzf1o4S4Sw2Pansw41QAW/73d7VnsLmoIXQTRppGQxW
         ePkDCdfPs9/k1O+QDm+UGl+IRVSxwAz0Ggi/X0r6n6oeWCcH1WyUnX6+fosbrRPsRs8o
         YEDMbBWTycvkKmIXIx/Tv0UAM1pSNFtoPYe2wZuA+6nrc8DqQTpxtlMUY9BFHvvjXxpT
         SmQQ==
X-Gm-Message-State: AOAM530yoamVr1jw+S1m7owSi8FgEaynsiOdrRR1rF7TYwNTCxwei370
        NI4+i4fKyNcRjRtm8zPtJpL8CUtYaohfEps4LFs=
X-Google-Smtp-Source: ABdhPJwKqt8Pli3eLUo/cAdDE493A7RYnCH6YhcSP2uXzgc0UZ3nMXi/e+zfoURQDu6AXFhjaIIyYXZCWBQ1U58iAEE=
X-Received: by 2002:a02:9382:: with SMTP id z2mr27838093jah.120.1615275066773;
 Mon, 08 Mar 2021 23:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20210105062857.3566-1-yangerkun@huawei.com> <X/+/3ui/TQ9LjtNZ@mit.edu>
 <CAOQ4uxh2V6LF_t8ZaAOr=CbDrY3A5d0qSR7XWVX8dStR9mME5w@mail.gmail.com>
 <CAJfpegsVYF2wCiMKfRUzS_MpH9UKPh8g7ucG6w9uOcQodAzRAQ@mail.gmail.com> <CAD+ocbyEyeAbH1vqKieK9ENmM5k3K-WF1jMuqAzRwPfPC2Np8A@mail.gmail.com>
In-Reply-To: <CAD+ocbyEyeAbH1vqKieK9ENmM5k3K-WF1jMuqAzRwPfPC2Np8A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 9 Mar 2021 09:30:55 +0200
Message-ID: <CAOQ4uxi5Pqk=pVQQr7261tdy3FfkBJU32_bTd2zzmsAzythwnw@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: fix bug for rename with RENAME_WHITEOUT
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Ts'o" <tytso@mit.edu>, yangerkun <yangerkun@huawei.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, "zhangyi (F)" <yi.zhang@huawei.com>,
        lihaotian <lihaotian9@huawei.com>, lutianxiong@huawei.com,
        linfeilong <linfeilong@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 22, 2021 at 9:21 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks Amir for pointing that out. Yes we are missing fast commit
> tracking in whiteout. I'll send out a fix for that.
>

Ping.

Harshad,

Did you forget or did I miss the patch?

Thanks,
Amir.

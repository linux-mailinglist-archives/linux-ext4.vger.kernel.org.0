Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D91DBDA2
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgETTJN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgETTJL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 May 2020 15:09:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DCBC08C5C1
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:09:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b91so4365273edf.3
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tl5hNSaq9jwtAfQ3H4b6ZmG+ScLEKqnmbeQTtX38GBs=;
        b=ejWrZ/jfJqN1W3XBa5rEh8Lk4R2pGtjUsAfERal12GI7QfCZfWLDd9UtMrTSYE1/tI
         FovDCSwIGfbaaHj8cZJ1IKJDULyXaqYHAyGtIE65kUKbthWtIjz/KQGrx+y85v2kRRQb
         81QOjyfbBp6VHvsSe4y3k88jU+q/CRx/ohQyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tl5hNSaq9jwtAfQ3H4b6ZmG+ScLEKqnmbeQTtX38GBs=;
        b=DNHCZRiuoaPsPA6RaSgQ702xWwSWeV6JCTI+pLQHV/VlMl3Fp8wJWCSbJoXybl1Ejf
         qWrnPl3WMTKLSRRaFS2Y6ivsaGnJjx4dG9+LbhI01/JMAGfCYxPBETxhZM42eyat9XRN
         nCrucXO+Pot0KVMzx+G0STxChgjxkEZuDojbNV7OCTNEXIlWkdkUfCUWTsev/ZVqSvQc
         V3PMyTOXaDE7K5vnATD0fBYB8qwFwNxhjsVsahZIF1mkbbPwlijmkym5xHHyJXJlexIv
         zvMkC/ptTdl8S6JHG6uViNcXserLgUA0BXon8pdYZpCK/ictwrqHeeRChFXVPra/zq7Q
         uESw==
X-Gm-Message-State: AOAM533aKt1TY3vyFXq/hyEJn/SXHVs77n4GWd6fXMOvRGzVFIPeDlzD
        PJnoOkT5G7PtR8juKibIWjndaw==
X-Google-Smtp-Source: ABdhPJweTP3W62AzAZrqweXxsUYkSWvtaZ1Wr8JxuA7F/wzgya+W3/hBf6pFGJ7YDBt9fmp3P99NeQ==
X-Received: by 2002:a50:9312:: with SMTP id m18mr4674386eda.252.1590001748698;
        Wed, 20 May 2020 12:09:08 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:758d])
        by smtp.gmail.com with ESMTPSA id g21sm2514869edw.9.2020.05.20.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:09:08 -0700 (PDT)
Date:   Wed, 20 May 2020 20:09:06 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200520190906.GA558281@chrisdown.name>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Naresh,

Naresh Kamboju writes:
>As a part of investigation on this issue LKFT teammate Anders Roxell
>git bisected the problem and found bad commit(s) which caused this problem.
>
>The following two patches have been reverted on next-20200519 and retested the
>reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
>( invoked oom-killer is gone now)
>
>Revert "mm, memcg: avoid stale protection values when cgroup is above
>protection"
>    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
>
>Revert "mm, memcg: decouple e{low,min} state mutations from protection
>checks"
>    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.

Thanks Anders and Naresh for tracking this down and reverting.

I'll take a look tomorrow. I don't see anything immediately obviously wrong in 
either of those commits from a (very) cursory glance, but they should only be 
taking effect if protections are set.

Since you have i386 hardware available, and I don't, could you please apply 
only "avoid stale protection" again and check if it only happens with that 
commit, or requires both? That would help narrow down the suspects.

Do you use any memcg protections in these tests?

Thank you!

Chris

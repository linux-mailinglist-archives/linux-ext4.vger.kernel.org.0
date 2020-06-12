Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082841F7628
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFLJni (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLJnh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jun 2020 05:43:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF4C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jun 2020 02:43:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so10368336ljn.4
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jun 2020 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIjum0OdXj+v8gBuVrC8N67GclMwnVqsebwDSnxt9vM=;
        b=B5zzUnrxMZIR1cvpNNJdn3LFoosy6pPU4isLVSWgJ9nP8PUuaqb/X7mACFUtN4Zz0e
         je1pJ6/7L30IUd9miR1oO0pReCGX2bidQmzsxFyBH7tKSWWLqW6VQz10wJTlfMKj9rrB
         WBE/JK4Uw5jGqY0GBMDdgRP4v094YfQNIFITKncq2chQL2ULqFL5HZsbtycVUANMKQ4q
         Ff22Q8bj6f9otWxYKNEcAsUS4YOjCGydg0FG7aELVJHksT7x7qdY2jHFHD/khmaddwqh
         5gNJVS3WCEasOzyYFedHV6DyZL/RyohzMUHwWpOSbVYfzQc6KihVidQjyi/EVoZE4LYe
         XpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIjum0OdXj+v8gBuVrC8N67GclMwnVqsebwDSnxt9vM=;
        b=Zn7YI1um0vjuAoTQh6rFYZ+krQz0/RSCtS4SWYegSiLxi5zaA5p32iMbf3KHq3aHmc
         QZLELyk5mV1w6pQ7r9jPWVSee3bvayavc3rIT8mVab5ZEEwKM7SnhVcLXDH0QQ+uVzR5
         yB5K90yomdVFVFxffDYEwEQJ3aK68GRtWYNqUn9dRZXOssU1JCqZ9q5HUZl65nCjjTOh
         qlzW1kPH5+i09AKVPMX+OIuvGj4jY7xQMeUnjIq33GNq9GcIBYrbka9Qn2mVe9I6BRQL
         gWI/v7EgNmhKYGoh4Y5z089cI6gMCGPQyg/BBLRHM/8UYGsRzpt42flJJcqKVLzG/b2R
         K2ew==
X-Gm-Message-State: AOAM531NMwCWOpekAlXOM6hETJcNHOWuDb8vul18pFvyKP3+leYomBcJ
        idewe+W0hsBFSzMtjyV4YRTVnNyTRUzl+WLpzKPbZg==
X-Google-Smtp-Source: ABdhPJw5tmdt3Qb2oH83ueGFSlyEX7PXjd2r9+J99+ZU7hJQo8IwOlnJ7848er/3tfXq8Sq1AS7XMX8/8Aq5t7u2d+4=
X-Received: by 2002:a2e:984b:: with SMTP id e11mr6079071ljj.358.1591955014129;
 Fri, 12 Jun 2020 02:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200521095515.GK6462@dhcp22.suse.cz> <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz> <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name> <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
 <20200529015644.GA84588@chrisdown.name> <20200529094910.GH4406@dhcp22.suse.cz>
 <20200611095514.GD20450@dhcp22.suse.cz>
In-Reply-To: <20200611095514.GD20450@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 Jun 2020 15:13:22 +0530
Message-ID: <CA+G9fYsjH8vOTkSKGa5vgC=0fEXuC5UnGsZOirHxH9nOJSHPdA@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
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
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 11 Jun 2020 at 15:25, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 29-05-20 11:49:20, Michal Hocko wrote:
> > On Fri 29-05-20 02:56:44, Chris Down wrote:
> > > Yafang Shao writes:
> > Agreed. Even if e{low,min} might still have some rough edges I am
> > completely puzzled how we could end up oom if none of the protection
> > path triggers which the additional debugging should confirm. Maybe my
> > debugging patch is incomplete or used incorrectly (maybe it would be
> > esier to use printk rather than trace_printk?).
>
> It would be really great if we could move forward. While the fix (which
> has been dropped from mmotm) is not super urgent I would really like to
> understand how it could hit the observed behavior. Can we double check
> that the debugging patch really doesn't trigger (e.g.
> s@trace_printk@printk in the first step)?

Please suggest to me the way to get more debug information
by providing kernel debug patches and extra kernel configs.

I have applied your debug patch and tested on top on linux next 20200612
but did not find any printk output while running mkfs -t ext4 /drive test case.


> I have checked it again but
> do not see any potential code path which would be affected by the patch
> yet not trigger any output. But another pair of eyes would be really
> great.


---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..d13ce7b02de4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2375,6 +2375,8 @@ static void get_scan_count(struct lruvec
*lruvec, struct scan_control *sc,
  * sc->priority further than desirable.
  */
  scan = max(scan, SWAP_CLUSTER_MAX);
+
+ trace_printk("scan:%lu protection:%lu\n", scan, protection);
  } else {
  scan = lruvec_size;
  }
@@ -2618,6 +2620,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat,
struct scan_control *sc)

  switch (mem_cgroup_protected(target_memcg, memcg)) {
  case MEMCG_PROT_MIN:
+ trace_printk("under min:%lu emin:%lu\n", memcg->memory.min,
memcg->memory.emin);
  /*
  * Hard protection.
  * If there is no reclaimable memory, OOM.
@@ -2630,6 +2633,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat,
struct scan_control *sc)
  * there is an unprotected supply
  * of reclaimable memory from other cgroups.
  */
+ trace_printk("under low:%lu elow:%lu\n", memcg->memory.low,
memcg->memory.elow);
  if (!sc->memcg_low_reclaim) {
  sc->memcg_low_skipped = 1;
  continue;
-- 
2.23.0

ref:
test output:
https://lkft.validation.linaro.org/scheduler/job/1489767#L1388

Test artifacts link (kernel / modules):
https://builds.tuxbuild.com/5rRNgQqF_wHsSRptdj4A1A/
- Naresh

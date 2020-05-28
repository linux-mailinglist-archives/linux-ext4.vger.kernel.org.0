Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8BE1E679E
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405090AbgE1Qlw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405042AbgE1Qlu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 12:41:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618CC08C5C8
        for <linux-ext4@vger.kernel.org>; Thu, 28 May 2020 09:41:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q11so16609375wrp.3
        for <linux-ext4@vger.kernel.org>; Thu, 28 May 2020 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pvf7qBFEHIiAL/UpG9xM7Gf8VhxhCVBHlvWj3inRLaM=;
        b=dZ/4oQHkI3iFVl6Q4XDatBaCWT8WDKIy43ty6iL5UZV9y8w2Mwc2zwtaHwr00vostz
         c8tS4BvevPCZZt4NdTss07rL4pzKusdIZLJ1Zm9Z3FuwwbTD2hfas29vKN5+7iQ8CBt4
         fMhXjwXce9iKSnXnt3Jr4qQvtVDCYiR2OFQFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pvf7qBFEHIiAL/UpG9xM7Gf8VhxhCVBHlvWj3inRLaM=;
        b=eop1nG75TWIXpzb9qqP7bRg3OeHXQi057Esablj8ma9o0AWMKmHJhCnzQO/ftnR+RL
         tb/yST0j99hwO/Yf7mkkN1RaldiX9IRPnx/CCr2F+lYuvEyBIkKCE1wpoDfw0wLxgkMk
         BSljowOnUV1zqb2FWL5CQLCMjT2SaR8ZmnYT0HJFHIdu4oJ4u5LVbVoa96MJMuyCXlIB
         QmYo6MEZe1v37Sx8uolZhx4Aum3iLQtWd5Fcs7UMvywN7veOje3NDO9eaPko8Zmq/tz8
         5XOr7UPoVM09Ymj6aEyi/8jVe+3GzijwKfTWDDbIIuxKSjxSg10CHis9mVkDYSe2qrtg
         3oJg==
X-Gm-Message-State: AOAM530J++vAq3jPd8ffnb5hr+fSKsuq81LGxx6X7NGW3L3xELHpPYtD
        fJLPGZIDJ6LHWzt0XGmJwvQWog==
X-Google-Smtp-Source: ABdhPJx43EFGY79zZc9WHOq4nlucrHubXscZYsQcdCStmKVBziBJ4zuFJn23rjI3pradupO/1Tk0Ig==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr4130619wrr.375.1590684083033;
        Thu, 28 May 2020 09:41:23 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d125])
        by smtp.gmail.com with ESMTPSA id y66sm6698899wmy.24.2020.05.28.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 09:41:22 -0700 (PDT)
Date:   Thu, 28 May 2020 17:41:21 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200528164121.GA839178@chrisdown.name>
References: <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Naresh Kamboju writes:
>On Thu, 28 May 2020 at 20:33, Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Fri 22-05-20 02:23:09, Naresh Kamboju wrote:
>> > My apology !
>> > As per the test results history this problem started happening from
>> > Bad : next-20200430 (still reproducible on next-20200519)
>> > Good : next-20200429
>> >
>> > The git tree / tag used for testing is from linux next-20200430 tag and reverted
>> > following three patches and oom-killer problem fixed.
>> >
>> > Revert "mm, memcg: avoid stale protection values when cgroup is above
>> > protection"
>> > Revert "mm, memcg: decouple e{low,min} state mutations from protectinn checks"
>> > Revert "mm-memcg-decouple-elowmin-state-mutations-from-protection-checks-fix"
>>
>> The discussion has fragmented and I got lost TBH.
>> In http://lkml.kernel.org/r/CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com
>> you have said that none of the added tracing output has triggered. Does
>> this still hold? Because I still have a hard time to understand how
>> those three patches could have the observed effects.
>
>On the other email thread [1] this issue is concluded.
>
>Yafang wrote on May 22 2020,
>
>Regarding the root cause, my guess is it makes a similar mistake that
>I tried to fix in the previous patch that the direct reclaimer read a
>stale protection value.  But I don't think it is worth to add another
>fix. The best way is to revert this commit.

This isn't a conclusion, just a guess (and one I think is unlikely). For this 
to reliably happen, it implies that the same race happens the same way each 
time.

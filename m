Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD41FF202
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgFRMhr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgFRMhq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 08:37:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466EC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 05:37:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d128so5485405wmc.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OgZomFoj/7toYCBCKWRo7nq/kYdKAWeXt05LtEajY3k=;
        b=Vba3/YBp135F4zjZnb2RedWXF2lwu1lFFL34CLaNpxPjPTPlt0UR472eYi5S4YZ1Wx
         Z0rDK+6Hs9d3o0cUOdxwi2SS36Jq5bWlnav7DNmZNgJpcMQ+D8caGFIGg/ORh0SmmPxl
         k69/g/gWD8TgMCYkGiY2Wz/GRty0LMQ/SrbXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OgZomFoj/7toYCBCKWRo7nq/kYdKAWeXt05LtEajY3k=;
        b=iI3Qx9k1WUV4n6tftLQjE1VwPvvWNVqexyi6txK6RG5RfRuQP55JASBkkpksV/25ZV
         qaTLHYx53KckuU5pcLP1U9dx8pzBSVF7nw9waQod/aS5vmWw1t0zmQa4m/h05Mw1sWKI
         GFsyFQvIUnH6EZKau1poI1sYvajVsgIY2HW1nu5VOYD7JQhpCMFOu08snsK+/judn3CO
         KWwbre3puz9Gy1wFZLRwlH0aDWwD2mGygZVOcaApu3aqM1sV7lVXJ3XCQhWuVFkrN7p+
         B0jgsc/0gZQphAkatn4nO/AepcEcAleZsXz9AthOc1Q+2DdweEgp7WdY8msSMmYEde69
         clAQ==
X-Gm-Message-State: AOAM531WxL66XGeia+RXpcrluhPm1Wn0zbkyTjdMHBoINWQTd3Ivs5NY
        8qLuSehY/6Gq8ScT0sm2FpSSiA==
X-Google-Smtp-Source: ABdhPJzFoWSkp2MqAS0xx92RSUWbWQ0U7Z92SQ/MTtOdoN5z3gnxoKRC/r81z8qHIYMjhulYtZARyw==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr3734793wma.157.1592483864725;
        Thu, 18 Jun 2020 05:37:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id t82sm2586962wmg.10.2020.06.18.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:37:43 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:37:43 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200618123743.GA694719@chrisdown.name>
References: <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz>
 <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name>
 <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Yafang Shao writes:
>On Thu, Jun 18, 2020 at 5:09 AM Chris Down <chris@chrisdown.name> wrote:
>>
>> Naresh Kamboju writes:
>> >After this patch applied the reported issue got fixed.
>>
>> Great! Thank you Naresh and Michal for helping to get to the bottom of this :-)
>>
>> I'll send out a new version tomorrow with the fixes applied and both of you
>> credited in the changelog for the detection and fix.
>
>As we have already found that the usage around memory.{emin, elow} has
>many limitations, I think memory.{emin, elow} should be used for
>memcg-tree internally only, that means they can only be used to
>calculate the protection of a memcg in a specified memcg-tree but
>should not be exposed to other MM parts.

I agree that the current semantics are mentally taxing and we should generally 
avoid exposing the implementation details outside of memcg where possible. Do 
you have a suggested rework? :-)

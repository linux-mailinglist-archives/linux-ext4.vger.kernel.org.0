Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DAB362E71
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Apr 2021 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbhDQIDV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Apr 2021 04:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhDQIDU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Apr 2021 04:03:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94319C061760
        for <linux-ext4@vger.kernel.org>; Sat, 17 Apr 2021 01:02:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mh2so23848895ejb.8
        for <linux-ext4@vger.kernel.org>; Sat, 17 Apr 2021 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PLuLkF1IGWypPI+HiFb6Lc3kbaqrvgXd5rUpp6F9OyA=;
        b=f+fB8uprWV4VzDEpOVgLGalnWXSkba8mHn2f/QgTiso7d+EBzMNLlXbHyXVbmU9/SU
         8Toc6/TybN0Tm32Iuf39deCQf/CDvKOghOYk/pRERBtjMI4iomcdBdGkpI3hsu/xHMOf
         sTO7wkJj0piCgTtOL5WwyCohvOpc8UATN2j/YyiyO/SK5AA1vlFQcUmohKN/aVRKLP06
         JNolTMYL+cDFXUHMbqMhXrxjLx7qwBxf9aQS73B2jyqg0tmHzReT8gPMYvFdxMIPSjca
         nT0j7cE4klZDLfvOJIcHP92M4tD60c+bZ4bv2m8nmToU3O0abLogE76OPzw8setdqz8l
         TJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLuLkF1IGWypPI+HiFb6Lc3kbaqrvgXd5rUpp6F9OyA=;
        b=VFn0KzTgSdFhkn3LRwU0dKXhDE6lqokeVp99Cb7RcOLD79KfP5IVowQwSjT8t60RzP
         GWKogQ4wZkF/hAczhCSQcgCBMI2vt5zcvsvl4lBTpduwA8+xr9rBfyTdvyB9hlCtVBsY
         yKnRCKzuJb7KAO/QWWsSt++2tIj+kih5BA+/eKh7gwtSLSHc+zK4hYfJ98eR8mawZyid
         Gjo0dNe7BuqwjD8Lmsk8kebNN31i60sDlgi76Oycgk8OWsgcBC4d9IdiQI/k+m9EBJ6F
         W5uBPAP/5KTOcBc4mgOHwvDgcI1pfOF5lHn/VqzGqUQPfWeYQGnaGZrWMXjUbhXSE4kF
         y7Cw==
X-Gm-Message-State: AOAM532+LopYeqKaSCbktx3bvCQTBpg9sBy8mpVOKOXJtk5HNksFdAs/
        6tRMlxKEZNdg6QTM2LnRRA08jA==
X-Google-Smtp-Source: ABdhPJyIqgVZdxEPXFYbJlfPKeXXYMcbzGuCDPRZzGHX6+Kox4v/z173UZ4qXydlYv5wMfKAokc0oA==
X-Received: by 2002:a17:906:9a81:: with SMTP id ag1mr12006771ejc.464.1618646570130;
        Sat, 17 Apr 2021 01:02:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5c1f:7c5f:b466:7696])
        by smtp.gmail.com with ESMTPSA id mj7sm5853512ejb.39.2021.04.17.01.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 01:02:49 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
To:     David Gow <davidgow@google.com>, Nico Pache <npache@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        rafael@kernel.org, linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Theodore Ts'o <tytso@mit.edu>,
        mathew.j.martineau@linux.intel.com, davem@davemloft.net,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, mptcp@lists.linux.dev
References: <cover.1618388989.git.npache@redhat.com>
 <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
 <e26fbcc8-ba3e-573a-523d-9c5d5f84bc46@tessares.net>
 <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
 <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net>
 <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8b8aecaa-2651-2401-e5ad-499b2c920c6d@tessares.net>
Date:   Sat, 17 Apr 2021 10:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi David, Nico,

On 17/04/2021 06:24, David Gow wrote:
> Hi Matt,
> 
>> Like patch 1/6, I can apply it in MPTCP tree and send it later to
>> net-next with other patches.
>> Except if you guys prefer to apply it in KUnit tree and send it to
>> linux-next?
> 
> Given 1/6 is going to net-next, it makes sense to send this out that
> way too, then, IMHO.

Great!
Mat sent this patch to net-next and David already applied it (thanks!):

https://git.kernel.org/netdev/net-next/c/3fcc8a25e391

> The only slight concern I have is that the m68k test config patch in
> the series will get split from the others, but that should resolve
> itself when they pick up the last patch.

I see. I guess for this MPTCP patch, we are fine because 
MPTCP_KUNIT_TESTS was not used in m68k config.

 > At the very least, this shouldn't cause any conflicts with anything
 > we're doing in the KUnit tree.

Thanks for having checked!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F883602F8
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Apr 2021 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhDOHKh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Apr 2021 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhDOHKg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Apr 2021 03:10:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6FC06175F
        for <linux-ext4@vger.kernel.org>; Thu, 15 Apr 2021 00:10:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s15so26741485edd.4
        for <linux-ext4@vger.kernel.org>; Thu, 15 Apr 2021 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cVJbiBboy1l3Ex5mXO1TqNUpkFbiSXvC2bEmtOt51do=;
        b=o3uvJtrcuH/G7imD/Au58YPKPN98NKGlM/g+B1oDZtDbqRb1Wn4OIZOQW9jV95E0IN
         L0Ou+PdFlVMqLSU0ZnVfigJidlWASZ8NrtRuGkxzhotKufy3ZNjQ1irtu6SlCcQGdDCq
         LsODTEAaD1/yXJFdVQHAIsfOFBY1lpO5vLejISh+uDE9asQS2YlnXQRT9WdyK6ymdTOI
         oBO6Cyd2+rGjIJE1SnGocRO6nb9ebp0f3a5jAb4x1jPlzdj67O0tHydByRAAXi/4mMbw
         kzSjVbX9sFxmNwW7Zw7XQLZkJNzMfEdTi3IE/HpPn0XzKBg5HtWXLMV62G6gJW/Alkjh
         j1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cVJbiBboy1l3Ex5mXO1TqNUpkFbiSXvC2bEmtOt51do=;
        b=pkyGaMg1gdfZFchU2KBaiiegYdxIlCySCBFmoPjilHHJANRiKuEisYhDPsQTAOPUwm
         I+FbqAUxsBvwMTHivNiADruiS7EWuu235m1MpYt6ILgcOEHhnQwYziG1S8lIdL29lkzW
         +FM3G0gDXIVt58e8Ziua6gKTJTZ8VlnWB6rzfJcVYnezKcBMegMgYbSM1IZdJhlOrpq8
         lWDqE0G1ocz4vr+xhiGrzq+Jncqyb84+5FXpl38ps6mosQEbr/IHtd0/NecFOOk2Q65N
         /HE4ms6dnIWhPKgxalMST9G7Ws3iIH7zolYeyOvBpOU6QrfE3TJnmkQHLns4tT39/Fk1
         TptA==
X-Gm-Message-State: AOAM530Di9n52PnkA9tI+3/V8TKkIU5duTaFQ0ljerDSSJdbQZleeun2
        yX4D19jz9DK3Lj9b3gj8NABb8A==
X-Google-Smtp-Source: ABdhPJxUb5VhQZnEL91I2SJ6ZNy+oArB6BT1PUTEgTaNKWNU7cSgQhqUpHB8lUZMWvgfsQiAyskrqw==
X-Received: by 2002:a05:6402:1255:: with SMTP id l21mr1740882edw.362.1618470611776;
        Thu, 15 Apr 2021 00:10:11 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:4aaf:625b:29ae:a5])
        by smtp.gmail.com with ESMTPSA id c16sm1250634ejx.81.2021.04.15.00.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 00:10:11 -0700 (PDT)
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
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
Message-ID: <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net>
Date:   Thu, 15 Apr 2021 09:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi David,

Thank you for your very clear reply!

On 15/04/2021 08:01, David Gow wrote:
> On Wed, Apr 14, 2021 at 5:25 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>> Up to the KUnit maintainers to decide ;-)
> 
> To summarise my view: personally, I'd prefer things the way this patch
> works: have everything end in _KUNIT_TEST, even if that enables a
> couple of suites. The extra 'S' on the end isn't a huge problem if you
> have a good reason to particularly want to keep it, though: as long as
> you don't have something like _K_UNIT_VERIFICATION or something
> equally silly that'd break grepping for '_KUNIT_TEST', it's fine be
> me.

Indeed it makes sense: we don't need to split nor to have a meta-Kconfig 
entry. We can then remove the extra 'S' and update our tests suite:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I see that the whole series has been marked as "Not Applicable" on 
Netdev's patchwork:

https://patchwork.kernel.org/project/netdevbpf/patch/0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com/

Like patch 1/6, I can apply it in MPTCP tree and send it later to 
net-next with other patches.
Except if you guys prefer to apply it in KUnit tree and send it to 
linux-next?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

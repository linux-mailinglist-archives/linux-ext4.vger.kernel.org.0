Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5735F0CA
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Apr 2021 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbhDNJZb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Apr 2021 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350395AbhDNJZa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Apr 2021 05:25:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8748C06138C
        for <linux-ext4@vger.kernel.org>; Wed, 14 Apr 2021 02:25:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so22911421edc.0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Apr 2021 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHbX9CNZcLaiMHXNZmBKODRDqd/reEdwnJR9AYcgnvs=;
        b=gINN1R9lI5tCoYH2ZPewi+utvLw1oNr+AYOfDMNtw/hKaSHIjWFrbHQ2mEP/s050tD
         g448CE9NUc6LD5cIHE915wtYMuh12ELdt/BZzVJtfcbRlcZzDt0CH8Ve04xqPwET4Rh5
         BHdMYM5h1f/E2uWaCn6cX9rtXlGY2VM249gpU+JczEOZGYRnqBdk5vjJ2O5+ToJ3ERbh
         U3FM3+/YLy3sEwiHrE30IVFtoFTTLn4R1GTNSu4oQJjn/xhueIXu1t9NC5c0QjPFa4VI
         mHQlWeb7xSouf3EcOgTxrw7wUrUZIGalS4Ba2F808A+YtDSZwP171zeWniTOjTgCp8d7
         ejDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHbX9CNZcLaiMHXNZmBKODRDqd/reEdwnJR9AYcgnvs=;
        b=sz9mZogix40lFEFX1uvHi+pCnXn0yiIPO/DTYwFhCBhLLz+TnS2X0AD1cbi+nHcuSY
         6f2PDI5ZiYGl8Fo/j9w14LEZUMUs+drQjSp9lyJovoEoZvjiO/BW0HELNvMDa3n+j6LL
         7YcT4Wns3TlU4dq6FmnV5mWLZ4F7CjhitntCT35qlqWEojmMmlrMixqJu43pYhR4p3c0
         My+El8mAk+ctGv9iI3ecLAyZd3ajVmjiu5/Vf/p+jkIN+BAsbDp+Gc7kvAVAnO0+kcna
         X3z4fp+iIwGNrPqJCEf8TFO06FdjJa+qRzLP1ejIDyFmUjm5/FGyzd7Q8YM4LfVDcMzI
         de4Q==
X-Gm-Message-State: AOAM531jKy7JvHJQL9z1T++Gw9xyPNquOyZ+AVXyzoQrPK8BINFi6nT5
        VocLpatvhd6eawXGT2wJNdqGJQ==
X-Google-Smtp-Source: ABdhPJwKI3fyWANihaNxRNJcYcXaOIyeXGZHEp2xOggKD3L098p3onGrqOxzTlf7HKaohGrVesV2FQ==
X-Received: by 2002:aa7:c907:: with SMTP id b7mr40534459edt.37.1618392305540;
        Wed, 14 Apr 2021 02:25:05 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:bfbf:e0a9:a746:c4b9])
        by smtp.gmail.com with ESMTPSA id t14sm9473304ejc.121.2021.04.14.02.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 02:25:05 -0700 (PDT)
To:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org
Cc:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        linux-ext4@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, linux-m68k@lists.linux-m68k.org,
        geert@linux-m68k.org, tytso@mit.edu,
        mathew.j.martineau@linux.intel.com, davem@davemloft.net,
        broonie@kernel.org, davidgow@google.com, skhan@linuxfoundation.org,
        mptcp@lists.linux.dev
References: <cover.1618388989.git.npache@redhat.com>
 <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
Message-ID: <e26fbcc8-ba3e-573a-523d-9c5d5f84bc46@tessares.net>
Date:   Wed, 14 Apr 2021 11:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Nico,

On 14/04/2021 10:58, Nico Pache wrote:
> Drop 'S' from end of CONFIG_MPTCP_KUNIT_TESTS inorder to adhear to the
> KUNIT *_KUNIT_TEST config name format.

For MPTCP, we have multiple KUnit tests: crypto and token. That's why we 
wrote TESTS with a S.

I'm fine without S if we need to stick with KUnit' standard. But maybe 
the standard wants us to split the two tests and create 
MPTCP_TOKEN_KUNIT_TEST and MPTCP_TOKEN_KUNIT_TEST config?

In this case, we could eventually keep MPTCP_KUNIT_TESTS which will in 
charge of selecting the two new ones.

Up to the KUnit maintainers to decide ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

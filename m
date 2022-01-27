Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC949DB2B
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jan 2022 08:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiA0HGy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jan 2022 02:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HGy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jan 2022 02:06:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A32C061714
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jan 2022 23:06:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so2617793wmd.5
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jan 2022 23:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Dw2vsnDPy4bAOFWcdaGeSZdx/xcsSNnShvjql+tRmx8=;
        b=RCk6D6EeCg/9Qfd0K9c/eC8WIrD8YZng0Jw33h9j2LSIIwmgSSPmTZODxvqQ5yCMwy
         ZD3GrH2XH0oPlsGdXt+4lTT0vd3Sm7nwfIk4Z0KU0kNkGzli5V5cnP9RyrHB6GiCNaIr
         8Iy0j5eDD9myWkdaGJL8kHwYGEUtkxvez6MdWY7ftjotmN7fd1g0HevR2EQSeS4dETxx
         dhwsX6kunXvy2adw4e6j4Be/WX3DoQc9b7RF4GgKqg6YnK+OKSEqQwxpu+ielQuGxaFb
         SkZ7e73oEOTWNXutb3LtSdgPK96aCGQtSQQGLZoj7PBq4bqSWino+IkgGoMvC4g7O9FR
         sopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Dw2vsnDPy4bAOFWcdaGeSZdx/xcsSNnShvjql+tRmx8=;
        b=krbM9lWMSlRTB7VMTHmEDPPC081lgLBeVPwdlnxIuZ9asZjKfyir6HndkGWjtwQM59
         /h0xqb0vPmzBcXhdhzjQGuLGWWBJhzpdyb3Agg8fhjvFGdfmDlZ/bl2NUEb11sqooe/D
         WCZIDocFTV1u8NUTiXEu8O4lqKPt63L0ZVmARF9uL+TRMdtZfK50z38haFkBgsd910vW
         Wq2axvPzi54dDOKDs6bB7axOn8takc0XX/8eC4PjnD0yP8Gc5r7pSAjdBjCCT1KeSI0n
         4wViVBsm6Tw8IhhJzql/YFFBEIAu6fjZikZKCXqukDqyjcZygz4vs4jb6aEZguAT6pR1
         iQYg==
X-Gm-Message-State: AOAM530k1xObBU72D43QVFKLg3MOssJqR0fG650kfMVR2Tsr/fs2hvOX
        S5/Otnl+AX2VFdagD2rkOn9d4A2K1vCjUg==
X-Google-Smtp-Source: ABdhPJyPmStBo713qw0nBMDmn8ziKBg5Gz20C9MprW7T/XmiaDtm3SK5u/bmD/LayK0Y337F9RasFQ==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr10469322wmd.167.1643267212300;
        Wed, 26 Jan 2022 23:06:52 -0800 (PST)
Received: from [192.168.88.236] (79-69-186-222.dynamic.dsl.as9105.com. [79.69.186.222])
        by smtp.gmail.com with ESMTPSA id 1sm1197585wmo.37.2022.01.26.23.06.51
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 23:06:52 -0800 (PST)
From:   Maxim Blinov <maxim.blinov@embecosm.com>
To:     linux-ext4@vger.kernel.org
Subject: Help! How to delete an 8094-byte PATH?
Message-ID: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
Date:   Thu, 27 Jan 2022 07:06:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

I'm not a subscriber to this list (so please put me in the CC), but I've
hit a really annoying un-googleable issue that I don't know who to ask
about.

A runaway script has been recursively creating sub-directories under
sub-directories until it hit the (apparent) OS limit. The path in
question goes something like this:

/work/build-native/binutils-gdb/gnulib/confdir3/confdir3/confdir3/confdir3/confdir3/........
(you get the idea)

It was only stopped by the following error:
mkdir: cannot create directory 'confdir3': File name too long

OK, fine, that was silly but whatever, right? I tried to delete this
huge directory from the top with

rm -rf confdir3/

but that simply generated the same error as above. So, I figured "Hey,
I'll just walk all the way to the bottom, and delete the directories
one-by-one bottom up". Here's the script I ran to get to the bottom:

$ for i in $(seq 999999); do echo "im $i levels deep"; cd confdir3; done;

It then ran for a while, and eventually I got to the bottom:

```
...
im 892 levels deep
im 893 levels deep
im 894 levels deep
im 895 levels deep
im 896 levels deep
bash: cd: confdir3: File name too long
$ ls
<nothing here>
```

So then, I `cd ../`, and `rmdir confdir3`, but even here, I get

rmdir: failed to remove 'confdir3/': File name too long

I would be very grateful if someone could please help suggest how I
might get this infernal tower of directories off of my precious ext4
partition.

I was thinking maybe there's some kind of magic "forget this directory
inode ever existed" command, but I am out of my depth with filesystems.

Best Regards,

Maxim Blinov

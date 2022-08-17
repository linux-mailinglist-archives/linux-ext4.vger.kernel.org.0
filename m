Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967A596EAD
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHQMmx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiHQMmw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 08:42:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73089908
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 05:42:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id jm11so9683095plb.13
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4STvXWpvbow12e0C1k6z0nR3Pwe4vj/lzkg+JX2AG/Q=;
        b=Xbi0tGL19gmk8OdqZm7qU0z8y9SsmtNz4PkaMXsz6OH+bp8Hc9nPJzSek3BHtuJ5VU
         kIA9F7X7x+JeDkQ8J0brog9e3Xr4KW0EbdLjQJBwGTQzulLQ9mgI7Z3LFLfHAxVmg8gs
         GGE7Jh3kDD9p/ek1wf30L9YfmGk9M1QuXo8FfA695mrsPV+w5UHEyr19CUYsx49bE7mC
         64tNn8wVZgft/DmBABs1KzkoCEb5kh19CeR/cEbLQR38OQiqkGPtFtmHGFWHrXdqoz0c
         6WY4p4HcQXR7nvzwU9q9R6wSDQN76h19Zujz6pnwF0ry/Xlj1zBKGYpufSt72+HEjwYv
         B1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4STvXWpvbow12e0C1k6z0nR3Pwe4vj/lzkg+JX2AG/Q=;
        b=18ymG1Pkf/UeIoEP5OUVUdpmFtegL+EcBDdLb+1IDwxCx/4hpj1OApAq4u2Vt33siH
         EdgzCLDiP4AhONR3M1k7Q51BbNYimvqumAPPzZJP9LbdbuGI/6zvdtljIteQi3e2hiIy
         OhfH4a/rVz2QyrCGz7pO+/8D2DvKwcWzqgw/lfAqDh+vXtg7NIoazmtTwzvVkh1Z7/Jc
         DX1maaDJm9klucJ4CUZXqcM5RO12Gy8BewvToKNrxs7dWb5h4QsuHSE/T8FZx004gOH+
         igeZ43Ejas9vpVVKlvaV68iLI10rvnSJrE45PzB+b7D3qLR0c62Rz/Y9KQ9uueugYik6
         YNbQ==
X-Gm-Message-State: ACgBeo3zlyM1uDidCeNIilnxObbQkeBxba0jYyjy9l8iZjfUyp3vDk4Q
        wWhZ+tXuA89QuourSPrvp6M=
X-Google-Smtp-Source: AA6agR5kCB4re95YQwlOr2aCwP5I/+ZY6Sc4Ht0CwC6kHVaOGyUqud6IyI7K6Y6rfoDZaVkL1Om0MQ==
X-Received: by 2002:a17:902:db08:b0:170:9ba1:92e9 with SMTP id m8-20020a170902db0800b001709ba192e9mr26140734plx.45.1660740170728;
        Wed, 17 Aug 2022 05:42:50 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090a1c9000b001f30f823145sm1426974pjt.55.2022.08.17.05.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:42:50 -0700 (PDT)
Message-ID: <6ab696fb-c9e8-b9a7-8b51-3ed697f515db@gmail.com>
Date:   Wed, 17 Aug 2022 20:42:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia> <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area> <YuH4nY6DGodheXoE@mit.edu>
 <20220802032559.GB3861211@dread.disaster.area>
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <20220802032559.GB3861211@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 2022/8/2 11:25, Dave Chinner wrote:
>> I don't particularly worry about "responsible disclosure" because I
>> don't consider fuzzed file system crashes to be a particularly serious
>> security concern.  There are some crazy container folks who think
>> containers are just as secure(tm) as VM's, and who advocate allowing
>> untrusted containers to mount arbitrary file system images and expect
>> that this not cause the "host" OS to crash or get compromised.  Those
>> people are insane(tm), and I don't particularly worry about their use
>> cases.
> 
> They may be "crazy container" use cases, but anything we can do to
> make that safer is a good thing.
> 
> 
> But if the filesystem crashes or has a bug that can be exploited
> during the mount process....
> 

I think filesystem-safety is very import to consumer devices like 
computers or smartphones, at least for those filesystems designed for 
(or widely used for) data exchange, like fat and exfat. Please see my 
comments below.

On the other hand, filesystem designed for internal use like ext4 or xfs 
can ignore deliberate manipulation but users still expect they can deal 
with random errors, e.g. you don't want whole file server down because 
of single faulty disk. And this has nothing to do with containers.


>> If you have a Linux laptop with an automounter enabled it's possible
>> that when you plug in a USB stick containing a corrupted file system,
>> it could cause the system to crash.  But that requires physical access
>> to the machine, and if you have physical access, there is no shortage
>> of problems you could cause in any case.
> 
> Yes, the real issue is that distros automount filesystems with
> "noexec,nosuid,nodev". They use these mount options so that the OS
> protects against trojanned permissions and binaries on the untrusted
> filesystem, thereby preventing most of the vectors an untrusted
> filesystem can use to subvert the security of the system without the
> user first making an explicit choice to allow the system to run
> untrusted code.
> 
> But exploiting an automoutner does not require physical access at
> all. Anyone who says this is ignoring the elephant in the room:
> supply chain attacks.guarantee
> 
> All it requires is a supply chain to be subverted somehere, and now
> the USB drive that contains the drivers for your special hardware
> from a manufacturer you trust (and with manufacturer
> trust/anti-tamper seals intact) now powns your machine when you plug
> it in.
> 
> Did the user do anything wrong? No, not at all. But they could
> have a big problem if filesystem developers don't care about
> threat models like subverted supply chains and leave the door wide
> open even when the user does all the right things...
> 

Yes, an attack need physical access doesn't means the attacker need 
physical access.

USB sticks (or more generally, external storage devices), is still a 
very important way to exchange data between computers (and/or smart 
devices), although it's not as common as before. No safe guarantee here 
means there is no way to even read untrusted filesystems without using 
virtual machines / DMZ machines. Thus, using untrusted filesystems 
natively will become "give root privilege to those who wrote to that 
filesystem". That makes me recall the nightmare of autorun.inf worms on 
Windows platforms. I think no user/vendor really want this. At least I'm 
sure it would be scandal for Tesla if their cars can be hacked by 
inserting a USB stick.

Best Regards,
Zhang Boyang

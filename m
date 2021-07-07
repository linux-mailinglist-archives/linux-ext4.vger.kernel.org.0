Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93193BEF9A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhGGSpJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhGGSpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 14:45:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12DC061574
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jul 2021 11:42:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ga42so4865766ejc.6
        for <linux-ext4@vger.kernel.org>; Wed, 07 Jul 2021 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=famzah-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Ev4xLSy5HqW3W1Px7/oMFO+6V02IJLBRYDeDv5aAbpY=;
        b=Luz25RWXmjWPH9pu6L6FihGJbijG+aU0t78SN8YLyy4rBolPKXm97pNP4Ma20TbWdN
         0gL9uz81Y2gXCayqVhejyG7d9udFHRmXU4QlsUNxUuzUK3iv7TJe50hGZYT/qwD2BF6W
         AehQtcWtSQFUyU2J2zuAIOw0djFwH5Cs+9VD4aUHvWJlcxrarTKGfGxXf+zKJwWFiT+e
         1ovluYr0Euh2KMp3UyOMQgcWL5i/ZYt97BOkCHeD4FntnqX0EBXsTi8c5DOBpGAGbOVq
         U6IYeWOWPbpHccX9QpQg1xrsiIyxNMptVNVXsbWbusEMB1OjSxOX4iuOPiXgvmRhNy8H
         9lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Ev4xLSy5HqW3W1Px7/oMFO+6V02IJLBRYDeDv5aAbpY=;
        b=KkYKbfXuV9e1/eXNkNTy5/YJrnm/xEovvHasdTHGGCqHybW0d3McdsfhLbKeAi2UNn
         HxdNVoXD9W2QK+FR2d89+B0+62fvWCxIP+i2/lG9nYgROshFftHsGORHsTP9qkAEhRPF
         A6oEc0IdBX3ou1wpgW+01kQVbBZOCKUbfi5F+ALEKNJ9rb6SwMoAghnMg1JFZomeO7Ia
         Wh0XZkePv6L9H+2UgvGEmeAWIy/GC+KzBeHFBx8zfCzBk7w1MpYk69QXRw1reIb/1oe8
         Nz2SyiJ653h58tiakLCXgf4iqLIH/h64KxCiVNo+pwSDlc7flpj2ENl6gkiQIjvlNkW5
         UdYg==
X-Gm-Message-State: AOAM533bs4As2r1n47a4Jr/HSocczW7rFc89rJyt6yqZelaacH2BeIzo
        exU5glFbNLF7JEZ6cGK0UqGfni8rP50kpA==
X-Google-Smtp-Source: ABdhPJyHcvRilpxYpPJl6OaeI+Bzq5U6dh8lRIs9KZ2MSXYi3+UTpb6AqmLZGbYKpn3qCdMUOp62WQ==
X-Received: by 2002:a17:906:d8cf:: with SMTP id re15mr25995743ejb.410.1625683347277;
        Wed, 07 Jul 2021 11:42:27 -0700 (PDT)
Received: from [213.145.98.224] (224.98.145.213.in-addr.arpa. [213.145.98.224])
        by smtp.googlemail.com with ESMTPSA id x16sm4717882ejj.74.2021.07.07.11.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:42:27 -0700 (PDT)
To:     linux-ext4@vger.kernel.org
From:   Ivan Zahariev <famzah@famzah.net>
Subject: jbd2: fix deadlock while checkpoint thread waits commit thread to
 finish (backport to 4.14)
Message-ID: <3221ced0-e8f3-53da-3474-28367272f35d@famzah.net>
Date:   Wed, 7 Jul 2021 21:42:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

We're running Linux kernel 4.14.x and our systems occasionally suffer a 
bug which is already fixed: 
https://github.com/torvalds/linux/commit/53cf978457325d8fb2cdecd7981b31a8229e446e

This bugfix hasn't been ported to Linux kernels 4.14 or 4.19. The patch 
applies cleanly. The two files "fs/jbd2/checkpoint.c" and 
"fs/jbd2/journal.c" seem pretty identical in the affected sections 
compared to kernel 5.4 where we have this bugfix already applied.

Is it on purpose that this bugfix hasn't been ported to 4.14? Is it safe 
that we backport it manually in our kernel 4.14 builds? Or is the "ext4" 
system in 4.14 and 5.4 fundamentally different and this would lead to 
data loss or other problems?

Thank you.

Best regards.
--Ivan


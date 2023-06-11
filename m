Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0472B002
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFKC2A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Jun 2023 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFKC17 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 10 Jun 2023 22:27:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70750359D;
        Sat, 10 Jun 2023 19:27:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-543d32eed7cso1230555a12.2;
        Sat, 10 Jun 2023 19:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686450474; x=1689042474;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZKyrk80GHGRjJOdJJel001FvO+j2KlRrTx+XA1IwaY=;
        b=SShXsAlVmeCsuDtXoC4sUVjP18LPMX5YXeAyzaUykqPgqjdinAS9aVALm4NbO1tENU
         Vp4dQgXCSDwH+qUoBfttSyBYTYTZPMWvUSAkKBWX8zlC6q3TmvR4q67zT5GFZgOgA973
         WzAS0BkwQg77hZol7FWQfT2ebs7aA+3y4pRCwZumd1wInTQQohKXcvTnkPsVBvlfLr8x
         71ovfgqOPS/0sWJvrXeLGzfzVYaxpToSe73LAIEkTIwP7dC+/DZuxPDPTMFgKKMed0y/
         jpbWFAl40YRFaEvEIG9J58aJLwNf7M7QCo3Fpre208BwXo3PpYUE8jgsOklS+KKGVnew
         RaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686450474; x=1689042474;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZKyrk80GHGRjJOdJJel001FvO+j2KlRrTx+XA1IwaY=;
        b=Z6vKJIG7xZkLm+v9v7aA0iNuALkTYV3u82iVlqhQ8xmR2Q9dsnxl10eTQqhUD5tRlV
         PKE1NGpMLTu4S5H0ULOaj7hItqN6yKtQww1/sLxh7DqPdvr+8mDEB3fMCTMsEWDdd8rL
         UpKJ4l840B6kWWl7isuEXs5G8DQP49ViJ3eWxe3peeQh2zCWgotSisxJDpQ+9ECpMXmp
         PcdiAj6o1OsQlgYBkI33y1BZhIczNIt1oD3/SlVuI6pk5frgZ0gFT/gSRrEnX/noZeTe
         a1Oo3kZdl/lWkK2k9sUPZ3DdKCelF1m7ioeeGl1CeANfMEFy3hnWWWHH+7MVd38WvIrV
         QK0g==
X-Gm-Message-State: AC+VfDz3oYJw7vHYt0fMCax4TJPz/3XFtxhUnsCPEgW2t6qXNNl92SSo
        NDPmVWIz1afZfG76qs3meoqWTr+xLmZhbA==
X-Google-Smtp-Source: ACHHUZ6HnAVMhp2lSn0I3LgkbxqGHsODoUKgxm2ScyRFWnbq0b/2evpKIWwkzHPOPOpKkT4UrbW10Q==
X-Received: by 2002:a17:90b:3b90:b0:259:d0f2:3576 with SMTP id pc16-20020a17090b3b9000b00259d0f23576mr5008901pjb.19.1686450473758;
        Sat, 10 Jun 2023 19:27:53 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-75.three.co.id. [180.214.233.75])
        by smtp.gmail.com with ESMTPSA id z7-20020a170902708700b001ae3b51269dsm5566976plk.262.2023.06.10.19.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 19:27:53 -0700 (PDT)
Message-ID: <17d7e7f8-ad8d-1696-32b7-3ff9fd4548c1@gmail.com>
Date:   Sun, 11 Jun 2023 09:27:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ext4 Development <linux-ext4@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: ext4_check_descriptors: Block bitmap for group 0 overlaps block
 group descriptors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hi,
> 
> Fail to mount a filesystem in kernel 6.4.0
> 
> The Filesystem is clean. fsck -fp reports no errors
> 
> # uname -a
> Linux medusa.dds.de 6.4.0-rc5 #2 SMP PREEMPT_DYNAMIC Wed Jun  7 08:11:59 CEST 2023 x86_64 GNU/Linux
> # mount /dev/bigvg/lv_dat /mnt
> mount: /mnt: mount(2) system call failed: Structure needs cleaning.
>        dmesg(1) may have more information after failed mount system call.
> 
> Under Kernel 6.3.4 everything works with this Filesystem

The reporter then pasted short dmesg snippet:

> [  104.501659] EXT4-fs (dm-9): ext4_check_descriptors: Block bitmap for group 0 overlaps block group descriptors
> [  104.501664] EXT4-fs (dm-9): group descriptors corrupted!
> 

See Bugzilla for the full thread and attached dumpe2fs, lspci, and systeminfo.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v6.3..v6.4 https://bugzilla.kernel.org/show_bug.cgi?id=217534
#regzbot title: Block bitmap for group 0 overlaps block group descriptors, causing mount failure

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217534

-- 
An old man doll... just what I always wanted! - Clara

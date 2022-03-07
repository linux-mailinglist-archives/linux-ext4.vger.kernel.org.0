Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765B4D0054
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiCGNnv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Mar 2022 08:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCGNnu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Mar 2022 08:43:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C831537
        for <linux-ext4@vger.kernel.org>; Mon,  7 Mar 2022 05:42:56 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e15so12224897pfv.11
        for <linux-ext4@vger.kernel.org>; Mon, 07 Mar 2022 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dO6x0urderFyV2KEmYHOZGi+h8qzVo3thAZZhX59WVI=;
        b=5ivy39D4HyOHzg3oXUga22rP3KTFbBIawIRKB8iyjtZt6Z58pqc4Vql+X/c079mPEJ
         f46YzW+GeFbCYLaUqhF8sKcWOG7kD0I6IAOSSvNUN25urxnis6OsYxY004mMcZ7s8Ot6
         Cv40ygftIN8yDAI7xlnfg/uCigTwKBqyuwZcEuTsz996r2SqMANbP8/hilAuT89IyDnb
         WDuKNZ/1/Ni+EBzc2RTEpBTQosuTWCnL43mmiICwJHjHdRofOxPPziZaIADND/ymXIH7
         tzcUUP6N+Xo2Ct9hWPxVf5lBpRv8YJIceX/H68gQoUM3KU1za/aPz5aLYjJdmyuMB5mY
         FICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dO6x0urderFyV2KEmYHOZGi+h8qzVo3thAZZhX59WVI=;
        b=aXWjwcS2LWtkrbjLZsJ8cjdImENLnrrNEXXlsx8X6ocwBPFIdJ5zf6Od6ACpQbx0iL
         K5Q9zSoiimfJ3NvVrpsaol+1VlJ34IgZZzVA/3YGjk7dS9sTYUS5PUXE8CBXrSvCu2EM
         AOe/a7XckPDPVj29MDkoM8l6TiYdhfwJC3wC3rAPdMmHj5wSohNxefUCsfK/mxnz7i49
         M5XTAiiXog8dt0/tAHsjeat23DLvlABOuv9ND8B2DCo38iaBRTQ3P/lTlj7/XPi642T7
         HGoX9eXkKuz6PnJ5qAOD3BffngaEe+6Su9kWACJxOY3fboCbG2hW+/cXnq+4cc6yrOxS
         M4mg==
X-Gm-Message-State: AOAM532dkXDBA5P5uPSqdxgf+L7oP/3hQWAaMA1/hMqWb6BRqGA8DkJJ
        Mydhq7M5LD5VZkDwq9/HCb1gzA==
X-Google-Smtp-Source: ABdhPJw5/FtlFVkWiR7cSvl2rHTtKJ6vmy5dszUzno3/VlrXoUuSSW3LtUf6Iv+dMHFIDtyxNHJnyA==
X-Received: by 2002:a63:6908:0:b0:372:d919:82ed with SMTP id e8-20020a636908000000b00372d91982edmr10020149pgc.104.1646660575327;
        Mon, 07 Mar 2022 05:42:55 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 78-20020a621451000000b004f6e8a033b5sm6745253pfu.142.2022.03.07.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:42:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-raid@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Song Liu <song@kernel.org>
In-Reply-To: <20220304180105.409765-1-hch@lst.de>
References: <20220304180105.409765-1-hch@lst.de>
Subject: Re: remove bio_devname
Message-Id: <164666057398.15541.7415780807920631127.b4-ty@kernel.dk>
Date:   Mon, 07 Mar 2022 06:42:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 4 Mar 2022 19:00:55 +0100, Christoph Hellwig wrote:
> this series removes the bio_devname helper and just switches all users
> to use the %pg format string directly.
> 
> Diffstat
>  block/bio.c               |    6 ------
>  block/blk-core.c          |   25 +++++++------------------
>  drivers/block/pktcdvd.c   |    9 +--------
>  drivers/md/dm-crypt.c     |   10 ++++------
>  drivers/md/dm-integrity.c |    5 ++---
>  drivers/md/md-multipath.c |    9 ++++-----
>  drivers/md/raid1.c        |    5 ++---
>  drivers/md/raid5-ppl.c    |   13 ++++---------
>  fs/ext4/page-io.c         |    5 ++---
>  include/linux/bio.h       |    2 --
>  10 files changed, 26 insertions(+), 63 deletions(-)
> 
> [...]

Applied, thanks!

[01/10] block: fix and cleanup bio_check_ro
        commit: 57e95e4670d1126c103305bcf34a9442f49f6d6a
[02/10] block: remove handle_bad_sector
        commit: ad740780bbc2fe37856f944dbbaff07aac9db9e3
[03/10] pktcdvd: remove a pointless debug check in pkt_submit_bio
        commit: 47c426d5241795cfcd9be748c44d1b2e2987ce70
[04/10] dm-crypt: stop using bio_devname
        commit: 66671719650085f92fd460d2a356c33f9198dd35
[05/10] dm-integrity: stop using bio_devname
        commit: 0a806cfde82fcd1fb856864e33d17c68d1b51dee
[06/10] md-multipath: stop using bio_devname
        commit: ee1925bd834418218c782c94e889f826d40b14d5
[07/10] raid1: stop using bio_devname
        commit: ac483eb375fa4a815a515945a5456086c197430e
[08/10] raid5-ppl: stop using bio_devname
        commit: c7dec4623c9cde20dad8de319d177ed6aa382aaa
[09/10] ext4: stop using bio_devname
        commit: 734294e47a2ec48fd25dcf2d96cdf2c6c6740c00
[10/10] block: remove bio_devname
        commit: 97939610b893de068c82c347d06319cd231a4602

Best regards,
-- 
Jens Axboe



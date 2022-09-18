Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD25BBD73
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Sep 2022 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIRKdl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 18 Sep 2022 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRKdj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 18 Sep 2022 06:33:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11361DA67
        for <linux-ext4@vger.kernel.org>; Sun, 18 Sep 2022 03:33:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb3so28763001ejb.9
        for <linux-ext4@vger.kernel.org>; Sun, 18 Sep 2022 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=mAqSDukE27pRl9JzgDtjNMx2nR6WnXWe1hBC0SoTGH0=;
        b=BVGVTRvnARQoY8S6eX/mt5o3098Ub2ruYN/xcFxXG5g0s2y8i/Q0RNx40OwWPbnJqe
         W9xipIYm32a9tKs2vmBjh71qP0vvngSSBQGQkmY7oxcTPDK1JmZbPFXZUIeODXfcKCNl
         bRkDISmzGD7YHiGW23vFma2f6M1a7t9HjpsuOLOY7zJveuIfaaoe9uo53NkaOOAbQ3S0
         nTPhs3rUtQC/dsTxxE86vYPuEHYoaf1dtIxAasutmHzRBV2+g6EGvZj8k90QCYcu/iOz
         ArRc37hxs2f5NvIJAeBkCmmVvUbxYj2yNzND1kygdeEPX3SWgJmkipSGDwNX/qhYJulB
         fnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mAqSDukE27pRl9JzgDtjNMx2nR6WnXWe1hBC0SoTGH0=;
        b=2XAzPKmo/tXGQAum5MGk6h83tVnBa/JMFxW7dyE9zbz++VG51vJnWYuXPozgIE39o9
         2AlnhqRBeIMFkWeAhCnT0DxTC9rZAVi2UJvU1KMmbEM7ZD9ArysgVBq/wpFepaaS3U4l
         +DA1FxCKxE7/Jsr1qLisKrB9O/d59Qz3UcZhAgZz6e761yJy3pbkNQdCKMgdCnIyh9iX
         PL878n/hpfefYtQSXxs9El5p52HIrT0TER2syibClr2lQoLeUFitZDlHE25CSbMsIqnB
         JNdF3UnP8DteYxQjwLjW420tImbLsrFx2KGBpq1qRLSbKFae4NwTK7TUVufWY+jCXOrx
         AcbQ==
X-Gm-Message-State: ACrzQf1QFPX3WKcUxI+o3r8r8Hnq7LVCKMOg8E5dl/9B5wGLdJcNFTvP
        LTIuUd53eojYksasiDRRNukwc/yMWZ6xuk+JYjH4uuImWa0=
X-Google-Smtp-Source: AMsMyM6vFiqQzYUyMKI87GjlzSOKm28+UxF5sG/nmll7A0bqhFGi65LQxlG/Qixu7JzFXj4vfpawiCIKvnI0zVzJQUU=
X-Received: by 2002:a17:906:65c6:b0:73c:8897:65b0 with SMTP id
 z6-20020a17090665c600b0073c889765b0mr9586740ejn.322.1663497217216; Sun, 18
 Sep 2022 03:33:37 -0700 (PDT)
MIME-Version: 1.0
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Sun, 18 Sep 2022 18:33:26 +0800
Message-ID: <CAHB1Naj3y12kez5O66a9o-6tXu_Rf9svXCQK3eZfD38uO6pEwg@mail.gmail.com>
Subject: xfstests ext4/049 failed on 5.9.16
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Recently I ran xfstests on 5.9.16, and I noticed that ext4/049 failed.
This case is tested for commit a149d2a5cabb (ext4: fix check to
prevent false positive report of incorrect used inodes). The reason is
that this commit is not merged in the 5.9.y branch, should we merge it
into the 5.9.y as well as other unmerged branches?

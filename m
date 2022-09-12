Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E16F5B5AE5
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiILNKG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiILNKE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 09:10:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A1F14005
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 06:10:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f20so8215523edf.6
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=8jQC7//WNV6hD0fu47qIxc2D1tR6QQ/lIWxL2H/+dqU=;
        b=bY03QIp+rpoakQZIfXfikYwrNxuSccpKUdo8qHTTAkfAe7EsryVDRl3XO9MlY10LvV
         hobkLQD+TSvSqh061mvosFj3SA4v2t2Xo7tEQ3potCYkunXzsRvF9s3VMfQPYYmLF2oJ
         p6aLHxfvLf53kBpgacyTiUZJafTQmVZiUADBeR171oJUGUEzNjmDMxtpxwXkwdg82d/z
         cotoblWjRS3YAjvjGTX4RvXjGWvpkFplMCUk7Z90LM2ysfW2sK1cbVBht+6+GF0ct0Kk
         5oPXMvKaz5kZVydum5zIDjngIbyCD/cza6zsyBSAiHCnwZo/RvArJtvo70PCc39E8F0Q
         1Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=8jQC7//WNV6hD0fu47qIxc2D1tR6QQ/lIWxL2H/+dqU=;
        b=hxe6GUpSDmRnshvRo1hfENqif1sx40GEY0YFw+Fy4id1+wQEMU1G0HtyrTLCdzK7CB
         QrNhrov6lrF5ky2N2Rx3naAi7l5qzEA9DnTA+Ng6GYvOAafOyQFXsNQOAwe+I5+GAUL4
         hvxAbLFjHsSglK+Ln3TkXvv3bgg8UqUgGA7YzMoJgvbJIofJxOSP9pA0zpCdUMOgzZEH
         WTiwYODy3BpbqjfR4g36AzOKYZu/1Hc9smj+uveV4rsfPDymcsgLwmlEVwn3DKrUjuxn
         HzS4ErMt5D0Hj7H+nG5LnLGFubRNkeYJnrr7emeUFJIK44dmWyTVAaUwuC2zdPx2GLW3
         o3aw==
X-Gm-Message-State: ACgBeo2PxrS7RYMV7FWlUrAafxbFN7g+rD/AS5bej5IrItyDYNyB05qS
        Wk8aFF1ta7e5PKzz33aCn4rKPmdukV49U02SCrwEpt27sBdH0fOw
X-Google-Smtp-Source: AA6agR5NPzaT+BV8uhkXc6ybkaVz2XKphMeW8cbTvKmbDjZD2eLZG+w0yyjDdr40cIW0kGcTdvEfbNZTq/qGt9mOtyQ=
X-Received: by 2002:a05:6402:90d:b0:443:ef4c:480f with SMTP id
 g13-20020a056402090d00b00443ef4c480fmr21927927edz.128.1662988200262; Mon, 12
 Sep 2022 06:10:00 -0700 (PDT)
MIME-Version: 1.0
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Mon, 12 Sep 2022 21:09:48 +0800
Message-ID: <CAHB1NahK6LMggGEcoCfhun6rAWiyrANnNR5+d93c07WsZk6Kvg@mail.gmail.com>
Subject: How does newbie find bugs in ext4?
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted.
I am a new guy in ext4, may I ask several questions about ext4?
I am very interested in ext4 file system and have been reading and
debugging ext4 source code for 2-3 months(just about basic
open(create)/close read/write, do not involve advanced features). I
want to contribute to ext4 but I find it seems hard only by reading
and debugging by myself, can't even find bugs. I only sent two patches
up to now. The reason that I could not find bugs in ext4 may be that I
could not understand code deeply only by reading and debugging them...
And I find many contributors fix bugs which are found at work, but my
company will not give me opportunity to trace the bug in the kernel,
they just tell users "this is a bug in linux", and I could not repro
that by myself...
Could you please provide some suggestions for people who want to
contribute to ext4 like me? Any suggestions about how to start
contributing to ext4 step by step? I mean, really bugs fix other than
document correction(This is also very important and one of the patches
I have sent is about document correction, but I want to learn ext4
more deeply). I know that there is xfs-tests project which is used for
testing ext4/xfs, but I think ext4 developers will pass all test cases
before releasing a new version, so is it necessary to retest ext4
using xfs-tests?
Best regards.

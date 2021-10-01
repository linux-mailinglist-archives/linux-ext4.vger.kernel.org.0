Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6861341EC8B
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353896AbhJALvg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 07:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353771AbhJALvf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 07:51:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC37C061775
        for <linux-ext4@vger.kernel.org>; Fri,  1 Oct 2021 04:49:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x7so32678093edd.6
        for <linux-ext4@vger.kernel.org>; Fri, 01 Oct 2021 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=yhjheNI5MEnyZY0tqqwyqqVXxlQtJnGlEnfizEhjEq4=;
        b=0XtBLWB/JefBKcFrkITj3SyZs6m3cdGCT89Zw7rgtGckcg+4uPRbq+YI7Jj4WOBL08
         VncqOAkN4GrNioWpdy/jGKjl3uhidEZtUaMd7zXFWgrpvYd34KH9IIuK4jjScUYQzZR/
         Rqd+FwXk7y5JTgfGPatxqAVgHucs4m6EKhS8O8s+tdBBy5GnYmQErtEW2VWThcQKVx3j
         uiGUG+IaruLr9q/wZHpWnBkKAIsAcqbUsgxeyXWUu16Aoe//qNgUIci3Zz15dyThjLdB
         jp+N/PLAMv9vP7PJcVqEfxX1IG7y8h0y3QBwHkyqxzyyd5aUpekQj1FcEBJPRbvHoLKa
         TtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yhjheNI5MEnyZY0tqqwyqqVXxlQtJnGlEnfizEhjEq4=;
        b=PWeYqPeePa03kPOM9MEYpmLiQ1/N3lVTDmG/yt7TRwSqy8V+oeiH45Ym6gGISjX/5E
         4dMOnbPW3a0Y7/jPFQrp60iqTJbJR/TJtqdYcGTJPaAiAiRyE1sTIw7UCzVB08d6Zurg
         fnTdLTA4bsb6f7RmJmCBGGvz3pkWicvmg1LXYFf2eQuukQ8ujVFtieto97WnVx/kE+7U
         oQUp77zVkjroOEb7Iy1Plkdpx1wFs2hDcZ6MoPFvbb7SctxtiJWxPZfSFJUOaSHrN8TV
         GudHa0qJxaTAWPvZDalCp2N9tUmJIZz6RI8BN6+tRx9V2QuEz/gKNJSPHYbYyyXpjjQq
         1baw==
X-Gm-Message-State: AOAM533Axbo4LXgW0wx+HAQpCC49DvCnItTBFooIIlG04p9H1L/0Ibqb
        SyrjIqKaC27UeW5EP+4y0LWSrNX5O427v3T36rtMxhYMtoq4Tg==
X-Google-Smtp-Source: ABdhPJx3AOyd7Ig9B97vKOTmTk1zK5x2n/qq8MEIfGTFtAE9VkxS+yBttfQHoPKexT6Ni64+erXn5dNnxnowDrKihm8=
X-Received: by 2002:a17:906:a408:: with SMTP id l8mr5821886ejz.489.1633088989430;
 Fri, 01 Oct 2021 04:49:49 -0700 (PDT)
MIME-Version: 1.0
From:   Avi Deitcher <avi@deitcher.net>
Date:   Fri, 1 Oct 2021 14:49:37 +0300
Message-ID: <CAF1vpkgE3XopWRqzFqdyCWg0hQB9FtEhbWmz1t=HZPE+WNEQ3A@mail.gmail.com>
Subject: algorithm for half-md4 used in htree directories
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I have been trying to understand the algorithm used for the "half-md4"
in htree-structured directories. Going through the code (and trying
not to get into reverse engineering), it looks like it is part of md4
but not entirely? Yet any subset I take doesn't quite line up with
what I see in an actual sample.

What is the algorithm it is using to turn an entry of, e.g., "file125"
into the appropriate hash. I did run a live sample, and try to get
some form of correlation between the actual md4 hash (16 bytes) of the
above to the actual entry (4 bytes) shown by debugfs, without much
luck.

What basic thing am I missing?

Separately, how does the seed play into it?

Thanks
Avi

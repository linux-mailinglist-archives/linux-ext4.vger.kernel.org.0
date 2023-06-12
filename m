Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007E72B7CC
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFLFrM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 01:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjFLFqa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 01:46:30 -0400
X-Greylist: delayed 616 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 22:43:11 PDT
Received: from striker.routify.me (unknown [64.94.212.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA14358E
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 22:43:11 -0700 (PDT)
Received: from glitch (unknown [IPv6:2602:24c:b8f:cd90::8eb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by striker.routify.me (Postfix) with ESMTPSA id 59DE3E34;
        Mon, 12 Jun 2023 05:32:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 striker.routify.me 59DE3E34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=striker-outgoing; t=1686547971;
        bh=OpuZonpOnWj1ze09y0fzISAkhENi9z8b6394SLSE3Dg=;
        h=Date:From:To:Cc:Subject:From;
        b=dABR/KqU7D3nbFKTGRcekMuG1xtblKLHWKpR7PLski27Ev3MnTCJJzY8RN8t0Kpsd
         T3EEF2t6TtGvKqGRk8RqA1nYSmN6BsiX/t37HgzCPjTVRG9uzZmFnpEJheZ6BEvESM
         4Cg3RWuc15GLeBSVHbXO6OzTxxQc3z8YoHx41jbk=
Date:   Sun, 11 Jun 2023 22:32:53 -0700
From:   Sean Greenslade <sean@seangreenslade.com>
To:     linux-ext4@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: RO mount of ext4 filesystem causes writes
Message-ID: <ZIauBR7YiV3rVAHL@glitch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello, folks.

I noticed a change in behavior of ext4 in recent kernels. I make use of
several luks loopback images formatted as ext4 that I mount read-only
most of the time. I use rsync to synchronize the backing images between
machines. In the past, mouning the images as read-only would not touch
the backing image contents at all, but recently this changed. Every
mount, even ones that are RO from the start, will cause some small
writes to the backing image and thus force rsync to scan the whole file.

I confirmed that the issue is still present on v6.4.rc6, so I performed
a bisect and landed on the following commit:

> eee00237fa5ec8f704f7323b54e48cc34e2d9168 is the first bad commit
> commit eee00237fa5ec8f704f7323b54e48cc34e2d9168
> Author: Ye Bin <yebin10@huawei.com>
> Date:   Tue Mar 7 14:17:02 2023 +0800
> 
>     ext4: commit super block if fs record error when journal record without error

That certainly looks like a likely cause of my issue, but I'm not
familiar enough with the ext4 code to diagnose any further. Please let
me know if you need any additional information, or if you would like me
to test anything.

Thanks,

--Sean


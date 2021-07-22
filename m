Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF03D25D7
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jul 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGVNxG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jul 2021 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhGVNxG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jul 2021 09:53:06 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jul 2021 07:33:40 PDT
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [IPv6:2801:82:80ff:7fff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A50C061575
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jul 2021 07:33:40 -0700 (PDT)
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id A897136303CA; Thu, 22 Jul 2021 11:23:42 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1626963822;
        bh=RrZkFKYuEKYxIP/oWbrs4M9gvzHSViCI2H6S5fTxTQU=;
        h=Date:From:To:Subject:From;
        b=J+RFsK2cBEH0Tl0r6TnLqAnRj7HVjAedd0wbFSQt9JKZBRKo9qxSs3/FBr2A+eudZ
         9QdfIE8n8rNpGAqzb3UKOlelix1YvTW/1Go7lez5xInUq3jw8MmioJ1yLraMWbhyVB
         0OHwreruHWTloZWzz7nADUW0epx2LIncqRfKWOiQX1Fu09v6eA64LemdvuJJyVcJet
         c9ooJj6+peb5ZfZs0e7FSbUbhZ8gNaolyTYuVSCs5999JrjagDkxVoDLOlNXSgK4XM
         GXfnILrT2cWYoQ3Ako/JziIfVNes6V3RJHEdmtzG5eO7yOnWC2s/cRxvIxWuJ37e9z
         W3EuEih5MpweQ==
Date:   Thu, 22 Jul 2021 11:23:42 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     linux-ext4@vger.kernel.org
Subject: bug with large_dir in 5.12.17
Message-ID: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is a bug when enabling large_dir in 5.12.17. I got this during a backup:

index full, reach max htree level :2
Large directory feature is not enabled on this filesystem

So I unmounted, ran tune2fs -O large_dir /dev/device and mounted again. However
this error appeared:

dx_probe:864: inode #576594294: block 144245: comm rsync: directory leaf block found instead of index block

I unmounted, ran fsck and it "salvaged" a bunch of directories. However at the
next backup run the same errors appeared again.

This is with vanilla 5.2.17.

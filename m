Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD23B5ECF96
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiI0Vxq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiI0Vxp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:53:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3031075B5;
        Tue, 27 Sep 2022 14:53:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RLrbNe032600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 17:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664315619; bh=ad0Co2gwoETAaQ3iv6PJGA2jCBbTSP7zL889h15igoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FOmxrPo5BPxRjeBGGb5xkqf1Sont2q0Xc1rqMjLR1KEJKb9Gu163T70et7Hl/3WHf
         z5ttIXJ32+QmkmhlQIPoNdpqYnOG3hdtYjfB0XQxBkMwqRAX7fnIZBeGPQr7kiaKH5
         raID9JcxZfNN97pFY4wxLmUcqXWhUppuW7xrwhDbgJoYsr7FdAqmfM01FPD8eSJa2p
         HgQsVHqhP//TQxrieUPh2KuE9eC0UcfTkjMWeCGWGeZByXnNQBUsTlWDTrUd8lpYgB
         kaY1ldcLrjO5vk1m+zPJKWL4jvk1yRlDksRlJJKmiPzKpZVR7RW/cdNIeaqjbJT/gK
         dV/GT/6iiTo+g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A33E915C528C; Tue, 27 Sep 2022 17:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, josh@joshtriplett.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't run ext4lazyinit for read-only filesystems
Date:   Tue, 27 Sep 2022 17:53:34 -0400
Message-Id: <166431556706.3511882.3840047540179825060.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <48b41da1498fcac3287e2e06b660680646c1c050.1659323972.git.josh@joshtriplett.org>
References: <48b41da1498fcac3287e2e06b660680646c1c050.1659323972.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 31 Jul 2022 20:24:53 -0700, Josh Triplett wrote:
> On a read-only filesystem, we won't invoke the block allocator, so we
> don't need to prefetch the block bitmaps.
> 
> This avoids starting and running the ext4lazyinit thread at all on a
> system with no read-write ext4 filesystems (for instance, a container VM
> with read-only filesystems underneath an overlayfs).
> 
> [...]

Applied, thanks!

[1/1] ext4: Don't run ext4lazyinit for read-only filesystems
      commit: 3490a40364962a2599bc5a8126003a47150b84d3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

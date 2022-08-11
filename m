Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87758FE64
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Aug 2022 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiHKOdx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Aug 2022 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiHKOdd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Aug 2022 10:33:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1844B956BB
        for <linux-ext4@vger.kernel.org>; Thu, 11 Aug 2022 07:32:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27BEWd7t008259
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660228360; bh=btH93kHUDL19sYRG+g4Oz+xX0+Xy+nZHIK7Wv90NhAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F90wy1ovwT4ydw+nU1S2cvPpuhO8P6HmpFflGGbUSCFazPM02xIf3MBD6DawS3g4b
         UFJM1WVNzNkhXTe7thbXG7zeOUfkjDEF9JpNAhDV/raF0cgnuwmEShTfRTXSvo+cG/
         ntdUVR12/htvrOgv1UbSk06tpTzhFP1OB1YgvIDNvdc2zwmPHQQAimULxF73hxRYyP
         B9dNG5iAw2I3BHqAigZTdiCFnEEeY64G7z4KtNf3N9g2nUVlRTZfbNMM6xiMQxUd9z
         dF7HEWWX6sYX+s5bv+GRnxhIA8GaLdndxRAaR5wEpTZnaedhh8gxTdORQp1ceKaugB
         8lEuztprQzUSw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8543815C41BE; Thu, 11 Aug 2022 10:32:38 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, okiselev@amazon.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] resize2fs: trim resize to cluster boundary
Date:   Thu, 11 Aug 2022 10:32:36 -0400
Message-Id: <166022767027.3024810.15898278112171800464.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <FD65D2E2-16C1-48D6-8CB3-BA09CC35E6DB@amazon.com>
References: <FD65D2E2-16C1-48D6-8CB3-BA09CC35E6DB@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 14 May 2022 04:17:09 +0000, Kiselev, Oleg wrote:
> This patch rounds down the size provided to resize2fs to the nearest
> cluster boundary for bigalloc filesystems.  This is similar to the
> trimming already done for page boundary alignment.  Aligning the size in
> the user space provides the right value feedback from the resize2fs
> command, which is a better user experience than trimming the size
> in the kernel.
> 
> [...]

Applied, thanks!

[1/1] resize2fs: trim resize to cluster boundary
      commit: b609d01e6d200638aad42adee922f91d91e3e642

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

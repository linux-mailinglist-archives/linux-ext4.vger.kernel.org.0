Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678C731C0C
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjFOPAV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbjFOPAJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 11:00:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04E2943
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 08:00:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FExxcY026885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686841201; bh=qC8NN7fxuUhWVEK//rGqo7hDx93g+QEST3XI0PJlCX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aGyFglYYM63OuQIWyB497lOyC9/RksmWL9lKbUnwjD3VPvKT3ampziYm2zb/SsR33
         fsu0S/44Og6tVXtiTQfRlYtcp7fXc0J+RsUPqydl0Li5/zuW32+d/socbCuBaqiE2K
         7k4sTg9EUDByTa1Rng3E3KkGFKNCPalCcCDb2TG7hkcXKjQwv0k8IZGL2jxFd5jrju
         YH+1PQX35qHZdZzEiXsZ4PDw8ov4ZefrQ0iXh1GyAPyzMrPfeEUbbN1D0fnlTUukS4
         8A+Ks9ZdUp+iEizMTGJVUBFYQIT9USM4eUrV5SUmnx1fGhPMI6NWW1hFFBiVnEObcU
         4PzUjxS9gV/oQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D153E15C02DD; Thu, 15 Jun 2023 10:59:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Drop the call to ext4_error() from ext4_get_group_info()
Date:   Thu, 15 Jun 2023 10:59:54 -0400
Message-Id: <168683994079.282246.8360074850989025705.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230614100446.14337-1-fmdefrancesco@gmail.com>
References: <20230614100446.14337-1-fmdefrancesco@gmail.com>
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


On Wed, 14 Jun 2023 12:02:55 +0200, Fabio M. De Francesco wrote:
> A recent patch added a call to ext4_error() which is problematic since
> some callers of the ext4_get_group_info() function may be holding a
> spinlock, whereas ext4_error() must never be called in atomic context.
> 
> This triggered a report from Syzbot: "BUG: sleeping function called from
> invalid context in ext4_update_super" (see the link below).
> 
> [...]

Applied, thanks!

[1/1] ext4: Drop the call to ext4_error() from ext4_get_group_info()
      commit: f451fd97dd2b78f286379203a47d9d295c467255

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

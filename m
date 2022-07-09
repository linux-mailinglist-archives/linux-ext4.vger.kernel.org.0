Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E756CA5F
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGIPht (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Jul 2022 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGIPht (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Jul 2022 11:37:49 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D161260A;
        Sat,  9 Jul 2022 08:37:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 269FbTwk024416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Jul 2022 11:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657381052; bh=9DitvARArg4OKL8NQwK5saaEpS4clc1oleOnJJ3e2rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WnkeauIe0vsGvZqf4Iq3fZsUY55/p1pMzrArEgVExy5wAUZnCd6FF0kYKcxz4eRfu
         8rh2wjw6exfCHhaWhplj7gUEEfV2iMCkKUILxUGpnZbHqIKHMJueNmgjH47yttn5Vd
         D7fg7gO29jyUtYlV8/kfDMvjgxbB/i6kwqJE1vfK6AT2NMEBNH++57saXq0adaB0Yl
         DA7cki0QU8OtP5aSt8jUyjKmaHRYRLoPBgb/zil9QBcfyGmc5FOKLDyD0BFO+8Ez8k
         FrRuksLI2Qe2f1yS5mgXYSBK7Jq1noJlVe8S2CCxH+xdbUtKRalQ2ROItoyDRqY3HA
         EXWUE5nsa/CHg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7164D15C4331; Sat,  9 Jul 2022 11:37:29 -0400 (EDT)
Date:   Sat, 9 Jul 2022 11:37:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/21] docs: ext4: blockmap.rst: fix a broken table
Message-ID: <YsmguYemOmrLLXt9@mit.edu>
References: <cover.1657360984.git.mchehab@kernel.org>
 <29d2a3787e46de72db8563b8c08f593b6b6f0c14.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d2a3787e46de72db8563b8c08f593b6b6f0c14.1657360984.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jul 09, 2022 at 11:07:28AM +0100, Mauro Carvalho Chehab wrote:
> There's one missing space, causing a long error message when
> building the docs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

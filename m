Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925106066C0
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Oct 2022 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJTRIg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Oct 2022 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJTRIf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Oct 2022 13:08:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875A11D20D5
        for <linux-ext4@vger.kernel.org>; Thu, 20 Oct 2022 10:08:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29KH8C7b000645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 13:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1666285694; bh=9/GCzYBu3HD6nrPKV9PLKrFEm8Vu7uup0HyZifYqPGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BBZG0nv2GmLeTT22W1zI+B1bUELmnqe+jqlIRjqSrjXO06g0HYLSrZ+d/xZyjbevL
         Cn8VMz77JnasHGvzP6+6oFwADpAKH3TpuD62s00PXPI3tWXQUaG9mrpPc+tgtkbrre
         SI0waQwys/5IVcGv4uWrSV9p4cYRnA3Qsd1P5apb1tAHZ53RFqAa3mCMW40zlvcLHo
         jmWNsTebItbvHCeWjU51LMm2fMGwrK9srLFQL4AtK5PJDtZsM0dkNH9z65PSXufks0
         rtoDiJsmHmMarTNjW+kjL52aDyyvyGP/n/qh1E+m26U59+jP8GtXhJzkTsstMVI2Rt
         HGZWAfTibgO3Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D677815C3AD1; Thu, 20 Oct 2022 13:08:12 -0400 (EDT)
Date:   Thu, 20 Oct 2022 13:08:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     adilger@whamcloud.com, linux-ext4@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH] tune2fs: exit directly when fs freed in
 ext2fs_run_ext3_journal
Message-ID: <Y1GAfCVhruEJ+5IL@mit.edu>
References: <20220916074223.8885-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916074223.8885-1-lijinlin3@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 16, 2022 at 03:42:23PM +0800, Li Jinlin wrote:
> In ext2fs_run_ext3_journal(), fs will be free and reallocate. But
> reallocating by ext2fs_open() may fail in some cases, such as device
> being offline at the same time. In these cases, goto closefs will
> cause segfault, fix it by exiting directly.
> 
> Signed-off-by: Li Jinlin <lijinlin3@huawei.com>

Thanks, applied, although I simplified the patch a little:

@@ -3106,6 +3106,8 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
                        com_err("tune2fs", retval,
                                "while recovering journal.\n");
                        printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
+                       if (!fs)
+                               exit(1);
                        rc = 1;
                        goto closefs;
                }

					- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC55780556
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357894AbjHRFGT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357962AbjHRFFv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:05:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0DA35BD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:05:50 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55Dmu026894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335115; bh=M6/sEOtCDnOtga/KztaWzD4SsfJgFihD+x3byyi68Pw=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=VNLyV3OHPa6oGKbWQeuB7RcfN10P/YuKyTvhHJ1MQYuTregnggbmJFROboueDaZF9
         ZAiBmKyhEDmLe6Ag6SBasy1u4fmhozQ0MFXj15n7olsENmNCNk8LLa5t+aau5w7H+e
         k/9W3EwnFaV7vcEpr2cadfFjJEPWSyh+gJqBmWGFE9xLOFzFMN+hCUrKhNIEPxlU/2
         V2nNBFnqdAYpXCsNYuKhV7OfV6BSvNvA2gyHqlhemZujUXs5jYQuQpI1k4PFBzXi0s
         NbEjF8PkS8W/7yhwLKFqVNsZkodhLi1fHL1ijoWAWIZH+oSGhBbni/vAag8+WV5yPY
         KG9t0iHjffGog==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3241C15C0503; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, jack@suse.cz,
        Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix unttached inode after power cut with orphan file feature enabled
Date:   Fri, 18 Aug 2023 01:05:08 -0400
Message-Id: <169233503393.3504102.2943351658392769443.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230628132011.650383-1-chengzhihao1@huawei.com>
References: <20230628132011.650383-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Wed, 28 Jun 2023 21:20:11 +0800, Zhihao Cheng wrote:
> Running generic/475(filesystem consistent tests after power cut) could
> easily trigger unattached inode error while doing fsck:
>   Unattached zero-length inode 39405.  Clear? no
> 
>   Unattached inode 39405
>   Connect to /lost+found? no
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix unttached inode after power cut with orphan file feature enabled
      commit: 94b4275ca8246a3c5b454b764dd48321baf1a954

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

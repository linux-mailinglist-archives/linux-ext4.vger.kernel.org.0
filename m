Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9916BE000
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 05:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCQEKQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 00:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCQEKO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 00:10:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347454FF25
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 21:10:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H4A6Xr026390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 00:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679026208; bh=fO4GaZKIGm1Wn3RQAbCRU5BraN8zK6xwxFqXiPoJSaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oHM1Jv+SrE7a3gXo2k4aHtzTqf4jsd5i761sTvRnkE3zYqFKkeQYn4ojeXemFJFWW
         KOOo5zHZZUr3Cwq/sjKPT7XkmFPuRbLdbZ/w/B+PZ8Rk1BjJ47AMM85FGRFY4gxpEv
         saB/agUKkM7UPSaBQvW94a9hZJP+xnOihgFdESwYCWJvJGx7AoPb7Ri8FfjPBuis2j
         HgmDO01OVkcWPhy2z6Jm6k4YPhlJdIMgfx8B98sa3lJL1+RIBrLQGH7AVk/nLw4Epv
         uJ53aN9UjH341XrWysEzEyDOI7/p2kU9hKw5Itt5sAX2B/ymlFVnDC7zZqUNCqBbhr
         Bi5gHpqHVG72Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9990A15C33A7; Fri, 17 Mar 2023 00:10:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tests: fix r_move_itable_realloc to run on Linux
Date:   Fri, 17 Mar 2023 00:10:03 -0400
Message-Id: <167902618367.3260753.13912687434327412856.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1673323372-13786-1-git-send-email-adilger@dilger.ca>
References: <1673323372-13786-1-git-send-email-adilger@dilger.ca>
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

On Mon, 9 Jan 2023 21:02:52 -0700, Andreas Dilger wrote:
> The check for the various unsupported OSes incorrectly checked if
> the string "FreeBSD" was true, which it always was.  Fix this.
> 
> Update the expect file as commit v1.46.4-17-g4ea80d031c7e did to
> adjust the total number of blocks requested during resize.
> 
> 
> [...]

Applied, thanks!

[1/1] tests: fix r_move_itable_realloc to run on Linux
      commit: 516d53a42d4ffa79b31f8190530b7ac184d71b06

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

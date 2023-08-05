Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F7770F90
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Aug 2023 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjHEMUm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Aug 2023 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHEMUl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Aug 2023 08:20:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE20244BE
        for <linux-ext4@vger.kernel.org>; Sat,  5 Aug 2023 05:20:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 375CKV5N027554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Aug 2023 08:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691238033; bh=/5OQsuvO8EFAtW28naZltrWyp9MTJKzUfAozLxzSpVo=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=H8fXBmdwWi0D/RONRjWCczx10L5vMLEjaC+HyHKveGxMB8kAsV4bD+Sl7Wey8pWMX
         obFeiUmsZavSGhbIXG/LrsYkaDR4/BeuC+CmgczvYAbUmcj0WrH67Vo3KvBWRQJ60d
         sI9S8sPRGBu1q60h5e98YSQXu3r+iS5B1HnYmEJV3+2wKdqfxY7zKjkO3Cghh9veHq
         bTTqioZsnxdLKBvCi4iBs3ri7/YD99WAKFLC6a2wIwZdpXO4+n1HTO/tLTVww5mMxK
         08PMNfD8loVqZ/QftFRMVXJV9chEETUmNiR48Y40uTtJO/ffXIhOhMJHcwCjviv/43
         jtg7fRyCrnrTw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 53C8315C04F2; Sat,  5 Aug 2023 08:20:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: Don't use CR_BEST_AVAIL_LEN for non-regular files
Date:   Sat,  5 Aug 2023 08:20:25 -0400
Message-Id: <169123801882.1434487.3791634089100240584.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
References: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Sun, 16 Jul 2023 19:33:34 +0530, Ritesh Harjani (IBM) wrote:
> Using CR_BEST_AVAIL_LEN only make sense for regular files, as for
> non-regular files we never normalize the allocation request length i.e.
> goal len is same as original length (ac_g_ex.fe_len == ac_o_ex.fe_len).
> 
> Hence there is no scope of trimming the goal length to make it
> satisfy original request len. Thus this patch avoids using
> CR_BEST_AVAIL_LEN criteria for non-regular files request.
> 
> [...]

Applied, thanks!

[1/1] ext4: Don't use CR_BEST_AVAIL_LEN for non-regular files
      commit: 772c9f691dcf3a487f29ddb90a5a15c78d7328e1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

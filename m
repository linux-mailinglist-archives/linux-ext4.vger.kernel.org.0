Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFA591B32
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiHMO6i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Aug 2022 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiHMO6h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Aug 2022 10:58:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E28DF31
        for <linux-ext4@vger.kernel.org>; Sat, 13 Aug 2022 07:58:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27DEwCoh022508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660402694; bh=pZQVjdq5zdGKOG2lEi/fuSzrJyO7WWkHICXpw1lAlmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H17rHZmxHw/O//9+o6iPqMuf+RYj1Kw8ut9p555mZ4SRRM5DeokkDAhgOJ1CPT40l
         gQpab//Vf7oQEYwGrzeXu29JSzDHLNXfCf9tWV964QCBaxHfpNvVZOUMu5ezyzlm4n
         h0zKnJVDCJgLFUzKJER1qT+SDxybWs8l/112QsBPtH240pGbaOruNW+5FKyB5CdzXT
         Mleu2YrAo3KCn3Akn+WEEGi3NCSQ+n3GJl38Ea2+I6sm7kRUWZ5oFqQ2k7DLrgrc6E
         de8sFJWqQiUZP5CJOrlLSprnjwAEel/lcG6t60BORNI4li6fxnDl1zsxhytRWFOcQd
         mf+MPt2CzQktg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B276F15C41BC; Sat, 13 Aug 2022 10:58:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     lihaoxiang9@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, louhongxiang@huawei.com,
        linfeilong@huawei.com, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH] debugfs:add logdump with option -n that display n records
Date:   Sat, 13 Aug 2022 10:58:10 -0400
Message-Id: <166040264335.3360334.9256977073226062013.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <608df030-593f-8c69-cb65-632a34729d23@huawei.com>
References: <608df030-593f-8c69-cb65-632a34729d23@huawei.com>
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

On Thu, 14 Jul 2022 09:32:48 +0800, lihaoxiang (F) wrote:
> The current version's debugfs possessed the function logdump. Executing
> with option -O could output the log history. But when it occurred the block
> which had no magic number in it's header, the program would exit.
> 
> Sometimes we were locating problems, needed for more transactions that
> had replayed instead of the latest batch of transactions and we weren't
> hope to display all the history in the meanwhile. So we introduced
> the option -n used for controlling the print of history transactions.
> Specially, this parameter was depending on the option -O otherwise it
> couldn't work.
> 
> [...]

Applied, thanks!

[1/1] debugfs:add logdump with option -n that display n records
      commit: 6e4cc3d5eeb2dfaa055e652b5390beaa6c3d05da

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5665513AB3
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiD1RTX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiD1RTW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 13:19:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D05B3FD
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 10:16:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23SHG24R020342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 13:16:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DA4D915C3EA1; Thu, 28 Apr 2022 13:16:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] resize2fs: remove unused variable 'c'
Date:   Thu, 28 Apr 2022 13:16:00 -0400
Message-Id: <165116607839.466979.13531412130110018943.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220217092500.40525-1-lczerner@redhat.com>
References: <20220217092500.40525-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Applied, thanks!

I did make a minor change in the libss patch; there's no need to
create a new error code, SS_ET_ENOMEM; we can just return the standard
ENOMEM error.

[1/3] resize2fs: remove unused variable 'c'
      commit: 997902106fab2bc7cb0f7251eb55fad4b721b51a
[2/3] libss: fix possible NULL pointer dereferece on allocation failure
      commit: a282671a02e8fffa04ac0f9db7982fd6bb0a0916
[3/3] e2fsprogs: use mallinfo2 instead of mallinfo if available
      commit: 97079a792dd5e9ea9d4708d2e80244c930a139cd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

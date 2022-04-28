Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0551372B
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348257AbiD1OrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347623AbiD1OrD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 10:47:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351C21E38
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 07:43:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23SEhhKq032434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 10:43:43 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F281615C3EA1; Thu, 28 Apr 2022 10:43:42 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Nils Bars <nils_bars@t-online.de>
Subject: Re: [PATCH] e2fsprogs: add sanity check to extent manipulation
Date:   Thu, 28 Apr 2022 10:43:40 -0400
Message-Id: <165115689135.440993.1403044617589707642.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220421173148.20193-1-lczerner@redhat.com>
References: <20220421173148.20193-1-lczerner@redhat.com>
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

On Thu, 21 Apr 2022 19:31:48 +0200, Lukas Czerner wrote:
> It is possible to have a corrupted extent tree in such a way that a leaf
> node contains zero extents in it. Currently if that happens and we try
> to traverse the tree we can end up accessing wrong data, or possibly
> even uninitialized memory. Make sure we don't do that.
> 
> Additionally make sure that we have a sane number of bytes passed to
> memmove() in ext2fs_extent_delete().
> 
> [...]

Applied, thanks!

[1/1] libext2fs: add sanity check to extent manipulation
      commit: ab51d587bb9b229b1fade1afd02e1574c1ba5c76

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

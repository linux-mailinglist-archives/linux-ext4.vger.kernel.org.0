Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97A4CB3F2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 02:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiCCAm2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Mar 2022 19:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCCAm1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Mar 2022 19:42:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CE403EB
        for <linux-ext4@vger.kernel.org>; Wed,  2 Mar 2022 16:41:43 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2230fTQO019234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Mar 2022 19:41:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C4EE15C0038; Wed,  2 Mar 2022 19:41:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: fix remount with 'abort' option
Date:   Wed,  2 Mar 2022 19:41:23 -0500
Message-Id: <164626805478.621144.15168980198456730624.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220201131345.77591-1-lczerner@redhat.com>
References: <YcSYvk5DdGjjB9q/@mit.edu> <20220201131345.77591-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 1 Feb 2022 14:13:45 +0100, Lukas Czerner wrote:
> After commit 6e47a3cc68fc ("ext4: get rid of super block and sbi from
> handle_mount_ops()") the 'abort' options stopped working. This is
> because we're using ctx_set_mount_flags() helper that's expecting an
> argument with the appropriate bit set, but instead got
> EXT4_MF_FS_ABORTED which is a bit position. ext4_set_mount_flag() is
> using set_bit() while ctx_set_mount_flags() was using bitwise OR.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix remount with 'abort' option
      commit: e3952fcce1aad934f1322843b564ff86256444b2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

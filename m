Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3C5169A8
	for <lists+linux-ext4@lfdr.de>; Mon,  2 May 2022 05:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiEBEDW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 May 2022 00:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiEBEDV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 May 2022 00:03:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673F18E2E;
        Sun,  1 May 2022 20:59:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2423xeW1026463
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 1 May 2022 23:59:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 58AF115C3ECD; Sun,  1 May 2022 23:59:40 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] test-appliance: remove convenience fstab entries
Date:   Sun,  1 May 2022 23:59:35 -0400
Message-Id: <165146396605.790141.6548436162681770266.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220430175733.110401-1-ebiggers@kernel.org>
References: <20220430175733.110401-1-ebiggers@kernel.org>
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

On Sat, 30 Apr 2022 10:57:33 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Fstab entries for the xfstests filesystems interfere with xfstests
> because they change the behavior of 'mount -o remount MOUNTPOINT' to
> remount relative to the mount options from the fstab rather than the
> actual mount options.  For example:
> 
> [...]

Applied, thanks!

[1/1] test-appliance: remove convenience fstab entries
      commit: d396dac653c99e46e4234d9600c6e2b0de433fdd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

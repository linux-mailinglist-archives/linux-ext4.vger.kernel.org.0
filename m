Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930805ECF97
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiI0Vxr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiI0Vxp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:53:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400610B234
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 14:53:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RLrbgr032605
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 17:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664315619; bh=tjj0CMLS7u7I8CGKPk57YOU2LucDrtahzefDHJvuqfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QWYxmlNVDxmVFhO1amhd3TqzTwK4KuFnK/SE2MWNZY7j6hklw5JEu3U0JwRn6v2gG
         7KKq/7j3XSiKIUjEXykFPhJs9kSiWbsmY4k4VuBu8OsWeijEr6EG8oZ4USupHKzl6m
         096X3Tf/dt46CxynamCu1CsiKVRJGbnMLv3jOj8VIJeGaX9zWIgP3TN76+lIzU/Zpi
         NwwCWYJsRB/3oLN0SY8Z2pvdH61njZ+Ym239RECY+F7JB0xdomvvwKcHdMqanFZA1g
         vSzdzkDtEgn6QP0kFYPEc3rwfnTWQGwZaFXYo9ESpVyviSHDSbhM0MYOCTncMYMvIg
         RbixR+cQHPk/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A13D915C528B; Tue, 27 Sep 2022 17:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jerrylee@qnap.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: continue to expand file system when the target size doesn't reach
Date:   Tue, 27 Sep 2022 17:53:33 -0400
Message-Id: <166431556704.3511882.8729097617255264599.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <PU1PR04MB22635E739BD21150DC182AC6A18C9@PU1PR04MB2263.apcprd04.prod.outlook.com>
References: <PU1PR04MB22635E739BD21150DC182AC6A18C9@PU1PR04MB2263.apcprd04.prod.outlook.com>
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

On Mon, 18 Jul 2022 10:25:19 +0000, Jerry Lee 李修賢 wrote:
> When expanding a file system from (16TiB-2MiB) to 18TiB, the operation
> exits early which leads to result inconsistency between resize2fs and
> Ext4 kernel driver.
> 
> === before ===
> ○ → resize2fs /dev/mapper/thin
> resize2fs 1.45.5 (07-Jan-2020)
> Filesystem at /dev/mapper/thin is mounted on /mnt/test; on-line resizing required
> old_desc_blocks = 2048, new_desc_blocks = 2304
> The filesystem on /dev/mapper/thin is now 4831837696 (4k) blocks long.
> 
> [...]

Applied, thanks!

[1/1] ext4: continue to expand file system when the target size doesn't reach
      commit: df3cb754d13d2cd5490db9b8d536311f8413a92e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF135730EA4
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 07:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFOF1p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 01:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFOF1o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 01:27:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDCA26A8
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 22:27:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35F5QspV008358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 01:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686806819; bh=Po4rH3mQnno7yPh3tew09XIyoTvRmvr6uS4A8avOe5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h3ViLjAzuEiURUQyEYkyI17a87bLptC1CrlRJfznkMym+PdMYwIc+qI8PH5lOhVvi
         jd9j3XNsuQ88COnkwE5gTsamJjFEJgaJaMYaVVLm9rvXRl+UPGuFx4eEI2vgGOKyHH
         XwBBa+hHf54I2VtBGaD9RQbSAtqLjq+ngBWbVlQupoPlkqSxvdWEQvkCd7MetWy0Jt
         d3cFMHNFFXXVyw5T0PWgeNJXXULi8aI0VrsBM4o9lkdw3KuXTYQfapFzoNcwUr9vLq
         oMUAKHysaezG046NiepM3V8kbSp5TZa98bGNzvgmhGevVr3Ce4Ha83n0pFw37FxyHv
         oPrPFpey3X/1g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 09D0415C00B0; Thu, 15 Jun 2023 01:26:54 -0400 (EDT)
Date:   Thu, 15 Jun 2023 01:26:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] jbd2: skip reading super block if it has been verified
Message-ID: <20230615052654.GF51259@mit.edu>
References: <20230615034941.2335484-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615034941.2335484-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 15, 2023 at 11:49:41AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> We got a NULL pointer dereference issue below while running generic/475
> I/O failure pressure test.

Have you been able to reproduce this failure without the "recheck
checkpoint" series applied?  I have not, so like with the e2fsck bug
fix, I can understand how the bug fix worked, but I still don't
understand why I wasn't seeing until I tried to apply the "recheck
chekcpoint" and the following patches in that patch series.

> If the journal super block had been read and verified, there is no need
> to call bh_read() read it again even if it has been failed to written
> out. So the fix could be simply move buffer_verified(bh) in front of
> bh_read().
> 
> Fixes: d9eafe0afafa ("jbd2: factor out journal initialization from journal_get_superblock()")

That works, but it's worth noting that commit d9eafe0afafa caused the
failure by removing the check on j_journal_version to determine
whether the superblock was read or not.  If the journal superblock had
been previously read, j_journal_version would be either 1 or 2.  If it
had been zero, then superblock was not read.  So from commit
d9eafe0afafa:

 	/* Load journal superblock if it is not loaded yet. */
-	if (journal->j_format_version == 0 &&
-	    journal_get_superblock(journal) != 0)
+	if (journal_get_superblock(journal))
 		return 0;
 	if (!jbd2_format_support_feature(journal))
 		return 0;


The comment "Load journal superblock if it is not loaded yet." should
be removed, since it no longer makes sense once the
"journal->j_format_version == 0" check was removed.

I'll also note that a problem with d9eafe0afafa is that by removing
the j_format_version check, every time we add a revoke header, and we
call jbd2_journal_set_features(), this was causing an unconditional
read of the journal superblock and that unnecessary I/O could slow
down certain workloads.

						- Ted

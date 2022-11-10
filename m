Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9882624B7D
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 21:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKJUQ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 15:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJUQZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 15:16:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72F43841
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 12:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A231861CAD
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 20:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1310C433D6;
        Thu, 10 Nov 2022 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668111384;
        bh=djuvWUsVQSpOx0Qs6OFbBiL6OhlRUDzRqU+ADpL+6Bs=;
        h=Subject:From:To:Cc:Date:From;
        b=ckNrle2nqw1Qwd+exzJT8bzZbLbjR1STUcEKpJT5XQ/GGTeGatKt41v0pbZL1CE6K
         pKr9W9o18uQRJYvBbWQAg/1tjPQmIx1+nZM8gH4kh3+xz4t3buFDJnxGUhXohARb2h
         ePAbuTapd4hVHnlo1TUPgXdqjt6V47ERV+9NtvFmn7scr5+01pADr8Wx+KKEObVWsB
         vHYIsGS3XdaPclvUuLujeBCQsCHSba05JMVg/expfuj3gQySX1GqVi0w63pY4QfnYH
         hPFkN8tviM0YRfBly3BN/vCYEr16Be9ekRPda7iOULc6xGNr+MdqOERyDrHm5cxzPR
         HdTkCG7ZIu/Xg==
Subject: [PATCHSET 0/2] ext4: minor fixes to GETFSUUID ioctl
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, tytso@mit.edu
Cc:     catherine.hoang@oracle.com, linux-ext4@vger.kernel.org
Date:   Thu, 10 Nov 2022 12:16:23 -0800
Message-ID: <166811138334.327006.2601737065307668866.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Ted and I looked at the EXT4_IOC_GETFSUUID implementation on the ext4
concall this morning, and I pointed out that there were a couple of odd
things about the ioctl behavior.  Since Ted hasn't released a version of
e2fsprogs that uses this ioctl, let's tidy those things up before 6.1
comes out, eh?

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D
---
 fs/ext4/ioctl.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E838690DB8
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBIP5P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBIP5N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 10:57:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54DE2B631
        for <linux-ext4@vger.kernel.org>; Thu,  9 Feb 2023 07:57:07 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 319FuqVQ019618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 10:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675958214; bh=AOLKA4OAVKOEzTVswvLfgRyKkolhjkXWuFeXKF0Ywqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bpEg/kLsHPfl+cU6TrAWmG8gc/+3uV9/WAWR4hdcs25svrocdARXsJPOzgAuRGxHq
         IHHHP3plvB1sBc/2VM7fMOLCQxCYXFPPbmzuIAMnVHdDxFH0I8igz4LQPWqGzESicB
         hS10Zc1dqwHqd8QO2ckN6m7ByTcg7mTni9LYBUPZw0u6mglfwvrFBqSo78oRBXB8Jm
         vyTBUbUnp9pw0OBu3gAX07T8dqSVgCrtO3oaoZBdyPwW7jukwEkC92v2HeyAVXPLsE
         i2o3DSLAIOGslPfLsSyl9T93RnV4hQImmJHTCtmTQGb+8PJw1/tGxWyUc18d6Uest6
         mEXGLa3wIB6jA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 00CB215C3587; Thu,  9 Feb 2023 10:56:51 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     yebin@huaweicloud.com
Subject: Re: [PATCH] ext4: improve xattr consistency checking and error reporting
Date:   Thu,  9 Feb 2023 10:56:49 -0500
Message-Id: <167595818785.2451331.503812160366980592.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221214200818.870087-1-tytso@mit.edu>
References: <20221214200818.870087-1-tytso@mit.edu>
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

On Wed, 14 Dec 2022 15:08:18 -0500, Theodore Ts'o wrote:
> Refactor the in-inode and xattr block consistency checking, and report
> more fine-grained reports of the consistency problems.  Also add more
> consistency checks for ea_inode number.
> 
> 

Applied, thanks!

[1/1] ext4: improve xattr consistency checking and error reporting
      commit: 3478c83cf26bbffd026ae6a56bcb1fe544f0834e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8711523799
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbiEKPoI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEKPoH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 11:44:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEF4E44F2;
        Wed, 11 May 2022 08:44:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BFhwM7013033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652283840; bh=rGR9lBAoNm8DMktTwLsasf+2wJML9uFzVwn56HBtvLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OplIdzmF3KpKKauL2SgRFX8Zhb9Grayd4vaRcj89GGOOTj9lBiVgwb3aQcsVzF8az
         dwEMzbpx0hKA+G/WUFmEyPWdGtlbN85wd4GmDe3dLeZl5EcG8JWmNoItOxgZgID9HQ
         z7B0/eHgbUpayf2y54IqOHf6CQIyE2SKAi5YRghvnt1B3ApNbMgPL7iCtcDjnNcrpt
         ozULwEyd/HdzkUs2WypXV4H940besupCLegvz8IvczNszl0mFyCjFeEc0PFN1TBj4S
         pCA8TuBYmmh071ZscT/TsJvrBEneGq/k+RcCMm4irawZowZWKWDZnCndDQfz+6wWut
         jixdOfJT4teOw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2AFE415C3F0C; Wed, 11 May 2022 11:43:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Jinke Han <hanjinke.666@bytedance.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary code in __mb_check_buddy
Date:   Wed, 11 May 2022 11:43:53 -0400
Message-Id: <165228380205.403983.14257203487141722033.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220404152243.13556-1-hanjinke.666@bytedance.com>
References: <20220404152243.13556-1-hanjinke.666@bytedance.com>
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

On Mon, 4 Apr 2022 23:22:43 +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> When enter elseif branch, the the MB_CHECK_ASSERT will never fail.
> In addtion, the only illegal combination is 0/0, which can be caught
> by the first if branch.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: remove unnecessary code in __mb_check_buddy
      commit: 3114e248fcda22f4d9bb149050c22d5efb999899

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

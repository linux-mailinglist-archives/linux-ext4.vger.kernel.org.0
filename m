Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A988457E2B0
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiGVN6n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiGVN6j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA5A8BAAC;
        Fri, 22 Jul 2022 06:58:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwR8J016699
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498309; bh=KDkvkOaznIAbtg/ZOhrIdeChH7McTYcZFnsNaZUYifM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KX51YzoYHxqJv7/BLTWt4OGCnNlNrEdI59qPeq7PDj6TVY+5W98QqcEwZM0WvG9fC
         Rlp2MkbL/yupOfoSVRwdY3vA14zRNmCFSw5P8ucKTPWP2q9hsYxhDzSnVFerCFqjQH
         5FwrTuX2Tp0pNubaMzy/eX9KpUTvHmrwj5D5BHNzury/JnSuscP49j3ti5QKf6rP7s
         kPRJYxARhvA9gKKRyp7ACo3uc6Lffki0XnpxLG2h2qo6pTUK1zleRYpg2huP+qcpxc
         byU29xGAZTdbPqCNEjZ6ntCrOPS1TKn3UBOjHrdktp6pkv8RSDjowBnTo97XfFiYLt
         V9YUBFr8mr/lA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6CE5515C3F01; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jiangjian@cdjrlc.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: aligned '*' in comments
Date:   Fri, 22 Jul 2022 09:58:15 -0400
Message-Id: <165849767594.303416.9706322073721252641.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220621061531.19669-1-jiangjian@cdjrlc.com>
References: <20220621061531.19669-1-jiangjian@cdjrlc.com>
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

On Tue, 21 Jun 2022 14:15:31 +0800, Jiang Jian wrote:
> The '*' in the comment is not aligned.
> 
> 

Applied, thanks!

[1/1] ext4: aligned '*' in comments
      commit: 5f2d635229947b4d1066c24b709c588afb69e393

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

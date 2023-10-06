Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64187BBE5A
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjJFSGo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjJFSGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D37CE
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6ZXe008086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=bXYY3Wx31qEWsln/08L3bdR2MQEOn8sQrXOUxm8LR1Q=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=LPT+V+2lrO8gUMDV3GDsV+sQLm6dFuRk3W6fUjjZpY7SR6n2DcvK8vy0D6Us9k+ep
         jGlJKbEZFm4F6jX/v4wupZrcYQKY2zL3xN0JOMxEOSVHIzSIkT3ywHQM3gfQmIClFB
         SBn7tjt+wEng34iFJ64WKHxQgT4NbAvCUr9ypltpuggIM3EMhadbWjJVRTtpnb0Pye
         idtGqGvQaeshtDH68iZkJlc63ttNSdnrb266BOamR0wa0R2KGuhCsNZuYrYWE4MA43
         R5nLRN9WguLbOhoTVR55Cdvf863a/ER8B7wwgZLo7zIerNqA7QM4x2NaQ5xWCeWJ7J
         fUw3UTvBqBRSg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2309915C0260; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Hongfei <luhongfei@vivo.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, opensource.kernel@vivo.com
Subject: Re: [PATCH] ext4: Fix traditional comparison using max/min method
Date:   Fri,  6 Oct 2023 14:06:21 -0400
Message-Id: <169661554695.173366.10172426933007973778.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230529070930.37949-1-luhongfei@vivo.com>
References: <20230529070930.37949-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Mon, 29 May 2023 15:09:30 +0800, Lu Hongfei wrote:
> It would be better to replace the traditional ternary conditional
> operator with max()/min()
> 
> 

Applied, thanks!

[1/1] ext4: Fix traditional comparison using max/min method
      commit: a8c1eb77edfc92a64788dad70fedf9277cbafe76

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

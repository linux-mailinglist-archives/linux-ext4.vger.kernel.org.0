Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107386E9968
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjDTQV6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Apr 2023 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjDTQV5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Apr 2023 12:21:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429422139
        for <linux-ext4@vger.kernel.org>; Thu, 20 Apr 2023 09:21:56 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLodW022480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007712; bh=iWaa+54MkcyZyrknYXe0AXVRWJL4oLJpa7J80MeCZS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WYUBwh+jPL7HKjjpe/auHOPmcIXyBeHHVX64vOEQNLte7oArlfxm4DTCADOqoNFpd
         mxg2mUas9ysO1GGARVfC3tFDABeh5V81JwM3/aDoq2pL4CRCSRXmi/258weT2+bryB
         PDFl5Q75uXsWUPFZ5+niNUdkE4o42SIyskqxDYTkNYE6aPdK4NHr47Dv9rSqAPuhAc
         aIAk2RZ7b57IPodDORQwOLKPZR9sLSncx8yYBZ2Hf/83qVGFv2VfBcaWl248w+pNtI
         TOBJmbqYEfm/ZQrP5l0WjMAGfWAizVT6SdvFRHTSyxBJ6S3FjgOYlRLCUw98Qb70lC
         pmWerbpJF01og==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E7DC215C543E; Thu, 20 Apr 2023 09:47:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, wuchi <wuchi.zero@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove useless conditional branch code
Date:   Thu, 20 Apr 2023 09:47:10 -0400
Message-Id: <168199842265.1078192.15127233222130867199.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230401075303.45206-1-wuchi.zero@gmail.com>
References: <20230401075303.45206-1-wuchi.zero@gmail.com>
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


On Sat, 01 Apr 2023 15:53:03 +0800, wuchi wrote:
> It's ok because the code will be optimized by the compiler, just
> try to simple the code.
> 
> 

Applied, thanks!

[1/1] ext4: remove useless conditional branch code
      commit: 17809d3cf801374d7c23101800770ea34951f3c8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

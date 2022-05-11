Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5652364B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiEKOzA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbiEKOzA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 10:55:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C6020CDBE;
        Wed, 11 May 2022 07:54:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BEslok030732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652280890; bh=taRKOz6EwUQ4xQ+9EE5nIHkaGt56loAP/vKFnY/T/qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pEQr4Mvcx+rxbMbfiuQRCEquMPWIWaKhilTyX8kwOJWdJNxODiQ9gYOlklfCV+YCJ
         JuJMlCE/nWhjUU+kauXTyFuQEhFfyDvPOS+0wKZuFm4QtNmy4PwuKo78rMxUIXCkw2
         1X7tviROMGaod86CPpC3uyMEyCOfqsNuaW39GVSWnKEucDw8j5hLGfqBj79ZhS1KeU
         3LFr9YcyCScicQQz8ILTrkfuGLg4l82olwgkTMnksMvkgyl7x00da4UDYK6zw8TKKI
         NYpg36bWez6+G0ClCQTjVmU2kVH6K0MfRVaUUGDe0meAq4CETUO5zzfUhmJzstbhNN
         PMv9yw1xkO9sA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1DEEF15C3F0C; Wed, 11 May 2022 10:54:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yu Zhe <yuzhe@nfschina.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary type castings
Date:   Wed, 11 May 2022 10:54:46 -0400
Message-Id: <165228086549.396391.14523472198531093519.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220401081321.73735-1-yuzhe@nfschina.com>
References: <20220401081321.73735-1-yuzhe@nfschina.com>
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

On Fri, 1 Apr 2022 01:13:21 -0700, Yu Zhe wrote:
> remove unnecessary void* type castings.
> 
> 

Applied, thanks!

[1/1] ext4: remove unnecessary type castings
      commit: a10f869aef759f2000d5f953cff5bc87162390c1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

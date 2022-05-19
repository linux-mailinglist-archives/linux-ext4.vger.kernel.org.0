Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAA52C963
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 03:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiESBpS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 21:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiESBpR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 21:45:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF3A2051;
        Wed, 18 May 2022 18:45:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24J1j5al009497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 21:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652924707; bh=XZBubmJaF7MirEr/S4g/wn5KyE+MVVbZKpWxmbukzWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E4HHzVJGM1DTLR+K9N9hJCqRKGOMjEJaqg3JMe67U9TQV7xgyA/AktYC3UN/NCOi4
         cj6LfNaMQKBZWI2o/zxe0ZR3pLXoeG/QDgzW4NB4Z7cwUyWsdctvtcZxMGKDmqGbi8
         YRVpbRtGRDeTLZVpwDYeSHXMkeqM9fWlK5NoWjcSXwVAnmI0cv81CziEkG+jdz1yes
         3MTtiJor+8iaz1j/VImClyGMmdGCFArgYWVgGQxGxFur0yRgpW+9JGa5135r5wUIte
         bcDhGovAcGyFLdvjXfUdUvr/I+aTrtfNTjglBU8KYAvWGOG13k1PDLQCbyX4NRzV8O
         uHnCKIYVSG7Sg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7C80815C3EC0; Wed, 18 May 2022 21:45:05 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs: Remove duplicated include in inode.c
Date:   Wed, 18 May 2022 21:45:04 -0400
Message-Id: <165292468154.1199114.9470848940112002749.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504225025.44753-1-yang.lee@linux.alibaba.com>
References: <20220504225025.44753-1-yang.lee@linux.alibaba.com>
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

On Thu, 5 May 2022 06:50:25 +0800, Yang Li wrote:
> Fix following includecheck warning:
> ./fs/ext4/inode.c: linux/dax.h is included more than once.
> 
> 

Applied, thanks!

[1/1] fs: Remove duplicated include in inode.c
      commit: b10b6278ae17366fec058219623c757b3302baae

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

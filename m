Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1174CB07
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jul 2023 06:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGJEJf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jul 2023 00:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJEJe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jul 2023 00:09:34 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9CE7;
        Sun,  9 Jul 2023 21:09:30 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qIiCt-0010X8-6f; Mon, 10 Jul 2023 14:09:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Jul 2023 14:08:56 +1000
Date:   Mon, 10 Jul 2023 14:08:56 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-crypto@vger.kernel.org,
        netdev@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: algif/hash: Fix race between MORE and non-MORE
 sends
Message-ID: <ZKuEWM3dbt/NpJDx@gondor.apana.org.au>
References: <2227988.1688721158@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2227988.1688721158@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 07, 2023 at 10:12:38AM +0100, David Howells wrote:
> The 'MSG_MORE' state of the previous sendmsg() is fetched without the
> socket lock held, so two sendmsg calls can race.  This can be seen with a
> large sendfile() as that now does a series of sendmsg() calls, and if a
> write() comes in on the same socket at an inopportune time, it can flip the
> state.
> 
> Fix this by moving the fetch of ctx->more inside the socket lock.
> 
> Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
> Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000554b8205ffdea64e@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: linux-crypto@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  crypto/algif_hash.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

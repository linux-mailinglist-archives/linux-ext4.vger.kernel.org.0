Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC06FB4E4
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjEHQPK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHQPJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 12:15:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2761D49D7
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 09:15:08 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.215] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 348GEt8W000886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 12:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683562498; bh=3yxhxZv//0lwbrrlJ0FBf69IOB3kNLzDF0lKVItgTQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=el0V0w3tN9DyVl8Jbyg2HyL1S2OiLV2X+ZXkRvxcQW7rHlfkvQjNDXz+JP5r1Fa9g
         22stNJE3wOYgqqtiD3DL8F5KpEp9+DiFHsyfaYtnmJblmxJe0BMHk2W2WlqGqK2WYA
         2bkx7pb9Io+QgKAGK5Bw+wQcBp3LCxH4PM6221qDXjTK2q7udaLHIuB9ssnN1+aGCQ
         8FpZNzjqpZvzDkuVIgMCW0ww64VKi39jGJdbhVutO4hCjsPzvPjx773OojarX6guxc
         ogcJyEHAMeM6oQM4snEz4opKtxZfu77+4jTxPv9n2YSixi/qO1sqdHkx62C5YK/K0g
         rU26k1jr5JFAw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id ABF8C8C03A6; Mon,  8 May 2023 12:14:54 -0400 (EDT)
Date:   Mon, 8 May 2023 12:14:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] ext4: remove superfluous check that pointer is not NULL
Message-ID: <ZFkf/oJnCLZSWgYr@mit.edu>
References: <20230508151337.79304-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508151337.79304-1-tudor.ambarus@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 08, 2023 at 03:13:37PM +0000, Tudor Ambarus wrote:
> If @buffer is NULL, no operation is performed for kvfree(buffer),
> remove superfluous check.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

I was looking at this just a few weeks ago, and I couldn't find any
actual *documentation* that it was safe to call vfree(NIILL) or
kvfree(NULL).  The problem is there are a lot of architecture-specific
functions, and unlike with kfree() there is no top-level "if (ptr ==
NULL) return;" in the top-level vfree() and kvfree().

So I thought about removing the NULL check for kvfree(), and
ultimately chickened out, since I was afraid that there might be
crashes for some obscure architecture or kernel CONFIG setup.

I've added linux-mm@ for their comments, and for a plea that if it
is safe to pass NULL to vfree, kvfree, kvfree_rcu, etc. that it
actually be *documented* somewhere.

						- Ted

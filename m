Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABBE523A4C
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbiEKQ2D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiEKQ2C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 12:28:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95D666A2
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 09:28:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BGRjSm006409
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652286466; bh=sixMYQ0R7mrXqEOvBn/r3CaRGGSsWzEq5FUp5X2sNm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=B7B3bqMphTrX7sLmIsCzb6lGQI/PHn+iOOr2jAHrAmj2mxjN/nLk2Tv1Yt/sj9Mce
         60TqwQ3B3bqG0DUVfR9uYrlbPl14457emVL1vXUPWJgDIkkmvG1XeQ6WISn5JRvVh6
         TX7NHkA84Ks630ABnB3wVLue4+QqX9ZdYNYBv2smRwKp6VK5FCwKOLV4EL2s0wAHst
         24JKV4kbpHEvG87tXy5DG9wa16qbt03dHPPeVBdGScdZq9W94uhCmyQXR348vy/IwH
         cCRkS198lmG6jQ2XKLrhYB7W0u3OK5jJJh+wXA/9L28cfAppn8nCTUOAStqKMtWxxK
         lOVTz91U0pcyg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 00ABD15C3F0C; Wed, 11 May 2022 12:27:44 -0400 (EDT)
Date:   Wed, 11 May 2022 12:27:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianjian <wangjianjian3@huawei.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Should ext4_bio_end_io be ext4_end_io_end ?
Message-ID: <YnvkAEDnqySmU72j@mit.edu>
References: <20220406125251.2135346-1-wangjianjian3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406125251.2135346-1-wangjianjian3@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 06, 2022 at 08:52:51PM +0800, Wang Jianjian wrote:
> There is no ext4_bio_end_io, should it be ext4_end_io_end ?

I believe the correction in the comment should be "cannot be called
from ext4_end_bio()".

					- Ted
